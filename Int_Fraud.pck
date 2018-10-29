CREATE OR REPLACE Package Int_Fraud Is

  Function Spr_Fa_Setting_Add(p_Code         Varchar2,
                              p_Name         Varchar2,
                              p_Description  Varchar2,
                              p_Value        Varchar2,
                              Out_Code       Out Varchar2,
                              Out_Text       Out Varchar2) 
   Return Boolean;

  Function Spr_Fa_Setting_Edit(p_Code         Varchar2,
                               p_Name         Varchar2,
                               p_Description  Varchar2,
                               p_Value        Varchar2,
                               Out_Code       Out Varchar2,
                               Out_Text       Out Varchar2) 
   Return Boolean;

  Function Spr_Fa_Setting_Delete(p_Code       Varchar2,
                                 Out_Code     Out Varchar2,
                                 Out_Text     Out Varchar2) 
   Return Boolean;

  Function Spr_Fa_Criteria_Add(p_Code        Varchar2,
                               p_Name        Varchar2,
                               p_Description Varchar2,
                               Out_Code      Out Varchar2,
                               Out_Text      Out Varchar2) 
   Return Boolean;
   
  Function Spr_Fa_Criteria_Edit(p_Code        Varchar2,
                                p_Name        Varchar2,
                                p_Description Varchar2,
                                Out_Code      Out Varchar2,
                                Out_Text      Out Varchar2) 
   Return Boolean;
   
  Function Spr_Fa_Criteria_Delete(p_Code      Varchar2,
                                  Out_Code    Out Varchar2,
                                  Out_Text    Out Varchar2) 
   Return Boolean;     

  Function Fraud_Check_Payment_Add(p_Fraud_System Varchar2,
                                   p_Amount       Number,
                                   p_Remark       Varchar2,
                                   Out_Code       Out Varchar2,
                                   Out_Text       Out Varchar2)
    Return Boolean;

  Function Fraud_Check_Payment_Delete(p_Id     Number,
                                      Out_Code Out Varchar2,
                                      Out_Text Out Varchar2) Return Boolean;

  Function Fraud_Check_Kyc(p_Fraud_Check_Id Number,
                           p_Approved       Varchar2,
                           p_Date_End       Date,
                           Out_Code         Out Varchar2,
                           Out_Text         Out Varchar2) Return Boolean;

End Int_Fraud;
/
CREATE OR REPLACE Package Body Int_Fraud Is

  Function Spr_Fa_Setting_Add(p_Code        Varchar2,
                              p_Name        Varchar2,
                              p_Description Varchar2,
                              p_Value       Varchar2,
                              Out_Code      Out Varchar2,
                              Out_Text      Out Varchar2) Return Boolean Is
    v_Setting Spr_Fa_Settings%Rowtype;
  Begin
    v_Setting.Code        := p_Code;
    v_Setting.Name        := p_Name;
    v_Setting.Description := p_Description;
    v_Setting.Value       := p_Value;
  
    If Trim(v_Setting.Code) Is Null Then
      Out_Code := 'ERR_NULL_CODE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(v_Setting.Name) Is Null Then
      Out_Code := 'ERR_NULL_NAME';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Insert Into Spr_Fa_Settings Values v_Setting;
  
    Out_Code := 'OK_ADD_SETTING';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Spr_Fa_Setting_Edit(p_Code        Varchar2,
                               p_Name        Varchar2,
                               p_Description Varchar2,
                               p_Value       Varchar2,
                               Out_Code      Out Varchar2,
                               Out_Text      Out Varchar2) Return Boolean Is
    v_Setting Spr_Fa_Settings%Rowtype := Null;
  Begin
    Begin
      Select * Into v_Setting From Spr_Fa_Settings t Where t.Code = p_Code;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_SETTING_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_SETTING_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End; 
    
    If Trim(p_Code) Is Null Then
      Out_Code := 'ERR_NULL_CODE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(p_Name) Is Null Then
      Out_Code := 'ERR_NULL_NAME';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;

    v_Setting.Code        := p_Code;
    v_Setting.Name        := p_Name;
    v_Setting.Description := p_Description;
    v_Setting.Value       := p_Value;

    Update Spr_Fa_Settings t
       Set t.Name        = v_Setting.Name,
           t.Description = v_Setting.Description,
           t.Value       = v_Setting.Value
     Where t.Code = v_Setting.Code;
  
    Out_Code := 'OK_EDIT_SETTING';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Spr_Fa_Setting_Delete(p_Code       Varchar2,
                                 Out_Code     Out Varchar2,
                                 Out_Text     Out Varchar2) Return Boolean Is
  Begin
  
    Delete From Spr_Fa_Settings Where Code = p_Code;
  
    Out_Code := 'OK_DELETE_SETTING';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Spr_Fa_Criteria_Add(p_Code        Varchar2,
                               p_Name        Varchar2,
                               p_Description Varchar2,
                               Out_Code      Out Varchar2,
                               Out_Text      Out Varchar2) Return Boolean Is
    v_Criteria Spr_Fa_Criterias%Rowtype;
  Begin
      If Trim(p_Code) Is Null Then
      Out_Code := 'ERR_NULL_CODE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(p_Name) Is Null Then
      Out_Code := 'ERR_NULL_NAME';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;  
  
    v_Criteria.Code        := p_Code;
    v_Criteria.Name        := p_Name;
    v_Criteria.Description := p_Description;
  
    Insert Into Spr_Fa_Criterias Values v_Criteria;
  
    Out_Code := 'OK_ADD_CRITERIA';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Spr_Fa_Criteria_Edit(p_Code        Varchar2,
                                p_Name        Varchar2,
                                p_Description Varchar2,
                                Out_Code      Out Varchar2,
                                Out_Text      Out Varchar2) Return Boolean Is
    v_Criteria Spr_Fa_Criterias%Rowtype := Null;
  Begin
    Begin
      Select * Into v_Criteria From Spr_Fa_Criterias t Where t.Code = p_Code;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_CRITERIA_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_CRITERIA_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End; 
  
    v_Criteria.Code        := p_Code;
    v_Criteria.Name        := p_Name;
    v_Criteria.Description := p_Description;
  
    If Trim(v_Criteria.Code) Is Null Then
      Out_Code := 'ERR_NULL_CODE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Trim(v_Criteria.Name) Is Null Then
      Out_Code := 'ERR_NULL_NAME';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;  
  
    Update Spr_Fa_Criterias t
       Set t.Name        = v_Criteria.Name,
           t.Description = v_Criteria.Description
     Where t.Code = v_Criteria.Code;
  
    Out_Code := 'OK_EDIT_CRITERIA';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Spr_Fa_Criteria_Delete(p_Code       Varchar2,
                                  Out_Code     Out Varchar2,
                                  Out_Text     Out Varchar2) Return Boolean Is
  Begin
  
    Delete From Spr_Fa_Criterias Where Code = p_Code;
  
    Out_Code := 'OK_DELETE_CRITERIA';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;


  Function Fraud_Check_Payment_Add(p_Fraud_System Varchar2,
                                   p_Amount       Number,
                                   p_Remark       Varchar2,
                                   Out_Code       Out Varchar2,
                                   Out_Text       Out Varchar2)
    Return Boolean Is
    v_Fraud_Sustem     Spr_Fraud_Systems%Rowtype;
    v_Last_Payment     Dat_Fraud_Checks_Payments%Rowtype;
    v_Payment          Dat_Fraud_Checks_Payments%Rowtype;
    v_Fraud_Checks_Ids Number_Array := Number_Array();
  Begin
    Begin
      Select *
        Into v_Fraud_Sustem
        From Spr_Fraud_Systems t
       Where t.Code = p_Fraud_System;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_FRAUD_SYSTEM_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    Begin
      Select *
        Into v_Last_Payment
        From Dat_Fraud_Checks_Payments t
       Where t.Id = (Select Max(p.Id)
                       From Dat_Fraud_Checks_Payments p
                      Where p.Fraud_System = v_Fraud_Sustem.Code)
         For Update Nowait;
    Exception
      When No_Data_Found Then
        v_Last_Payment := Null;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_LAST_PAYMENT_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    If p_Amount Is Null Or p_Amount < 0 Then
      Out_Code := 'ERR_WRONG_PAYMENT_AMOUNT';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Remark Is Not Null And Length(p_Remark) > 1000 Then
      Out_Code := 'ERR_LONG_REMARK';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Select Common_Sq.Nextval Into v_Payment.Id From Dual;
    v_Payment.Fraud_System   := v_Fraud_Sustem.Code;
    v_Payment.Date_Ini       := Sysdate;
    v_Payment.Status         := Stm_Const.c_Status_Entered;
    v_Payment.User_Id        := Stm_Access.Current_User_Id;
    v_Payment.Remark         := p_Remark;
    v_Payment.Amount_Prepaid := Nvl(v_Last_Payment.Amount_Rest, 0);
    v_Payment.Amount         := p_Amount;
    v_Payment.Fraud_Fee      := v_Fraud_Sustem.Check_Fee;
    v_Payment.Paid_Count     := Trunc((v_Payment.Amount_Prepaid +
                                      v_Payment.Amount) /
                                      v_Fraud_Sustem.Check_Fee);
  
    Select Id Bulk Collect
      Into v_Fraud_Checks_Ids
      From (Select Id, Row_Number() Over(Order By t.Id) Rn
              From Dat_Fraud_Checks t
             Where t.Fraud_System = v_Fraud_Sustem.Code
               And t.Real_Check = Stm_Const.c_Yes
               And Nvl(t.Paid_To_Fraud_System, 'N') = 'N'
               And t.Is_Valid <> 'P') t
     Where Rn <= v_Payment.Paid_Count;
  
    v_Payment.Paid_Count  := v_Fraud_Checks_Ids.Count;
    v_Payment.Amount_Rest := (v_Payment.Amount_Prepaid + v_Payment.Amount) -
                             v_Payment.Fraud_Fee * v_Payment.Paid_Count;
  
    Insert Into Dat_Fraud_Checks_Payments Values v_Payment;
  
    Forall i In 1 .. v_Fraud_Checks_Ids.Count
      Update Dat_Fraud_Checks t
         Set t.Paid_To_Fraud_System = Stm_Const.c_Yes,
             t.Fraud_System_Fee     = v_Payment.Fraud_Fee,
             t.Payment_Id           = v_Payment.Id
       Where t.Id = v_Fraud_Checks_Ids(i);
  
    Out_Code := 'OK_PAYMENT_ADD';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Out_Code := Sqlcode;
      Out_Text := Sqlerrm;
      Return False;
  End;

  Function Fraud_Check_Payment_Delete(p_Id     Number,
                                      Out_Code Out Varchar2,
                                      Out_Text Out Varchar2) Return Boolean Is
    v_Payment          Dat_Fraud_Checks_Payments%Rowtype;
    v_Fraud_Checks_Ids Number_Array := Number_Array();
    v_Cnt              Number;
  Begin
    Begin
      Select *
        Into v_Payment
        From Dat_Fraud_Checks_Payments t
       Where t.Id = p_Id
         For Update Nowait;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_PAYMENT_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_PAYMENT_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    Select Count(*)
      Into v_Cnt
      From Dat_Fraud_Checks_Payments t
     Where t.Id > v_Payment.Id
       And t.Fraud_System = v_Payment.Fraud_System;
  
    If v_Cnt > 0 Then
      Out_Code := 'ERR_FOUND_LATER_PAYMENTS';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    Select Id Bulk Collect
      Into v_Fraud_Checks_Ids
      From Dat_Fraud_Checks t
     Where t.Payment_Id = v_Payment.Id;
  
    If v_Fraud_Checks_Ids.Count <> v_Payment.Paid_Count Then
      Out_Code := 'ERR_DETAILS_NUMBER_NOT_SAME';
      Out_Text := Utils.Format(p_Str => 'Number of checks %1% dont same with number of paid checks %2%. Please check system',
                               p_V1  => v_Fraud_Checks_Ids.Count,
                               p_V2  => v_Payment.Paid_Count);
      Return False;
    End If;
  
    Forall i In 1 .. v_Fraud_Checks_Ids.Count
      Update Dat_Fraud_Checks t
         Set t.Paid_To_Fraud_System = Stm_Const.c_No,
             t.Fraud_System_Fee     = Null,
             t.Payment_Id           = Null
       Where t.Id = v_Fraud_Checks_Ids(i);
  
    Delete From Dat_Fraud_Checks_Payments t Where t.Id = v_Payment.Id;
  
    Out_Code := 'OK_PAYMENT_DELETE';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Out_Code := Sqlcode;
      Out_Text := Sqlerrm;
      Return False;
  End;

  Function Fraud_Check_Kyc(p_Fraud_Check_Id Number,
                           p_Approved       Varchar2,
                           p_Date_End       Date,
                           Out_Code         Out Varchar2,
                           Out_Text         Out Varchar2) Return Boolean Is
    v_Fraud_Check Dat_Fraud_Checks%Rowtype;
  Begin
    Begin
      Select *
        Into v_Fraud_Check
        From Dat_Fraud_Checks t
       Where t.Id = p_Fraud_Check_Id
         For Update Nowait;
    Exception
      When No_Data_Found Then
        Out_Code := 'ERR_FRAUD_CHECK_NOT_FOUND';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
      When Stm_Const.Err_Resource_Busy Then
        Out_Code := 'ERR_FRAUD_CHECK_BUSY';
        Out_Text := Stm_General.Get_Message_Text(Out_Code);
        Return False;
    End;
  
    If v_Fraud_Check.Real_Check <> Stm_Const.c_Yes Then
      Out_Code := 'ERR_FRAUD_CHECK_IS_NOT_REAL';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If v_Fraud_Check.Is_Valid <> Stm_Const.c_No Then
      Out_Code := 'ERR_FRAUD_CHECK_MUST_BE_NOT_VALID';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If Nvl(p_Approved, 'XXX') Not In (Stm_Const.c_Yes, Stm_Const.c_No) Then
      Out_Code := 'ERR_WRONG_APPROVED_VALUE';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Approved = Stm_Const.c_Yes And p_Date_End Is Null Then
      Out_Code := 'ERR_NULL_DATE_END';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Approved = Stm_Const.c_No And p_Date_End Is Not Null Then
      Out_Code := 'ERR_WRONG_DATE_END';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  
    If p_Approved = Stm_Const.c_Yes Then
      Update Dat_Fraud_Checks t
         Set t.Kyc_Approved   = p_Approved,
             t.Kyc_Date_Begin = Nvl(t.Kyc_Date_Begin, Sysdate),
             t.Kyc_Date_End   = p_Date_End
       Where t.Id = v_Fraud_Check.Id;
    Elsif p_Approved = Stm_Const.c_No Then
      Update Dat_Fraud_Checks t
         Set t.Kyc_Approved = p_Approved, t.Kyc_Date_End = Null
       Where t.Id = v_Fraud_Check.Id;
    End If;
  
    Out_Code := 'OK_FRAUD_CHECK_KYC_STATUS_CHANGED';
    Out_Text := Stm_General.Get_Message_Text(Out_Code);
    Return True;
  Exception
    When Others Then
      Out_Code := Sqlcode;
      Out_Text := Sqlerrm;
      Return False;
  End;

End Int_Fraud;
/
