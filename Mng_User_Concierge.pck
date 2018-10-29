create or replace package Mng_User_Concierge is

  Function User_Add(p_Login      Dat_Clients_Users.Login%Type,
                    p_Password   Dat_Clients_Users.Password%Type,
                    p_Repassword Dat_Clients_Users.Password%Type,
                    Out_Code     Out Varchar2,
                    Out_Text     Out Varchar2) Return Number;

  Function User_Activate(p_User_Id  Dat_Clients_Users.Id%Type,
                         p_Activate Varchar2,
                         Out_Code   Out Varchar2,
                         Out_Text   Out Varchar2) Return Number;

  Function User_Activate_Mlt(p_User_Id Varchar2, p_Activate Varchar2)
    Return Sys_Refcursor;

  Function User_Password(p_User_Id        Dat_Clients_Users.Id%Type,
                         p_Password_New   Dat_Clients_Users.Password%Type,
                         p_Password_New_2 Dat_Clients_Users.Password%Type,
                         Out_Code         Out Varchar2,
                         Out_Text         Out Varchar2) Return Number;

  Function User_Channel(p_User_Id Number,
                        p_Channel Spr_Channels.Code%Type,
                        p_Allow   Varchar2,
                        Out_Code  Out Varchar2,
                        Out_Text  Out Varchar2) Return Number;

  Function User_Channel_Mlt(p_User_Id Varchar2,
                            p_Channel Varchar2,
                            p_Allow   Varchar2) Return Sys_Refcursor;

  Function Get_Users(p_Client_Id    Varchar2,
                     p_Client_Group Varchar2,
                     p_User_Id      Varchar2,
                     p_Login        Varchar2,
                     p_Name         Varchar2,
                     p_Bo_Type      Varchar2,
                     p_Pagenum      Number,
                     p_Perpage      Number,
                     Out_Cnt        Out Number) Return Sys_Refcursor;

  Function Get_User_Channels(p_User_Id       Varchar2,
                             p_Allow         Varchar2,
                             p_Channel_Group Varchar2,
                             p_Bank_Type     Varchar2,
                             p_Channel_Code  Varchar2,
                             p_Channel_Name  Varchar2,
                             p_Pagenum       In Number,
                             p_Perpage       In Number,
                             Out_Cnt         Out Number) Return Sys_Refcursor;

  Function Get_Users_Dyn(p_Client_Id    Varchar2,
                         p_Client_Group Varchar2,
                         p_User_Id      Varchar2,
                         p_Login        Varchar2,
                         p_Name         Varchar2,
                         p_Bo_Type      Varchar2,
                         p_Pagenum      Number,
                         p_Perpage      Number,
                         Out_Data       Out Sys_Refcursor,
                         Out_Code       Out Varchar2,
                         Out_Text       Out Varchar2) Return Number;

  Function Get_Channels_Dyn(p_User_Id       Varchar2,
                            p_Allow         Varchar2,
                            p_Channel_Group Varchar2,
                            p_Bank_Type     Varchar2,
                            p_Channel_Code  Varchar2,
                            p_Channel_Name  Varchar2,
                            p_Pagenum       Number,
                            p_Perpage       Number,
                            Out_Data        Out Sys_Refcursor,
                            Out_Code        Out Varchar2,
                            Out_Text        Out Varchar2) Return Number;

end Mng_User_Concierge;
/
create or replace package body Mng_User_Concierge is

  Function User_Add(p_Login      Dat_Clients_Users.Login%Type,
                    p_Password   Dat_Clients_Users.Password%Type,
                    p_Repassword Dat_Clients_Users.Password%Type,
                    Out_Code     Out Varchar2,
                    Out_Text     Out Varchar2) Return Number Is
  Begin
    If Not Int_User_Concierge.User_Add(p_Login      => p_Login,
                                       p_Password   => p_Password,
                                       p_Repassword => p_Repassword,
                                       Out_Code     => Out_Code,
                                       Out_Text     => Out_Text) then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function User_Activate(p_User_Id  Dat_Clients_Users.Id%Type,
                         p_Activate Varchar2,
                         Out_Code   Out Varchar2,
                         Out_Text   Out Varchar2) Return Number Is
  Begin
    If Not Int_User_Concierge.User_Activate(p_User_Id  => p_User_Id,
                                            p_Activate => p_Activate,
                                            Out_Code   => Out_Code,
                                            Out_Text   => Out_Text) then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function User_Activate_Mlt(p_User_Id Varchar2, p_Activate Varchar2)
    Return Sys_Refcursor Is
    v_Result   Result_Table := Result_Table();
    v_User_Ids Number_Array;
    Out_Code   Varchar2(4000);
    Out_Text   Varchar2(4000);
  Begin
    If Not Utils.Try_Split_Number_String(p_String  => p_User_Id,
                                         Out_Array => v_User_Ids,
                                         Out_Code  => Out_Code,
                                         Out_Text  => Out_Text) Then
      Utils.Add(p_Results => v_Result,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Out_Code,
                p_Text    => Out_Text);
      Return Utils.To_Cursor(v_Result);
    End If;
  
    For i In 1 .. v_User_Ids.Count Loop
      If Int_User_Concierge.User_Activate(p_User_Id  => v_User_Ids(i),
                                          p_Activate => p_Activate,
                                          Out_Code   => Out_Code,
                                          Out_Text   => Out_Text) Then
        Commit;
        Utils.Add(p_Results   => v_Result,
                  p_Object_Id => v_User_Ids(i),
                  p_Result    => Stm_Const.c_Result_Ok,
                  p_Code      => Out_Code,
                  p_Text      => Out_Text);
      Else
        Rollback;
        Utils.Add(p_Results   => v_Result,
                  p_Object_Id => v_User_Ids(i),
                  p_Result    => Stm_Const.c_Result_Error,
                  p_Code      => Out_Code,
                  p_Text      => Out_Text);
      End If;
    End Loop;
    Return Utils.To_Cursor(v_Result);
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(v_Result);
      Return Utils.To_Cursor(v_Result);
  End;

  Function User_Password(p_User_Id        Dat_Clients_Users.Id%Type,
                         p_Password_New   Dat_Clients_Users.Password%Type,
                         p_Password_New_2 Dat_Clients_Users.Password%Type,
                         Out_Code         Out Varchar2,
                         Out_Text         Out Varchar2) Return Number Is
  Begin
    If Not
        Int_User_Concierge.User_Password(p_User_Id            => p_User_Id,
                                         p_Password_Old       => Null,
                                         p_Password_New       => p_Password_New,
                                         p_Password_New_2     => p_Password_New_2,
                                         p_Check_Old_Password => False,
                                         p_Show_Password      => True,
                                         Out_Code             => Out_Code,
                                         Out_Text             => Out_Text) Then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function User_Channel(p_User_Id Number,
                        p_Channel Spr_Channels.Code%Type,
                        p_Allow   Varchar2,
                        Out_Code  Out Varchar2,
                        Out_Text  Out Varchar2) Return Number Is
  Begin
    If Not Int_User_Concierge.User_Channel(p_User_Id => p_User_Id,
                                           p_Channel => p_Channel,
                                           p_Allow   => p_Allow,
                                           Out_Code  => Out_Code,
                                           Out_Text  => Out_Text) Then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function User_Channel_Mlt(p_User_Id Varchar2,
                            p_Channel Varchar2,
                            p_Allow   Varchar2) Return Sys_Refcursor Is
    v_Result        Result_Table := Result_Table();
    v_Channel_Codes Varchar_Array;
    v_User_Ids      Number_Array;
    Out_Code        Varchar2(4000);
    Out_Text        Varchar2(4000);
  Begin
    If Not Utils.Try_Split_Number_String(p_String  => p_User_Id,
                                         Out_Array => v_User_Ids,
                                         Out_Code  => Out_Code,
                                         Out_Text  => Out_Text) Then
      Utils.Add(p_Results => v_Result,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Out_Code,
                p_Text    => Out_Text);
      Return Utils.To_Cursor(v_Result);
    End If;
  
    v_Channel_Codes := Utils.Split_String(p_Channel);
  
    For User_Index In 1 .. v_User_Ids.Count Loop
      For Channel_Index In 1 .. v_Channel_Codes.Count Loop
        If Int_User_Concierge.User_Channel(p_User_Id => v_User_Ids(User_Index),
                                           p_Channel => v_Channel_Codes(Channel_Index),
                                           p_Allow   => p_Allow,
                                           Out_Code  => Out_Code,
                                           Out_Text  => Out_Text) Then
          Commit;
          Utils.Add(p_Results   => v_Result,
                    p_Object_Id => v_User_Ids(User_Index) || ' ' ||
                                   v_Channel_Codes(Channel_Index),
                    p_Result    => Stm_Const.c_Result_Ok,
                    p_Code      => Out_Code,
                    p_Text      => Out_Text);
        Else
          Rollback;
          Utils.Add(p_Results   => v_Result,
                    p_Object_Id => v_User_Ids(User_Index) || ' ' ||
                                   v_Channel_Codes(Channel_Index),
                    p_Result    => Stm_Const.c_Result_Error,
                    p_Code      => Out_Code,
                    p_Text      => Out_Text);
        End If;
      End Loop;
    End Loop;
    Return Utils.To_Cursor(v_Result);
  Exception
    When Others Then
      Rollback;
      Utils.Process_Exception(v_Result);
      Return Utils.To_Cursor(v_Result);
  End;

  Function Get_Users(p_Client_Id    Varchar2,
                     p_Client_Group Varchar2,
                     p_User_Id      Varchar2,
                     p_Login        Varchar2,
                     p_Name         Varchar2,
                     p_Bo_Type      Varchar2,
                     p_Pagenum      Number,
                     p_Perpage      Number,
                     Out_Cnt        Out Number) Return Sys_Refcursor Is
    v_Crs             Sys_Refcursor;
    From_i            Number := 0;
    To_i              Number := 0;
    v_Client_Ids      Number_Array := Number_Array();
    v_Client_Ids_Used Varchar2(1);
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        p_Bo_Type      => p_Bo_Type,
                                                        Out_Used       => v_Client_Ids_Used);
  
    Select Count(u.Id)
      Into Out_Cnt
      From Dat_Clients_Users u, Dat_clients c
     Where u.client_id = c.id
       And (v_Client_Ids_Used = 'N' Or
           (v_Client_Ids_Used = 'Y' And
           c.id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
       And (p_User_Id Is Null Or
           (p_User_Id Is Not Null And u.Id = p_User_Id))
       And (p_Name Is Null Or
           (p_Name Is Not Null And
           Upper(u.Name) Like Upper('%' || p_Name || '%')))
       And (p_Login Is Null Or
           (p_Login Is Not Null And Exists
            (Select *
                From Table(Utils.Split_String_Pipelined(p_Login)) l
               Where u.Login Like Upper('%' || l.Column_Value || '%'))));
  
    Open v_Crs For
      With Data As
       (Select u.Client_Id,
               u.Login,
               u.Status,
               Count(*) Over(Order By u.Client_Id Desc, u.Id) Rn
          From Dat_Clients_Users u, Dat_clients c
         Where u.client_id = c.id
           And (v_Client_Ids_Used = 'N' Or
               (v_Client_Ids_Used = 'Y' And
               c.Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (p_User_Id Is Null Or
               (p_User_Id Is Not Null And u.Id = p_User_Id))
           And (p_Name Is Null Or
               (p_Name Is Not Null And
               Upper(u.Name) Like Upper('%' || p_Name || '%')))
           And (p_Login Is Null Or
               (p_Login Is Not Null And Exists
                (Select *
                    From Table(Utils.Split_String_Pipelined(p_Login)) l
                   Where u.Login Like Upper('%' || l.Column_Value || '%'))))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.* From Page t Order By Rn;
    Return v_Crs;
  End;

  Function Get_User_Channels(p_User_Id       Varchar2,
                             p_Allow         Varchar2,
                             p_Channel_Group Varchar2,
                             p_Bank_Type     Varchar2,
                             p_Channel_Code  Varchar2,
                             p_Channel_Name  Varchar2,
                             p_Pagenum       In Number,
                             p_Perpage       In Number,
                             Out_Cnt         Out Number) Return Sys_Refcursor Is
    v_Crs  Sys_Refcursor;
    From_i Number := 0;
    To_i   Number := 0;
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    Select Count(*)
      Into Out_Cnt
      From Spr_Channels c, Stm_Users_Channels u
     Where u.channel(+) = c.Code
       And u.user_id(+) = p_User_Id
       And (p_Channel_Code Is Null Or
            (p_Channel_Code Is Not Null And c.Code = p_Channel_Code))
       And (p_Channel_Name Is Null Or
            (p_Channel_Name Is Not Null And
            Upper(c.Name) Like '%' || Upper(p_Channel_Name) || '%'))
       And (p_Channel_Group = 'XXX' Or
            (p_Channel_Group <> 'XXX' And c.Group_Code = p_Channel_Group))
       And (p_Bank_Type = 'XXX' Or
            (p_Bank_Type <> 'XXX' And c.Bank_Type = p_Bank_Type))
       And (p_Allow = 'XXX' Or
            (p_Allow <> 'XXX' And nvl2(u.channel, 'Y', 'N') = p_Allow));
  
    Open v_Crs For
      With Data As
       (Select c.Code Channel,
               c.bank_type Bank_Type,
               nvl2(u.channel, 'Y', 'N') ALLOW,
               count(*) Over(Order By c.Code Desc) Rn
          From Spr_Channels c, Stm_Users_Channels u
         Where u.channel(+) = c.Code
           And u.user_id(+) = p_User_Id
           And (p_Channel_Code Is Null Or
                (p_Channel_Code Is Not Null And c.Code = p_Channel_Code))
           And (p_Channel_Name Is Null Or
                (p_Channel_Name Is Not Null And
                Upper(c.Name) Like '%' || Upper(p_Channel_Name) || '%'))
           And (p_Channel_Group = 'XXX' Or
                (p_Channel_Group <> 'XXX' And c.Group_Code = p_Channel_Group))
           And (p_Bank_Type = 'XXX' Or
                (p_Bank_Type <> 'XXX' And c.Bank_Type = p_Bank_Type))
           And (p_Allow = 'XXX' Or
                (p_Allow <> 'XXX' And nvl2(u.channel, 'Y', 'N') = p_Allow))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.* From Page t Order By Rn;
    Return v_Crs;
  End;

  Function Get_Users_Dyn(p_Client_Id    Varchar2,
                         p_Client_Group Varchar2,
                         p_User_Id      Varchar2,
                         p_Login        Varchar2,
                         p_Name         Varchar2,
                         p_Bo_Type      Varchar2,
                         p_Pagenum      Number,
                         p_Perpage      Number,
                         Out_Data       Out Sys_Refcursor,
                         Out_Code       Out Varchar2,
                         Out_Text       Out Varchar2) Return Number Is
    v_Request         Utl_Dyn_Sql.Utl_Sql_Request_Type;
    v_Login           Varchar_Array;
    v_Client_Ids      Number_Array := Number_Array();
    v_Client_Ids_Used Varchar2(1);
  Begin
  
    v_Request := Utl_Dyn_Sql.Create_Request(p_Tables     => 'Dat_Clients_Users u, Dat_Clients c, Dat_Clients a',
                                            p_Conditions => Varchar_Array('u.Client_Id = c.Id',
                                                                          'c.Agent_Id = a.Id(+)'));
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        p_Bo_Type      => p_Bo_Type,
                                                        Out_Used       => v_Client_Ids_Used);
  
    If v_Client_Ids_Used = 'Y' Then
      Utl_Dyn_Sql.Add_Filter_In_Number_Array(p_Request     => v_Request,
                                             p_Column_Name => 'c.Id',
                                             p_Value       => v_Client_Ids);
    End If;
  
    Utl_Dyn_Sql.Add_Filter_In_Number_Array(p_Request     => v_Request,
                                           p_Column_Name => 'u.Id',
                                           p_Value       => p_User_Id);
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'u.Name',
                                      p_Value       => p_Name);
  
    If p_Login Is Not Null Then
      v_Login := Utils.Split_String(p_Login);
      Utl_Dyn_Sql.Add_Filter_Expression(p_Request    => v_Request,
                                        p_Expression => 'Exists
             (Select *
                From Table(Cast(:Login As Varchar_Array)) l
               Where Upper(u.Login) Like Upper(''%'' || l.Column_Value || ''%''))');
      Utl_Dyn_Sql.Add_Bind(p_Binds => v_Request.Binds,
                           p_Name  => 'Login',
                           p_Value => v_Login);
    
    End If;
  
    Out_Data := Utl_Dyn_Sql.Request_Page(p_Request            => v_Request,
                                         p_Data_Columns       => Varchar_Array('c.Name Client_Name',
                                                                               'a.Name Agent_Name',
                                                                               'c.Group_Code Client_Group_Code',
                                                                               'c.Bo_Type Bo_Type_Code',
                                                                               'c.Email',
                                                                               'u.Client_Id',
                                                                               'u.Login',
                                                                               'u.Status'),
                                         p_Sort_Columns       => Varchar_Array('u.Client_Id Desc, u.Id'),
                                         p_Final_Columns      => Varchar_Array('t.*',
                                                                               'Mg.Name Client_Group_Name',
                                                                               'Bt.Name BO_Type_Name',
                                                                               'Ss.Name_2 User_Status_Name'),
                                         p_Final_Tables       => 'Page t, Dat_Merchant_Group Mg, Spr_Bo_Types Bt, Spr_Status Ss',
                                         p_Final_Conditions   => Varchar_Array('t.Client_Group_Code = Mg.Code(+)',
                                                                               't.Bo_Type_Code = Bt.Code(+)',
                                                                               't.Status = Ss.Code(+)'),
                                         p_Final_Sort_Columns => Varchar_Array('t.Rn'),
                                         p_Pagenum            => p_Pagenum,
                                         p_Perpage            => p_Perpage);
  
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Utils.Close_Cursor(Out_Data);
      Out_Data := Null;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function Get_Channels_Dyn(p_User_Id       Varchar2,
                            p_Allow         Varchar2,
                            p_Channel_Group Varchar2,
                            p_Bank_Type     Varchar2,
                            p_Channel_Code  Varchar2,
                            p_Channel_Name  Varchar2,
                            p_Pagenum       Number,
                            p_Perpage       Number,
                            Out_Data        Out Sys_Refcursor,
                            Out_Code        Out Varchar2,
                            Out_Text        Out Varchar2) Return Number Is
    v_Request Utl_Dyn_Sql.Utl_Sql_Request_Type;
  Begin
  
    v_Request := Utl_Dyn_Sql.Create_Request(p_Tables     => 'Spr_Channels c, Stm_Users_Channels u',
                                            p_Conditions => Varchar_Array('u.Channel(+) = c.Code',
                                                                          'u.User_id(+) = :User_Id'));
    Utl_Dyn_Sql.Add_Bind(p_Binds => v_Request.Binds,
                         p_Name  => 'User_Id',
                         p_Value => p_User_Id);
  
    Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                 p_Column_Name => 'c.Code',
                                 p_Value       => p_Channel_Code);
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'c.Name',
                                      p_Value       => p_Channel_Name);
  
    If Nvl(p_Channel_Group, 'XXX') <> 'XXX' Then
      Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                   p_Column_Name => 'c.Group_Code',
                                   p_Value       => p_Channel_Group);
    End If;
  
    If Nvl(p_Bank_Type, 'XXX') <> 'XXX' Then
      Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                   p_Column_Name => 'c.Bank_Type',
                                   p_Value       => p_Bank_Type);
    End If;
  
    If Nvl(p_Allow, 'XXX') <> 'XXX' Then
      Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                   p_Column_Name => 'nvl2(u.Channel, ''Y'', ''N'')',
                                   p_Value       => p_Allow);
    End If;
  
    Out_Data := Utl_Dyn_Sql.Request_Page(p_Request            => v_Request,
                                         p_Data_Columns       => Varchar_Array('c.Code Channel_Code',
                                                                               'c.Name Channel_Name',
                                                                               'c.Bank_Type Bank_Type',
                                                                               'c.Group_Code Group_Code',
                                                                               'c.Status Channel_Status',
                                                                               'nvl2(u.Channel, ''Y'', ''N'') Allow'),
                                         p_Sort_Columns       => Varchar_Array('c.Code Desc'),
                                         p_Final_Columns      => Varchar_Array('t.*',
                                                                               'Utils.Decode_Yes_No(t.Allow) Allow_Name',
                                                                               'g.Name Group_Name',
                                                                               'Bt.Name Bank_Type_Name',
                                                                               'Ss.Name_2 Channel_Status_Name'),
                                         p_Final_Tables       => 'Page t, Spr_Channels_Groups g, Spr_Bank_Type Bt, Spr_Status Ss',
                                         p_Final_Conditions   => Varchar_Array('t.Group_Code = g.Code(+)',
                                                                               't.Bank_Type = Bt.Code(+)',
                                                                               't.Channel_Status = Ss.Code(+)'),
                                         p_Final_Sort_Columns => Varchar_Array('t.Rn'),
                                         p_Pagenum            => p_Pagenum,
                                         p_Perpage            => p_Perpage);
  
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Utils.Close_Cursor(Out_Data);
      Out_Data := Null;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

End Mng_User_Concierge;
/
