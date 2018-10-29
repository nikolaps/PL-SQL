create or replace package Mng_Order_Dyn is

  Function Get_Transactions(p_Client_Id             Varchar2,
                            p_Client_Group          Varchar2,
                            p_Bo_Type               Varchar2,
                            p_Channel               Varchar2,
                            p_Channel_Group         Varchar2,
                            p_Bank_Type             Varchar2,
                            p_Channel_Mer_No        Varchar2,
                            p_Bin                   Varchar2,
                            p_Order_Id              Varchar2,
                            p_Client_Order_Id       Varchar2,
                            p_Bank_Order_Id         Varchar2,
                            p_Date_Order_Begin      Varchar2,
                            p_Date_Order_End        Varchar2,
                            p_Date_Refund_Begin     Varchar2,
                            p_Date_Refund_End       Varchar2,
                            p_Date_Chargeback_Begin Varchar2,
                            p_Date_Chargeback_End   Varchar2,
                            p_Status                Varchar2,
                            p_Refunded              Varchar2,
                            p_Chargebacked          Varchar2,
                            p_Preauth_Status        Varchar2,
                            p_Settled               Varchar2,
                            p_Settled_Reserve       Varchar2,
                            p_Bank_Paid             Varchar2,
                            p_Currency              Varchar2,
                            p_Currency_Original     Varchar2,
                            p_Amount_Begin          Number,
                            p_Amount_End            Number,
                            p_Amount_Original_Begin Number,
                            p_Amount_Original_End   Number,
                            p_Ip                    Varchar2,
                            p_Card_Number           Varchar2,
                            p_Card_Brand            Varchar2,
                            p_Refund_Settled        Varchar2,
                            p_Chargeback_Settled    Varchar2,
                            p_Email                 Varchar2,
                            p_Phone                 Varchar2,
                            p_Last_Name             Varchar2,
                            p_First_Name            Varchar2,
                            p_Billing_Descriptor    Varchar2,
                            p_Remark                Varchar2,
                            p_Bank_Remark           Varchar2,
                            p_Customer_Type         Varchar2,
                            p_Self_Vt               Varchar2,
                            p_Pagenum               Number,
                            p_Perpage               Number,
                            Out_Data                Out Sys_Refcursor,
                            Out_Total               Out Sys_Refcursor,
                            Out_Code                Out Varchar2,
                            Out_Text                Out Varchar2)
    Return Number;

  Function Get_Transactions_Rep(p_Client_Id             Varchar2,
                                p_Client_Group          Varchar2,
                                p_Bo_Type               Varchar2,
                                p_Channel               Varchar2,
                                p_Channel_Group         Varchar2,
                                p_Bank_Type             Varchar2,
                                p_Channel_Mer_No        Varchar2,
                                p_Bin                   Varchar2,
                                p_Order_Id              Varchar2,
                                p_Client_Order_Id       Varchar2,
                                p_Bank_Order_Id         Varchar2,
                                p_Date_Order_Begin      Varchar2,
                                p_Date_Order_End        Varchar2,
                                p_Date_Refund_Begin     Varchar2,
                                p_Date_Refund_End       Varchar2,
                                p_Date_Chargeback_Begin Varchar2,
                                p_Date_Chargeback_End   Varchar2,
                                p_Status                Varchar2,
                                p_Refunded              Varchar2,
                                p_Chargebacked          Varchar2,
                                p_Preauth_Status        Varchar2,
                                p_Settled               Varchar2,
                                p_Settled_Reserve       Varchar2,
                                p_Bank_Paid             Varchar2,
                                p_Currency              Varchar2,
                                p_Currency_Original     Varchar2,
                                p_Amount_Begin          Number,
                                p_Amount_End            Number,
                                p_Amount_Original_Begin Number,
                                p_Amount_Original_End   Number,
                                p_Ip                    Varchar2,
                                p_Card_Number           Varchar2,
                                p_Card_Brand            Varchar2,
                                p_Refund_Settled        Varchar2,
                                p_Chargeback_Settled    Varchar2,
                                p_Email                 Varchar2,
                                p_Phone                 Varchar2,
                                p_Last_Name             Varchar2,
                                p_First_Name            Varchar2,
                                p_Billing_Descriptor    Varchar2,
                                p_Remark                Varchar2,
                                p_Bank_Remark           Varchar2,
                                p_Customer_Type         Varchar2,
                                p_Self_Vt               Varchar2)
    Return Sys_Refcursor;

end Mng_Order_Dyn;
/
create or replace package body Mng_Order_Dyn is

  Function Check_Transactions_Params(p_Order_Id              Varchar2,
                                     p_Client_Order_Id       Varchar2,
                                     p_Bank_Order_Id         Varchar2,
                                     p_Date_Order_Begin      Varchar2,
                                     p_Date_Order_End        Varchar2,
                                     p_Date_Refund_Begin     Varchar2,
                                     p_Date_Refund_End       Varchar2,
                                     p_Date_Chargeback_Begin Varchar2,
                                     p_Date_Chargeback_End   Varchar2,
                                     p_Card_Number           Varchar2,
                                     p_Email                 Varchar2,
                                     p_Ip                    Varchar2,
                                     Out_Code                Out Varchar2,
                                     Out_Text                Out Varchar2)
    Return Boolean Is
  Begin
    If p_Order_Id Is Not Null Then
      Return True;
    Elsif p_Client_Order_Id Is Not Null Then
      Return True;
    Elsif p_Bank_Order_Id Is Not Null Then
      Return True;
    Elsif p_Date_Order_Begin Is Not Null And p_Date_Order_End Is Not Null Then
      If Not Utils.Check_Period(p_Date_Begin => p_Date_Order_Begin,
                                p_Date_End   => p_Date_Order_End,
                                p_Field      => 'DATE_ORDER',
                                Out_Code     => Out_Code,
                                Out_Text     => Out_Text) Then
        Return False;
      End If;
      Return True;
    Elsif p_Date_Refund_Begin Is Not Null And p_Date_Refund_End Is Not Null Then
      If Not Utils.Check_Period(p_Date_Begin => p_Date_Refund_Begin,
                                p_Date_End   => p_Date_Refund_End,
                                p_Field      => 'DATE_REFUND',
                                Out_Code     => Out_Code,
                                Out_Text     => Out_Text) Then
        Return False;
      End If;
      Return True;
    Elsif p_Date_Chargeback_Begin Is Not Null And
          p_Date_Chargeback_End Is Not Null Then
      If Not Utils.Check_Period(p_Date_Begin => p_Date_Chargeback_Begin,
                                p_Date_End   => p_Date_Chargeback_End,
                                p_Field      => 'DATE_CHARGEBACK',
                                Out_Code     => Out_Code,
                                Out_Text     => Out_Text) Then
        Return False;
      End If;
      Return True;
    Elsif p_Card_Number Is Not Null Then
      Return True;
    Elsif p_Email Is Not Null Then
      Return True;
    Elsif p_Ip Is Not Null Then
      Return True;
    Else
      Out_Code := 'ERR_REQUIRED_PARAMETERS_NOT_SPECIFIED';
      Out_Text := Stm_General.Get_Message_Text(Out_Code);
      Return False;
    End If;
  End;

  Function Get_Transactions_Request(p_Client_Id             Varchar2,
                                    p_Client_Group          Varchar2,
                                    p_Bo_Type               Varchar2,
                                    p_Channel               Varchar2,
                                    p_Channel_Group         Varchar2,
                                    p_Bank_Type             Varchar2,
                                    p_Channel_Mer_No        Varchar2,
                                    p_Bin                   Varchar2,
                                    p_Order_Id              Varchar2,
                                    p_Client_Order_Id       Varchar2,
                                    p_Bank_Order_Id         Varchar2,
                                    p_Date_Order_Begin      Varchar2,
                                    p_Date_Order_End        Varchar2,
                                    p_Date_Refund_Begin     Varchar2,
                                    p_Date_Refund_End       Varchar2,
                                    p_Date_Chargeback_Begin Varchar2,
                                    p_Date_Chargeback_End   Varchar2,
                                    p_Status                Varchar2,
                                    p_Refunded              Varchar2,
                                    p_Chargebacked          Varchar2,
                                    p_Preauth_Status        Varchar2,
                                    p_Settled               Varchar2,
                                    p_Settled_Reserve       Varchar2,
                                    p_Bank_Paid             Varchar2,
                                    p_Currency              Varchar2,
                                    p_Currency_Original     Varchar2,
                                    p_Amount_Begin          Number,
                                    p_Amount_End            Number,
                                    p_Amount_Original_Begin Number,
                                    p_Amount_Original_End   Number,
                                    p_Ip                    Varchar2,
                                    p_Card_Number           Varchar2,
                                    p_Card_Brand            Varchar2,
                                    p_Refund_Settled        Varchar2,
                                    p_Chargeback_Settled    Varchar2,
                                    p_Email                 Varchar2,
                                    p_Phone                 Varchar2,
                                    p_Last_Name             Varchar2,
                                    p_First_Name            Varchar2,
                                    p_Billing_Descriptor    Varchar2,
                                    p_Remark                Varchar2,
                                    p_Bank_Remark           Varchar2,
                                    p_Customer_Type         Varchar2,
                                    p_Self_Vt               Varchar2,
                                    Out_Request             Out Utl_Dyn_Sql.Utl_Sql_Request_Type,
                                    Out_Code                Out Varchar2,
                                    Out_Text                Out Varchar2)
    Return Boolean Is
    v_Request     Utl_Dyn_Sql.Utl_Sql_Request_Type;
    v_Client_Ids  Number_Array := Number_Array();
    v_Channels    Varchar_Array := Varchar_Array();
    v_Card_Number Varchar_Array := Varchar_Array();
    v_Phone       Varchar2(100) := Utils.Digits_Only(p_Phone);
  Begin
    If Not Check_Transactions_Params(p_Order_Id              => p_Order_Id,
                                     p_Client_Order_Id       => p_Client_Order_Id,
                                     p_Bank_Order_Id         => p_Bank_Order_Id,
                                     p_Date_Order_Begin      => p_Date_Order_Begin,
                                     p_Date_Order_End        => p_Date_Order_End,
                                     p_Date_Refund_Begin     => p_Date_Refund_Begin,
                                     p_Date_Refund_End       => p_Date_Refund_End,
                                     p_Date_Chargeback_Begin => p_Date_Chargeback_Begin,
                                     p_Date_Chargeback_End   => p_Date_Chargeback_End,
                                     p_Card_Number           => p_Card_Number,
                                     p_Email                 => p_Email,
                                     p_Ip                    => p_Ip,
                                     Out_Code                => Out_Code,
                                     Out_Text                => Out_Text) Then
      Return False;
    End If;
   
    v_Request             := Utl_Dyn_Sql.Create_Request(p_Tables => 'Dat_Orders o');
  
    If Mng_Utils.Get_Client_Ids_For_Filter(p_Client_Id    => p_Client_Id,
                                           p_Client_Group => p_Client_Group,
                                           p_Bo_Type      => p_Bo_Type,
                                           Out_Client_Ids => v_Client_Ids) Then
      Utl_Dyn_Sql.Add_Filter_In_Number_Array(p_Request     => v_Request,
                                             p_Column_Name => 'o.Client_Id',
                                             p_Value       => v_Client_Ids);
    End If;
  
    If Mng_Utils.Get_Channels_Codes_For_Filter(p_Channel        => p_Channel,
                                               p_Channel_Group  => p_Channel_Group,
                                               p_Bank_Type      => p_Bank_Type,
                                               p_Channel_Mer_No => p_Channel_Mer_No,
                                               Out_Channels     => v_Channels) Then
      Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                              p_Column_Name => 'o.Channel',
                                              p_Value       => v_Channels);
    End If;
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'Substr(o.Card_Number, 1, 6)',
                                            p_Value       => p_Bin);
  
    Utl_Dyn_Sql.Add_Filter_In_Number_Array(p_Request     => v_Request,
                                           p_Column_Name => 'o.Id',
                                           p_Value       => p_Order_Id);
  
    Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                 p_Column_Name => 'o.Client_Bill_No',
                                 p_Value       => p_Client_Order_Id);
  
    Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                 p_Column_Name => 'Trim(o.Ecpss_Order_No)',
                                 p_Value       => p_Bank_Order_Id);
  
    Utl_Dyn_Sql.Add_Filter_Between_Date_Time(p_Request     => v_Request,
                                             p_Column_Name => 'o.Date_Order',
                                             p_Value_1     => p_Date_Order_Begin,
                                             p_Value_2     => p_Date_Order_End);
  
    Utl_Dyn_Sql.Add_Filter_Between_Date_Time(p_Request     => v_Request,
                                             p_Column_Name => 'o.Date_Refund',
                                             p_Value_1     => p_Date_Refund_Begin,
                                             p_Value_2     => p_Date_Refund_End);
  
    Utl_Dyn_Sql.Add_Filter_Between_Date_Time(p_Request     => v_Request,
                                             p_Column_Name => 'o.Date_Chargeback',
                                             p_Value_1     => p_Date_Chargeback_Begin,
                                             p_Value_2     => p_Date_Chargeback_End);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Status',
                                            p_Value       => p_Status);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Refunded',
                                            p_Value       => p_Refunded);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Chargebacked',
                                            p_Value       => p_Chargebacked);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Preauth_Status',
                                            p_Value       => p_Preauth_Status);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Settled',
                                            p_Value       => p_Settled);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'Nvl(o.Settled_Reserve, ''N'')',
                                            p_Value       => p_Settled_Reserve);
  
    If p_Bank_Paid <> 'XXX' Then
      Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                   p_Column_Name => 'Nvl(o.Bank_Paid, ''N'')',
                                   p_Value       => p_Bank_Paid);
    End If;
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'o.Currency',
                                            p_Value       => p_Currency);
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'Nvl(o.Currency_Original, o.Currency)',
                                            p_Value       => p_Currency_Original);
  
    Utl_Dyn_Sql.Add_Filter_Between(p_Request     => v_Request,
                                   p_Column_Name => 'o.Amount',
                                   p_Value_1     => p_Amount_Begin,
                                   p_Value_2     => p_Amount_End);
  
    Utl_Dyn_Sql.Add_Filter_Between(p_Request     => v_Request,
                                   p_Column_Name => 'Nvl(o.Amount_Original, o.Amount)',
                                   p_Value_1     => p_Amount_Original_Begin,
                                   p_Value_2     => p_Amount_Original_End);
  
    Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                 p_Column_Name => 'o.Client_Ip',
                                 p_Value       => p_Ip);
  If p_Card_Number Is Not Null Then
    v_Card_Number := Utils.Split_String(Replace(p_Card_Number, '*', '%'));
    If v_Card_Number.Count = 1 Then
      Utils.Add(v_Request.Conditions, 'o.Card_Number like :Card_Number || ''%''');
      Utl_Dyn_Sql.Add_Bind(p_Binds => v_Request.Binds,
                           p_Name  => 'Card_Number',
                           p_Value => v_Card_Number(1));
    Else
      Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                              p_Column_Name => 'o.Card_Number',
                                              p_Value       => v_Card_Number);
    End If;
  End If;
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'Nvl(o.Card_Brand, (Select Upper(Trim(b.Card_Brand)) From Spr_Bins b Where b.Bin = Substr(o.Card_Number, 1, 6)))',
                                            p_Value       => p_Card_Brand);
  
    Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                 p_Column_Name => 'Upper(o.Billing_Email)',
                                 p_Value       => Upper(p_Email));
    
    Utl_Dyn_Sql.Add_Filter_Like(p_Request     => v_Request,
                                p_Column_Name => 'o.Billing_Phone_Digits',
                                p_Value       => v_Phone);
    
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'o.Billing_Last_Name',
                                      p_Value       => p_Last_Name);
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'o.Billing_First_Name',
                                      p_Value       => p_First_Name);
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'o.Ecpss_Billing_Descriptor',
                                      p_Value       => p_Billing_Descriptor);
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'o.Ecpss_Remarks',
                                      p_Value       => Trim(p_Remark));
  
    Utl_Dyn_Sql.Add_Filter_Like_Upper(p_Request     => v_Request,
                                      p_Column_Name => 'o.Self_Error_Text',
                                      p_Value       => Trim(p_Bank_Remark));
  
    Utl_Dyn_Sql.Add_Filter_In_Varchar_Array(p_Request     => v_Request,
                                            p_Column_Name => 'Nvl(o.Customer_Type, ''NAN'')',
                                            p_Value       => p_Customer_Type);
  
    If p_Self_Vt <> 'XXX' Then
      Utl_Dyn_Sql.Add_Filter_Equal(p_Request     => v_Request,
                                   p_Column_Name => 'Nvl(o.Self_Vt, ''N'')',
                                   p_Value       => p_Self_Vt);
    End If;
  
    Out_Request := v_Request;
  
    Return True;
  Exception
    When Others Then
      Utils.Process_Exception(Out_Code, Out_Text);
      Return False;
  End;

  Function Get_Transactions(p_Client_Id             Varchar2,
                            p_Client_Group          Varchar2,
                            p_Bo_Type               Varchar2,
                            p_Channel               Varchar2,
                            p_Channel_Group         Varchar2,
                            p_Bank_Type             Varchar2,
                            p_Channel_Mer_No        Varchar2,
                            p_Bin                   Varchar2,
                            p_Order_Id              Varchar2,
                            p_Client_Order_Id       Varchar2,
                            p_Bank_Order_Id         Varchar2,
                            p_Date_Order_Begin      Varchar2,
                            p_Date_Order_End        Varchar2,
                            p_Date_Refund_Begin     Varchar2,
                            p_Date_Refund_End       Varchar2,
                            p_Date_Chargeback_Begin Varchar2,
                            p_Date_Chargeback_End   Varchar2,
                            p_Status                Varchar2,
                            p_Refunded              Varchar2,
                            p_Chargebacked          Varchar2,
                            p_Preauth_Status        Varchar2,
                            p_Settled               Varchar2,
                            p_Settled_Reserve       Varchar2,
                            p_Bank_Paid             Varchar2,
                            p_Currency              Varchar2,
                            p_Currency_Original     Varchar2,
                            p_Amount_Begin          Number,
                            p_Amount_End            Number,
                            p_Amount_Original_Begin Number,
                            p_Amount_Original_End   Number,
                            p_Ip                    Varchar2,
                            p_Card_Number           Varchar2,
                            p_Card_Brand            Varchar2,
                            p_Refund_Settled        Varchar2,
                            p_Chargeback_Settled    Varchar2,
                            p_Email                 Varchar2,
                            p_Phone                 Varchar2,
                            p_Last_Name             Varchar2,
                            p_First_Name            Varchar2,
                            p_Billing_Descriptor    Varchar2,
                            p_Remark                Varchar2,
                            p_Bank_Remark           Varchar2,
                            p_Customer_Type         Varchar2,
                            p_Self_Vt               Varchar2,
                            p_Pagenum               Number,
                            p_Perpage               Number,
                            Out_Data                Out Sys_Refcursor,
                            Out_Total               Out Sys_Refcursor,
                            Out_Code                Out Varchar2,
                            Out_Text                Out Varchar2)
    Return Number Is
    v_Request Utl_Dyn_Sql.Utl_Sql_Request_Type;
    v_Columns Varchar_Array := Varchar_Array();
  Begin
    If Not Get_Transactions_Request(p_Client_Id             => p_Client_Id,
                                    p_Client_Group          => p_Client_Group,
                                    p_Bo_Type               => p_Bo_Type,
                                    p_Channel               => p_Channel,
                                    p_Channel_Group         => p_Channel_Group,
                                    p_Bank_Type             => p_Bank_Type,
                                    p_Channel_Mer_No        => p_Channel_Mer_No,
                                    p_Bin                   => p_Bin,
                                    p_Order_Id              => p_Order_Id,
                                    p_Client_Order_Id       => p_Client_Order_Id,
                                    p_Bank_Order_Id         => p_Bank_Order_Id,
                                    p_Date_Order_Begin      => p_Date_Order_Begin,
                                    p_Date_Order_End        => p_Date_Order_End,
                                    p_Date_Refund_Begin     => p_Date_Refund_Begin,
                                    p_Date_Refund_End       => p_Date_Refund_End,
                                    p_Date_Chargeback_Begin => p_Date_Chargeback_Begin,
                                    p_Date_Chargeback_End   => p_Date_Chargeback_End,
                                    p_Status                => p_Status,
                                    p_Refunded              => p_Refunded,
                                    p_Chargebacked          => p_Chargebacked,
                                    p_Preauth_Status        => p_Preauth_Status,
                                    p_Settled               => p_Settled,
                                    p_Settled_Reserve       => p_Settled_Reserve,
                                    p_Bank_Paid             => p_Bank_Paid,
                                    p_Currency              => p_Currency,
                                    p_Currency_Original     => p_Currency_Original,
                                    p_Amount_Begin          => p_Amount_Begin,
                                    p_Amount_End            => p_Amount_End,
                                    p_Amount_Original_Begin => p_Amount_Original_Begin,
                                    p_Amount_Original_End   => p_Amount_Original_End,
                                    p_Ip                    => p_Ip,
                                    p_Card_Number           => p_Card_Number,
                                    p_Card_Brand            => p_Card_Brand,
                                    p_Refund_Settled        => p_Refund_Settled,
                                    p_Chargeback_Settled    => p_Chargeback_Settled,
                                    p_Email                 => p_Email,
                                    p_Phone                 => p_Phone,
                                    p_Last_Name             => p_Last_Name,
                                    p_First_Name            => p_First_Name,
                                    p_Billing_Descriptor    => p_Billing_Descriptor,
                                    p_Remark                => p_Remark,
                                    p_Bank_Remark           => p_Bank_Remark,
                                    p_Customer_Type         => p_Customer_Type,
                                    p_Self_Vt               => p_Self_Vt,
                                    Out_Request             => v_Request,
                                    Out_Code                => Out_Code,
                                    Out_Text                => Out_Text) Then
      Return Stm_Const.c_Result_Error;
    End If;
  
    Out_Total := Utl_Dyn_Sql.Request_Group_By(p_Request          => v_Request,
                                              p_Data_Columns     => Varchar_Array('Sum(o.Amount) Amount_Total',
                                                                                  'Sum(Decode(o.Status, ''A'', o.Amount, 0)) Amount_Approved',
                                                                                  'Sum(Decode(o.Status, ''D'', o.Amount, 0)) Amount_Declined',
                                                                                  'Sum(Decode(o.Status, ''P'', o.Amount, 0)) Amount_Processing',
                                                                                  'Count(o.Id) Cnt_Total',
                                                                                  'Count(Decode(o.Status, ''A'', o.Id)) Cnt_Approved',
                                                                                  'Count(Decode(o.Status, ''D'', o.Id)) Cnt_Declined',
                                                                                  'Count(Decode(o.Status, ''P'', o.Id)) Cnt_Processing'),
                                              p_Group_By_Columns => Varchar_Array('o.Channel',
                                                                                  'o.Currency'),
                                              p_Final_Tables     => '(Select Decode(ch.Bank_Type, Null, ''Y'', ''N'') Is_Total,
           Row_Number() Over(Partition By ch.Bank_Type Order By o.Currency Nulls Last) Row_Num,
           Count(o.Currency) Over(Partition By ch.Bank_Type) Cnt_Curency,
           Decode(o.Currency, Null, ''Y'', ''N'') Is_Total_By_Bank,
           Nvl(ch.Bank_Type, ''Total'') Bank_Type,
           o.Currency,
           Trim(To_Char(Sum(Amount_Total), ''99G999G999G999G999G990D00'')) Amount_Total,
           Trim(To_Char(Sum(Amount_Approved), ''99G999G999G999G999G990D00'')) Amount_Approved,
           Trim(To_Char(Sum(Amount_Declined), ''99G999G999G999G999G990D00'')) Amount_Declined,
           Trim(To_Char(Sum(Amount_Processing), ''99G999G999G999G999G990D00'')) Amount_Processing,
           Trim(To_Char(Sum(Cnt_Total), ''99G999G999G999G999G990'')) Cnt_Total,
           Trim(To_Char(Sum(Cnt_Approved), ''99G999G999G999G999G990'')) Cnt_Approved,
           Trim(To_Char(Sum(Cnt_Declined), ''99G999G999G999G999G990'')) Cnt_Declined,
           Trim(To_Char(Sum(Cnt_Processing), ''99G999G999G999G999G990'')) Cnt_Processing
      From Data o, Spr_Channels ch
     Where o.Channel = ch.Code
     Group By Cube(ch.Bank_Type, o.Currency)
     Order By ch.Bank_Type Nulls First, o.Currency Nulls Last)');
  
    Utils.Add(v_Columns, 'o.Client_Id');
    Utils.Add(v_Columns, 'c.Name Client_Name');
    Utils.Add(v_Columns, 'o.Id Order_Id');
    Utils.Add(v_Columns, 'o.Client_Bill_No Client_Order_Id');
    Utils.Add(v_Columns, 'o.Currency');
    Utils.Add(v_Columns, 'o.Date_Order Date_Order');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount, ''99999999999999990.00'')) Amount');
    Utils.Add(v_Columns, 'o.Currency_Original');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount_Original, ''99999999999999990.00'')) Amount_Original');
    Utils.Add(v_Columns, 'c.Converted_Currency');
    Utils.Add(v_Columns,
              'Trim(To_Char(Round(Decode(o.Currency,
                                       c.Converted_Currency,
                                       o.Amount,
                                       o.Amount * Rt.Rate),2),''99999999999999990.00'')) Converted_Amount');
  
    Utils.Add(v_Columns, 'o.Status');
    Utils.Add(v_Columns, 'Ss.Name_2 Status_Name');
    Utils.Add(v_Columns, 'o.Refunded');
    Utils.Add(v_Columns, 'Sr.Name_2 Refunded_Name');
    Utils.Add(v_Columns, 'o.Settled');
    Utils.Add(v_Columns, 'St.Name_2 Settled_Name');
    Utils.Add(v_Columns, 'o.Chargebacked');
    Utils.Add(v_Columns, 'Sc.Name_2 Chargebacked_Name');
    Utils.Add(v_Columns, 'o.Ecpss_Billing_Descriptor Billing_Descriptor');
    Utils.Add(v_Columns, 'o.Ecpss_Remarks Remark');
    Utils.Add(v_Columns, 'o.Self_Error_Text Bank_Remark');
    Utils.Add(v_Columns, 'o.Ecpss_Order_No Bank_Order_Id');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount_Refund, ''99999999999999990.00'')) Amount_Refund');
    Utils.Add(v_Columns, 'o.Channel');
    Utils.Add(v_Columns, 'Ch.Name Channel_Name');
    Utils.Add(v_Columns, 'o.Billing_Country Country');
    Utils.Add(v_Columns, 'Substr(o.Card_Number, 1, 6) || ''******'' || Substr(o.Card_Number, -2) Card_Number');
    Utils.Add(v_Columns, 'o.Billing_Email');
    Utils.Add(v_Columns, 'o.Client_Ip');
    Utils.Add(v_Columns, 'o.Amount Amount_Num');
    Utils.Add(v_Columns, 'o.Amount_Refund Amount_Refund_Num');
    Utils.Add(v_Columns, 'Ch.Is_Refund');
    Utils.Add(v_Columns, 'Ch.Is_Cb');
    Utils.Add(v_Columns, 'Ch.Is_Check');
    Utils.Add(v_Columns, 'Null Ars_Reason');
    Utils.Add(v_Columns, 'o.Preauth_Status');
    Utils.Add(v_Columns, 'Pas.Name_2 Preauth_Status');
    Utils.Add(v_Columns, 'Bn.Card_Brand');
    Utils.Add(v_Columns, 'Rst.Name_2 Settled_Reserve');
    Utils.Add(v_Columns, 'Ch.Fraud_Check Channel_Antifraud_Enabled');
    Utils.Add(v_Columns,
              'Case
               When (Select Count(*)
                       From Dat_Fraud_Checks t
                      Where t.Order_Id = o.Id
                        And t.Fraud_System = ''ATF''
                        And (t.Real_Check = ''Y'' Or
                            (t.Real_Check = ''N'' And
                            t.Method In
                            (''CARDHOLDER_INVALIDATED_2_WEEKS_AGO'',
                               ''CARDHOLDER_ALREADY_VALIDATED'')))) > 0 Then
                ''Y''
               Else
                ''N''
             End Checked_By_Fraud_System');
    Utils.Add(v_Columns, 'o.Customer_Type');
    Utils.Add(v_Columns, 'o.Self_Vt');
    Utils.Add(v_Columns,
              'Decode(o.Self_Vt, ''Y'', ''Yes'', ''N'', ''No'') Self_Vt_Name');
  
    Out_Data := Utl_Dyn_Sql.Request_Page(p_Request            => v_Request,
                                         p_Data_Columns       => Varchar_Array('o.Client_Id',
                                                                               'o.Id',
                                                                               'o.Client_Bill_No',
                                                                               'o.Currency',
                                                                               'o.Date_Order',
                                                                               'o.Amount',
                                                                               'o.Currency_Original',
                                                                               'o.Amount_Original',
                                                                               'o.Refunded',
                                                                               'o.Settled',
                                                                               'o.Chargebacked',
                                                                               'o.Status',
                                                                               'o.Ecpss_Billing_Descriptor',
                                                                               'o.Ecpss_Remarks',
                                                                               'o.Ecpss_Order_No',
                                                                               'o.Self_Error_Text',
                                                                               'o.Amount_Refund',
                                                                               'o.Channel',
                                                                               'o.Billing_Country',
                                                                               'o.Card_Number',
                                                                               'o.Billing_Email',
                                                                               'o.Client_Ip',
                                                                               'o.Preauth_Status',
                                                                               'o.Customer_Type',
                                                                               'o.Self_Vt',
                                                                               'Nvl(o.Settled_Reserve, ''N'') Settled_Reserve'),
                                         p_Sort_Columns       => Varchar_Array('o.Date_Order Desc',
                                                                               'Substr(To_Char(o.Id), 6) Desc'),
                                         p_Final_Columns      => v_Columns,
                                         p_Final_Tables       => 'Page o
                                                                  Join Dat_Clients c
                                                                  On o.Client_Id = c.Id
                                                                  Join Spr_Orders_Status Ss
                                                                  On o.Status = Ss.Code
                                                                  Join Spr_Orders_Refund Sr
                                                                  On o.Refunded = Sr.Code
                                                                  Join Spr_Orders_Chargeback Sc
                                                                  On o.Chargebacked = Sc.Code
                                                                  Join Spr_Orders_Settle St
                                                                  On o.Settled = St.Code
                                                                  Join Spr_Orders_Settle Rst
                                                                  On o.Settled_Reserve = Rst.Code
                                                                  Join Spr_Channels Ch
                                                                  On o.Channel = Ch.Code
                                                                  Left Join Spr_Preauth_Status Pas
                                                                  On Pas.Code = o.Preauth_Status
                                                                  Left Join Spr_Bins Bn
                                                                  On Substr(o.Card_Number, 1, 6) = Bn.Bin
                                                                  Left Join Currency_Rates Rt
                                                                  On o.Date_Order Between Rt.Date_Begin And Rt.Date_End
                                                                  And Rt.Currency_In = o.Currency
                                                                  And Rt.Currency_Out = c.Converted_Currency',
                                         p_Final_Sort_Columns => Varchar_Array('o.Rn'),
                                         p_Pagenum            => p_Pagenum,
                                         p_Perpage            => p_Perpage);
  
    Return Stm_Const.c_Result_Ok;
  Exception
    When Others Then
      Utils.Close_Cursor(Out_Data);
      Out_Data := Null;
      Utils.Close_Cursor(Out_Total);
      Out_Total := Null;
      Utils.Process_Exception(Out_Code, Out_Text);
      Return Stm_Const.c_Result_Error;
  End;

  Function Get_Transactions_Rep(p_Client_Id             Varchar2,
                                p_Client_Group          Varchar2,
                                p_Bo_Type               Varchar2,
                                p_Channel               Varchar2,
                                p_Channel_Group         Varchar2,
                                p_Bank_Type             Varchar2,
                                p_Channel_Mer_No        Varchar2,
                                p_Bin                   Varchar2,
                                p_Order_Id              Varchar2,
                                p_Client_Order_Id       Varchar2,
                                p_Bank_Order_Id         Varchar2,
                                p_Date_Order_Begin      Varchar2,
                                p_Date_Order_End        Varchar2,
                                p_Date_Refund_Begin     Varchar2,
                                p_Date_Refund_End       Varchar2,
                                p_Date_Chargeback_Begin Varchar2,
                                p_Date_Chargeback_End   Varchar2,
                                p_Status                Varchar2,
                                p_Refunded              Varchar2,
                                p_Chargebacked          Varchar2,
                                p_Preauth_Status        Varchar2,
                                p_Settled               Varchar2,
                                p_Settled_Reserve       Varchar2,
                                p_Bank_Paid             Varchar2,
                                p_Currency              Varchar2,
                                p_Currency_Original     Varchar2,
                                p_Amount_Begin          Number,
                                p_Amount_End            Number,
                                p_Amount_Original_Begin Number,
                                p_Amount_Original_End   Number,
                                p_Ip                    Varchar2,
                                p_Card_Number           Varchar2,
                                p_Card_Brand            Varchar2,
                                p_Refund_Settled        Varchar2,
                                p_Chargeback_Settled    Varchar2,
                                p_Email                 Varchar2,
                                p_Phone                 Varchar2,
                                p_Last_Name             Varchar2,
                                p_First_Name            Varchar2,
                                p_Billing_Descriptor    Varchar2,
                                p_Remark                Varchar2,
                                p_Bank_Remark           Varchar2,
                                p_Customer_Type         Varchar2,
                                p_Self_Vt               Varchar2)
    Return Sys_Refcursor Is
    v_Request Utl_Dyn_Sql.Utl_Sql_Request_Type;
    v_Columns Varchar_Array := Varchar_Array();
    v_Code    Varchar2(4000);
    v_Text    Varchar2(4000);
  Begin
    If Not Get_Transactions_Request(p_Client_Id             => p_Client_Id,
                                    p_Client_Group          => p_Client_Group,
                                    p_Bo_Type               => p_Bo_Type,
                                    p_Channel               => p_Channel,
                                    p_Channel_Group         => p_Channel_Group,
                                    p_Bank_Type             => p_Bank_Type,
                                    p_Channel_Mer_No        => p_Channel_Mer_No,
                                    p_Bin                   => p_Bin,
                                    p_Order_Id              => p_Order_Id,
                                    p_Client_Order_Id       => p_Client_Order_Id,
                                    p_Bank_Order_Id         => p_Bank_Order_Id,
                                    p_Date_Order_Begin      => p_Date_Order_Begin,
                                    p_Date_Order_End        => p_Date_Order_End,
                                    p_Date_Refund_Begin     => p_Date_Refund_Begin,
                                    p_Date_Refund_End       => p_Date_Refund_End,
                                    p_Date_Chargeback_Begin => p_Date_Chargeback_Begin,
                                    p_Date_Chargeback_End   => p_Date_Chargeback_End,
                                    p_Status                => p_Status,
                                    p_Refunded              => p_Refunded,
                                    p_Chargebacked          => p_Chargebacked,
                                    p_Preauth_Status        => p_Preauth_Status,
                                    p_Settled               => p_Settled,
                                    p_Settled_Reserve       => p_Settled_Reserve,
                                    p_Bank_Paid             => p_Bank_Paid,
                                    p_Currency              => p_Currency,
                                    p_Currency_Original     => p_Currency_Original,
                                    p_Amount_Begin          => p_Amount_Begin,
                                    p_Amount_End            => p_Amount_End,
                                    p_Amount_Original_Begin => p_Amount_Original_Begin,
                                    p_Amount_Original_End   => p_Amount_Original_End,
                                    p_Ip                    => p_Ip,
                                    p_Card_Number           => p_Card_Number,
                                    p_Card_Brand            => p_Card_Brand,
                                    p_Refund_Settled        => p_Refund_Settled,
                                    p_Chargeback_Settled    => p_Chargeback_Settled,
                                    p_Email                 => p_Email,
                                    p_Phone                 => p_Phone,
                                    p_Last_Name             => p_Last_Name,
                                    p_First_Name            => p_First_Name,
                                    p_Billing_Descriptor    => p_Billing_Descriptor,
                                    p_Remark                => p_Remark,
                                    p_Bank_Remark           => p_Bank_Remark,
                                    p_Customer_Type         => p_Customer_Type,
                                    p_Self_Vt               => p_Self_Vt,
                                    Out_Request             => v_Request,
                                    Out_Code                => v_Code,
                                    Out_Text                => v_Text) Then
      Stm_General.Raise_Error(v_Text);
    End If;
  
    Utils.Add(v_Columns, 'o.Client_Id');
    Utils.Add(v_Columns, 'c.Name Client_Name');
    Utils.Add(v_Columns, 'o.Id Order_Id');
    Utils.Add(v_Columns, 'o.Client_Bill_No Client_Order_Id');
    Utils.Add(v_Columns, 'o.Currency');
    Utils.Add(v_Columns,
              'To_Char(o.Date_Order, ''yyyy - mm - dd HH24:Mi:Ss'') Date_Order');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount, ''99999999999999990.00'')) Amount');
    Utils.Add(v_Columns, 'o.Currency_Original');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount_Original, ''99999999999999990.00'')) Amount_Original');
    Utils.Add(v_Columns, 'c.Converted_Currency');
    Utils.Add(v_Columns,
              'Trim(To_Char(Round(Decode(o.Currency,
                                       c.Converted_Currency,
                                       o.Amount,
                                       o.Amount * Rt.Rate),2),''99999999999999990.00'')) Converted_Amount');
    Utils.Add(v_Columns, 'o.Status');
    Utils.Add(v_Columns, 'Ss.Name_2 Status_Name');
    Utils.Add(v_Columns, 'o.Refunded');
    Utils.Add(v_Columns, 'Sr.Name_2 Refunded_Name');
    Utils.Add(v_Columns, 'o.Settled');
    Utils.Add(v_Columns, 'St.Name_2 Settled_Name');
    Utils.Add(v_Columns, 'o.Chargebacked');
    Utils.Add(v_Columns, 'Sc.Name_2 Chargebacked_Name');
    Utils.Add(v_Columns, 'o.Ecpss_Billing_Descriptor Billing_Descriptor');
    Utils.Add(v_Columns, 'o.Ecpss_Remarks Remark');
    Utils.Add(v_Columns, 'o.Self_Error_Text Bank_Remark');
    Utils.Add(v_Columns, 'o.Ecpss_Order_No Bank_Order_Id');
    Utils.Add(v_Columns,
              'Trim(To_Char(o.Amount_Refund, ''99999999999999990.00'')) Amount_Refund');
    Utils.Add(v_Columns, 'o.Channel');
    Utils.Add(v_Columns, 'Ch.Name Channel_Name');
    Utils.Add(v_Columns, 'o.Billing_Country Country');
    Utils.Add(v_Columns,
              'Substr(o.Card_Number, 1, 6) || '' ** ** **
              '' || Substr(o.Card_Number, 13, 16) Card_Number');
    Utils.Add(v_Columns, 'o.Billing_Email');
    Utils.Add(v_Columns, 'o.Client_Ip');
    Utils.Add(v_Columns, 'o.Amount Amount_Num');
    Utils.Add(v_Columns, 'o.Amount_Refund Amount_Refund_Num');
    Utils.Add(v_Columns, 'Ch.Is_Refund');
    Utils.Add(v_Columns, 'Ch.Is_Cb');
    Utils.Add(v_Columns, 'Ch.Is_Check');
    Utils.Add(v_Columns, 'Null Ars_Reason');
    Utils.Add(v_Columns, 'o.Preauth_Status');
    Utils.Add(v_Columns, 'Pas.Name_2 Preauth_Status');
    Utils.Add(v_Columns, 'Bn.Card_Brand');
    Utils.Add(v_Columns, 'Rst.Name_2 Settled_Reserve');
    Utils.Add(v_Columns, 'Ch.Fraud_Check Channel_Antifraud_Enabled');
    Utils.Add(v_Columns,
              'Case
               When (Select Count(*)
                       From Dat_Fraud_Checks t
                      Where t.Order_Id = o.Id
                        And t.Fraud_System = ''ATF''
                        And (t.Real_Check = ''Y'' Or
                            (t.Real_Check = ''N'' And
                            t.Method In
                            (''CARDHOLDER_INVALIDATED_2_WEEKS_AGO'',
                               ''CARDHOLDER_ALREADY_VALIDATED'')))) > 0 Then
                ''Y''
               Else
                ''N''
             End Checked_By_Fraud_System');
    Utils.Add(v_Columns, 'o.Customer_Type');
    Utils.Add(v_Columns, 'o.Self_Vt');
    Utils.Add(v_Columns,
              'Decode(o.Self_Vt, ''Y'', ''Yes'', ''N'', ''No'') Self_Vt_Name');
  
    Return Utl_Dyn_Sql.Request_Data(p_Request            => v_Request,
                                    p_Data_Columns       => Varchar_Array('o.Client_Id',
                                                                          'o.Id',
                                                                          'o.Client_Bill_No',
                                                                          'o.Currency',
                                                                          'o.Date_Order',
                                                                          'o.Amount',
                                                                          'o.Currency_Original',
                                                                          'o.Amount_Original',
                                                                          'o.Refunded',
                                                                          'o.Settled',
                                                                          'o.Chargebacked',
                                                                          'o.Status',
                                                                          'o.Ecpss_Billing_Descriptor',
                                                                          'o.Ecpss_Remarks',
                                                                          'o.Ecpss_Order_No',
                                                                          'o.Self_Error_Text',
                                                                          'o.Amount_Refund',
                                                                          'o.Channel',
                                                                          'o.Billing_Country',
                                                                          'o.Card_Number',
                                                                          'o.Billing_Email',
                                                                          'o.Client_Ip',
                                                                          'o.Preauth_Status',
                                                                          'o.Customer_Type',
                                                                          'o.Self_Vt',
                                                                          'Nvl(o.Settled_Reserve, ''N'') Settled_Reserve'),
                                    p_Final_Columns      => v_Columns,
                                    p_Final_Tables       => 'Data o
                                                             Join Dat_Clients c
                                                             On o.Client_Id = c.Id
                                                             Join Spr_Orders_Status Ss
                                                             On o.Status = Ss.Code
                                                             Join Spr_Orders_Refund Sr
                                                             On o.Refunded = Sr.Code
                                                             Join Spr_Orders_Chargeback Sc
                                                             On o.Chargebacked = Sc.Code
                                                             Join Spr_Orders_Settle St
                                                             On o.Settled = St.Code
                                                             Join Spr_Orders_Settle Rst
                                                             On o.Settled_Reserve = Rst.Code
                                                             Join Spr_Channels Ch
                                                             On o.Channel = Ch.Code
                                                             Left Join Spr_Preauth_Status Pas
                                                             On Pas.Code = o.Preauth_Status
                                                             Left Join Spr_Bins Bn
                                                             On Substr(o.Card_Number, 1, 6) = Bn.Bin
                                                             Left Join Currency_Rates Rt
                                                             On o.Date_Order Between Rt.Date_Begin And Rt.Date_End
                                                             And Rt.Currency_In = o.Currency
                                                             And Rt.Currency_Out = c.Converted_Currency',
                                    p_Final_Sort_Columns => Varchar_Array('o.Date_Order Desc, o.Id Desc'));
  End;

End Mng_Order_Dyn;
/
