CREATE OR REPLACE Package Mng_Block Is

  Function Card_Block(p_Card_Numbers Varchar2,
                      p_Client_Group Varchar2,
                      p_Client_Ids   Varchar2,
                      p_Reason       Varchar2,
                      p_Remark       Varchar2) Return Sys_Refcursor;

  Function Email_Block(p_Emails       Varchar2,
                       p_Client_Group Varchar2,
                       p_Client_Ids   Varchar2,
                       p_Reason       Varchar2,
                       p_Remark       Varchar2) Return Sys_Refcursor;

  Function Ip_Block(p_Ips          Varchar2,
                    p_Client_Group Varchar2,
                    p_Client_Ids   Varchar2,
                    p_Reason       Varchar2,
                    p_Remark       Varchar2) Return Sys_Refcursor;

  Function Ip_Unblock(p_Ips          Varchar2,
                      p_Client_Group Varchar2,
                      p_Client_Ids   Varchar2,
                      p_Reason       Varchar2,
                      p_Remark       Varchar2) Return Sys_Refcursor;

  Function Get_Black_Cards(p_Client_Id      Varchar2,
                           p_Client_Group   Varchar2,
                           p_Card_Number    Varchar2,
                           p_Block_Reason   Varchar2,
                           p_Unblock_Reason Varchar2,
                           p_Allow          Varchar2,
                           p_Fixed          Varchar2,
                           p_Is_Auditor     Varchar2,
                           p_Pagenum        Number,
                           p_Perpage        Number,
                           Out_Cnt          Out Number) Return Sys_Refcursor;

  Function Get_Black_Emails(p_Client_Id      Varchar2,
                            p_Client_Group   Varchar2,
                            p_Email          Varchar2,
                            p_Block_Reason   Varchar2,
                            p_Unblock_Reason Varchar2,
                            p_Allow          Varchar2,
                            p_Fixed          Varchar2,
                            p_Is_Auditor     Varchar2,
                            p_Pagenum        Number,
                            p_Perpage        Number,
                            Out_Cnt          Out Number) Return Sys_Refcursor;

  Function Get_Black_Ips(p_Client_Id      Varchar2,
                         p_Client_Group   Varchar2,
                         p_Ip             Varchar2,
                         p_Block_Reason   Varchar2,
                         p_Unblock_Reason Varchar2,
                         p_Allow          Varchar2,
                         p_Fixed          Varchar2,
                         p_Is_Auditor     Varchar2,
                         p_Is_Vt          Varchar2,
                         p_Pagenum        Number,
                         p_Perpage        Number,
                         Out_Cnt          Out Number) Return Sys_Refcursor;

  Function Get_Black_Orders(p_Order_Id          In Number,
                            p_Client_Id         In Number,
                            p_Group_Code        In Varchar2,
                            p_Date_Begin        In Varchar2,
                            p_Date_End          In Varchar2,
                            p_Card_Number       In Varchar2,
                            p_Email             In Varchar2,
                            p_Ip                In Varchar2,
                            p_Card_Number_Allow In Varchar2,
                            p_Email_Allow       In Varchar2,
                            p_Ip_Allow          In Varchar2,
                            p_Pagenum           In Number,
                            p_Perpage           In Number,
                            Out_Data            Out Sys_Refcursor,
                            Out_Code            Out Varchar2,
                            Out_Text            Out Varchar2) Return Number;

End Mng_Block;
/
CREATE OR REPLACE Package Body Mng_Block Is

  Function Get_Clients(p_Client_Group Varchar2,
                       p_Client_Ids   Varchar2,
                       Out_Client_Ids Out Number_Array,
                       Out_Code       Out Varchar2,
                       Out_Text       Out Varchar2) Return Boolean Is
  Begin
    Out_Client_Ids := Number_Array();
    If Nvl(p_Client_Group, 'XXX') <> 'XXX' Then
      Select c.Id Bulk Collect
        Into Out_Client_Ids
        From Dat_Clients c
       Where c.Group_Code = p_Client_Group;
    Else
      If p_Client_Ids Is Null Then
        If Out_Client_Ids.Count = 0 Then
          Utils.Add(Out_Client_Ids, 10000);
        End If;
      Else
        If Not Utils.Try_Split_Number_String(p_String  => p_Client_Ids,
                                             Out_Array => Out_Client_Ids,
                                             Out_Code  => Out_Code,
                                             Out_Text  => Out_Text) Then
          Return False;
        End If;
      End If;
    End If;
    If Out_Client_Ids.Count = 0 Then
      Out_Code := 'ERR_CLIENT_NOT_FOUND';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
    Return True;
  End;

  Function Card_Block(p_Card_Numbers Varchar2,
                      p_Client_Group Varchar2,
                      p_Client_Ids   Varchar2,
                      p_Reason       Varchar2,
                      p_Remark       Varchar2) Return Sys_Refcursor Is
    v_Card_Numbers Varchar_Array;
    v_Client_Ids   Number_Array := Number_Array();
    v_Results      Result_Table := Result_Table();
    v_Client       Dat_Clients%Rowtype;
    v_Card_Number  Dat_Black_Cards.Card_Number%Type;
    v_Object_Id    Varchar2(200);
    v_Id           Number;
    v_Code         Varchar2(4000);
    v_Text         Varchar2(4000);
    v_Is_Auditor   Varchar2(1);
  Begin
    If Not Get_Clients(p_Client_Group => p_Client_Group,
                       p_Client_Ids   => p_Client_Ids,
                       Out_Client_Ids => v_Client_Ids,
                       Out_Code       => v_Code,
                       Out_Text       => v_Text) Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => v_Code,
                p_Text    => v_Text);
      Return Utils.To_Cursor(v_Results);
    End If;
  
    If Nvl(p_Reason, 'XXX') Not In ('FRAUDER', 'AUDITOR', 'SUSPICIOUS') Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => 'ERR_WRONG_REASON');
      Return Utils.To_Cursor(v_Results);
    End If;
  
    v_Card_Numbers := Utils.Split_String(p_Card_Numbers);
  
    For Client_Index In 1 .. v_Client_Ids.Count Loop
      If Not Stm_General.Get_Client(p_Client_Id => v_Client_Ids(Client_Index),
                                    Out_Client  => v_Client,
                                    Out_Code    => v_Code,
                                    Out_Text    => v_Text) Then
        Rollback;
        Utils.Add(p_Results   => v_Results,
                  p_Object_Id => v_Client_Ids(Client_Index),
                  p_Result    => Stm_Const.c_Result_Error,
                  p_Code      => v_Code,
                  p_Text      => v_Text);
        Continue;
      End If;
    
      For Card_Index In 1 .. v_Card_Numbers.Count Loop
        v_Card_Number := Trim(v_Card_Numbers(Card_Index));
        v_Object_Id   := v_Client.Id || ' ' || v_Card_Number;
      
        If p_Reason = 'AUDITOR' Then
          v_Is_Auditor := 'Y';
        Else
          Begin
            Select t.Is_Auditor
              Into v_Is_Auditor
              From Dat_Black_Cards t
             Where t.Client_Id = v_Client.Id
               And t.Card_Number = v_Card_Number;
          Exception
            When No_Data_Found Then
              Begin
                Select t.Is_Auditor
                  Into v_Is_Auditor
                  From Dat_Black_Cards t
                 Where t.Client_Id = 1000
                   And t.Card_Number = v_Card_Number;
              Exception
                When No_Data_Found Then
                  v_Is_Auditor := 'N';
              End;
          End;
        End If;
      
        If Int_Block.Card_Block(p_Client_Id   => v_Client.Id,
                                p_Card_Number => v_Card_Number,
                                p_Is_Auditor  => v_Is_Auditor,
                                p_Remark      => p_Remark,
                                p_Reason      => p_Reason,
                                Out_Id        => v_Id,
                                Out_Code      => v_Code,
                                Out_Text      => v_Text) Then
          Commit;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Ok,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        Else
          Rollback;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Error,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        End If;
      End Loop;
    End Loop;
  
    Return Utils.To_Cursor(v_Results);
  Exception
    When Others Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Sqlcode,
                p_Text    => Sqlerrm);
      Return Utils.To_Cursor(v_Results);
  End;

  Function Email_Block(p_Emails       Varchar2,
                       p_Client_Group Varchar2,
                       p_Client_Ids   Varchar2,
                       p_Reason       Varchar2,
                       p_Remark       Varchar2) Return Sys_Refcursor Is
    v_Emails     Varchar_Array;
    v_Client_Ids Number_Array := Number_Array();
    v_Results    Result_Table := Result_Table();
    v_Client     Dat_Clients%Rowtype;
    v_Email      Dat_Black_Emails.Email%Type;
    v_Object_Id  Varchar2(200);
    v_Id         Number;
    v_Code       Varchar2(4000);
    v_Text       Varchar2(4000);
    v_Is_Auditor Varchar2(1);
  Begin
    If Not Get_Clients(p_Client_Group => p_Client_Group,
                       p_Client_Ids   => p_Client_Ids,
                       Out_Client_Ids => v_Client_Ids,
                       Out_Code       => v_Code,
                       Out_Text       => v_Text) Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => v_Code,
                p_Text    => v_Text);
      Return Utils.To_Cursor(v_Results);
    End If;
  
    If Nvl(p_Reason, 'XXX') Not In ('FRAUDER', 'AUDITOR', 'SUSPICIOUS') Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => 'ERR_WRONG_REASON');
      Return Utils.To_Cursor(v_Results);
    End If;
  
    v_Emails := Utils.Split_String(p_Emails);
  
    For Client_Index In 1 .. v_Client_Ids.Count Loop
      If Not Stm_General.Get_Client(p_Client_Id => v_Client_Ids(Client_Index),
                                    Out_Client  => v_Client,
                                    Out_Code    => v_Code,
                                    Out_Text    => v_Text) Then
        Rollback;
        Utils.Add(p_Results   => v_Results,
                  p_Object_Id => v_Client_Ids(Client_Index),
                  p_Result    => Stm_Const.c_Result_Error,
                  p_Code      => v_Code,
                  p_Text      => v_Text);
        Continue;
      End If;
    
      For Email_Index In 1 .. v_Emails.Count Loop
        v_Email     := Trim(v_Emails(Email_Index));
        v_Object_Id := v_Client.Id || ' ' || v_Email;
      
        If p_Reason = 'AUDITOR' Then
          v_Is_Auditor := 'Y';
        Else
          Begin
            Select t.Is_Auditor
              Into v_Is_Auditor
              From Dat_Black_Emails t
             Where t.Client_Id = v_Client.Id
               And Upper(t.Email) = Upper(v_Email);
          Exception
            When No_Data_Found Then
              Begin
                Select t.Is_Auditor
                  Into v_Is_Auditor
                  From Dat_Black_Emails t
                 Where t.Client_Id = 1000
                   And Upper(t.Email) = Upper(v_Email);
              Exception
                When No_Data_Found Then
                  v_Is_Auditor := 'N';
              End;
          End;
        End If;
      
        If Int_Block.Email_Block(p_Client_Id  => v_Client.Id,
                                 p_Email      => Lower(v_Email),
                                 p_Is_Auditor => v_Is_Auditor,
                                 p_Remark     => p_Remark,
                                 p_Reason     => p_Reason,
                                 Out_Id       => v_Id,
                                 Out_Code     => v_Code,
                                 Out_Text     => v_Text) Then
          Commit;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Ok,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        Else
          Rollback;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Error,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        End If;
      End Loop;
    End Loop;
  
    Return Utils.To_Cursor(v_Results);
  Exception
    When Others Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Sqlcode,
                p_Text    => Sqlerrm);
      Return Utils.To_Cursor(v_Results);
  End;

  Function Ip_Block(p_Ips          Varchar2,
                    p_Client_Group Varchar2,
                    p_Client_Ids   Varchar2,
                    p_Reason       Varchar2,
                    p_Remark       Varchar2) Return Sys_Refcursor Is
    v_Ips        Varchar_Array;
    v_Client_Ids Number_Array := Number_Array();
    v_Results    Result_Table := Result_Table();
    v_Client     Dat_Clients%Rowtype;
    v_Ip         Dat_Black_Ips.Ip_Address%Type;
    v_Object_Id  Varchar2(200);
    v_Id         Number;
    v_Code       Varchar2(4000);
    v_Text       Varchar2(4000);
    v_Is_Auditor Varchar2(1);
  Begin
    If Not Get_Clients(p_Client_Group => p_Client_Group,
                       p_Client_Ids   => p_Client_Ids,
                       Out_Client_Ids => v_Client_Ids,
                       Out_Code       => v_Code,
                       Out_Text       => v_Text) Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => v_Code,
                p_Text    => v_Text);
      Return Utils.To_Cursor(v_Results);
    End If;
  
    If Nvl(p_Reason, 'XXX') Not In
       ('FRAUDER', 'AUDITOR', 'VPN', 'SUSPICIOUS') Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => 'ERR_WRONG_REASON');
      Return Utils.To_Cursor(v_Results);
    End If;
  
    v_Ips := Utils.Split_String(p_Ips);
  
    For Client_Index In 1 .. v_Client_Ids.Count Loop
      If Not Stm_General.Get_Client(p_Client_Id => v_Client_Ids(Client_Index),
                                    Out_Client  => v_Client,
                                    Out_Code    => v_Code,
                                    Out_Text    => v_Text) Then
        Rollback;
        Utils.Add(p_Results   => v_Results,
                  p_Object_Id => v_Client_Ids(Client_Index),
                  p_Result    => Stm_Const.c_Result_Error,
                  p_Code      => v_Code,
                  p_Text      => v_Text);
        Continue;
      End If;
    
      For Ip_Index In 1 .. v_Ips.Count Loop
        v_Ip        := Trim(v_Ips(Ip_Index));
        v_Object_Id := v_Client.Id || ' ' || v_Ip;
      
        If p_Reason = 'AUDITOR' Then
          v_Is_Auditor := 'Y';
        Else
          Begin
            Select t.Is_Auditor
              Into v_Is_Auditor
              From Dat_Black_Ips t
             Where t.Client_Id = v_Client.Id
               And t.Ip_Address = v_Ip;
          Exception
            When No_Data_Found Then
              Begin
                Select t.Is_Auditor
                  Into v_Is_Auditor
                  From Dat_Black_Ips t
                 Where t.Client_Id = 1000
                   And t.Ip_Address = v_Ip;
              Exception
                When No_Data_Found Then
                  v_Is_Auditor := 'N';
              End;
          End;
        End If;
      
        If Int_Block.Ip_Block(p_Client_Id  => v_Client.Id,
                              p_Ip_Address => v_Ip,
                              p_Is_Auditor => v_Is_Auditor,
                              p_Remark     => p_Remark,
                              p_Reason     => p_Reason,
                              Out_Id       => v_Id,
                              Out_Code     => v_Code,
                              Out_Text     => v_Text) Then
          Commit;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Ok,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        Else
          Rollback;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Error,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        End If;
      End Loop;
    End Loop;
  
    Return Utils.To_Cursor(v_Results);
  Exception
    When Others Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Sqlcode,
                p_Text    => Sqlerrm);
      Return Utils.To_Cursor(v_Results);
  End;

  Function Ip_Unblock(p_Ips          Varchar2,
                      p_Client_Group Varchar2,
                      p_Client_Ids   Varchar2,
                      p_Reason       Varchar2,
                      p_Remark       Varchar2) Return Sys_Refcursor Is
    v_Ips        Varchar_Array;
    v_Client_Ids Number_Array := Number_Array();
    v_Results    Result_Table := Result_Table();
    v_Client     Dat_Clients%Rowtype;
    v_Ip         Dat_Black_Ips.Ip_Address%Type;
    v_Object_Id  Varchar2(200);
    v_Id         Number;
    v_Code       Varchar2(4000);
    v_Text       Varchar2(4000);
    v_Is_Vt      Varchar2(1);
  Begin
    If Not Get_Clients(p_Client_Group => p_Client_Group,
                       p_Client_Ids   => p_Client_Ids,
                       Out_Client_Ids => v_Client_Ids,
                       Out_Code       => v_Code,
                       Out_Text       => v_Text) Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => v_Code,
                p_Text    => v_Text);
      Return Utils.To_Cursor(v_Results);
    End If;
  
    If Nvl(p_Reason, 'XXX') Not In ('MERCHANT_VT') Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => 'ERR_WRONG_REASON');
      Return Utils.To_Cursor(v_Results);
    End If;
  
    v_Ips := Utils.Split_String(p_Ips);
  
    For Client_Index In 1 .. v_Client_Ids.Count Loop
      If Not Stm_General.Get_Client(p_Client_Id => v_Client_Ids(Client_Index),
                                    Out_Client  => v_Client,
                                    Out_Code    => v_Code,
                                    Out_Text    => v_Text) Then
        Rollback;
        Utils.Add(p_Results   => v_Results,
                  p_Object_Id => v_Client_Ids(Client_Index),
                  p_Result    => Stm_Const.c_Result_Error,
                  p_Code      => v_Code,
                  p_Text      => v_Text);
        Continue;
      End If;
    
      For Ip_Index In 1 .. v_Ips.Count Loop
        v_Ip        := Trim(v_Ips(Ip_Index));
        v_Object_Id := v_Client.Id || ' ' || v_Ip;
      
        If p_Reason = 'MERCHANT_VT' Then
          v_Is_Vt := 'Y';
        Else
          v_Is_Vt := 'N';
        End If;
      
        If Int_Block.Ip_Unblock(p_Client_Id  => v_Client.Id,
                                p_Ip_Address => v_Ip,
                                p_Remark     => p_Remark,
                                p_Is_Vt      => v_Is_Vt,
                                p_Reason     => p_Reason,
                                Out_Id       => v_Id,
                                Out_Code     => v_Code,
                                Out_Text     => v_Text) Then
          Commit;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Ok,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        Else
          Rollback;
          Utils.Add(p_Results   => v_Results,
                    p_Object_Id => v_Object_Id,
                    p_Result    => Stm_Const.c_Result_Error,
                    p_Code      => v_Code,
                    p_Text      => v_Text);
        End If;
      End Loop;
    End Loop;
  
    Return Utils.To_Cursor(v_Results);
  Exception
    When Others Then
      Rollback;
      Utils.Add(p_Results => v_Results,
                p_Result  => Stm_Const.c_Result_Error,
                p_Code    => Sqlcode,
                p_Text    => Sqlerrm);
      Return Utils.To_Cursor(v_Results);
  End;

  Function Get_Black_Cards(p_Client_Id      Varchar2,
                           p_Client_Group   Varchar2,
                           p_Card_Number    Varchar2,
                           p_Block_Reason   Varchar2,
                           p_Unblock_Reason Varchar2,
                           p_Allow          Varchar2,
                           p_Fixed          Varchar2,
                           p_Is_Auditor     Varchar2,
                           p_Pagenum        Number,
                           p_Perpage        Number,
                           Out_Cnt          Out Number) Return Sys_Refcursor Is
    v_Crs             Sys_Refcursor := Null;
    From_i            Number := 0;
    To_i              Number := 0;
    v_Client_Ids      Number_Array := Number_Array();
    v_Client_Ids_Used Varchar2(1);
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Client_Id Is Not Null And p_Client_Group Is Not Null Then
      v_Client_Ids_Used := 'Y';
      Select c.Id Bulk Collect
        Into v_Client_Ids
        From Dat_Clients c
       Where c.Id In
             (Select Column_Value
                From Table(Utils.Split_Number_String_Pipelined(p_Client_Id)))
         And (p_Client_Group Is Null Or
             (p_Client_Group Is Not Null And
             c.Group_Code In
             (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Client_Group)))));
    Else
      v_Client_Ids_Used := 'N';
    End If;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Black_Cards t
     Where (v_Client_Ids_Used = 'N' Or
           (v_Client_Ids_Used = 'Y' And
           t.Client_Id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
       And (p_Card_Number Is Null Or
           (p_Card_Number Is Not Null And
           t.Card_Number In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Card_Number)))))
       And (p_Block_Reason Is Null Or
           (p_Block_Reason Is Not Null And
           t.Block_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
       And (p_Unblock_Reason Is Null Or
           (p_Unblock_Reason Is Not Null And
           t.Unblock_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
       And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
       And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
       And (p_Is_Auditor = 'XXX' Or
           (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor));
  
    Open v_Crs For
      With Data As
       (Select t.*, Count(*) Over(Order By t.Mdate Desc, t.Id Desc) Rn
          From Dat_Black_Cards t
         Where (v_Client_Ids_Used = 'N' Or
               (v_Client_Ids_Used = 'Y' And
               t.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               t.Card_Number In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Card_Number)))))
           And (p_Block_Reason Is Null Or
               (p_Block_Reason Is Not Null And
               t.Block_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
           And (p_Unblock_Reason Is Null Or
               (p_Unblock_Reason Is Not Null And
               t.Unblock_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
           And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
           And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
           And (p_Is_Auditor = 'XXX' Or
               (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.Id,
             t.Client_Id,
             c.Name Client_Name,
             t.Date_Ini,
             t.Mdate,
             t.Card_Number,
             t.Allow,
             Decode(t.Allow, 'Y', 'Yes', 'N', 'No') Allow_Name,
             t.Fixed,
             Decode(t.Fixed, 'Y', 'Yes', 'N', 'No') Fixed_Name,
             t.Is_Auditor,
             Decode(t.Is_Auditor, 'Y', 'Yes', 'N', 'No') Is_Auditor_Name,
             t.Block_Reason,
             Br.Name Block_Reason_Name,
             t.Block_Score,
             t.Unblock_Reason,
             t.Unblock_Score,
             Ur.Name Unblock_Reason_Name,
             t.Remark,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Block,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Unblock
        From Page                t,
             Dat_Clients         c,
             Spr_Block_Reasons   Br,
             Spr_Unblock_Reasons Ur
       Where t.Client_Id = c.Id
         And t.Block_Reason = Br.Code(+)
         And t.Unblock_Reason = Ur.Code(+)
       Order By Rn;
    Return v_Crs;
  End;

  /*  Function Get_Black_Emails(p_Client_Id      Varchar2,
                              p_Client_Group   Varchar2,
                              p_Email          Varchar2,
                              p_Block_Reason   Varchar2,
                              p_Unblock_Reason Varchar2,
                              p_Allow          Varchar2,
                              p_Fixed          Varchar2,
                              p_Is_Auditor     Varchar2,
                              p_Pagenum        Number,
                              p_Perpage        Number,
                              Out_Cnt          Out Number) Return Sys_Refcursor Is
      v_Crs             Sys_Refcursor := Null;
      From_i            Number := 0;
      To_i              Number := 0;
      v_Client_Ids      Number_Array := Number_Array();
      v_Client_Ids_Used Varchar2(1);
    Begin
      From_i := p_Perpage * (p_Pagenum - 1) + 1;
      To_i   := (p_Perpage * p_Pagenum);
    
      If p_Client_Id Is Not Null Or p_Client_Group Is Not Null Then
        v_Client_Ids_Used := 'Y';
        Select c.Id Bulk Collect
          Into v_Client_Ids
          From Dat_Clients c
         Where (p_Client_Id Is Null Or
               (p_Client_Id Is Not Null And
               c.Id In
               (Select Column_Value
                    From Table(Utils.Split_Number_String_Pipelined(p_Client_Id)))))
           And (p_Client_Group Is Null Or
               (p_Client_Group Is Not Null And
               c.Group_Code In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Client_Group)))));
      Else
        v_Client_Ids_Used := 'N';
      End If;
    
      Select Count(*)
        Into Out_Cnt
        From Dat_Black_Emails t
       Where (v_Client_Ids_Used = 'N' Or
             (v_Client_Ids_Used = 'Y' And
             t.Client_Id In
             (Select Column_Value
                  From Table(Cast(v_Client_Ids As Number_Array)))))
         And (p_Email Is Null Or
             (p_Email Is Not Null And Exists
              (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Email))
                 Where Upper(t.Email) Like
                       Upper('%' || Trim(Column_Value) || '%'))))
         And (p_Block_Reason Is Null Or
             (p_Block_Reason Is Not Null And
             t.Block_Reason In
             (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
         And (p_Unblock_Reason Is Null Or
             (p_Unblock_Reason Is Not Null And
             t.Unblock_Reason In
             (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
         And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
         And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
         And (p_Is_Auditor = 'XXX' Or
             (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor));
    
      Open v_Crs For
        With Data As
         (Select t.*, Count(*) Over(Order By t.Mdate Desc, t.Id Desc) Rn
            From Dat_Black_Emails t
           Where (v_Client_Ids_Used = 'N' Or
                 (v_Client_Ids_Used = 'Y' And
                 t.Client_Id In
                 (Select Column_Value
                      From Table(Cast(v_Client_Ids As Number_Array)))))
             And (p_Email Is Null Or
                 (p_Email Is Not Null And Exists
                  (Select Column_Value
                      From Table(Utils.Split_String_Pipelined(p_Email))
                     Where Upper(t.Email) Like
                           Upper('%' || Trim(Column_Value) || '%'))))
             And (p_Block_Reason Is Null Or
                 (p_Block_Reason Is Not Null And
                 t.Block_Reason In
                 (Select Column_Value
                      From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
             And (p_Unblock_Reason Is Null Or
                 (p_Unblock_Reason Is Not Null And
                 t.Unblock_Reason In
                 (Select Column_Value
                      From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
             And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
             And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
             And (p_Is_Auditor = 'XXX' Or
                 (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor))),
        Page As
         (Select * From Data Where Rn Between From_i And To_i)
        Select t.Id,
               t.Client_Id,
               c.Name Client_Name,
               t.Date_Ini,
               t.Mdate,
               t.Email,
               t.Allow,
               Decode(t.Allow, 'Y', 'Yes', 'N', 'No') Allow_Name,
               t.Fixed,
               Decode(t.Fixed, 'Y', 'Yes', 'N', 'No') Fixed_Name,
               t.Is_Auditor,
               Decode(t.Is_Auditor, 'Y', 'Yes', 'N', 'No') Is_Auditor_Name,
               t.Block_Reason,
               Br.Name Block_Reason_Name,
               t.Block_Score,
               t.Unblock_Reason,
               t.Unblock_Score,
               Ur.Name Unblock_Reason_Name,
               t.Remark,
               Case
                 When t.Fixed = 'N' Then
                  'Y'
                 Else
                  'N'
               End Can_Block,
               Case
                 When t.Fixed = 'N' Then
                  'Y'
                 Else
                  'N'
               End Can_Unblock
          From Page                t,
               Dat_Clients         c,
               Spr_Block_Reasons   Br,
               Spr_Unblock_Reasons Ur
         Where t.Client_Id = c.Id
           And t.Block_Reason = Br.Code(+)
           And t.Unblock_Reason = Ur.Code(+)
         Order By Rn;
      Return v_Crs;
    End;
  */
  Function Get_Black_Emails(p_Client_Id      Varchar2,
                            p_Client_Group   Varchar2,
                            p_Email          Varchar2,
                            p_Block_Reason   Varchar2,
                            p_Unblock_Reason Varchar2,
                            p_Allow          Varchar2,
                            p_Fixed          Varchar2,
                            p_Is_Auditor     Varchar2,
                            p_Pagenum        Number,
                            p_Perpage        Number,
                            Out_Cnt          Out Number) Return Sys_Refcursor Is
    v_Crs             Sys_Refcursor := Null;
    From_i            Number := 0;
    To_i              Number := 0;
    v_Client_Ids      Number_Array := Number_Array();
    v_Client_Ids_Used Varchar2(1);
    v_Emails          Varchar_Array := Varchar_Array();
    v_Emails_Used     Varchar2(1);
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Client_Id Is Not Null Or p_Client_Group Is Not Null Then
      v_Client_Ids_Used := 'Y';
      Select c.Id Bulk Collect
        Into v_Client_Ids
        From Dat_Clients c
       Where (p_Client_Id Is Null Or
             (p_Client_Id Is Not Null And
             c.Id In
             (Select Column_Value
                  From Table(Utils.Split_Number_String_Pipelined(p_Client_Id)))))
         And (p_Client_Group Is Null Or
             (p_Client_Group Is Not Null And
             c.Group_Code In
             (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Client_Group)))));
    Else
      v_Client_Ids_Used := 'N';
    End If;
  
    If p_Email Is Not Null Then
      v_Emails_Used := 'Y';
      v_Emails      := Utils.Split_String(p_Email);
    Else
      v_Emails_Used := 'N';
    End If;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Black_Emails t
     Where (v_Client_Ids_Used = 'N' Or
           (v_Client_Ids_Used = 'Y' And
           t.Client_Id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
       And (v_Emails_Used = 'N' Or
           (v_Emails_Used = 'Y' And Exists
            (Select Column_Value
                From Table(Cast(v_Emails As Varchar_Array))
               Where Upper(t.Email) Like
                     Upper('%' || Trim(Column_Value) || '%'))))
       And (p_Block_Reason Is Null Or
           (p_Block_Reason Is Not Null And
           t.Block_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
       And (p_Unblock_Reason Is Null Or
           (p_Unblock_Reason Is Not Null And
           t.Unblock_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
       And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
       And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
       And (p_Is_Auditor = 'XXX' Or
           (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor));
  
    Open v_Crs For
      With Data As
       (Select t.*, Count(*) Over(Order By t.Mdate Desc, t.Id Desc) Rn
          From Dat_Black_Emails t
         Where (v_Client_Ids_Used = 'N' Or
               (v_Client_Ids_Used = 'Y' And
               t.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (v_Emails_Used = 'N' Or
               (v_Emails_Used = 'Y' And Exists
                (Select Column_Value
                    From Table(Cast(v_Emails As Varchar_Array))
                   Where Upper(t.Email) Like
                         Upper('%' || Trim(Column_Value) || '%'))))
           And (p_Block_Reason Is Null Or
               (p_Block_Reason Is Not Null And
               t.Block_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
           And (p_Unblock_Reason Is Null Or
               (p_Unblock_Reason Is Not Null And
               t.Unblock_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
           And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
           And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
           And (p_Is_Auditor = 'XXX' Or
               (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.Id,
             t.Client_Id,
             c.Name Client_Name,
             t.Date_Ini,
             t.Mdate,
             t.Email,
             t.Allow,
             Decode(t.Allow, 'Y', 'Yes', 'N', 'No') Allow_Name,
             t.Fixed,
             Decode(t.Fixed, 'Y', 'Yes', 'N', 'No') Fixed_Name,
             t.Is_Auditor,
             Decode(t.Is_Auditor, 'Y', 'Yes', 'N', 'No') Is_Auditor_Name,
             t.Block_Reason,
             Br.Name Block_Reason_Name,
             t.Block_Score,
             t.Unblock_Reason,
             t.Unblock_Score,
             Ur.Name Unblock_Reason_Name,
             t.Remark,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Block,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Unblock
        From Page                t,
             Dat_Clients         c,
             Spr_Block_Reasons   Br,
             Spr_Unblock_Reasons Ur
       Where t.Client_Id = c.Id
         And t.Block_Reason = Br.Code(+)
         And t.Unblock_Reason = Ur.Code(+)
       Order By Rn;
    Return v_Crs;
  End;

  Function Get_Black_Ips(p_Client_Id      Varchar2,
                         p_Client_Group   Varchar2,
                         p_Ip             Varchar2,
                         p_Block_Reason   Varchar2,
                         p_Unblock_Reason Varchar2,
                         p_Allow          Varchar2,
                         p_Fixed          Varchar2,
                         p_Is_Auditor     Varchar2,
                         p_Is_Vt          Varchar2,
                         p_Pagenum        Number,
                         p_Perpage        Number,
                         Out_Cnt          Out Number) Return Sys_Refcursor Is
    v_Crs             Sys_Refcursor := Null;
    From_i            Number := 0;
    To_i              Number := 0;
    v_Client_Ids      Number_Array := Number_Array();
    v_Client_Ids_Used Varchar2(1);
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Client_Id Is Not Null Or p_Client_Group Is Not Null Then
      v_Client_Ids_Used := 'Y';
      Select c.Id Bulk Collect
        Into v_Client_Ids
        From Dat_Clients c
       Where (p_Client_Id Is Null Or
             (p_Client_Id Is Not Null And
             c.Id In
             (Select Column_Value
                  From Table(Utils.Split_Number_String_Pipelined(p_Client_Id)))))
         And (p_Client_Group Is Null Or
             (p_Client_Group Is Not Null And
             c.Group_Code In
             (Select Column_Value
                  From Table(Utils.Split_String_Pipelined(p_Client_Group)))));
    Else
      v_Client_Ids_Used := 'N';
    End If;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Black_Ips t
     Where (v_Client_Ids_Used = 'N' Or
           (v_Client_Ids_Used = 'Y' And
           t.Client_Id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
       And (p_Ip Is Null Or
           (p_Ip Is Not Null And
           t.Ip_Address In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Ip)))))
       And (p_Block_Reason Is Null Or
           (p_Block_Reason Is Not Null And
           t.Block_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
       And (p_Unblock_Reason Is Null Or
           (p_Unblock_Reason Is Not Null And
           t.Unblock_Reason In
           (Select Column_Value
                From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
       And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
       And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
       And (p_Is_Auditor = 'XXX' Or
           (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor))
       And (p_Is_Vt = 'XXX' Or (p_Is_Vt <> 'XXX' And t.Is_Vt = p_Is_Vt));
  
    Open v_Crs For
      With Data As
       (Select t.*, Count(*) Over(Order By t.Mdate Desc, t.Id Desc) Rn
          From Dat_Black_Ips t
         Where (v_Client_Ids_Used = 'N' Or
               (v_Client_Ids_Used = 'Y' And
               t.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (p_Ip Is Null Or
               (p_Ip Is Not Null And
               t.Ip_Address In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Ip)))))
           And (p_Block_Reason Is Null Or
               (p_Block_Reason Is Not Null And
               t.Block_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Block_Reason)))))
           And (p_Unblock_Reason Is Null Or
               (p_Unblock_Reason Is Not Null And
               t.Unblock_Reason In
               (Select Column_Value
                    From Table(Utils.Split_String_Pipelined(p_Unblock_Reason)))))
           And (p_Allow = 'XXX' Or (p_Allow <> 'XXX' And t.Allow = p_Allow))
           And (p_Fixed = 'XXX' Or (p_Fixed <> 'XXX' And t.Fixed = p_Fixed))
           And (p_Is_Auditor = 'XXX' Or
               (p_Is_Auditor <> 'XXX' And t.Is_Auditor = p_Is_Auditor))
           And (p_Is_Vt = 'XXX' Or (p_Is_Vt <> 'XXX' And t.Is_Vt = p_Is_Vt))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.Id,
             t.Client_Id,
             c.Name Client_Name,
             t.Date_Ini,
             t.Mdate,
             t.Ip_Address Ip,
             t.Allow,
             Decode(t.Allow, 'Y', 'Yes', 'N', 'No') Allow_Name,
             t.Fixed,
             Decode(t.Fixed, 'Y', 'Yes', 'N', 'No') Fixed_Name,
             t.Is_Auditor,
             Decode(t.Is_Auditor, 'Y', 'Yes', 'N', 'No') Is_Auditor_Name,
             t.Is_Vt,
             Decode(t.Is_Vt, 'Y', 'Yes', 'N', 'No') Is_Vt_Name,
             t.Block_Reason,
             Br.Name Block_Reason_Name,
             t.Block_Score,
             t.Unblock_Reason,
             t.Unblock_Score,
             Ur.Name Unblock_Reason_Name,
             t.Remark,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Block,
             Case
               When t.Fixed = 'N' Then
                'Y'
               Else
                'N'
             End Can_Unblock
        From Page                t,
             Dat_Clients         c,
             Spr_Block_Reasons   Br,
             Spr_Unblock_Reasons Ur
       Where t.Client_Id = c.Id
         And t.Block_Reason = Br.Code(+)
         And t.Unblock_Reason = Ur.Code(+)
       Order By Rn;
    Return v_Crs;
  End;

  Function Get_Black_Orders(p_Order_Id          In Number,
                            p_Client_Id         In Number,
                            p_Group_Code        In Varchar2,
                            p_Date_Begin        In Varchar2,
                            p_Date_End          In Varchar2,
                            p_Card_Number       In Varchar2,
                            p_Email             In Varchar2,
                            p_Ip                In Varchar2,
                            p_Card_Number_Allow In Varchar2,
                            p_Email_Allow       In Varchar2,
                            p_Ip_Allow          In Varchar2,
                            p_Pagenum           In Number,
                            p_Perpage           In Number,
                            Out_Data            Out Sys_Refcursor,
                            Out_Code            Out Varchar2,
                            Out_Text            Out Varchar2) Return Number Is
    v_Crs       Sys_Refcursor;
    From_i      Number := 0;
    To_i        Number := 0;
    v_Client_Id Number := p_Client_Id;
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Order_Id <> 0 And p_Client_Id = 0 Then
      v_Client_Id := Substr(p_Order_Id, 1, 5);
    Elsif p_Client_Id = 0 And p_Group_Code Is Null Then
      Out_Code := 'ERR_NULL_GROUP_CODE_CLIENT_ID_ORDER_ID';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return Stm_Const.c_Result_Error;
    End If;
  
    Open Out_Data For
      With Data As
       (Select o.Id,
               o.Date_Order,
               o.Client_Id,
               o.Client_Bill_No,
               Substr(o.Card_Number, 1, 6) || '********' Card_Number,
               o.Billing_Email,
               o.Client_Ip,
               Be.Allow Email_Allow,
               Be.Date_Ini Email_Date_Ini,
               Be.Remark Email_Remark,
               Ip.Allow Ip_Allow,
               Ip.Fixed Ip_Fixed,
               Ip.Date_Ini Ip_Date_Ini,
               Ip.Remark Ip_Remark,
               Bc.Allow Card_Number_Allow,
               Bc.Remark Card_Number_Remark,
               Bc.Date_Ini Card_Number_Date_Ini,
               Count(*) Over() Cnt
          From (Select Id
                  From Dat_Clients c
                 Where (v_Client_Id = 0 Or
                       (v_Client_Id <> 0 And c.Id = v_Client_Id))
                   And (p_Group_Code Is Null Or (p_Group_Code Is Not Null And
                       c.Group_Code = p_Group_Code))) c,
               Dat_Orders o,
               Dat_Black_Emails Be,
               Dat_Black_Ips Ip,
               Dat_Black_Cards Bc
         Where o.Client_Id = c.Id
           And (p_Order_Id = 0 Or (p_Order_Id <> 0 And o.Id = p_Order_Id))
           And Be.Email(+) = Lower(o.Billing_Email)
           And Ip.Ip_Address(+) = o.Client_Ip
           And Bc.Card_Number(+) = o.Card_Number
           And (p_Date_Begin Is Null Or
               (p_Date_Begin Is Not Null And
               Trunc(o.Date_Order) >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
           And (p_Date_End Is Null Or
               (p_Date_End Is Not Null And
               Trunc(o.Date_Order) <= To_Date(p_Date_End, 'yyyy-mm-dd')))
           And (Be.Email Is Not Null Or Ip.Ip_Address Is Not Null Or
               Bc.Card_Number Is Not Null)
           And (p_Email Is Null Or
               (p_Email Is Not Null And
               o.Billing_Email Like '%' || p_Email || '%'))
           And (p_Ip Is Null Or (p_Ip Is Not Null And o.Client_Ip = p_Ip))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               o.Card_Number Like '%' || p_Card_Number || '%'))
           And (p_Ip_Allow = 'XXX' Or
               (p_Ip_Allow <> 'XXX' And Ip.Allow = p_Ip_Allow))
           And (p_Email_Allow = 'XXX' Or
               (p_Email_Allow <> 'XXX' And Be.Allow = p_Email_Allow))
           And (p_Card_Number_Allow = 'XXX' Or
               (p_Card_Number_Allow <> 'XXX' And
               Bc.Allow = p_Card_Number_Allow))
         Order By o.Date_Order Desc),
      Page As
       (Select *
          From (Select o.*, Rownum Rn From Data o)
         Where Rn Between From_i And To_i)
      Select o.*,
             c.Name Client_Name,
             Decode(o.Email_Allow, 'Y', 'Allow', 'N', 'Deny', o.Email_Allow) Email_Allow_Name,
             Decode(o.Ip_Allow, 'Y', 'Allow', 'N', 'Deny', o.Ip_Allow) Ip_Allow_Name,
             Decode(o.Ip_Fixed, 'Y', 'Fixed', 'N', 'No', o.Ip_Fixed) Ip_Fixed_Name,
             Decode(o.Card_Number_Allow,
                    'Y',
                    'Allow',
                    'N',
                    'Deny',
                    o.Card_Number_Allow) Card_Number_Allow_Name
        From Page o, Dat_Clients c
       Where c.Id = o.Client_Id;
  
    Out_Code := 'OK';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return Stm_Const.c_Result_Ok;
  End;

End Mng_Block;
/
