create or replace package Int_User_Concierge is

  Function User_Add(p_Login      Dat_Clients_Users.Login%Type,
                    p_Password   Dat_Clients_Users.Password%Type,
                    p_Repassword Dat_Clients_Users.Password%Type,
                    Out_Code     Out Varchar2,
                    Out_Text     Out Varchar2) Return Boolean;

  Function User_Activate(p_User_Id  Dat_Clients_Users.Id%Type,
                         p_Activate Varchar2,
                         Out_Code   Out Varchar2,
                         Out_Text   Out Varchar2) Return Boolean;

  Function User_Password(p_User_Id            Dat_Clients_Users.Id%Type,
                         p_Password_Old       Dat_Clients_Users.Password%Type,
                         p_Password_New       Dat_Clients_Users.Password%Type,
                         p_Password_New_2     Dat_Clients_Users.Password%Type,
                         p_Check_Old_Password Boolean Default True,
                         p_Show_Password      Boolean Default False,
                         Out_Code             Out Varchar2,
                         Out_Text             Out Varchar2) Return Boolean;

  Function User_Channel(p_User_Id Number,
                        p_Channel Spr_Channels.Code%Type,
                        p_Allow   Varchar2,
                        Out_Code  Out Varchar2,
                        Out_Text  Out Varchar2) Return Boolean;

end Int_User_Concierge;
/
create or replace package body Int_User_Concierge is

  Function User_Add(p_Login      Dat_Clients_Users.Login%Type,
                    p_Password   Dat_Clients_Users.Password%Type,
                    p_Repassword Dat_Clients_Users.Password%Type,
                    Out_Code     Out Varchar2,
                    Out_Text     Out Varchar2) Return Boolean Is
    v_Cnt Number := 0;
    v_Id  Dat_Clients_Users.id%Type;
  Begin
    If Trim(p_Login) Is Null Then
      Out_Code := 'ERR_NULL_LOGIN';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Not Int_Utils.Check_Login(p_Login  => p_Login,
                                 Out_Code => Out_Code,
                                 Out_Text => Out_Text) Then
      Return False;
    End If;
  
    Select Count(*)
      Into v_Cnt
      From Dat_Clients_Users
     Where Upper(Login) = Upper(p_Login);
  
    If v_Cnt > 0 Then
      Out_Code := 'ERR_USER_ALREADY_EXISTS';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If (p_Password Is Null) Or (p_Repassword Is Null) Then
      Out_Code := 'ERR_NULL_PASSWORD';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Password <> p_Repassword Then
      Out_Code := 'ERR_PASSWORDS_NOT_IDENTICAL';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Select Nvl(Max(Id), 200) + 1
      Into v_Id
      From Dat_Clients_Users t
     Where t.Id Between 200 And 10000;
  
    Insert Into Dat_Clients_Users
      (Id,
       Client_Id,
       Login,
       Password,
       Is_Main,
       Status,
       Ip_Addresses,
       Type,
       Role,
       Date_Register,
       Date_Confirm,
       Channel,
       Name,
       Language,
       Bo_Type_Access)
    Values
      (v_Id,
       80101,
       Upper(p_Login),
       Stm_General.Encode_Md5(p_Password),
       'N',
       'A',
       'ALL',
       'R',
       'CONCIERGE',
       Sysdate,
       Sysdate,
       'SOME',
       Translate(Initcap(p_Login), '_.-', '   '),
       'ENG',
       'SOME');
    Out_Code := 'OK';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function User_Activate(p_User_Id  Dat_Clients_Users.Id%Type,
                         p_Activate Varchar2,
                         Out_Code   Out Varchar2,
                         Out_Text   Out Varchar2) Return Boolean Is
    v_Client_User Dat_Clients_Users%Rowtype := Null;
  Begin
    Begin
      Select *
        Into v_Client_User
        From Dat_Clients_Users
       Where Id = p_User_Id
         For Update Nowait;
    Exception
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_USER_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When No_Data_Found Then
        Out_Code := 'ERR_USER_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    If Trim(Upper(p_Activate)) Is Null Or
       Trim(Upper(p_Activate)) Not In ('Y', 'N') Then
      Out_Code := 'ERR_BAD_ACTIVATION_VALUE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(Upper(p_Activate)) = 'Y' Then
      If v_Client_User.Status = 'A' Then
        Out_Code := 'ERR_USER_ALREADY_ACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      Else
        Update Dat_Clients_Users
           Set Status = 'A'
         Where Id = v_Client_User.Id;
        Out_Code := 'OK_USER_ACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return True;
      End If;
    Elsif Trim(Upper(p_Activate)) = 'N' Then
      If v_Client_User.Status = 'L' Then
        Out_Code := 'ERR_USER_ALREADY_DEACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      Else
        Update Dat_Clients_Users
           Set Status = 'L'
         Where Id = v_Client_User.Id;
        Out_Code := 'OK_USER_DEACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return True;
      End If;
    End If;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function User_Password(p_User_Id            Dat_Clients_Users.Id%Type,
                         p_Password_Old       Dat_Clients_Users.Password%Type,
                         p_Password_New       Dat_Clients_Users.Password%Type,
                         p_Password_New_2     Dat_Clients_Users.Password%Type,
                         p_Check_Old_Password Boolean Default True,
                         p_Show_Password      Boolean Default False,
                         Out_Code             Out Varchar2,
                         Out_Text             Out Varchar2) Return Boolean Is
    v_Client_User Dat_Clients_Users%Rowtype := Null;
  Begin
    Begin
      Select *
        Into v_Client_User
        From Dat_Clients_Users
       Where Id = p_User_Id
         For Update Nowait;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_CLIENT_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_CLIENT_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    If Nvl(p_Check_Old_Password, True) Then
      If p_Password_Old Is Null Then
        Out_Code := 'ERR_NULL_PASSWORD';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      End If;
    
      If v_Client_User.Password <> Stm_General.Encode_Md5(p_Password_Old) Then
        Out_Code := 'ERR_WRONG_PASSWORD';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      End If;
    End If;
  
    If (p_Password_New Is Null) Or (p_Password_New_2 Is Null) Then
      Out_Code := 'ERR_NULL_PASSWORD';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Password_New <> p_Password_New_2 Then
      Out_Code := 'ERR_PASSWORDS_NOT_IDENTICAL';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Update Dat_Clients_Users
       Set Password = Stm_General.Encode_Md5(p_Password_New)
     Where Id = v_Client_User.Id;
  
    Out_Code := 'OK_PASSWORD_CHANGED';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
  
    If Nvl(p_Show_Password, False) Then
      Out_Text := Utils.Format(p_Str => '%1% (Login: %2%, Passsword: %3%)',
                               p_V1  => Out_Text,
                               p_V2  => v_Client_User.Login,
                               p_V3  => p_Password_New);
    End If;
  
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function User_Channel(p_User_Id Number,
                        p_Channel Spr_Channels.Code%Type,
                        p_Allow   Varchar2,
                        Out_Code  Out Varchar2,
                        Out_Text  Out Varchar2) Return Boolean Is
    v_Cnt Integer;
  Begin
    If p_Channel Is Null Then
      Out_Code := 'ERR_NULL_CHANNEL';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
      Select Count(*) Into v_Cnt From Spr_Channels Where Code = p_Channel;
      
      If v_Cnt = 0 Then
        Out_Code := 'ERR_NO_CHANNEL_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      End If;
  
    If p_User_Id Is Null Then
      Out_Code := 'ERR_NULL_USER_ID';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Select Count(*) Into v_Cnt From Dat_Clients_Users Where id = p_User_Id;
  
    If v_Cnt = 0 Then
      Out_Code := 'ERR_NO_USER_FOUND';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(p_Allow) Is Null Or Trim(p_Allow) Not In ('Y', 'N') Then
      Out_Code := 'ERR_BAD_ACCESS_VALUE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Select Count(*)
      Into v_Cnt
      From Stm_Users_Channels
     Where Channel = p_Channel
       And User_Id = p_User_Id;
  
    If Trim(p_Allow) = 'Y' Then
      If v_Cnt <> 0 Then
        Out_Code := 'ERR_CHANNEL_ALREADY_ACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      Else
        Insert Into Stm_Users_Channels
          (User_Id, Channel, Date_Ini)
        Values
          (p_User_id, p_Channel, Sysdate);
        Out_Code := 'OK_CHANNEL_ACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return True;
      End If;
    Elsif Trim(p_Allow) = 'N' Then
      If v_Cnt = 0 Then
        Out_Code := 'ERR_CHANNEL_ALREADY_DEACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      Else
        Delete From Stm_Users_Channels Where User_Id = p_User_Id and Channel = p_Channel;
        Out_Code := 'OK_CHANNEL_DEACTIVATED';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return True;
      End If;
    End If;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

End Int_User_Concierge;
/
