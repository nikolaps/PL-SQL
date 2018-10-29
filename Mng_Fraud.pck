CREATE OR REPLACE Package Mng_Fraud Is

  Function Get_Fraud_Checks(p_Client_Id          Varchar2,
                            p_Client_Group       Varchar2,
                            p_Order_Id           Varchar2,
                            p_Client_Bill_No     Varchar2,
                            p_Date_Begin         Varchar2,
                            p_Date_End           Varchar2,
                            p_Status             Varchar2,
                            p_Channel            Varchar2,
                            p_Channel_Group      Varchar2,
                            p_Bank_Type          Varchar2,
                            p_Settled            Varchar2,
                            p_Currency           Varchar2,
                            p_Ip                 Varchar2,
                            p_Card_Brand         Varchar2,
                            p_Card_Number        Varchar2,
                            p_Email              Varchar2,
                            p_Last_Name          Varchar2,
                            p_Billing_Descriptor Varchar2,
                            p_Bank_Order_Id      Varchar2,
                            p_Remarks            Varchar2,
                            p_Fraud_System       Varchar2,
                            p_Fraud_Trans_Id     Varchar2,
                            p_Fraud_Settled      Varchar2,
                            p_Is_Valid           Varchar2,
                            p_Real_Check         Varchar2,
                            p_Fraud_Description  Varchar2,
                            p_Settle_Id          Varchar2,
                            p_Kyc_Approved       Varchar2,
                            p_Pagenum            Number,
                            p_Perpage            Number,
                            Out_Cnt              Out Number)
    Return Sys_Refcursor;

  Function Get_Fraud_Checks_Rep(p_Client_Id          Varchar2,
                                p_Client_Group       Varchar2,
                                p_Order_Id           Varchar2,
                                p_Client_Bill_No     Varchar2,
                                p_Date_Begin         Varchar2,
                                p_Date_End           Varchar2,
                                p_Status             Varchar2,
                                p_Channel            Varchar2,
                                p_Channel_Group      Varchar2,
                                p_Bank_Type          Varchar2,
                                p_Settled            Varchar2,
                                p_Currency           Varchar2,
                                p_Ip                 Varchar2,
                                p_Card_Brand         Varchar2,
                                p_Card_Number        Varchar2,
                                p_Email              Varchar2,
                                p_Last_Name          Varchar2,
                                p_Billing_Descriptor Varchar2,
                                p_Bank_Order_Id      Varchar2,
                                p_Remarks            Varchar2,
                                p_Fraud_System       Varchar2,
                                p_Fraud_Trans_Id     Varchar2,
                                p_Fraud_Settled      Varchar2,
                                p_Is_Valid           Varchar2,
                                p_Real_Check         Varchar2,
                                p_Fraud_Description  Varchar2,
                                p_Settle_Id          Varchar2,
                                p_Kyc_Approved       Varchar2)
    Return Sys_Refcursor;

  Function Get_Spr_FA_Settings(p_Code         Varchar2,
                               p_Name         Varchar2,
                               p_Description  Varchar2,
                               p_Pagenum      Number,
                               p_Perpage      Number,
                               Out_Cnt        Out Number)
    Return Sys_Refcursor;

  Function Get_Spr_FA_Criterias(p_Code         Varchar2,
                                p_Name         Varchar2,
                                p_Description  Varchar2,
                                p_Pagenum      Number,
                                p_Perpage      Number,
                                Out_Cnt        Out Number)
    Return Sys_Refcursor;

  Function Get_FA_Checks(p_Id         Number,
                         p_Remark     Varchar2,
                         p_Date_Begin Varchar2,
                         p_Date_End   Varchar2,
                         p_Is_Valid   Varchar2,
                         p_Pagenum    Number,
                         p_Perpage    Number,
                         Out_Cnt      Out Number) 
    Return Sys_Refcursor;

  Function Get_IP_Checks(p_Description              Varchar2,
                         p_Country                  Varchar2,
                         p_Region                   Varchar2,
                         p_City                     Varchar2,
                         p_Zipcode                  Varchar2,
                         p_Provider                 Varchar2,
                         p_Geo_Location_Blacklisted Varchar2,
                         p_Client_Id                Varchar2,
                         p_Client_Group             Varchar2,
                         p_Order_Id                 Varchar2,
                         p_Client_Bill_No           Varchar2,
                         p_Date_Begin               Varchar2,
                         p_Date_End                 Varchar2,
                         p_Status                   Varchar2,
                         p_Channel                  Varchar2,
                         p_Channel_Group            Varchar2,
                         p_Bank_Type                Varchar2,
                         p_Settled                  Varchar2,
                         p_Currency                 Varchar2,
                         p_Ip                       Varchar2,
                         p_Card_Brand               Varchar2,
                         p_Card_Number              Varchar2,
                         p_Email                    Varchar2,
                         p_Last_Name                Varchar2,
                         p_Billing_Descriptor       Varchar2,
                         p_Bank_Order_Id            Varchar2,
                         p_Remarks                  Varchar2,
                         p_Fraud_Settled            Varchar2,
                         p_Is_Valid                 Varchar2,
                         p_Real_Check               Varchar2,
                         p_Settle_Id                Varchar2,
                         p_Pagenum                  Number,
                         p_Perpage                  Number,
                         Out_Cnt                    Out Number)
    Return Sys_Refcursor;

  Function Get_IP_Checks_Rep(p_Description              Varchar2,
                             p_Country                  Varchar2,
                             p_Region                   Varchar2,
                             p_City                     Varchar2,
                             p_Zipcode                  Varchar2,
                             p_Provider                 Varchar2,
                             p_Geo_Location_Blacklisted Varchar2,
                             p_Client_Id                Varchar2,
                             p_Client_Group             Varchar2,
                             p_Order_Id                 Varchar2,
                             p_Client_Bill_No           Varchar2,
                             p_Date_Begin               Varchar2,
                             p_Date_End                 Varchar2,
                             p_Status                   Varchar2,
                             p_Channel                  Varchar2,
                             p_Channel_Group            Varchar2,
                             p_Bank_Type                Varchar2,
                             p_Settled                  Varchar2,
                             p_Currency                 Varchar2,
                             p_Ip                       Varchar2,
                             p_Card_Brand               Varchar2,
                             p_Card_Number              Varchar2,
                             p_Email                    Varchar2,
                             p_Last_Name                Varchar2,
                             p_Billing_Descriptor       Varchar2,
                             p_Bank_Order_Id            Varchar2,
                             p_Remarks                  Varchar2,
                             p_Fraud_Settled            Varchar2,
                             p_Is_Valid                 Varchar2,
                             p_Real_Check               Varchar2,
                             p_Settle_Id                Varchar2)
    Return Sys_Refcursor;

  Function Fraud_Check_Kyc(p_Fraud_Check_Id Number,
                           p_Approved       Varchar2,
                           p_Date_End       Date,
                           Out_Code         Out Varchar2,
                           Out_Text         Out Varchar2) Return Number;

  Function Get_Fraud_Checks_Payments(p_Id           Number,
                                     p_Fraud_System Varchar2,
                                     p_Date_Begin   Varchar2,
                                     p_Date_End     Varchar2,
                                     p_Pagenum      Number,
                                     p_Perpage      Number,
                                     Out_Total      Out Sys_Refcursor,
                                     Out_Cnt        Out Number)
    Return Sys_Refcursor;

  Function Get_Fraud_Checks_Payments_Rep(p_Id           Number,
                                         p_Fraud_System Varchar2,
                                         p_Date_Begin   Varchar2,
                                         p_Date_End     Varchar2)
    Return Sys_Refcursor;

  Function Fraud_Check_Payment_Add(p_Fraud_System Varchar2,
                                   p_Amount       Number,
                                   p_Remark       Varchar2,
                                   Out_Code       Out Varchar2,
                                   Out_Text       Out Varchar2) Return Number;

  Function Fraud_Check_Payment_Delete(p_Id     Number,
                                      Out_Code Out Varchar2,
                                      Out_Text Out Varchar2) Return Number;

End Mng_Fraud;
/
CREATE OR REPLACE Package Body Mng_Fraud Is

  Function Get_Fraud_Checks(p_Client_Id          Varchar2,
                            p_Client_Group       Varchar2,
                            p_Order_Id           Varchar2,
                            p_Client_Bill_No     Varchar2,
                            p_Date_Begin         Varchar2,
                            p_Date_End           Varchar2,
                            p_Status             Varchar2,
                            p_Channel            Varchar2,
                            p_Channel_Group      Varchar2,
                            p_Bank_Type          Varchar2,
                            p_Settled            Varchar2,
                            p_Currency           Varchar2,
                            p_Ip                 Varchar2,
                            p_Card_Brand         Varchar2,
                            p_Card_Number        Varchar2,
                            p_Email              Varchar2,
                            p_Last_Name          Varchar2,
                            p_Billing_Descriptor Varchar2,
                            p_Bank_Order_Id      Varchar2,
                            p_Remarks            Varchar2,
                            p_Fraud_System       Varchar2,
                            p_Fraud_Trans_Id     Varchar2,
                            p_Fraud_Settled      Varchar2,
                            p_Is_Valid           Varchar2,
                            p_Real_Check         Varchar2,
                            p_Fraud_Description  Varchar2,
                            p_Settle_Id          Varchar2,
                            p_Kyc_Approved       Varchar2,
                            p_Pagenum            Number,
                            p_Perpage            Number,
                            Out_Cnt              Out Number)
    Return Sys_Refcursor Is
    v_Crs           Sys_Refcursor;
    From_i          Number := 0;
    To_i            Number := 0;
    v_Date_Begin    Date;
    v_Date_End      Date;
    v_Use_Order_Id  Varchar2(1) := 'N';
    v_Order_Id      Number_Array := Number_Array();
    v_Channels      Varchar_Array := Varchar_Array();
    v_Use_Channels  Varchar2(1) := 'N';
    v_Client_Ids    Number_Array := Number_Array();
    v_Use_Clients   Varchar2(1) := 'N';
    v_Settle_Id     Number_Array := Number_Array();
    v_Use_Settle_Id Varchar2(1) := 'N';
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Date_Begin Is Not Null Then
      v_Date_Begin := Utils.Char_To_Date(p_Date_Begin);
    Else
      v_Date_Begin := Trunc(Sysdate - 30);
    End If;
  
    If p_Date_End Is Not Null Then
      v_Date_End := Utils.Char_To_Date(p_Date_End);
    Else
      v_Date_End := Trunc(Sysdate) + 1 - Interval '1' Second; -- today 23:59:59
    End If;
  
    If p_Order_Id Is Not Null Then
      v_Use_Order_Id := 'Y';
      v_Order_Id     := Utils.Split_Number_String(p_Order_Id);
      Select Least(Min(Trunc(o.Date_Order))),
             Greatest(Max(Trunc(o.Date_Order)), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders o
       Where o.Id In
             (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)));
    End If;
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        Out_Used       => v_Use_Clients);
  
    v_Channels := Mng_Utils.Get_Channels_Codes_For_Filter(p_Channel       => p_Channel,
                                                          p_Channel_Group => p_Channel_Group,
                                                          p_Bank_Type     => p_Bank_Type,
                                                          Out_Used        => v_Use_Channels);
  
    If p_Settle_Id Is Not Null Then
      v_Use_Settle_Id := 'Y';
      v_Settle_Id     := Utils.Split_Number_String(p_Settle_Id);
      Select Least(Min(Trunc(f.Date_Create) - 1), v_Date_Begin),
             Greatest(Max(Trunc(f.Date_Create) + 1), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Fraud_Checks f
       Where Exists (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array))
               Where Column_Value = f.Settle_Id);
    End If;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Orders o, Dat_Fraud_Checks f
     Where f.Order_Id = o.Id
       And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
           Trunc(v_Date_End)
       And o.Date_Order Between v_Date_Begin And v_Date_End
       And (v_Use_Clients = 'N' Or
           (v_Use_Clients = 'Y' And
           o.Client_Id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
       And (v_Use_Order_Id = 'N' Or
           (v_Use_Order_Id = 'Y' And
           o.Id In
           (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)))))
       And (p_Client_Bill_No Is Null Or
           (p_Client_Bill_No Is Not Null And
           o.Client_Bill_No = p_Client_Bill_No))
       And (p_Status = 'XXX' Or (p_Status <> 'XXX' And o.Status = p_Status))
       And (v_Use_Channels = 'N' Or
           (v_Use_Channels = 'Y' And
           o.Channel In
           (Select Column_Value
                From Table(Cast(v_Channels As Varchar_Array)))))
       And (p_Settled = 'XXX' Or
           (p_Settled <> 'XXX' And o.Settled = p_Settled))
       And (p_Currency = 'XXX' Or
           (p_Currency <> 'XXX' And o.Currency = p_Currency))
       And (p_Ip Is Null Or
           (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
       And (p_Card_Brand = 'XXX' Or
           (p_Card_Brand <> 'XXX' And Exists
            (Select Bin
                From Spr_Bins b
               Where b.Bin = Substr(o.Card_Number, 1, 6)
                 And b.Card_Brand = p_Card_Brand)))
       And (p_Card_Number Is Null Or
           (p_Card_Number Is Not Null And
           o.Card_Number Like '%' || p_Card_Number || '%'))
       And (p_Email Is Null Or
           (p_Email Is Not Null And
           Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
       And (p_Last_Name Is Null Or
           (p_Last_Name Is Not Null And Upper(o.Billing_Last_Name) Like
           Upper('%' || p_Last_Name || '%')))
       And (p_Billing_Descriptor Is Null Or
           (p_Billing_Descriptor Is Not Null And
           Upper(o.Ecpss_Billing_Descriptor) Like
           Upper('%' || p_Billing_Descriptor || '%')))
       And (p_Bank_Order_Id Is Null Or (p_Bank_Order_Id Is Not Null And
           o.Ecpss_Order_No = p_Bank_Order_Id))
       And (p_Remarks Is Null Or
           (p_Remarks Is Not Null And
           (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
           Upper(o.Self_Error_Text) Like Upper('%' || p_Remarks || '%'))))
       And (p_Fraud_System = 'XXX' Or
           (p_Fraud_System <> 'XXX' And f.Fraud_System = p_Fraud_System))
       And (p_Fraud_Trans_Id Is Null Or
           (p_Fraud_Trans_Id Is Not Null And
           f.Fraud_Trans_Id = p_Fraud_Trans_Id))
       And (p_Fraud_Settled = 'XXX' Or
           (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
       And (p_Is_Valid = 'XXX' Or
           (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
       And (p_Real_Check = 'XXX' Or
           (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
       And (p_Fraud_Description Is Null Or
           (p_Fraud_Description Is Not Null And
           Upper(f.Fraud_Description) Like
           Upper('%' || p_Fraud_Description || '%')))
       And (v_Use_Settle_Id = 'N' Or
           (v_Use_Settle_Id = 'Y' And
           f.Settle_Id In
           (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array)))))
       And (p_Kyc_Approved = 'XXX' Or
           (p_Kyc_Approved <> 'XXX' And
           Nvl(f.Kyc_Approved, 'N') = p_Kyc_Approved));
  
    Open v_Crs For
      With Data As
       (Select o.Id Order_Id,
               o.Date_Order,
               o.Channel,
               o.Client_Id,
               o.Currency,
               o.Amount,
               o.Settled,
               o.Status,
               o.Ecpss_Remarks,
               o.Self_Error_Text,
               f.Id,
               f.Fraud_System,
               f.Fraud_Trans_Id,
               f.Fraud_Description,
               f.Is_Valid,
               f.Real_Check,
               f.Description,
               f.Settled Fraud_Settled,
               f.Settle_Id,
               f.Fee_Amount,
               Nvl(f.Kyc_Approved, 'N') Kyc_Approved,
               To_Char(f.Kyc_Date_Begin, 'yyyy-mm-dd') Kyc_Date_Begin,
               To_Char(f.Kyc_Date_End, 'yyyy-mm-dd') Kyc_Date_End,
               Count(*) Over(Order By o.Date_Order Desc, o.Id Desc, f.Fraud_System, f.Id Desc) Rn
          From Dat_Orders o, Dat_Fraud_Checks f
         Where f.Order_Id = o.Id
           And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
               Trunc(v_Date_End)
           And o.Date_Order Between v_Date_Begin And v_Date_End
           And (v_Use_Clients = 'N' Or
               (v_Use_Clients = 'Y' And
               o.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (v_Use_Order_Id = 'N' Or
               (v_Use_Order_Id = 'Y' And
               o.Id In
               (Select Column_Value
                    From Table(Cast(v_Order_Id As Number_Array)))))
           And (p_Client_Bill_No Is Null Or
               (p_Client_Bill_No Is Not Null And
               o.Client_Bill_No = p_Client_Bill_No))
           And (p_Status = 'XXX' Or
               (p_Status <> 'XXX' And o.Status = p_Status))
           And (v_Use_Channels = 'N' Or
               (v_Use_Channels = 'Y' And
               o.Channel In
               (Select Column_Value
                    From Table(Cast(v_Channels As Varchar_Array)))))
           And (p_Settled = 'XXX' Or
               (p_Settled <> 'XXX' And o.Settled = p_Settled))
           And (p_Currency = 'XXX' Or
               (p_Currency <> 'XXX' And o.Currency = p_Currency))
           And (p_Ip Is Null Or
               (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
           And (p_Card_Brand = 'XXX' Or
               (p_Card_Brand <> 'XXX' And Exists
                (Select Bin
                    From Spr_Bins b
                   Where b.Bin = Substr(o.Card_Number, 1, 6)
                     And b.Card_Brand = p_Card_Brand)))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               o.Card_Number Like '%' || p_Card_Number || '%'))
           And (p_Email Is Null Or
               (p_Email Is Not Null And
               Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
           And (p_Last_Name Is Null Or (p_Last_Name Is Not Null And
               Upper(o.Billing_Last_Name) Like
               Upper('%' || p_Last_Name || '%')))
           And (p_Billing_Descriptor Is Null Or
               (p_Billing_Descriptor Is Not Null And
               Upper(o.Ecpss_Billing_Descriptor) Like
               Upper('%' || p_Billing_Descriptor || '%')))
           And (p_Bank_Order_Id Is Null Or
               (p_Bank_Order_Id Is Not Null And
               o.Ecpss_Order_No = p_Bank_Order_Id))
           And (p_Remarks Is Null Or
               (p_Remarks Is Not Null And
               (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
               Upper(o.Self_Error_Text) Like
               Upper('%' || p_Remarks || '%'))))
           And (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And f.Fraud_System = p_Fraud_System))
           And (p_Fraud_Trans_Id Is Null Or
               (p_Fraud_Trans_Id Is Not Null And
               f.Fraud_Trans_Id = p_Fraud_Trans_Id))
           And (p_Fraud_Settled = 'XXX' Or
               (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
           And (p_Is_Valid = 'XXX' Or
               (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
           And (p_Real_Check = 'XXX' Or
               (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
           And (p_Fraud_Description Is Null Or
               (p_Fraud_Description Is Not Null And
               Upper(f.Fraud_Description) Like
               Upper('%' || p_Fraud_Description || '%')))
           And (v_Use_Settle_Id = 'N' Or
               (v_Use_Settle_Id = 'Y' And
               f.Settle_Id In
               (Select Column_Value
                    From Table(Cast(v_Settle_Id As Number_Array)))))
           And (p_Kyc_Approved = 'XXX' Or
               (p_Kyc_Approved <> 'XXX' And
               Nvl(f.Kyc_Approved, 'N') = p_Kyc_Approved))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select o.*,
             o.Ecpss_Remarks || ' (' || o.Self_Error_Text || ')' Remarks,
             Ch.Name Channel_Name,
             c.Name Client_Name,
             Fs.Name Fraud_System_Name,
             St.Name_2 Settled_Name,
             Decode(o.Fraud_Settled, 'Y', 'Yes', 'No') Fraud_Settled_Name,
             Decode(o.Is_Valid, 'Y', 'Yes', 'No') Is_Valid_Name,
             Decode(o.Real_Check, 'Y', 'Yes', 'No') Real_Check_Name,
             Decode(o.Kyc_Approved, 'Y', 'Yes', 'No') Kyc_Approved_Name,
             Case
               When o.Real_Check = 'Y' And o.Is_Valid = 'N' Then
                'Y'
               Else
                'N'
             End Can_Kyc_Approve
        From Page              o,
             Spr_Channels      Ch,
             Dat_Clients       c,
             Spr_Fraud_Systems Fs,
             Spr_Orders_Settle St
       Where Ch.Code = o.Channel
         And c.Id = o.Client_Id
         And Fs.Code = o.Fraud_System
         And St.Code = o.Settled
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Get_Fraud_Checks_Rep(p_Client_Id          Varchar2,
                                p_Client_Group       Varchar2,
                                p_Order_Id           Varchar2,
                                p_Client_Bill_No     Varchar2,
                                p_Date_Begin         Varchar2,
                                p_Date_End           Varchar2,
                                p_Status             Varchar2,
                                p_Channel            Varchar2,
                                p_Channel_Group      Varchar2,
                                p_Bank_Type          Varchar2,
                                p_Settled            Varchar2,
                                p_Currency           Varchar2,
                                p_Ip                 Varchar2,
                                p_Card_Brand         Varchar2,
                                p_Card_Number        Varchar2,
                                p_Email              Varchar2,
                                p_Last_Name          Varchar2,
                                p_Billing_Descriptor Varchar2,
                                p_Bank_Order_Id      Varchar2,
                                p_Remarks            Varchar2,
                                p_Fraud_System       Varchar2,
                                p_Fraud_Trans_Id     Varchar2,
                                p_Fraud_Settled      Varchar2,
                                p_Is_Valid           Varchar2,
                                p_Real_Check         Varchar2,
                                p_Fraud_Description  Varchar2,
                                p_Settle_Id          Varchar2,
                                p_Kyc_Approved       Varchar2)
    Return Sys_Refcursor Is
    v_Crs           Sys_Refcursor;
    v_Date_Begin    Date;
    v_Date_End      Date;
    v_Use_Order_Id  Varchar2(1) := 'N';
    v_Order_Id      Number_Array := Number_Array();
    v_Channels      Varchar_Array := Varchar_Array();
    v_Use_Channels  Varchar2(1) := 'N';
    v_Client_Ids    Number_Array := Number_Array();
    v_Use_Clients   Varchar2(1) := 'N';
    v_Settle_Id     Number_Array := Number_Array();
    v_Use_Settle_Id Varchar2(1) := 'N';
  Begin
  
    If p_Date_Begin Is Not Null Then
      v_Date_Begin := Utils.Char_To_Date(p_Date_Begin);
    Else
      v_Date_Begin := Trunc(Sysdate - 30);
    End If;
  
    If p_Date_End Is Not Null Then
      v_Date_End := Utils.Char_To_Date(p_Date_End);
    Else
      v_Date_End := Trunc(Sysdate) + 1 - Interval '1' Second; -- today 23:59:59
    End If;
  
    If p_Order_Id Is Not Null Then
      v_Use_Order_Id := 'Y';
      v_Order_Id     := Utils.Split_Number_String(p_Order_Id);
      Select Least(Min(Trunc(o.Date_Order))),
             Greatest(Max(Trunc(o.Date_Order)), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders o
       Where o.Id In
             (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)));
    End If;
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        Out_Used       => v_Use_Clients);
  
    v_Channels := Mng_Utils.Get_Channels_Codes_For_Filter(p_Channel       => p_Channel,
                                                          p_Channel_Group => p_Channel_Group,
                                                          p_Bank_Type     => p_Bank_Type,
                                                          Out_Used        => v_Use_Channels);
  
    If p_Settle_Id Is Not Null Then
      v_Use_Settle_Id := 'Y';
      v_Settle_Id     := Utils.Split_Number_String(p_Settle_Id);
      Select Least(Min(Trunc(f.Date_Create) - 1), v_Date_Begin),
             Greatest(Max(Trunc(f.Date_Create) + 1), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Fraud_Checks f
       Where Exists (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array))
               Where Column_Value = f.Settle_Id);
    End If;
  
    Open v_Crs For
      With Data As
       (Select o.Id,
               o.Date_Order,
               o.Channel,
               o.Client_Id,
               o.Currency,
               o.Amount,
               o.Settled,
               o.Status,
               o.Ecpss_Remarks,
               o.Self_Error_Text,
               o.Card_Number,
               o.Client_Ip,
               f.Fraud_System,
               f.Fraud_Trans_Id,
               f.Fraud_Description,
               f.Is_Valid,
               f.Real_Check,
               f.Settled Fraud_Settled,
               f.Settle_Id,
               f.Fee_Amount,
               Nvl(f.Kyc_Approved, 'N') Kyc_Approved,
               f.Kyc_Date_Begin,
               f.Kyc_Date_End,
               Count(*) Over(Order By o.Date_Order Desc, o.Id Desc, f.Fraud_System, f.Id Desc) Rn
          From Dat_Orders o, Dat_Fraud_Checks f
         Where f.Order_Id = o.Id
           And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
               Trunc(v_Date_End)
           And o.Date_Order Between v_Date_Begin And v_Date_End
           And (v_Use_Clients = 'N' Or
               (v_Use_Clients = 'Y' And
               o.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (v_Use_Order_Id = 'N' Or
               (v_Use_Order_Id = 'Y' And
               o.Id In
               (Select Column_Value
                    From Table(Cast(v_Order_Id As Number_Array)))))
           And (p_Client_Bill_No Is Null Or
               (p_Client_Bill_No Is Not Null And
               o.Client_Bill_No = p_Client_Bill_No))
           And (p_Status = 'XXX' Or
               (p_Status <> 'XXX' And o.Status = p_Status))
           And (v_Use_Channels = 'N' Or
               (v_Use_Channels = 'Y' And
               o.Channel In
               (Select Column_Value
                    From Table(Cast(v_Channels As Varchar_Array)))))
           And (p_Settled = 'XXX' Or
               (p_Settled <> 'XXX' And o.Settled = p_Settled))
           And (p_Currency = 'XXX' Or
               (p_Currency <> 'XXX' And o.Currency = p_Currency))
           And (p_Ip Is Null Or
               (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
           And (p_Card_Brand = 'XXX' Or
               (p_Card_Brand <> 'XXX' And Exists
                (Select Bin
                    From Spr_Bins b
                   Where b.Bin = Substr(o.Card_Number, 1, 6)
                     And b.Card_Brand = p_Card_Brand)))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               o.Card_Number Like '%' || p_Card_Number || '%'))
           And (p_Email Is Null Or
               (p_Email Is Not Null And
               Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
           And (p_Last_Name Is Null Or (p_Last_Name Is Not Null And
               Upper(o.Billing_Last_Name) Like
               Upper('%' || p_Last_Name || '%')))
           And (p_Billing_Descriptor Is Null Or
               (p_Billing_Descriptor Is Not Null And
               Upper(o.Ecpss_Billing_Descriptor) Like
               Upper('%' || p_Billing_Descriptor || '%')))
           And (p_Bank_Order_Id Is Null Or
               (p_Bank_Order_Id Is Not Null And
               o.Ecpss_Order_No = p_Bank_Order_Id))
           And (p_Remarks Is Null Or
               (p_Remarks Is Not Null And
               (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
               Upper(o.Self_Error_Text) Like
               Upper('%' || p_Remarks || '%'))))
           And (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And f.Fraud_System = p_Fraud_System))
           And (p_Fraud_Trans_Id Is Null Or
               (p_Fraud_Trans_Id Is Not Null And
               f.Fraud_Trans_Id = p_Fraud_Trans_Id))
           And (p_Fraud_Settled = 'XXX' Or
               (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
           And (p_Is_Valid = 'XXX' Or
               (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
           And (p_Real_Check = 'XXX' Or
               (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
           And (p_Fraud_Description Is Null Or
               (p_Fraud_Description Is Not Null And
               Upper(f.Fraud_Description) Like
               Upper('%' || p_Fraud_Description || '%')))
           And (v_Use_Settle_Id = 'N' Or
               (v_Use_Settle_Id = 'Y' And
               f.Settle_Id In
               (Select Column_Value
                    From Table(Cast(v_Settle_Id As Number_Array)))))
           And (p_Kyc_Approved = 'XXX' Or
               (p_Kyc_Approved <> 'XXX' And
               Nvl(f.Kyc_Approved, 'N') = p_Kyc_Approved)))
      Select o.Id,
             o.Date_Order,
             o.Client_Id,
             c.Name Client_Name,
             Ch.Name Channel,
             o.Currency,
             o.Amount,
             Os.Name_2 Status,
             o.Ecpss_Remarks || ' (' || o.Self_Error_Text || ')' Remarks,
             o.Client_Ip Ip,
             Substr(o.Card_Number, 1, 6) || '******' ||
             Substr(o.Card_Number, 13, 16) Card_Number,
             St.Name_2 Settled,
             Fs.Name Fraud_System,
             o.Fraud_Trans_Id,
             o.Fraud_Description,
             Decode(o.Is_Valid, 'Y', 'Yes', 'No') Is_Valid,
             Decode(o.Real_Check, 'Y', 'Yes', 'No') Real_Check,
             Decode(o.Kyc_Approved, 'Y', 'Yes', 'No') Kyc_Approved,
             o.Kyc_Date_Begin,
             o.Kyc_Date_End,
             Decode(o.Fraud_Settled, 'Y', 'Yes', 'No') Fraud_Settled,
             o.Settle_Id,
             o.Fee_Amount
        From Data              o,
             Spr_Channels      Ch,
             Dat_Clients       c,
             Spr_Fraud_Systems Fs,
             Spr_Orders_Settle St,
             Spr_Orders_Status Os
       Where Ch.Code = o.Channel
         And c.Id = o.Client_Id
         And Fs.Code = o.Fraud_System
         And St.Code = o.Settled
         And Os.Code = o.Status
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Get_Spr_FA_Settings(p_Code        Varchar2,
                               p_Name        Varchar2,
                               p_Description Varchar2,
                               p_Pagenum     Number,
                               p_Perpage     Number,
                               Out_Cnt       Out Number)
    Return Sys_Refcursor Is
    v_Crs  Sys_Refcursor;
    From_i Number := 0;
    To_i   Number := 0;
  
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    Select Count(*)
      Into Out_Cnt
      From Spr_FA_Settings
     Where (p_Code Is Null Or
           (p_Code Is Not Null And
           Upper(Code) Like Upper('%' || p_Code || '%')))
       And (p_Name Is Null Or
           (p_Name Is Not Null And
           Upper(Name) Like Upper('%' || p_Name || '%')))
       And (p_Description Is Null Or
           (p_Description Is Not Null And
           Upper(Description) Like Upper('%' || p_Description || '%')));
  
    Open v_Crs For
      With Data As
      (Select Code,
              Name,
              Description,
              Value,
              Count(*) Over(Order By Code Desc, Name Desc) Rn
         From Spr_FA_Settings
       Where (p_Code Is Null Or
             (p_Code Is Not Null And
             Upper(Code) Like Upper('%' || p_Code || '%')))
         And (p_Name Is Null Or
             (p_Name Is Not Null And
             Upper(Name) Like Upper('%' || p_Name || '%')))
         And (p_Description Is Null Or
             (p_Description Is Not Null And
             Upper(Description) Like Upper('%' || p_Description || '%')))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.*
        from Page t;
  
    Return v_Crs;
  End;

  Function Get_Spr_FA_Criterias(p_Code        Varchar2,
                                p_Name        Varchar2,
                                p_Description Varchar2,
                                p_Pagenum     Number,
                                p_Perpage     Number,
                                Out_Cnt       Out Number)
    Return Sys_Refcursor Is
    v_Crs  Sys_Refcursor;
    From_i Number := 0;
    To_i   Number := 0;
  
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    Select Count(*)
      Into Out_Cnt
      From Spr_FA_Criterias
     Where (p_Code Is Null Or
           (p_Code Is Not Null And
           Upper(Code) Like Upper('%' || p_Code || '%')))
       And (p_Name Is Null Or
           (p_Name Is Not Null And
           Upper(Name) Like Upper('%' || p_Name || '%')))
       And (p_Description Is Null Or
           (p_Description Is Not Null And
           Upper(Description) Like Upper('%' || p_Description || '%')));
  
    Open v_Crs For
      With Data As
      (Select Code,
              Name,
              Description,
              Count(*) Over(Order By Code Desc, Name Desc) Rn
         From Spr_FA_Criterias
       Where (p_Code Is Null Or
             (p_Code Is Not Null And
             Upper(Code) Like Upper('%' || p_Code || '%')))
         And (p_Name Is Null Or
             (p_Name Is Not Null And
             Upper(Name) Like Upper('%' || p_Name || '%')))
         And (p_Description Is Null Or
             (p_Description Is Not Null And
             Upper(Description) Like Upper('%' || p_Description || '%')))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.*
        from Page t;
  
    Return v_Crs;
  End;

  Function Get_FA_Checks(p_Id         Number,
                         p_Remark     Varchar2,
                         p_Date_Begin Varchar2,
                         p_Date_End   Varchar2,
                         p_Is_Valid   Varchar2,
                         p_Pagenum    Number,
                         p_Perpage    Number,
                         Out_Cnt      Out Number) 
    Return Sys_Refcursor Is
    v_Crs  Sys_Refcursor;
    From_i Number := 0;
    To_i   Number := 0;
  
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    Select Count(*)
      Into Out_Cnt
      From Dat_FA_Checks
     Where (p_Id Is Null Or (p_Id Is Not Null And Id = p_Id))
       And (p_Date_Begin is null or
           (p_Date_Begin is not null And
           Trunc(Date_Ini) >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
       And (p_Date_End is null or
           (p_Date_End is not null And
           Trunc(Date_Ini) <= To_Date(p_Date_End, 'yyyy-mm-dd')))
       And (p_Is_Valid = 'XXX' Or
           (p_Is_Valid <> 'XXX' And Is_Valid = p_Is_Valid))
       And (p_Remark Is Null Or
           (p_Remark Is Not Null And
           Upper(Remark) Like Upper('%' || p_Remark || '%')));
  
    Open v_Crs For
      With Data As
       (Select Id,
               Is_Valid,
               Date_Ini,
               Remark,
               Score,
               Count(*) Over(Order By Date_Ini Desc, Id Desc) Rn
          From Dat_FA_Checks
         Where (p_Id Is Null Or (p_Id Is Not Null And Id = p_Id))
           And (p_Date_Begin is null or
               (p_Date_Begin is not null And
               trunc(Date_Ini) >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
           And (p_Date_End is null or
               (p_Date_End is not null And
               trunc(Date_Ini) <= To_Date(p_Date_End, 'yyyy-mm-dd')))
           And (p_Is_Valid = 'XXX' Or
               (p_Is_Valid <> 'XXX' And Is_Valid = p_Is_Valid))
           And (p_Remark Is Null Or
               (p_Remark Is Not Null And
               Upper(Remark) Like Upper('%' || p_Remark || '%')))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select t.*, 
      Decode(t.Is_Valid, 'Y', 'Yes', 'N', 'No') Is_Valid_Name
        from Page t;
  
    Return v_Crs;
  End;

  Function Get_IP_Checks(p_Description              Varchar2,
                         p_Country                  Varchar2,
                         p_Region                   Varchar2,
                         p_City                     Varchar2,
                         p_Zipcode                  Varchar2,
                         p_Provider                 Varchar2,
                         p_Geo_Location_Blacklisted Varchar2,
                         p_Client_Id                Varchar2,
                         p_Client_Group             Varchar2,
                         p_Order_Id                 Varchar2,
                         p_Client_Bill_No           Varchar2,
                         p_Date_Begin               Varchar2,
                         p_Date_End                 Varchar2,
                         p_Status                   Varchar2,
                         p_Channel                  Varchar2,
                         p_Channel_Group            Varchar2,
                         p_Bank_Type                Varchar2,
                         p_Settled                  Varchar2,
                         p_Currency                 Varchar2,
                         p_Ip                       Varchar2,
                         p_Card_Brand               Varchar2,
                         p_Card_Number              Varchar2,
                         p_Email                    Varchar2,
                         p_Last_Name                Varchar2,
                         p_Billing_Descriptor       Varchar2,
                         p_Bank_Order_Id            Varchar2,
                         p_Remarks                  Varchar2,
                         p_Fraud_Settled            Varchar2,
                         p_Is_Valid                 Varchar2,
                         p_Real_Check               Varchar2,
                         p_Settle_Id                Varchar2,
                         p_Pagenum                  Number,
                         p_Perpage                  Number,
                         Out_Cnt                    Out Number)
    Return Sys_Refcursor Is
    v_Crs           Sys_Refcursor;
    From_i          Number := 0;
    To_i            Number := 0;
    v_Date_Begin    Date;
    v_Date_End      Date;
    v_Use_Order_Id  Varchar2(1) := 'N';
    v_Order_Id      Number_Array := Number_Array();
    v_Channels      Varchar_Array := Varchar_Array();
    v_Use_Channels  Varchar2(1) := 'N';
    v_Client_Ids    Number_Array := Number_Array();
    v_Use_Clients   Varchar2(1) := 'N';
    v_Settle_Id     Number_Array := Number_Array();
    v_Use_Settle_Id Varchar2(1) := 'N';
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    If p_Date_Begin Is Not Null Then
      v_Date_Begin := Utils.Char_To_Date(p_Date_Begin);
    Else
      v_Date_Begin := Trunc(Sysdate - 30);
    End If;
  
    If p_Date_End Is Not Null Then
      v_Date_End := Utils.Char_To_Date(p_Date_End);
    Else
      v_Date_End := Trunc(Sysdate) + 1 - Interval '1' Second; -- today 23:59:59
    End If;
  
    If p_Order_Id Is Not Null Then
      v_Use_Order_Id := 'Y';
      v_Order_Id     := Utils.Split_Number_String(p_Order_Id);
      Select Least(Min(Trunc(o.Date_Order))),
             Greatest(Max(Trunc(o.Date_Order)), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders o
       Where o.Id In
             (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)));
    End If;
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        Out_Used       => v_Use_Clients);
  
    v_Channels := Mng_Utils.Get_Channels_Codes_For_Filter(p_Channel       => p_Channel,
                                                          p_Channel_Group => p_Channel_Group,
                                                          p_Bank_Type     => p_Bank_Type,
                                                          Out_Used        => v_Use_Channels);
  
    If p_Settle_Id Is Not Null Then
      v_Use_Settle_Id := 'Y';
      v_Settle_Id     := Utils.Split_Number_String(p_Settle_Id);
      Select Least(Min(Trunc(f.Date_Ini) - 1), v_Date_Begin),
             Greatest(Max(Trunc(f.Date_Ini) + 1), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders_Ip_Checks f
       Where Exists (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array))
               Where Column_Value = f.Settle_Id);
    End If;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Orders o, Dat_Orders_Ip_Checks f
     Where f.Order_Id = o.Id
       And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
           Trunc(v_Date_End)
       And o.Date_Order Between v_Date_Begin And v_Date_End
       And (v_Use_Clients = 'N' Or
           (v_Use_Clients = 'Y' And
           o.Client_Id In
           (Select Column_Value
                From Table(Cast(v_Client_Ids As Number_Array)))))
          
       And (v_Use_Order_Id = 'N' Or
           (v_Use_Order_Id = 'Y' And
           o.Id In
           (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)))))
       And (p_Client_Bill_No Is Null Or
           (p_Client_Bill_No Is Not Null And
           o.Client_Bill_No = p_Client_Bill_No))
       And (p_Status = 'XXX' Or (p_Status <> 'XXX' And o.Status = p_Status))
       And (v_Use_Channels = 'N' Or
           (v_Use_Channels = 'Y' And
           o.Channel In
           (Select Column_Value
                From Table(Cast(v_Channels As Varchar_Array)))))
       And (p_Settled = 'XXX' Or
           (p_Settled <> 'XXX' And o.Settled = p_Settled))
       And (p_Currency = 'XXX' Or
           (p_Currency <> 'XXX' And o.Currency = p_Currency))
       And (p_Ip Is Null Or
           (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
       And (p_Card_Brand = 'XXX' Or
           (p_Card_Brand <> 'XXX' And Exists
            (Select Bin
                From Spr_Bins b
               Where b.Bin = Substr(o.Card_Number, 1, 6)
                 And b.Card_Brand = p_Card_Brand)))
       And (p_Card_Number Is Null Or
           (p_Card_Number Is Not Null And
           o.Card_Number Like '%' || p_Card_Number || '%'))
       And (p_Email Is Null Or
           (p_Email Is Not Null And
           Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
       And (p_Last_Name Is Null Or
           (p_Last_Name Is Not Null And Upper(o.Billing_Last_Name) Like
           Upper('%' || p_Last_Name || '%')))
       And (p_Billing_Descriptor Is Null Or
           (p_Billing_Descriptor Is Not Null And
           Upper(o.Ecpss_Billing_Descriptor) Like
           Upper('%' || p_Billing_Descriptor || '%')))
       And (p_Bank_Order_Id Is Null Or (p_Bank_Order_Id Is Not Null And
           o.Ecpss_Order_No = p_Bank_Order_Id))
       And (p_Remarks Is Null Or
           (p_Remarks Is Not Null And
           (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
           Upper(o.Self_Error_Text) Like Upper('%' || p_Remarks || '%'))))
       And (p_Fraud_Settled = 'XXX' Or
           (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
       And (p_Is_Valid = 'XXX' Or
           (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
       And (p_Real_Check = 'XXX' Or
           (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
       And (v_Use_Settle_Id = 'N' Or
           (v_Use_Settle_Id = 'Y' And
           f.Settle_Id In
           (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array)))))
       And (p_Geo_Location_Blacklisted = 'XXX' Or
           (p_Geo_Location_Blacklisted <> 'XXX' And
           f.Geo_Location_Blacklisted = p_Geo_Location_Blacklisted))
       And (p_Description Is Null Or
           (p_Description Is Not Null And
           Upper(f.Remark) Like Upper('%' || p_Description || '%')))
       And (p_Country Is Null Or
           (p_Country Is Not Null And
           Upper(f.Country_Code) Like Upper('%' || p_Country || '%')))
       And (p_Region Is Null Or
           (p_Region Is Not Null And
           Upper(f.Region) Like Upper('%' || p_Region || '%')))
       And (p_City Is Null Or
           (p_City Is Not Null And
           Upper(f.City) Like Upper('%' || p_City || '%')))
       And (p_Zipcode Is Null Or
           (p_Zipcode Is Not Null And
           Upper(f.Postal_Code) Like Upper('%' || p_Zipcode || '%')))
       And (p_Provider Is Null Or
           (p_Provider Is Not Null And
           Upper(f.Provider_Data) Like Upper('%' || p_Provider || '%')));
  
    Open v_Crs For
      With Data As
       (Select o.Id Order_Id,
               o.Date_Order,
               o.Channel,
               o.Client_Id,
               o.Currency,
               o.Amount,
               o.Settled,
               o.Status,
               o.Ecpss_Remarks,
               o.Self_Error_Text,
               f.Id,
               f.Is_Valid,
               f.Real_Check,
               f.Remark,
               f.Settled Fraud_Settled,
               f.Settle_Id,
               f.Fee_Amount,
               f.Country_Code,
               f.Region,
               f.City,
               f.Postal_Code,
               f.Provider_Data,
               f.Geo_Location_Blacklisted,
               Count(*) Over(Order By o.Date_Order Desc, o.Id Desc, f.Id Desc) Rn
          From Dat_Orders o, Dat_Orders_Ip_Checks f
         Where f.Order_Id = o.Id
           And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
               Trunc(v_Date_End)
           And o.Date_Order Between v_Date_Begin And v_Date_End
           And (v_Use_Clients = 'N' Or
               (v_Use_Clients = 'Y' And
               o.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array)))))
           And (v_Use_Order_Id = 'N' Or
               (v_Use_Order_Id = 'Y' And
               o.Id In
               (Select Column_Value
                    From Table(Cast(v_Order_Id As Number_Array)))))
           And (p_Client_Bill_No Is Null Or
               (p_Client_Bill_No Is Not Null And
               o.Client_Bill_No = p_Client_Bill_No))
           And (p_Status = 'XXX' Or
               (p_Status <> 'XXX' And o.Status = p_Status))
           And (v_Use_Channels = 'N' Or
               (v_Use_Channels = 'Y' And
               o.Channel In
               (Select Column_Value
                    From Table(Cast(v_Channels As Varchar_Array)))))
           And (p_Settled = 'XXX' Or
               (p_Settled <> 'XXX' And o.Settled = p_Settled))
           And (p_Currency = 'XXX' Or
               (p_Currency <> 'XXX' And o.Currency = p_Currency))
           And (p_Ip Is Null Or
               (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
           And (p_Card_Brand = 'XXX' Or
               (p_Card_Brand <> 'XXX' And Exists
                (Select Bin
                    From Spr_Bins b
                   Where b.Bin = Substr(o.Card_Number, 1, 6)
                     And b.Card_Brand = p_Card_Brand)))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               o.Card_Number Like '%' || p_Card_Number || '%'))
           And (p_Email Is Null Or
               (p_Email Is Not Null And
               Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
           And (p_Last_Name Is Null Or (p_Last_Name Is Not Null And
               Upper(o.Billing_Last_Name) Like
               Upper('%' || p_Last_Name || '%')))
           And (p_Billing_Descriptor Is Null Or
               (p_Billing_Descriptor Is Not Null And
               Upper(o.Ecpss_Billing_Descriptor) Like
               Upper('%' || p_Billing_Descriptor || '%')))
           And (p_Bank_Order_Id Is Null Or
               (p_Bank_Order_Id Is Not Null And
               o.Ecpss_Order_No = p_Bank_Order_Id))
           And (p_Remarks Is Null Or
               (p_Remarks Is Not Null And
               (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
               Upper(o.Self_Error_Text) Like
               Upper('%' || p_Remarks || '%'))))
           And (p_Fraud_Settled = 'XXX' Or
               (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
           And (p_Is_Valid = 'XXX' Or
               (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
           And (p_Real_Check = 'XXX' Or
               (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
           And (p_Description Is Null Or
               (p_Description Is Not Null And
               Upper(f.Remark) Like Upper('%' || p_Description || '%')))
           And (v_Use_Settle_Id = 'N' Or
               (v_Use_Settle_Id = 'Y' And
               f.Settle_Id In
               (Select Column_Value
                    From Table(Cast(v_Settle_Id As Number_Array)))))
           And (p_Geo_Location_Blacklisted = 'XXX' Or
               (p_Geo_Location_Blacklisted <> 'XXX' And
               f.Geo_Location_Blacklisted = p_Geo_Location_Blacklisted))
           And (p_Country Is Null Or
               (p_Country Is Not Null And
               Upper(f.Country_Code) Like Upper('%' || p_Country || '%')))
           And (p_Region Is Null Or
               (p_Region Is Not Null And
               Upper(f.Region) Like Upper('%' || p_Region || '%')))
           And (p_City Is Null Or
               (p_City Is Not Null And
               Upper(f.City) Like Upper('%' || p_City || '%')))
           And (p_Zipcode Is Null Or
               (p_Zipcode Is Not Null And
               Upper(f.Postal_Code) Like Upper('%' || p_Zipcode || '%')))
           And (p_Provider Is Null Or
               (p_Provider Is Not Null And
               Upper(f.Provider_Data) Like Upper('%' || p_Provider || '%')))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select o.*,
             o.Ecpss_Remarks || ' (' || o.Self_Error_Text || ')' Remarks,
             Ch.Name Channel_Name,
             c.Name Client_Name,
             St.Name_2 Settled_Name,
             Decode(o.Fraud_Settled, 'Y', 'Yes', 'No') Fraud_Settled_Name,
             Decode(o.Is_Valid, 'Y', 'Yes', 'No') Is_Valid_Name,
             Decode(o.Real_Check, 'Y', 'Yes', 'No') Real_Check_Name
        From Page o, Spr_Channels Ch, Dat_Clients c, Spr_Orders_Settle St
       Where Ch.Code = o.Channel
         And c.Id = o.Client_Id
         And St.Code = o.Settled
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Get_IP_Checks_Rep(p_Description              Varchar2,
                             p_Country                  Varchar2,
                             p_Region                   Varchar2,
                             p_City                     Varchar2,
                             p_Zipcode                  Varchar2,
                             p_Provider                 Varchar2,
                             p_Geo_Location_Blacklisted Varchar2,
                             p_Client_Id                Varchar2,
                             p_Client_Group             Varchar2,
                             p_Order_Id                 Varchar2,
                             p_Client_Bill_No           Varchar2,
                             p_Date_Begin               Varchar2,
                             p_Date_End                 Varchar2,
                             p_Status                   Varchar2,
                             p_Channel                  Varchar2,
                             p_Channel_Group            Varchar2,
                             p_Bank_Type                Varchar2,
                             p_Settled                  Varchar2,
                             p_Currency                 Varchar2,
                             p_Ip                       Varchar2,
                             p_Card_Brand               Varchar2,
                             p_Card_Number              Varchar2,
                             p_Email                    Varchar2,
                             p_Last_Name                Varchar2,
                             p_Billing_Descriptor       Varchar2,
                             p_Bank_Order_Id            Varchar2,
                             p_Remarks                  Varchar2,
                             p_Fraud_Settled            Varchar2,
                             p_Is_Valid                 Varchar2,
                             p_Real_Check               Varchar2,
                             p_Settle_Id                Varchar2)
    Return Sys_Refcursor Is
    v_Crs           Sys_Refcursor;
    v_Date_Begin    Date;
    v_Date_End      Date;
    v_Use_Order_Id  Varchar2(1) := 'N';
    v_Order_Id      Number_Array := Number_Array();
    v_Channels      Varchar_Array := Varchar_Array();
    v_Use_Channels  Varchar2(1) := 'N';
    v_Client_Ids    Number_Array := Number_Array();
    v_Use_Clients   Varchar2(1) := 'N';
    v_Settle_Id     Number_Array := Number_Array();
    v_Use_Settle_Id Varchar2(1) := 'N';
  Begin
  
    If p_Date_Begin Is Not Null Then
      v_Date_Begin := Utils.Char_To_Date(p_Date_Begin);
    Else
      v_Date_Begin := Trunc(Sysdate - 30);
    End If;
  
    If p_Date_End Is Not Null Then
      v_Date_End := Utils.Char_To_Date(p_Date_End);
    Else
      v_Date_End := Trunc(Sysdate) + 1 - Interval '1' Second; -- today 23:59:59
    End If;
  
    If p_Order_Id Is Not Null Then
      v_Use_Order_Id := 'Y';
      v_Order_Id     := Utils.Split_Number_String(p_Order_Id);
      Select Least(Min(Trunc(o.Date_Order))),
             Greatest(Max(Trunc(o.Date_Order)), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders o
       Where o.Id In
             (Select Column_Value
                From Table(Cast(v_Order_Id As Number_Array)));
    End If;
  
    v_Client_Ids := Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                                        p_Client_Group => p_Client_Group,
                                                        Out_Used       => v_Use_Clients);
  
    v_Channels := Mng_Utils.Get_Channels_Codes_For_Filter(p_Channel       => p_Channel,
                                                          p_Channel_Group => p_Channel_Group,
                                                          p_Bank_Type     => p_Bank_Type,
                                                          Out_Used        => v_Use_Channels);
  
    If p_Settle_Id Is Not Null Then
      v_Use_Settle_Id := 'Y';
      v_Settle_Id     := Utils.Split_Number_String(p_Settle_Id);
      Select Least(Min(Trunc(f.Date_Ini) - 1), v_Date_Begin),
             Greatest(Max(Trunc(f.Date_Ini) + 1), v_Date_End)
        Into v_Date_Begin, v_Date_End
        From Dat_Orders_Ip_Checks f
       Where Exists (Select Column_Value
                From Table(Cast(v_Settle_Id As Number_Array))
               Where Column_Value = f.Settle_Id);
    End If;
  
    Open v_Crs For
      With Data As
       (Select o.Id Order_Id,
               o.Date_Order,
               o.Channel,
               o.Client_Id,
               o.Currency,
               o.Amount,
               o.Settled,
               o.Status,
               o.Ecpss_Remarks,
               o.Self_Error_Text,
               o.Card_Number,
               o.Client_Ip,
               f.Id,
               f.Is_Valid,
               f.Real_Check,
               f.Remark,
               f.Settled Fraud_Settled,
               f.Settle_Id,
               f.Fee_Amount,
               f.Country_Code,
               f.Region,
               f.City,
               f.Postal_Code,
               f.Provider_Data,
               f.Geo_Location_Blacklisted,
               Count(*) Over(Order By o.Date_Order Desc, o.Id Desc, f.Id Desc) Rn
          From Dat_Orders o, Dat_Orders_Ip_Checks f
         Where f.Order_Id = o.Id
           And Trunc(o.Date_Order) Between Trunc(v_Date_Begin) And
               Trunc(v_Date_End)
           And o.Date_Order Between v_Date_Begin And v_Date_End
           And (v_Use_Clients = 'N' Or
               (v_Use_Clients = 'Y' And
               o.Client_Id In
               (Select Column_Value
                    From Table(Cast(v_Client_Ids As Number_Array))))) 
           And (v_Use_Order_Id = 'N' Or
               (v_Use_Order_Id = 'Y' And
               o.Id In
               (Select Column_Value
                    From Table(Cast(v_Order_Id As Number_Array)))))
           And (p_Client_Bill_No Is Null Or
               (p_Client_Bill_No Is Not Null And
               o.Client_Bill_No = p_Client_Bill_No))
           And (p_Status = 'XXX' Or
               (p_Status <> 'XXX' And o.Status = p_Status))
           And (v_Use_Channels = 'N' Or
               (v_Use_Channels = 'Y' And
               o.Channel In
               (Select Column_Value
                    From Table(Cast(v_Channels As Varchar_Array)))))
           And (p_Settled = 'XXX' Or
               (p_Settled <> 'XXX' And o.Settled = p_Settled))
           And (p_Currency = 'XXX' Or
               (p_Currency <> 'XXX' And o.Currency = p_Currency))
           And (p_Ip Is Null Or
               (p_Ip Is Not Null And Trim(o.Client_Ip) = Trim(p_Ip)))
           And (p_Card_Brand = 'XXX' Or
               (p_Card_Brand <> 'XXX' And Exists
                (Select Bin
                    From Spr_Bins b
                   Where b.Bin = Substr(o.Card_Number, 1, 6)
                     And b.Card_Brand = p_Card_Brand)))
           And (p_Card_Number Is Null Or
               (p_Card_Number Is Not Null And
               o.Card_Number Like '%' || p_Card_Number || '%'))
           And (p_Email Is Null Or
               (p_Email Is Not Null And
               Upper(o.Billing_Email) Like Upper('%' || p_Email || '%')))
           And (p_Last_Name Is Null Or (p_Last_Name Is Not Null And
               Upper(o.Billing_Last_Name) Like
               Upper('%' || p_Last_Name || '%')))
           And (p_Billing_Descriptor Is Null Or
               (p_Billing_Descriptor Is Not Null And
               Upper(o.Ecpss_Billing_Descriptor) Like
               Upper('%' || p_Billing_Descriptor || '%')))
           And (p_Bank_Order_Id Is Null Or
               (p_Bank_Order_Id Is Not Null And
               o.Ecpss_Order_No = p_Bank_Order_Id))
           And (p_Remarks Is Null Or
               (p_Remarks Is Not Null And
               (Upper(o.Ecpss_Remarks) Like Upper('%' || p_Remarks || '%') Or
               Upper(o.Self_Error_Text) Like
               Upper('%' || p_Remarks || '%'))))
           And (p_Fraud_Settled = 'XXX' Or
               (p_Fraud_Settled <> 'XXX' And f.Settled = p_Fraud_Settled))
           And (p_Is_Valid = 'XXX' Or
               (p_Is_Valid <> 'XXX' And f.Is_Valid = p_Is_Valid))
           And (p_Real_Check = 'XXX' Or
               (p_Real_Check <> 'XXX' And f.Real_Check = p_Real_Check))
           And (p_Description Is Null Or
               (p_Description Is Not Null And
               Upper(f.Remark) Like Upper('%' || p_Description || '%')))
           And (v_Use_Settle_Id = 'N' Or
               (v_Use_Settle_Id = 'Y' And
               f.Settle_Id In
               (Select Column_Value
                    From Table(Cast(v_Settle_Id As Number_Array)))))
           And (p_Geo_Location_Blacklisted = 'XXX' Or
               (p_Geo_Location_Blacklisted <> 'XXX' And
               f.Geo_Location_Blacklisted = p_Geo_Location_Blacklisted))
           And (p_Country Is Null Or
               (p_Country Is Not Null And
               Upper(f.Country_Code) Like Upper('%' || p_Country || '%')))
           And (p_Region Is Null Or
               (p_Region Is Not Null And
               Upper(f.Region) Like Upper('%' || p_Region || '%')))
           And (p_City Is Null Or
               (p_City Is Not Null And
               Upper(f.City) Like Upper('%' || p_City || '%')))
           And (p_Zipcode Is Null Or
               (p_Zipcode Is Not Null And
               Upper(f.Postal_Code) Like Upper('%' || p_Zipcode || '%')))
           And (p_Provider Is Null Or
               (p_Provider Is Not Null And
               Upper(f.Provider_Data) Like Upper('%' || p_Provider || '%'))))
      Select o.Id,
             o.Date_Order,
             o.Client_Id,
             c.Name Client_Name,
             Ch.Name Channel,
             o.Currency,
             o.Amount,
             Os.Name_2 Status,
             o.Ecpss_Remarks || ' (' || o.Self_Error_Text || ')' Remarks,
             o.Client_Ip Ip,
             Substr(o.Card_Number, 1, 6) || '******' ||
             Substr(o.Card_Number, 13, 16) Card_Number,
             St.Name_2 Settled,
             o.Remark,
             Decode(o.Is_Valid, 'Y', 'Yes', 'No') Is_Valid,
             Decode(o.Real_Check, 'Y', 'Yes', 'No') Real_Check,
             Decode(o.Fraud_Settled, 'Y', 'Yes', 'No') Fraud_Settled,
             o.Settle_Id,
             o.Fee_Amount
        From Data              o,
             Spr_Channels      Ch,
             Dat_Clients       c,
             Spr_Orders_Settle St,
             Spr_Orders_Status Os
       Where Ch.Code = o.Channel
         And c.Id = o.Client_Id
         And St.Code = o.Settled
         And Os.Code = o.Status
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Fraud_Check_Kyc(p_Fraud_Check_Id Number,
                           p_Approved       Varchar2,
                           p_Date_End       Date,
                           Out_Code         Out Varchar2,
                           Out_Text         Out Varchar2) Return Number Is
  Begin
    If Not Stm_Access.Check_User_Access(p_Access_Type => 'CAN_KYC_APPROVE',
                                        p_User_Id     => Stm_Access.Current_User_Id,
                                        Out_Code      => Out_Code,
                                        Out_Text      => Out_Text) Then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
  
    If Int_Fraud.Fraud_Check_Kyc(p_Fraud_Check_Id => p_Fraud_Check_Id,
                                 p_Approved       => p_Approved,
                                 p_Date_End       => p_Date_End,
                                 Out_Code         => Out_Code,
                                 Out_Text         => Out_Text) Then
      Commit;
      Return Stm_Const.c_Result_Ok;
    Else
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
  End;

  Function Get_Fraud_Checks_Payments(p_Id           Number,
                                     p_Fraud_System Varchar2,
                                     p_Date_Begin   Varchar2,
                                     p_Date_End     Varchar2,
                                     p_Pagenum      Number,
                                     p_Perpage      Number,
                                     Out_Total      Out Sys_Refcursor,
                                     Out_Cnt        Out Number)
    Return Sys_Refcursor Is
    v_Crs  Sys_Refcursor;
    From_i Number := 0;
    To_i   Number := 0;
  Begin
    From_i := p_Perpage * (p_Pagenum - 1) + 1;
    To_i   := (p_Perpage * p_Pagenum);
  
    Open Out_Total For
      With Fraud_Checks As
       (Select t.Fraud_System,
               Sum(Nvl(t.Fraud_System_Fee, Fs.Check_Fee)) Amount_Total,
               Count(*) Count_Total,
               Count(Decode(t.Paid_To_Fraud_System, 'Y', 1)) Count_Paid,
               Count(Decode(t.Paid_To_Fraud_System, 'N', 1, Null, 1)) Count_Not_Paid
          From Dat_Fraud_Checks t, Spr_Fraud_Systems Fs
         Where Fs.Code = t.Fraud_System
           And t.Real_Check = 'Y'
           And (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And t.Fraud_System = p_Fraud_System))
         Group By t.Fraud_System),
      Payments As
       (Select p.Fraud_System, Sum(p.Amount) Amount_Paid
          From Dat_Fraud_Checks_Payments p
         Where (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And p.Fraud_System = p_Fraud_System))
         Group By p.Fraud_System)
      Select Fs.Code Fraud_System,
             Fs.Name Fraud_System_Name,
             Nvl(t.Count_Total, 0) Count_Total,
             Nvl(t.Count_Paid, 0) Count_Paid,
             Nvl(t.Count_Not_Paid, 0) Count_Not_Paid,
             Trim(To_Char(Nvl(t.Amount_Total, 0), '99999999999999990.00')) Amount_Total,
             Trim(To_Char(Nvl(p.Amount_Paid, 0), '99999999999999990.00')) Amount_Paid,
             Case
               When Nvl(p.Amount_Paid, 0) > Nvl(t.Amount_Total, 0) Then
                Trim(To_Char(Nvl(p.Amount_Paid, 0) - Nvl(t.Amount_Total, 0),
                             '99999999999999990.00'))
               Else
                '0.00'
             End Amount_Prepaid,
             Case
               When Nvl(p.Amount_Paid, 0) < Nvl(t.Amount_Total, 0) Then
                Trim(To_Char(Nvl(t.Amount_Total, 0) - Nvl(p.Amount_Paid, 0),
                             '99999999999999990.00'))
               Else
                '0.00'
             End Amount_Debt
        From Spr_Fraud_Systems Fs, Fraud_Checks t, Payments p
       Where Fs.Code = t.Fraud_System(+)
         And Fs.Code = p.Fraud_System(+)
         And (p_Fraud_System = 'XXX' Or
             (p_Fraud_System <> 'XXX' And Fs.Code = p_Fraud_System))
       Order By Fs.Name;
  
    Select Count(*)
      Into Out_Cnt
      From Dat_Fraud_Checks_Payments p
     Where (p_Id Is Null Or (p_Id Is Not Null And p.Id = p_Id))
       And (p_Fraud_System = 'XXX' Or
           (p_Fraud_System <> 'XXX' And p.Fraud_System = p_Fraud_System))
       And (p_Date_Begin Is Null Or
           (p_Date_Begin Is Not Null And
           p.Date_Ini >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
       And (p_Date_End Is Null Or
           (p_Date_End Is Not Null And
           p.Date_Ini <= To_Date(p_Date_End, 'yyyy-mm-dd')));
  
    Open v_Crs For
      With Data As
       (Select p.*, Count(*) Over(Order By p.Id Desc) Rn
          From Dat_Fraud_Checks_Payments p
         Where (p_Id Is Null Or (p_Id Is Not Null And p.Id = p_Id))
           And (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And p.Fraud_System = p_Fraud_System))
           And (p_Date_Begin Is Null Or
               (p_Date_Begin Is Not Null And
               p.Date_Ini >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
           And (p_Date_End Is Null Or
               (p_Date_End Is Not Null And
               p.Date_Ini <= To_Date(p_Date_End, 'yyyy-mm-dd')))),
      Page As
       (Select * From Data Where Rn Between From_i And To_i)
      Select p.Id,
             p.Fraud_System,
             Fs.Name Fraud_System_Name,
             p.Date_Ini,
             Trim(To_Char(p.Amount_Prepaid, '99999999999999990.00')) Amount_Prepaid,
             Trim(To_Char(p.Amount, '99999999999999990.00')) Amount,
             Trim(To_Char(p.Fraud_Fee, '99999999999999990.00')) Fraud_Fee,
             Trim(To_Char(p.Paid_Count, '99999999999999990')) Paid_Count,
             Trim(To_Char(p.Amount_Rest, '99999999999999990.00')) Amount_Rest,
             Decode(p.Id, Last_Ids.Last_Id, 'Y', 'N') Can_Delete
        From Page p,
             Spr_Fraud_Systems Fs,
             (Select t.Fraud_System, Max(Id) Last_Id
                From Dat_Fraud_Checks_Payments t
               Group By t.Fraud_System) Last_Ids
       Where Fs.Code = p.Fraud_System
         And p.Fraud_System = Last_Ids.Fraud_System(+)
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Get_Fraud_Checks_Payments_Rep(p_Id           Number,
                                         p_Fraud_System Varchar2,
                                         p_Date_Begin   Varchar2,
                                         p_Date_End     Varchar2)
    Return Sys_Refcursor Is
    v_Crs Sys_Refcursor;
  Begin
    Open v_Crs For
      With Data As
       (Select p.*, Count(*) Over(Order By p.Id Desc) Rn
          From Dat_Fraud_Checks_Payments p
         Where (p_Id Is Null Or (p_Id Is Not Null And p.Id = p_Id))
           And (p_Fraud_System = 'XXX' Or
               (p_Fraud_System <> 'XXX' And p.Fraud_System = p_Fraud_System))
           And (p_Date_Begin Is Null Or
               (p_Date_Begin Is Not Null And
               p.Date_Ini >= To_Date(p_Date_Begin, 'yyyy-mm-dd')))
           And (p_Date_End Is Null Or
               (p_Date_End Is Not Null And
               p.Date_Ini <= To_Date(p_Date_End, 'yyyy-mm-dd'))))
      Select p.Id,
             Fs.Name Fraud_System,
             p.Date_Ini,
             Trim(To_Char(p.Amount_Prepaid, '99999999999999990.00')) Amount_Prepaid,
             Trim(To_Char(p.Amount, '99999999999999990.00')) Amount,
             Trim(To_Char(p.Fraud_Fee, '99999999999999990.00')) Fraud_Fee,
             Trim(To_Char(p.Paid_Count, '99999999999999990')) Paid_Count,
             Trim(To_Char(p.Amount_Rest, '99999999999999990.00')) Amount_Rest
        From Data p,
             Spr_Fraud_Systems Fs,
             (Select t.Fraud_System, Max(Id) Last_Id
                From Dat_Fraud_Checks_Payments t
               Group By t.Fraud_System) Last_Ids
       Where Fs.Code = p.Fraud_System
         And p.Fraud_System = Last_Ids.Fraud_System(+)
       Order By Rn;
  
    Return v_Crs;
  End;

  Function Fraud_Check_Payment_Add(p_Fraud_System Varchar2,
                                   p_Amount       Number,
                                   p_Remark       Varchar2,
                                   Out_Code       Out Varchar2,
                                   Out_Text       Out Varchar2) Return Number Is
  Begin
    If Not Int_Fraud.Fraud_Check_Payment_Add(p_Fraud_System => p_Fraud_System,
                                             p_Amount       => p_Amount,
                                             p_Remark       => p_Remark,
                                             Out_Code       => Out_Code,
                                             Out_Text       => Out_Text) Then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  End;

  Function Fraud_Check_Payment_Delete(p_Id     Number,
                                      Out_Code Out Varchar2,
                                      Out_Text Out Varchar2) Return Number Is
  Begin
    If Not Int_Fraud.Fraud_Check_Payment_Delete(p_Id     => p_Id,
                                                Out_Code => Out_Code,
                                                Out_Text => Out_Text) Then
      Rollback;
      Return Stm_Const.c_Result_Error;
    End If;
    Commit;
    Return Stm_Const.c_Result_Ok;
  End;

End Mng_Fraud;
/
