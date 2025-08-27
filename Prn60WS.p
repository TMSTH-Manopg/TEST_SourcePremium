/* WctxPrn60WSRe.P  :  PERSONAL ACCIDENT FORM FOR A4  (WebService)                    */
/*                   Dup. form WA46N100.W                                           */                 
/* PRINT SCHEDULE POLICY FORM A4 LINE 60                                            */
/*                   PRINT SCHEDULE POLICY FORM A4 LINE 60 (P100 , PA2M)            */ 
/*                   1 Risk , 1 Item                                                */
/* CREATE By  : TANTAWAN CH.                                                        */ 
/* ASSIGN No. :  A58-0449                                                           */
/*----------------------------------------------------------------------------------*/
/* MIDIFY By  : TANTAWAN CH.  4/10/2018  เปลี่ยนลายเซ็นหน้าตาราง                    */ 
/* Modify By  : Kridtiya i.   06/01/2020 ปรับแก้ไขหัวรายงานเป็นชื่อบริษัทใหม่       */
/* Modify By  : Tantawan Ch.  A60-0019  DATE : 15/01/2020                           */
/*              - เปลี่ยนมาใช้ Document no 10 หลัก                                  */
/*              - เพิ่ม QRCode ที่หน้าตาราง สำหรับงาน Non-Motor                     */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A63-0343  DATE : 01/09/2020                           */
/*              - เปลี่ยนที่อยู่หัวกระดาษ เปลี่ยนชื่อไฟล์ให้เหมือนกัน               */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A63-0428  DATE : 17/09/2020                           */
/*              - เพิ่ม Micro เพื่อคนพิการ  Class : PA3M                            */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A63-0463  DATE : 06/11/2020                           */
/*              - หน้าตารางแยกตาม PlanCode เพื่อให้ยืดหยุ่นได้มากขึ้น               */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A66-0263  DATE : 13/12/2023                           */
/*              - Project PA สมาชิกศรีกรุง                                          */
/*                ดึงข้อมูลทุนประกันภัยเพิ่มให้ไปแสดงที่มหน้ารายการแนบใน PA ทั่วไป  */
/*                แสดงข้อความทั้งภาษาไทยและภาษาอังกฤษ คู่กัน                        */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A67-0017  DATE : 19/08/2024                           */
/*              - เพิ่ม class PASB - Sabai                                          */
/*                            PSBP - Sabai Plus                                     */
/*----------------------------------------------------------------------------------*/
/* Modify By  : Tantawan Ch.  A67-0173  DATE : 15/11/2024                           */
/*              - เพิ่มข้อมูล id no ของผู้เอาประกันภัย ไว้มุมล่างขวา                */
/*              - เพิ่มข้อมูล Previous Policy ไว้มุมล่างขวา                         */
/*----------------------------------------------------------------------------------*/
 /* 

/*1*/ DEFINE INPUT  PARAMETER nv_CompanyNo  AS CHARACTER NO-UNDO. /*'793'*/
/*2*/ DEFINE INPUT  PARAMETER nv_policy     AS CHARACTER NO-UNDO. /*"d07257bb0322"*/
/*3*/ DEFINE INPUT  PARAMETER nv_RenCnt     AS INTEGER   NO-UNDO.
/*4*/ DEFINE INPUT  PARAMETER nv_EedCnt     AS INTEGER   NO-UNDO.
/*5*/ DEFINE INPUT  PARAMETER nv_docno      AS CHARACTER NO-UNDO. /*"2000122"*/
/*6*/ DEFINE INPUT  PARAMETER nv_code       AS CHARACTER NO-UNDO. /*"201-01-5-57"*/
/*7*/ DEFINE INPUT  PARAMETER n_user        AS CHARACTER NO-UNDO. /*"cmluk0".*/
/*8*/ DEFINE INPUT  PARAMETER n_passwd      AS CHARACTER NO-UNDO. /*"luk0".*/
/*9*/ DEFINE OUTPUT PARAMETER n_err         AS CHARACTER NO-UNDO.
                */
/*1*/ DEFINE VAR  nv_CompanyNo  AS CHARACTER NO-UNDO INIT "833".
/*2*/ DEFINE VAR  nv_policy     AS CHARACTER NO-UNDO INIT "". 
/*3*/ DEFINE VAR  nv_RenCnt     AS INTEGER   NO-UNDO INIT 0.
/*4*/ DEFINE VAR  nv_EedCnt     AS INTEGER   NO-UNDO INIT 0.
/*5*/ DEFINE VAR  nv_docno      AS CHARACTER NO-UNDO. /*"2000122"*/
/*6*/ DEFINE VAR  nv_code       AS CHARACTER NO-UNDO. /*"201-01-5-57"*/
/*7*/ DEFINE VAR  n_user        AS CHARACTER NO-UNDO. /*"cmluk0".*/
/*8*/ DEFINE VAR  n_passwd      AS CHARACTER NO-UNDO. /*"luk*/.
/*9*/ DEFINE VAR  n_err         AS CHARACTER NO-UNDO.

// nv_policy = "D06067000690".  /*PASB */
// nv_policy = "D06067000694".  /*PSBP */
nv_policy = "D06068C22534".  /*P100  D06068C22534   PolCard */
nv_policy  =  "D06068C00010" . 
// nv_policy = "D06068M36161".  /*PA2M */
nv_policy = "D06068C00015".  /* PolCard , PolAtt , PolA */
//nv_policy = "D06068C00013".  /* Pol , Receipt  */
//nv_policy = "D06067M00014".  /* Micro , PA3M */
//nv_policy = "M36067BT0568".  /* Pol */
//nv_policy = "D06067C00087".  /* renew */
/*-------------- Reports -----------------*/
DEF VAR report-library       AS CHARACTER INIT "D:\WebOs\SteamServ\WS\WPRL\WCTXNON.PRL".
DEF VAR report-name          AS CHARACTER INIT "M60_Pol" .
DEF VAR RB-DB-CONNECTION     AS CHARACTER.
DEF VAR RB-INCLUDE-RECORDS   AS CHARACTER.
DEF VAR RB-FILTER            AS CHARACTER.
DEF VAR RB-MEMO-FILE         AS CHARACTER.
DEF VAR RB-PRINT-DESTINATION AS CHARACTER. 
DEF VAR RB-PRINTER-NAME      AS CHARACTER INIT "PDFCreator".
DEF VAR RB-PRINTER-PORT      AS CHARACTER.
DEF VAR RB-OUTPUT-FILE       AS CHARACTER.
DEF VAR RB-NUMBER-COPIES     AS INTEGER INIT 1.
DEF VAR RB-BEGIN-PAGE        AS INTEGER INIT 0.
DEF VAR RB-END-PAGE          AS INTEGER INIT 0.
DEF VAR RB-TEST-PATTERN      AS LOGICAL.
DEF VAR RB-WINDOW-TITLE      AS CHARACTER.
DEF VAR RB-DISPLAY-ERRORS    AS LOGICAL.
DEF VAR RB-DISPLAY-STATUS    AS LOGICAL.
DEF VAR RB-NO-WAIT           AS LOGICAL INIT NO.
DEF VAR RB-OTHER-PARAMETERS  AS CHARACTER .
/*===================================*/

DEF VAR a          AS CHAR.

DEFINE      VAR nv_uwd105 AS INT.
DEF         VAR nv_multi   AS  LOGI.

DEF VAR nv_emm     AS  CHAR  EXTENT 12 INIT
        ["January" , "February" , "March" ,
         "April"   , "May"      , "June"  ,
         "July"    , "August"   , "September" ,
         "October" , "November" , "December"].
DEF VAR nv_tmm     AS  CHAR  EXTENT 12 INIT
        ["มกราคม"  , "กุมภาพันธ์" , "มีนาคม" ,
         "เมษายน"  , "พฤษภาคม"  , "มิถุนายน" ,
         "กรกฎาคม" , "สิงหาคม"  ,"กันยายน" ,
         "ตุลาคม " , "พฤศจิกายน" , "ธันวาคม"].
DEF VAR nv_date        AS  CHAR  FORMAT "X(10)".         /*wantanee*/
DEF VAR nv_numdate     AS  INTE  .                                             /*wantanee*/

DEF VAR nv_cdat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_edat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_adat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_sdat    AS  CHAR  FORMAT "X(20)".

DEF VAR nv_date_2  AS  CHAR  FORMAT "X(20)".
DEF VAR nv_cdat_2  AS  CHAR  FORMAT "X(20)".
DEF VAR nv_edat_2  AS  CHAR  FORMAT "X(20)".
DEF VAR nv_adat_2  AS  CHAR  FORMAT "X(20)".
DEF VAR nv_sdat_2  AS  CHAR  FORMAT "X(20)".

DEF VAR nv_total   AS  DECI  FORMAT ">>,>>>,>>9.99-" EXTENT 6.
DEF VAR nv_be      AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_disc    AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_disc2   AS  DECI  FORMAT ">>,>>>,>>9.99".
DEF VAR nv_add     AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_ad1     AS  CHAR  FORMAT "X(15)".
DEF VAR nv_dsc2    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tax     AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_taxs    AS  CHAR  FORMAT "x(15)".
DEF VAR nv_subtot  AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_subtots AS  CHAR  FORMAT "X(15)".
DEF VAR nv_stamp   AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_stamp1  AS  CHAR  FORMAT "X(11)".
DEF VAR nv_grand   AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_grands  AS  CHAR  FORMAT "X(15)".
DEF VAR nv_age     AS  INTE  FORMAT ">9".
DEF VAR nv_aged    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_a       AS  INTE.
DEF VAR nv_b       AS  INTE.
DEF VAR nv_c       AS  INTE.
DEF VAR nv_cday    AS  INTE.
DEF VAR nv_cmonth  AS  INTE.
DEF VAR nv_iday    AS  INTE.
DEF VAR nv_imonth  AS  INTE.
DEF VAR nv_occup   AS  CHAR  FORMAT "X(25)".
DEF VAR nv_cnt     AS  INTE.
DEF VAR nv_bicno   AS  CHAR.                  /* A67-0173 */
DEF VAR nv_bnam1   AS  CHAR  FORMAT "X(50)".
DEF VAR nv_bnam2   AS  CHAR  FORMAT "X(50)".
DEF VAR nv_prtpol  AS  CHAR  FORMAT "X(12)".
DEF VAR nv_agtnam  AS  CHAR  FORMAT "x(50)".
DEF VAR nv_agtreg  AS  CHAR  FORMAT "x(15)".
DEF VAR nv_agttyp  AS  CHAR  FORMAT "x(2)".
DEF VAR n_inam1    AS  CHAR  FORMAT "x(120)".
DEF VAR n_inam2    AS  CHAR  FORMAT "x(120)".
DEF VAR nv_reship  AS  CHAR  FORMAT "X(50)".
DEF VAR nv_badd    AS  CHAR  FORMAT "X(80)".
DEF VAR nv_acctim  AS  CHAR  FORMAT "X(5)".
DEF VAR nv_area1   AS  CHAR  FORMAT "X(65)".
DEF VAR nv_area2   AS  CHAR  FORMAT "X(65)".
DEF VAR nv_mb4wks  AS  CHAR  FORMAT "X(3)".
DEF VAR nv_mb4ded  AS  CHAR  FORMAT "X(3)".
DEF VAR nv_mb5wks  AS  CHAR  FORMAT "X(3)".
DEF VAR nv_mb5ded  AS  CHAR  FORMAT "X(3)".
DEF VAR nv_mb6ded  AS  CHAR  FORMAT "X(3)".
DEF VAR nv_al123   AS  CHAR  FORMAT "X(20)".
DEF VAR nv_endatt  AS  CHAR  FORMAT "X(78)".
DEF VAR nv_ag      AS  CHAR  FORMAT "X".
DEF VAR nv_br      AS  CHAR  FORMAT "X".
DEF VAR nv_acno    AS  CHAR  FORMAT "X(10)".
DEF VAR nv_mbsi1   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi2   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi3   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi4   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi5   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi6   AS  CHAR  FORMAT "X(15)".

DEF VAR nv_mbsidec1   AS  DECI .
DEF VAR nv_mbsidec2   AS  DECI .
DEF VAR nv_mbsidec3   AS  DECI .
DEF VAR nv_mbsidec4   AS  DECI .
DEF VAR nv_mbsidec5   AS  DECI .
DEF VAR nv_mbsidec6   AS  DECI .

DEF VAR nv_tot1    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tot2    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tot3    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tot4    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tot5    AS  CHAR  FORMAT "X(15)".
DEF VAR nv_tot6    AS  CHAR  FORMAT "X(15)".
DEF VAR n_m60      AS  CHAR  FORMAT "X".
DEF VAR n_m64      AS  CHAR  FORMAT "X".
DEF VAR n_m67      AS  CHAR  FORMAT "X".
DEF VAR nv_tot123  AS  DECI.
DEF VAR n_tot123   AS  CHAR.
DEF VAR nv_user    AS  CHAR.
def var nv_Receipt_fil AS RECID.
DEF VAR nv_Count1  AS INT.
DEF VAR nv_lineCins AS INT.
 nv_user = n_user.

nv_multi = No.

DEF  VAR nv_nam2    AS  CHAR  FORMAT "x(120)".
DEF  VAR nv_badd1   AS  CHAR  FORMAT "X(50)".
DEF  VAR nv_badd2   AS  CHAR  FORMAT "X(25)".

/*----Begin by Chaiyong W. A58-0145 17/04/2015*/
DEF VAR nv_class AS CHAR INIT "".
DEF VAR nv_icno  AS CHAR INIT "".
DEF VAR nv_pic1  AS CHAR INIT "".
DEF VAR nv_pic2  AS CHAR INIT "".
DEF VAR nv_pic3  AS CHAR INIT "".
DEF VAR nv_pic4  AS CHAR INIT "".
DEF VAR nv_pic5  AS CHAR INIT "".
DEF VAR nv_pic6  AS CHAR INIT "".
DEF VAR nv_pic7  AS CHAR INIT "".
DEF VAR nv_pic8  AS CHAR INIT "".
DEF VAR nv_pic9  AS CHAR INIT "".  /* A67-0017*/
DEF VAR nv_pics  AS CHAR INIT "".
DEF VAR nv_pic   AS CHAR INIT "".

DEF VAR nv_qrcode  AS CHAR INIT "". /* QRCode Image -- A60-0019 --*/

DEF VAR nv_comdat AS CHAR INIT "".
DEF VAR nv_expdat AS CHAR INIT "".
DEF VAR nv_today  AS CHAR INIT "".
DEF VAR nv_poltyp AS CHAR INIT "".
DEF VAR nv_add11  AS CHAR INIT "".
DEF VAR nv_add12  AS CHAR INIT "".
DEF VAR nv_add13  AS CHAR INIT "".
DEF VAR nv_add14  AS CHAR INIT "".
DEF VAR nv_addpost AS CHAR INIT "".   // Manop G. 
DEF VAR nv_tel    AS CHAR INIT "".
DEF VAR nv_docno2 AS CHAR INIT "".
/*05/08/2015*/
DEF VAR nv_ma     AS CHAR INIT "".
DEF VAR nv_ma2    AS CHAR INIT "".
DEF VAR nv_mc     AS CHAR INIT "".
DEF VAR nv_mc2    AS CHAR INIT "".
DEF VAR nv_mbsi62 AS CHAR INIT "".

DEF VAR nv_nam1       AS CHARACTER .
DEF VAR nv_addr1      AS CHARACTER .  /*uwm100.addr1        nv_addr1    =   EntTa68.InsuredRefAddr           */
DEF VAR nv_addr2      AS CHARACTER .  /*uwm100.addr2        nv_addr2    =   EntTa68.InsuredRefSubDistrict    */
DEF VAR nv_addr3      AS CHARACTER .  /*uwm100.addr3        nv_addr3    =   EntTa68.InsuredRefDistrict       */
DEF VAR nv_prov       AS CHARACTER .  /*uwm100.addr4        nv_prov     =   EntTa68.InsuredRefProvinc        */
DEF VAR nv_postcode   AS CHARACTER .  /*uwm100.postcd       nv_postcode =   EntTA68.InsuredRefPostalCode     */

/* A63-0463 */
DEF VAR nv_IDHType    AS CHAR.
DEF VAR nvw_fptr      AS RECID.
DEF VAR nv_fptr       AS RECID.
DEF VAR nv_chkSI      AS INT.
DEF VAR nv_chkUOM     AS INT.

// DEF SHARED VAR gv_TypPermit    AS CHAR.
// DEF SHARED VAR gv_ReportName   AS CHAR.
// DEF SHARED VAR nv_PlanCode AS CHAR .
/* A63-0463 */
DEF VAR gv_TypPermit    AS CHAR.
DEF VAR gv_ReportName   AS CHAR.
DEF VAR nv_PlanCode     AS CHAR. /* A66-0263 */
/* A63-0463 */

/* A66-0263 */
DEF VAR nv_CoverSI1   AS CHAR  FORMAT "X(20)".
DEF VAR nv_CoverSI2   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CoverSI3   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CoverSI4   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CoverSI5   AS CHAR  FORMAT "X(15)".

DEF VAR nv_mbsi4_2  AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi5_2  AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi6_2  AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsides1   AS CHAR .
DEF VAR nv_mbsides2   AS CHAR .
DEF VAR nv_mbsides3   AS CHAR .
DEF VAR nv_mbsides4   AS CHAR .
DEF VAR nv_mbsides5   AS CHAR .
DEF VAR nv_mbsides6   AS CHAR .
DEF VAR nv_pmedi      AS CHAR  FORMAT "x(35)" .
DEF VAR nv_PB1        AS CHAR  FORMAT "x(35)" .
DEF VAR nv_PB2        AS CHAR  FORMAT "x(35)" .
DEF VAR nv_SIPMedi    AS DECI  FORMAT ">>,>>>,>>9".
DEF VAR nv_SIPB       AS DECI  FORMAT ">>,>>>,>>9".


/* A66-0263 */

/*-----  A67-0017 ----*/
DEF VAR nv_CoverSI6   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CoverSI7   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CoverSI8   AS CHAR  FORMAT "X(15)".
DEF VAR nv_CampDesc   AS CHAR  FORMAT "X(35)".
DEF VAR nv_accdat     AS CHAR  INIT "".
DEF VAR nv_trndat     AS CHAR  INIT "".
DEF VAR nv_login      AS CHAR  INIT "". 
/*-----  A67-0017 ----*/

DEF VAR nv_prvpol     AS CHAR  INIT "". /* A67-0173 */

// Manop G. SteamServe
DEF VAR  nv_rec120    AS  RECID  INIT ? . 
DEF VAR  nv_yrtyp     AS CHAR.     
DEF VAR  nv_poldes    AS CHAR.
DEF VAR  nv_taxno     AS CHAR .
DEF VAR  nv_rtevat    AS CHAR INIT "".
DEF VAR  nv_bDob      AS CHAR .
DEF VAR  nv_bOccup    AS CHAR .
DEF VAR  nv_product   AS CHAR .
DEF VAR  nv_proddes   AS CHAR .
DEF VAR  nv_PrnSCH    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnCER    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnRCP    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnATT    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnEXT    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnJKT    AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnCard   AS LOGICAL INIT FALSE .
DEF VAR  nv_PrnLST    AS LOGICAL INIT FALSE .
DEF VAR  nv_R003-9    AS CHAR INIT "". 
DEF VAR  nv_R003-6    AS CHAR INIT "". 
DEF VAR  nv_language  AS CHAR.
{WS\PrnTBAPI.i}     // Temp-Table & ProCedure 
{WS\procenter.i}     // Procedure Center
////////// Manop G. 

nv_login  =  "" . 
IF n_err = "" THEN DO:

    FIND FIRST uwm100 WHERE
               uwm100.policy = nv_policy /*AND
               uwm100.rencnt = nv_RenCnt AND
               uwm100.endcnt = nv_EedCnt*/ NO-ERROR.
    IF AVAIL uwm100 THEN DO:       
    
      nv_docno2 = "M " + uwm100.docno1.  
      nv_login   =  STRING(nv_policy) + STRING(DAY(TODAY)) + STRING(MONTH(TODAY)) + STRING(YEAR(TODAY)) + STRING(TIME) + STRING(MTIME) . 
          
      IF uwm100.expdat > uwm100.comdat THEN DO:
         /* IF uwm100.sch_p = NO AND      ปิดเทส  SteamServe Manop G. 
               uwm100.drn_p = NO THEN DO:  */
         
         IF uwm100.sch_p = YES AND 
            uwm100.drn_p = YES THEN DO:
         
             ASSIGN
                nv_uwd105  =  0      nv_addr1   =  ""      nv_addr2   =  ""           nv_date_2    =  ""
                nv_cdat    =  ""     nv_addr3   =  ""                                 nv_cdat_2    =  "" 
                nv_edat    =  ""     nv_adat    =  ""      nv_sdat    =  ""           nv_edat_2    =  "" 
                nv_total   =  0      nv_be      =  0       nv_disc    =  0            nv_sdat_2    =  ""
                nv_disc2   =  0      nv_add     =  0       nv_ad1     =  ""           nv_adat_2    =  "" 
                nv_dsc2    =  ""     nv_tax     =  0       nv_taxs    =  ""
                nv_subtot  =  0      nv_subtots =  ""      nv_stamp   =  0
                nv_stamp1  =  ""     nv_grand   =  0       nv_grands  =  ""
                nv_age     =  0      nv_aged    =  ""      nv_a       =  0
                nv_b       =  0      nv_c       =  0       nv_cday    =  0
                nv_cmonth  =  0      nv_iday    =  0       nv_imonth  =  0            nv_bicno     = ""  /* A67-0173 */
                nv_occup   =  ""     nv_cnt     =  0       nv_bnam1   =  ""
                nv_bnam2   =  ""     nv_prtpol  =  ""      nv_agtnam  =  ""
                nv_agtreg  =  ""     nv_agttyp  =  ""      /*nv_nam1    =  ""*/
                nv_nam2    =  ""     nv_reship  =  ""      nv_badd    =  ""
                nv_acctim  =  ""     nv_area1   =  ""      nv_area2   =  ""
                nv_mb4wks  =  ""     nv_mb4ded  =  ""      nv_mb5wks  =  ""
                nv_mb5ded  =  ""     nv_mb6ded  =  ""      nv_al123   =  ""
                nv_endatt  =  ""     nv_ag      =  ""      nv_br      =  ""
                nv_acno    =  ""     nv_mbsi1   =  ""      nv_mbsi2   =  ""
                nv_mbsi3   =  ""     nv_mbsi4   =  ""      nv_mbsi5   =  ""        nv_mbsi4_2   =  ""      nv_mbsi5_2   =  ""       nv_mbsi6_2   =  ""
                nv_mbsi6   =  ""     nv_tot1    =  ""      nv_tot2    =  ""
                nv_tot3    =  ""     nv_tot4    =  ""      nv_tot5    =  ""
                nv_tot6    =  ""     n_m60      =  ""      n_m64      =  ""
                n_m67      =  ""     nv_tot123  =  0       n_tot123   =  ""
                n_inam1    =  ""     n_inam2    =  ""
                /*005/08/2015 */ 
                nv_ma      =  ""     nv_ma2     =  ""      nv_mc      =  ""  
                nv_mc2     =  ""     nv_mbsi62  =  ""      nv_qrcode  =  ""      nv_IDHType = ""

                /* A66-0263 */
                nv_CoverSI1 = ""     nv_CoverSI2 =  ""     nv_pmedi    =  ""      nv_PB1  = ""   nv_SIPMedi = 0             
                nv_CoverSI3 = ""     nv_CoverSI4 = ""      nv_CoverSI5 =  ""      nv_PB2  = ""   nv_SIPB    = 0 
                /* A66-0263 */                                                   
                nv_CoverSI6 = ""     nv_CoverSI7 = ""      nv_CoverSI7 =  ""      nv_prvpol = ""  /* A67-0173 */
                nv_yrtyp    = ""     
                
                nv_mbsidec1 =  0     nv_mbsidec2  =  0     nv_mbsidec3  =  0        nv_mbsidec4  =  0       
                nv_mbsidec5 =  0     nv_mbsidec6  =  0  . 
                
                    FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                               uwm120.policy = uwm100.policy    AND
                               uwm120.rencnt = uwm100.rencnt    AND
                               uwm120.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
                    IF AVAIL uwm120 THEN DO:
                       nv_rec120    =  RECID(uwm120) .
                       nv_class     =  uwm120.CLASS.
                       IF uwm120.class = "P200" THEN nv_multi = YES.
                       IF uwm120.class = "P100" THEN nv_multi = NO.
                                       
                       IF uwm120.fptr01 = 0 THEN DO:
                           nv_PrnATT    =   FALSE .                              
                       END.
                       ELSE DO:                
                           RUN pd_uwd120 (INPUT nv_login , nv_policy).    // HeadCover  . . . . Manop G.
                           nv_PrnATT    =   TRUE .
                       END. 
                    END.           
                            
                    RUN pd_bookxml (INPUT nv_login , nv_policy) .    // Book-Clause  . . . . Manop G.      
                    // Assign UWM100 
                    
                    ASSIGN 
                    nv_prtpol        = uwm100.policy
                    nv_add11         = uwm100.addr1
                    nv_add12         = uwm100.addr2
                    nv_add13         = uwm100.addr3
                    nv_add14         = TRIM(TRIM(uwm100.addr4) + " " + TRIM(uwm100.postcd))
                    nv_comdat        = STRING(uwm100.comdat,"99/99/9999")
                    nv_expdat        = STRING(uwm100.expdat,"99/99/9999")
                    nv_today         = STRING(TODAY,"99/99/9999")
                    nv_accdat        = STRING(uwm100.accdat,"99/99/9999")      /* A67-0017 */
                    nv_trndat        = STRING(uwm100.trndat,"99/99/9999")      /* A67-0017 */
                    nv_acno          = uwm100.acno1 
                    nv_R003-9        = CAPS(uwm100.usrid)
                    nv_language      = uwm100.langug 
                    nv_acctim        = uwm100.acctim 
                    nv_taxno         = uwm100.icno    
                    nv_product       = uwm100.cr_1
                    nv_proddes       = ""          
                    nv_fptr          = 0 
                    nv_fptr          = uwm100.fptr01.
            
                    
                    FIND FIRST xcpara49 USE-INDEX xcpara4901 WHERE
                             xcpara49.class   = "GRPPROD"  AND /*GRP.PRODUCT*/
                             xcpara49.type[1] = uwm100.cr_1 NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xcpara49 THEN nv_proddes = TRIM(xcpara49.type[7]).
                    
                    IF TRIM(uwm100.prvpol) <> "" THEN nv_prvpol = "Prv.Pol: " + CAPS(uwm100.prvpol).  /* A67-0173 */
                    
                    nv_subtot        = uwm100.prem_t.
                    nv_subtots       = STRING(nv_subtot,">>>,>>>,>>9.99-").
                    nv_tax           = uwm100.pfee + uwm100.ptax + uwm100.rfee_t + uwm100.rtax_t.
                    nv_taxs          = string(nv_tax,">>>,>>>,>>9.99").
                    nv_stamp         = uwm100.pstp + uwm100.rstp_t.
                    
                    RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_subtot      ,OUTPUT nv_subtots).
                    RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_tax         ,OUTPUT nv_taxs).
                    RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_stamp       ,OUTPUT nv_stamp1).
                    RUN pd_cdeci(INPUT ""   ,INPUT "INT|B"   ,INPUT uwm100.gstrat  ,OUTPUT nv_rtevat).
        
                    IF uwm100.pstp = 0 THEN nv_stamp1 = string(nv_stamp,">>>,>>>,>>9.99-").
                                       ELSE nv_stamp1 = "Dup" + string(uwm100.pstp,">>9") + " + " +
                                                           trim(string(uwm100.rstp_t,">,>>9")).
                    nv_grand = nv_subtot + nv_tax + nv_stamp.    
                    RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_grand       ,OUTPUT nv_grands).
                    
                    // Date_1 
                    IF uwm100.comdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.comdat,OUTPUT nv_cdat). IF SUBSTR(nv_cdat,1,1) = "0" THEN nv_cdat = SUBSTR(nv_cdat,2).
                    IF uwm100.expdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.expdat,OUTPUT nv_edat). IF SUBSTR(nv_edat,1,1) = "0" THEN nv_edat = SUBSTR(nv_edat,2).
                    IF uwm100.accdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.accdat,OUTPUT nv_adat). IF SUBSTR(nv_adat,1,1) = "0" THEN nv_adat = SUBSTR(nv_adat,2).
                    IF uwm100.trndat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.trndat,OUTPUT nv_sdat). IF SUBSTR(nv_sdat,1,1) = "0" THEN nv_sdat = SUBSTR(nv_sdat,2).
                    RUN pd_matday(INPUT "1" ,nv_language,TODAY,OUTPUT nv_date). IF SUBSTR(nv_date,1,1) = "0" THEN nv_date = SUBSTR(nv_date,2).
                    // Date_2 
                    IF uwm100.comdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.comdat,OUTPUT nv_cdat_2). IF SUBSTR(nv_cdat_2,1,1) = "0" THEN nv_cdat_2 = SUBSTR(nv_cdat_2,2).
                    IF uwm100.expdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.expdat,OUTPUT nv_edat_2). IF SUBSTR(nv_edat_2,1,1) = "0" THEN nv_edat_2 = SUBSTR(nv_edat_2,2).
                    IF uwm100.accdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.accdat,OUTPUT nv_adat_2). IF SUBSTR(nv_adat_2,1,1) = "0" THEN nv_adat_2 = SUBSTR(nv_adat,2).
                    IF uwm100.trndat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.trndat,OUTPUT nv_sdat_2). IF SUBSTR(nv_sdat_2,1,1) = "0" THEN nv_sdat_2 = SUBSTR(nv_sdat_2,2).
                    RUN pd_matday(INPUT "1" ,nv_language,TODAY,OUTPUT nv_date_2). IF SUBSTR(nv_date_2,1,1) = "0" THEN nv_date_2 = SUBSTR(nv_date_2,2).
                    
                         // nv_nam1 
                         IF uwm100.ntitle <> "" AND uwm100.fname <> "" THEN nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.fname)  + " " + TRIM(uwm100.name1).
                    ELSE IF uwm100.fname  <> "" THEN nv_nam1 = TRIM(uwm100.fname)  + " " + TRIM(uwm100.name1).
                    ELSE IF uwm100.ntitle <> "" THEN nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1). 
                                                ELSE nv_nam1 = TRIM(uwm100.name1).
                    ASSIGN   // nv_nam2
                         nv_nam2 = uwm100.name2
                         nv_addr1  = TRIM(uwm100.addr1) + " " + TRIM(uwm100.addr2)
                         nv_addr2  = TRIM(uwm100.addr3) + " " + TRIM(uwm100.addr4) + " " + TRIM(uwm100.postcd).
                     
                         /* 
                         IF uwm100.poltyp = "M60" THEN n_m60 = "X".
                    ELSE IF uwm100.poltyp = "M64" THEN n_m64 = "X".
                    ELSE IF uwm100.poltyp = "M67" THEN n_m67 = "X". */  
            
                FIND /*FIRST*/ xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN ASSIGN     
                                    nv_poltyp = "Type of Policy........... " + xmm031.poldes
                                    nv_poldes = xmm031.poldes .
    
                FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.insref NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN DO:
                    ASSIGN
                        nv_tel  = xmm600.phone
                        nv_icno = xmm600.icno.
                END. 
                
                FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.agent NO-LOCK  NO-ERROR.
                IF AVAIL xmm600 THEN
                    ASSIGN
                        nv_agtreg = xmm600.agtreg
                        nv_agttyp = xmm600.acccod.
            
                IF uwm100.langug <> " " THEN DO:   /*thai*/
                   FIND /*FIRST*/ xtm600 USE-INDEX xtm60001 WHERE
                              xtm600.acno = uwm100.agent NO-LOCK  NO-ERROR NO-WAIT.
                   IF AVAIL xtm600  THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME. /* xtm600.name.*/
                   ELSE DO:
                      FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE
                      xmm600.acno =  uwm100.agent    NO-LOCK NO-ERROR NO-WAIT.
                      IF AVAIL xmm600 THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME . /*xmm600.name.*/
                                      ELSE nv_agtnam = " ".
                   END.
                END.
                ELSE DO:      /*eng*/
                   FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE
                              xmm600.acno = uwm100.agent NO-LOCK NO-ERROR NO-WAIT.
                   IF AVAIL xmm600 THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME . /*xmm600.name.*/
                                   ELSE nv_agtnam = " ".
                END.
            
                IF nv_agttyp  = "AG" THEN nv_ag = "X". ELSE nv_br = "X".
            
            /********************** not nv_multi **********************/
            FIND FIRST uwm307 USE-INDEX uwm30701 WHERE
                       uwm307.policy = uwm100.policy  AND
                       uwm307.rencnt = uwm100.rencnt  AND
                       uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
            IF AVAIL uwm307 THEN DO :

                    IF uwm307.idob <> ? THEN  nv_age = YEAR(uwm100.comdat) - YEAR(uwm307.idob).
               ELSE IF uwm307.iyob <> 0 THEN  nv_age = YEAR(uwm100.comdat) - uwm307.iyob.  
               ELSE nv_age = 0.  
               //คำนวน 
            
               ASSIGN
                  nv_total[1] = nv_total[1] + uwm307.mbpd[1]
                  nv_total[2] = nv_total[2] + uwm307.mbpd[2]
                  nv_total[3] = nv_total[3] + uwm307.mbpd[3]
                  nv_total[4] = nv_total[4] + uwm307.mbpd[4]
                  nv_total[5] = nv_total[5] + uwm307.mbpd[5]
                  nv_total[6] = nv_total[6] + uwm307.mbpd[6].
                  // nv_total  Manop G.
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[1],OUTPUT nv_total[1]). 
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[2],OUTPUT nv_total[2]). 
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[3],OUTPUT nv_total[3]). 
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[4],OUTPUT nv_total[4]).
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[5],OUTPUT nv_total[5]).
                  RUN pd_cdeci(INPUT "A",INPUT "",INPUT nv_total[6],OUTPUT nv_total[6]).
                   
        
               ASSIGN
                 nv_CoverSI1 = STRING(uwm307.mbsi[1],">>>,>>>,>>9.99")
                 nv_occup  = uwm307.iocc
                 nv_disc   = nv_disc + uwm307.abpd[4]
                 nv_add    = nv_add  + uwm307.abpd[1] + uwm307.abpd[2] + uwm307.abpd[3]
                 nv_bnam1  = uwm307.bname1
                 nv_bnam2  = uwm307.bname2
                 nv_reship = uwm307.reship
                 nv_badd   = uwm307.badd1  + " " + uwm307.badd2
                 n_inam1   = uwm307.ifirst + " " + uwm307.iname
                 n_inam2   = "".
                 nv_reship = uwm307.reship.                  
                 
                 //nv_bDob   = uwm307.idob .
                 IF uwm307.idob <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm307.idob,OUTPUT nv_bDob). IF SUBSTR(nv_bDob,1,1) = "0" THEN nv_bDob = SUBSTR(nv_bDob,2).
                 
               IF uwm100.acno1 = "B300308" THEN nv_bicno = "(" + substring(uwm307.icno,1,4) + "XXXXX" + substring(uwm307.icno,10,4) + ")". /* A67-0173 */
                    
            END.  // uwm307   not nv_multi 
            
            IF uwm100.langug = "" THEN DO :
                IF nv_age <> 0 THEN ASSIGN nv_aged = STRING(nv_age) + " Years"    nv_yrtyp = " Years"  . 
            END.
            ELSE DO:
                /*IF nv_age <> 0 THEN nv_aged = STRING(nv_age) + " ปี".  27/10/2023 */
                IF nv_age <> 0 THEN ASSIGN nv_aged = STRING(nv_age) + " ปี/Years" nv_yrtyp = " ปี/Years". 
            END.
            /****************** not nv_multi ***********************/
            
            /*------------------*/
            FIND FIRST uwm307  WHERE uwm307.policy = uwm100.policy NO-LOCK NO-WAIT NO-ERROR.
            IF uwm307.mbsi[1] = 0 THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi1 = SUBSTRING(xmd179.head,1,17).
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi1 = SUBSTRING(xmd179.head,1,17).
                END.                                                  
            END.
            ELSE IF nv_multi THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi1 = SUBSTRING(xmd179.head,1,17).             
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi1 = SUBSTRING(xmd179.head,1,17).
               END.  
            END.
            ELSE DO:
                IF nv_class = "PA2M" OR
                   nv_class = "PA3M" /* A63-0428 */
                                     THEN nv_mbsi1 = string(uwm307.mbsi[1], ">>>,>>>,>>9").
                                     ELSE nv_mbsi1 = string(uwm307.mbsi[1], ">>>,>>>,>>9.99").
                
                /*--- A66-0263 --- ดึงข้อมูลไปแสดงหน้ารายการแนบ ---*/
                IF (uwm307.abcd[1] = "PB"   OR
                    uwm307.abcd[2] = "PB"   OR
                    uwm307.abcd[3] = "PB"   OR
                    uwm307.abcd[4] = "PB")  THEN DO:

                    RUN PD_Package (INPUT  nv_PlanCode ,
                                    OUTPUT nv_SIPMedi,
                                    OUTPUT nv_SIPB,    
                                    OUTPUT nv_CampDesc).


                    nv_pmedi = STRING(nv_SIPMedi,">,>>>,>>9") + " บาท".

                END.
                IF (uwm307.abcd[1] = "FE"   OR
                    uwm307.abcd[2] = "FE"   OR
                    uwm307.abcd[3] = "FE"   OR
                    uwm307.abcd[4] = "FE")  THEN DO:

                    RUN PD_Package (INPUT  nv_PlanCode ,
                                    OUTPUT nv_SIPMedi,
                                    OUTPUT nv_SIPB ,   
                                    OUTPUT nv_CampDesc).

                    nv_PB1  = "3.  ผลประโยชน์ค่าใช้จ่ายในการจัดงานศพกรณีเสียเชีย (ยกเว้นกรณีเสียชีวิตจากการเจ็บป่วยภายใน 120 วันแรก นับจากวันเริ่มต้นระยะเวลาประกันภัย) : " + STRING(nv_SIPB,">,>>>,>>9") + " บาท".
                END.
                /*--- A66-0263 --- ดึงข้อมูลไปแสดงหน้ารายการแนบ ---*/
            END.
           
            IF uwm307.mbsi[4] = 0 THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR. /* E */
                  IF AVAIL xmd179 THEN nv_mbsi4 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR. /* T */
                  IF AVAIL xmd179 THEN nv_mbsi4_2 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
               END.
               ELSE DO : /* T */
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR. /* T */
                  IF AVAIL xmd179 THEN nv_mbsi4 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR. /* E */
                  IF AVAIL xmd179 THEN nv_mbsi4_2 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
               END.
            END.
            ELSE IF nv_multi THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi4 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi4_2 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi4 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi4_2 = SUBSTRING(xmd179.head,1,17).
                  /* A66-0263 */
               END.
            END.
            ELSE DO :
                IF nv_class = "PA2M" OR
                   nv_class = "PA3M" /* A63-0428 */
                                     THEN nv_mbsi4 = string(uwm307.mbsi[4], ">>>,>>>,>>9").
                                     ELSE nv_mbsi4 = string(uwm307.mbsi[4], ">>>,>>>,>>9.99").
            END.
          /***********************************************/
            IF uwm307.mbsi[5] = 0 THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5_2 = SUBSTRING(xmd179.head,1,17).
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5_2 = SUBSTRING(xmd179.head,1,17).
               END.
            END.
            ELSE IF nv_multi THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5_2 = SUBSTRING(xmd179.head,1,17).
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi5_2 = SUBSTRING(xmd179.head,1,17).
               END.
            END.
            ELSE DO :
               IF nv_class = "PA2M" OR
                  nv_class = "PA3M" /* A63-0428 */
                                    THEN nv_mbsi5 = string(uwm307.mbsi[5], ">>>,>>>,>>9").
                                    ELSE nv_mbsi5 = string(uwm307.mbsi[5], ">>>,>>>,>>9.99").
            END.
        
            IF uwm307.mbsi[6] = 0 THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6_2 = SUBSTRING(xmd179.head,1,17).
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "004"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008"  AND
                       xmd179.poltyp = ""     AND
                       xmd179.headno = "003"  NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6_2 = SUBSTRING(xmd179.head,1,17).
               END.
            END.
            ELSE IF nv_multi THEN DO :
               IF uwm100.langug = "" THEN DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6_2 = SUBSTRING(xmd179.head,1,17).
        
               END.
               ELSE DO :
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "058" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6 = SUBSTRING(xmd179.head,1,17).

                  FIND xmd179 USE-INDEX xmd17901 WHERE
                       xmd179.docno  = "008" AND
                       xmd179.poltyp = ""    AND
                       xmd179.headno = "057" NO-LOCK NO-ERROR.
                  IF AVAIL xmd179 THEN nv_mbsi6_2 = SUBSTRING(xmd179.head,1,17).

               END.
            END.
            ELSE DO :
               IF nv_class = "PA2M" OR nv_class = "PA3M" THEN nv_mbsi6 = string(uwm307.mbsi[6], ">>>,>>>,>>9").
               /*---- ข้อมูลสำหรับ Print PA Card กรณีแพ็คเกจที่มี ค่ารักษาพยาบาล ----*/ 
               ELSE DO:
                  nv_mbsi6  = string(uwm307.mbsi[6], ">>>,>>>,>>9.99").
                  nv_mbsi62 = string(uwm307.mbsi[6], ">>>,>>>,>>9").
                  nv_ma  = "คุ้มครองเพิ่มจากการถูกฆาตกรรมหรือถูกลอบทำร้าย".
                  nv_ma2 = "Murder & Assault".

                  IF (uwm307.abcd[1] = "31"   OR
                      uwm307.abcd[2] = "31"   OR
                      uwm307.abcd[3] = "31"   OR
                      uwm307.abcd[4] = "31")  THEN DO:
                      nv_mc  = "คุ้มครองเพิ่มอุบัติเหตุจากรถจักรยานยนต์".
                      nv_mc2 = "Motorcycle" . 
                  END.
                  /*report-name = "M60_polcard".   */
               END.
               /*---- ข้อมูลสำหรับ Print PA Card กรณีแพ็คเกจที่มี ค่ารักษาพยาบาล ----*/ 
            END.

            /*--- A67-0017 ---*/
            IF nv_class = "PSBP" THEN DO:
                RUN PD_Package (INPUT  nv_PlanCode ,
                                OUTPUT nv_SIPMedi,
                                OUTPUT nv_SIPB   , 
                                OUTPUT nv_CampDesc).
            END.
            /*--- A67-0017 ---*/
            
            
            nv_tot123 = nv_total[1] + nv_total[2] + nv_total[3].
            IF nv_tot123   = 0   THEN n_tot123 =  "-". ELSE n_tot123 = STRING(nv_tot123, ">>,>>>,>>9.99-").
            IF nv_total[4] = 0   THEN nv_tot4 =  "-".  ELSE nv_tot4 = STRING(nv_total[4], ">>,>>>,>>9.99-").
            IF nv_total[5] = 0   THEN nv_tot5 =  "-".  ELSE nv_tot5 = STRING(nv_total[5], ">>,>>>,>>9.99-").
            IF nv_total[6] = 0   THEN nv_tot6 =  "-".  ELSE nv_tot6 = STRING(nv_total[6], ">>,>>>,>>9.99-").
            // mbwks , mbsi , msded
            IF uwm307.mb4wks = 0 THEN nv_mb4wks = "-". ELSE nv_mb4wks = STRING(uwm307.mb4wks,">>9").
            IF uwm307.mb4ded = 0 THEN nv_mb4ded = "-". ELSE nv_mb4ded = STRING(uwm307.mb4ded,">>9").
            IF uwm307.mb5wks = 0 THEN nv_mb5wks = "-". ELSE nv_mb5wks = STRING(uwm307.mb5wks,">>9").
            IF uwm307.mb5ded = 0 THEN nv_mb5ded = "-". ELSE nv_mb5ded = STRING(uwm307.mb5ded,">>9").
            IF uwm307.mb6ded = 0 THEN nv_mb6ded = "-". ELSE nv_mb6ded = STRING(uwm307.mb6ded,">>,>>9.99").
            // ad1 
            IF nv_add = 0 THEN nv_ad1  = "-". ELSE nv_ad1  = STRING(nv_add, ">>,>>>,>>9.99-").
                
            // Manop G. StreamServe      TEST 
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_add   ,OUTPUT nv_ad1 ).
            // mbsi   // SunInsure 1,4,5,6
            nv_mbsi1    =   STRING(uwm307.mbsi[1]).
            nv_mbsi4    =   STRING(uwm307.mbsi[4]).
            nv_mbsi5    =   STRING(uwm307.mbsi[5]).
            nv_mbsi6    =   STRING(uwm307.mbsi[6]).
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_mbsi1   ,OUTPUT nv_mbsi1 ).
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_mbsi4   ,OUTPUT nv_mbsi4 ).
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_mbsi5   ,OUTPUT nv_mbsi5 ).
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_mbsi6   ,OUTPUT nv_mbsi6 ).
                        
            // RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_tot123    ,OUTPUT n_tot123 ).
            // RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_total[4]  ,OUTPUT nv_tot4  ).
            // RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_total[5]  ,OUTPUT nv_tot5  ).
            // RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_total[6]  ,OUTPUT nv_tot6  ).            
            // mb
            //  RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT uwm307.mb4wks  ,OUTPUT nv_mb4wks  ). 
            //  RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT uwm307.mb4ded  ,OUTPUT nv_mb4ded  ). 
            //  RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT uwm307.mb5wks  ,OUTPUT nv_mb5wks  ). 
            //  RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT uwm307.mb5ded  ,OUTPUT nv_mb5ded  ). 
            //  RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT uwm307.mb6ded  ,OUTPUT nv_mb6ded  ). 
            // mb UOM Desc
            RUN pd_uomdes(INPUT "J1" ,INPUT "" ,OUTPUT nv_mbsides1 ).  
            RUN pd_uomdes(INPUT "J2" ,INPUT "" ,OUTPUT nv_mbsides2 ).
            RUN pd_uomdes(INPUT "J3" ,INPUT "" ,OUTPUT nv_mbsides3 ).
            RUN pd_uomdes(INPUT "J4" ,INPUT "" ,OUTPUT nv_mbsides4 ).
            RUN pd_uomdes(INPUT "J5" ,INPUT "" ,OUTPUT nv_mbsides5 ).
            RUN pd_uomdes(INPUT "J6" ,INPUT "" ,OUTPUT nv_mbsides6 ). 
      
            RUN pd_riskcover (INPUT nv_login , 1 , "J1" , nv_mbsides1 , ""        ,  TRIM(nv_mbsi1) , ""        ,  TRIM(n_tot123) ) . 
            RUN pd_riskcover (INPUT nv_login , 2 , "J4" , nv_mbsides4 , nv_mb4wks ,  TRIM(nv_mbsi4) , nv_mb4ded ,  TRIM(nv_tot4) ) .
            RUN pd_riskcover (INPUT nv_login , 3 , "J5" , nv_mbsides5 , nv_mb5wks ,  TRIM(nv_mbsi5) , nv_mb5ded ,  TRIM(nv_tot5) ) .
            RUN pd_riskcover (INPUT nv_login , 4 , "J6" , nv_mbsides6 , ""        ,  TRIM(nv_mbsi6) , nv_mb6ded ,  TRIM(nv_tot6) ) .
           
                   
            nv_endatt = uwm307.endatt.                                      
            IF nv_disc = 0 THEN DO:
               nv_dsc2 = "-".
               nv_disc2 = 0.
            END.
            ELSE DO:
               nv_disc2 =  - nv_disc.
               nv_dsc2 = STRING(nv_disc2, ">>,>>>,>>9.99").
            END.
            
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_disc  , OUTPUT nv_dsc2  ).
            RUN pd_cdeci(INPUT  "A"  ,INPUT ""  ,INPUT nv_disc2 , OUTPUT nv_dsc2  ). 
                       
             // Manop G.  Risk-Detail & Benefit 
            RUN pd_riskDetail (INPUT nv_login ,n_inam1 ,nv_occup ,"" ,""  , TRIM(STRING(nv_age)) ,nv_yrtyp ,"nv_jrny" ,"Membercode" ,"Planname" ,nv_dsc2 ,"nv_load" ,nv_ad1 ,nv_endatt).
            RUN pd_benefit  (INPUT nv_login ,nv_policy ,1 ,nv_bnam1 ,nv_bicno ,nv_badd  , nv_bOccup ,nv_reship , "" ,nv_bDob ,TRIM(STRING(nv_age))).      

            IF nv_class = "PA2M" OR nv_class = "PA3M"     /* A63-0428 */
                    THEN nv_grands = string(nv_grand,">>>,>>>,>>9").
                    ELSE nv_grands = string(nv_grand,">>>,>>>,>>9.99").

            IF nv_class = "PA3M" THEN DO:
               /* TYPE IDH: ประเภทความพิการ = 1 ความพิการทางการมองเห็น */
               IF uwm100.fptr02 <> 0  AND uwm100.fptr02 <> ? THEN DO:
                   nvw_fptr = uwm100.fptr02.
                   DO WHILE nvw_fptr <> 0:
                       FIND uwd102 WHERE RECID(uwd102) = nvw_fptr NO-LOCK NO-ERROR.

                       IF INDEX(uwd102.ltext,"TYPE IDH:") <> 0 AND INDEX(uwd102.ltext,"=") <> 0 THEN DO:
                           nv_IDHType = TRIM(SUBSTRING(uwd102.ltext,INDEX(uwd102.ltext,"=") + 4)).
                       END.
                       nvw_fptr = uwd102.fptr.
                   END.
               END.
            END.

            
        
            
            
            /*---- A63-0463 ----*/
            IF gv_TypPermit <> "" AND gv_ReportName <> "" THEN DO :    
                report-name = gv_ReportName.                 
            END.
            ELSE DO: /* แผนเดิม อ่านค่าตามที่ Fix ไว้ */
                     IF nv_class = "PA2M" THEN report-name = "M60_micro".
                ELSE IF nv_class = "PA3M" THEN report-name = "M60_PA3M".     /* A63-0428 */
                ELSE IF nv_class = "PASB" THEN report-name = "M60_PASB".
                ELSE IF nv_class = "PSBP" THEN report-name = "M60_PSBP".
                ELSE DO: 
                    IF uwm307.mbsi[6] > 0 THEN report-name = "M60_PolCard".  /* มีค่ารักษาพยาบาล พิมพ์ PA Card ด้วย */
                     
                END.
            END.
            /*---- A63-0463 ----*/

            /*--- A67-0017 ---*/
            IF nv_class = "PASB" OR nv_class = "PSBP" THEN DO:
                IF nv_add  = 0 THEN nv_ad1 = "0.00".
                IF nv_disc = 0 THEN ASSIGN nv_dsc2  = "0.00"
                                           nv_disc2 =  0.
            END.
            /*--- A67-0017 ---*/
            
            DO WHILE nv_fptr <> 0 AND uwm100.fptr01 <> ? :
               FIND uwd100 WHERE RECID(uwd100) = nv_fptr NO-LOCK NO-ERROR.
               IF AVAILABLE uwd100 THEN DO: 
                 nv_fptr = uwd100.fptr.
                                  
                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:1 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI1 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI1 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI1 ).
                    
                 END.

                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:2 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI2 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI2 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI2 ).
                 END.
        
                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:3 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI3 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI3 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI3 ).
                 END.
        
                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:4 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI4 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI4 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI4 ).
                 END.

                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:5 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI5 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI5 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI5 ).
                 END.

                 ASSIGN nv_chkSI = 0  nv_chkUOM = 0.
                 IF INDEX(uwd100.ltext,"NO:5 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    nv_chkUOM = INDEX(uwd100.ltext,"UOM:").
                         IF nv_chkSI <> 0 AND nv_chkUOM  = 0 THEN nv_CoverSI5 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)).
                    ELSE IF nv_chkSI <> 0 AND nv_chkUOM <> 0 THEN nv_CoverSI5 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3,nv_chkUOM - nv_chkSI - 3)).
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI5 ).
                 END.

                 /*---------- A67-0017 -----------*/
                 nv_chkSI = 0.
                 IF INDEX(uwd100.ltext,"NO:6 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    IF nv_chkSI <> 0 THEN nv_CoverSI6 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)) .
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI6 ).
                 END.
                 nv_chkSI = 0.
                 IF INDEX(uwd100.ltext,"NO:7 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    IF nv_chkSI <> 0 THEN nv_CoverSI7 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)) .
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI7).
                 END.
                 nv_chkSI = 0.
                 IF INDEX(uwd100.ltext,"NO:8 COVER") <> 0 THEN DO:
                    nv_chkSI  = INDEX(uwd100.ltext,"SI:").
                    IF nv_chkSI <> 0 THEN nv_CoverSI8 = TRIM(SUBSTRING(uwd100.ltext,nv_chkSI + 3)) .
                    RUN pd_ptxcover (INPUT nv_login, nv_fptr ,nv_chkSI , nv_chkUOM , nv_CoverSI8).
                 END.
                 /*---------- A67-0017 -----------*/  
               END.
            END. 
            
            
                IF report-name = "M60_PolCard" THEN ASSIGN nv_PrnCard = TRUE nv_PrnATT = FALSE. 
                // uwm100.sch_p      =    YES .    TEST STEAMSERVE     MANOP  G.    เปิดก่อน ใช้จริง 
                // uwm100.drn_p      =    YES .    TEST STEAMSERVE     MANOP  G.    เปิดก่อน ใช้จริง   
                // Input Create Temp-Talble   
                RUN pd_tHeader       (INPUT nv_login, nv_cdat, nv_edat,     nv_adat,    nv_prtpol,  nv_class, nv_proddes ,nv_product , nv_mbsi1, nv_subtots, nv_stamp1, nv_taxs, nv_grands) . 
                RUN pd_AgentDet      (INPUT nv_login, nv_acno, nv_agtnam,   nv_agtreg,  nv_agttyp) .
                RUN pd_ClientDetails (INPUT nv_login, nv_nam1, nv_nam2,     nv_addr1,   nv_addr2,   nv_icno,    nv_tel ) .
                RUN pd_VATDet        (INPUT nv_login, nv_docno2 , nv_rtevat , nv_taxs , nv_nam1,  nv_nam2,    nv_addr1,   nv_addr2,    nv_icno ) .
                RUN pd_PrintDoc      (INPUT nv_login,   TRUE , FALSE , TRUE , nv_PrnATT , FALSE , FALSE , nv_PrnCard , FALSE) . 
                RUN PD_Prn60WS .    //Create Temp-Talble   
                //  Send Create Json 
                RUN WS\AddJson.p    (INPUT nv_login  ,
                                     INPUT nv_policy , 
                                     INPUT TABLE tHeader ,
                                     INPUT TABLE ClientDetails ,
                                     INPUT TABLE AgentDetails , 
                                     INPUT TABLE PCLAUSE ,
                                     INPUT TABLE HeadCover ,
                                     INPUT TABLE UpperText,
                                     INPUT TABLE RiskDetail,
                                     INPUT TABLE PBenefit ,
                                     INPUT TABLE RiskCover , 
                                     INPUT TABLE VATDlts ,
                                     INPUT TABLE PrintDoc)  .
                OUTPUT TO VALUE("WctxPrn60WS.TXT") APPEND.
                PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
                PUT "WctxPrn60WS 5 : " nv_policy  FORMAT "X(21)"
                                       nv_class   FORMAT "X(10)"
                                       report-name  FORMAT "X(20)"   
                    " CREATE PDF FILE Completed. " SKIP.
                OUTPUT CLOSE.
         END.
         ELSE DO:

            n_err = "กรุณาระบุเลขที่กรมธรรม์ใหม่ เนื่องจากมีการพิมพ์หน้าตารางกรมธรรม์แล้ว".
            
            OUTPUT TO VALUE("WctxPrn60WS.Err") APPEND.
              PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
              PUT "WctxPrn60WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
              PUT FILL("-",78) FORMAT "X(78)" SKIP.
            OUTPUT CLOSE.
         END.
       END.
       ELSE DO:
           n_err = "ไม่สามารถพิมพ์ได้ เนื่องจากวันที่หมดอายุน้อยกว่าวันที่คุ้มครอง".
           OUTPUT TO VALUE("WctxPrn60WS.Err") APPEND.
             PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
             PUT "WctxPrn60WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
             PUT FILL("-",78) FORMAT "X(78)" SKIP.
           OUTPUT CLOSE.
       END.
    END.
    ELSE DO:
       n_err = "ไม่พบเลขที่กรมธรรม์นี้ กรุณาตรวจสอบและระบุเลขที่กรมธรรม์ใหม่".
       OUTPUT TO VALUE("WctxPrn60WS.Err") APPEND.
         PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
         PUT "WctxPrn60WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
         PUT FILL("-",78) FORMAT "X(78)" SKIP.
       OUTPUT CLOSE.
    END.
END. /* IF n_err = "" THEN DO: */
ELSE DO:
    /*n_err = "ไม่สามารถปริ้นกรมธรรม์ได้".*/
    OUTPUT TO VALUE("WctxPrn60WS.Err") APPEND.
      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
      PUT "WctxPrn60WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
      PUT FILL("-",78) FORMAT "X(78)" SKIP.
    OUTPUT CLOSE.
END.

OUTPUT TO VALUE("WctxPrn60WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
PUT "WctxPrn60WS END " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
PUT FILL("-",78) FORMAT "X(78)" SKIP.
OUTPUT CLOSE.

PROCEDURE PD_Package.

    DEF INPUT   PARAMETER pv_PlanCode AS CHAR.
    DEF OUTPUT  PARAMETER pv_SIPMedi  AS deci.
    DEF OUTPUT  PARAMETER pv_SIPB     AS deci.
    DEF OUTPUT  PARAMETER pv_PlanDesc AS CHAR.
    
    DEFINE VARIABLE nv_Old              AS INT NO-UNDO.

    /* ถ้าเป็น PA เดี่ยว ใช้ BirthDate ของ Insured */
     nv_old = IF uwm307.idob <> ? THEN (YEAR(TODAY) - YEAR(uwm307.idob)) ELSE 0. 
    /**-------------------------------------------------------------------------------**/

    pv_SIPMedi = 0.
    pv_SIPB    = 0.
    pv_PlanDesc = "-". /* A67-0017 */

      FIND LAST package USE-INDEX package01 
          WHERE package.compno       = nv_CompanyNo  /* 833  */
          AND   package.poltyp       = uwm100.poltyp     /* M60  */
          AND   package.CLASS        = uwm120.class  /* P100 */
          AND   package.campaigncode = pv_PlanCode    /* ชื่อแผน  PASSK00001 , PASKG60200 */
          AND   package.age_min     <= nv_old
          AND   package.age_max     >= nv_old
          AND   package.effdat      <= uwm100.ComDat NO-LOCK NO-ERROR.
      IF NOT AVAIL package THEN DO:
         FIND LAST package USE-INDEX package01 
             WHERE package.compno       = nv_CompanyNo 
             AND   package.poltyp       = uwm100.poltyp
             AND   package.CLASS        = "ALL"               
             AND   package.campaigncode = pv_PlanCode
             AND   package.age_min     <= nv_old
             AND   package.age_max     >= nv_old
             AND   package.effdat      <= uwm100.ComDat NO-LOCK NO-ERROR.
         IF NOT AVAIL package THEN DO:
            FIND LAST package USE-INDEX package01 
                WHERE package.compno       = "ALL"            
                AND   package.poltyp       = uwm100.poltyp
                AND   package.CLASS        = uwm120.class
                AND   package.campaigncode = pv_PlanCode
                AND   package.age_min     <= nv_old
                AND   package.age_max     >= nv_old
                AND   package.effdat      <= uwm100.ComDat NO-LOCK NO-ERROR.
            IF NOT AVAIL package THEN DO:
               FIND LAST package USE-INDEX package01 
                   WHERE package.compno       = "ALL"  
                   AND   package.poltyp       = uwm100.poltyp
                   AND   package.CLASS        = "ALL"
                   AND   package.campaigncode = pv_PlanCode

                   AND   package.age_min     <= nv_old
                   AND   package.age_max     >= nv_old
                   AND   package.effdat      <= uwm100.ComDat NO-LOCK NO-ERROR.
               IF NOT AVAIL package THEN DO:
               END.
               ELSE DO:
                 ASSIGN
                   pv_SIPMedi  = Package.si_exten[2]
                   pv_SIPB     = Package.si_exten[3].
                   pv_PlanDesc = Package.campaigndesc. /* A67-0017 */
               END.
            END.
            ELSE DO:
                ASSIGN
                  pv_SIPMedi  = Package.si_exten[2]
                  pv_SIPB     = Package.si_exten[3].
                  pv_PlanDesc = Package.campaigndesc. /* A67-0017 */
            END.
         END.
         ELSE DO:
            ASSIGN
              pv_SIPMedi  = Package.si_exten[2]
              pv_SIPB     = Package.si_exten[3].
              pv_PlanDesc = Package.campaigndesc. /* A67-0017 */
         END.
      END.
      ELSE DO:
          ASSIGN
            pv_SIPMedi  = Package.si_exten[2]
            pv_SIPB     = Package.si_exten[3].
            pv_PlanDesc = Package.campaigndesc. /* A67-0017 */
      END.
      /**-------------------------------------------------------------------------------**/

      OUTPUT TO VALUE("WctxPrn60WS-Package.TXT") APPEND.
      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
      PUT "WctxPrn60WS nv_policy:" nv_policy FORMAT "X(20)" " " " Plan: " pv_PlanCode FORMAT "X(20)" " SIExt. : " string(pv_SIPMedi,">,>>>,>>9")  + "/" + string(pv_SIPB,">,>>>,>>9")  FORMAT "x(100)" SKIP
          pv_PlanDesc  FORMAT "x(300)" SKIP  . 
      OUTPUT CLOSE.                                     

END.

/***** END WCTXPRN64WS.P******/

 
PROCEDURE  PD_Prn60WS :   
  
           
           OUTPUT TO VALUE("REPORT_Prn60WS.TXT").
           PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP . 
           PUT  " report-name   ::   "    report-name   FORMAT "X(40)"  SKIP
                " n_m60         ::   "    n_m60         FORMAT "X(50)"  SKIP
                " n_m64         ::   "    n_m64         FORMAT "X(50)"  SKIP
                " n_m67         ::   "    n_m67         FORMAT "X(50)"  SKIP
                " nv_prtpol     ::   "    nv_prtpol     FORMAT "X(50)"  SKIP
                " nv_nam1       ::   "    nv_nam1       FORMAT "X(50)"  SKIP
                " n_inam1       ::   "    n_inam1       FORMAT "X(50)"  SKIP
                " n_inam2       ::   "    n_inam2       FORMAT "X(50)"  SKIP
                " nv_nam2       ::   "    nv_nam2       FORMAT "X(50)"  SKIP
                " nv_aged       ::   "    nv_aged       FORMAT "X(50)"  SKIP
                " nv_addr1      ::   "    nv_addr1      FORMAT "X(50)"  SKIP
                " nv_addr2      ::   "    nv_addr2      FORMAT "X(50)"  SKIP
                " nv_occup      ::   "    nv_occup      FORMAT "X(50)"  SKIP
                " nv_bicno      ::   "    nv_bicno      FORMAT "X(50)"  SKIP
                " nv_bnam1      ::   "    nv_bnam1      FORMAT "X(50)"  SKIP
                " nv_bnam2      ::   "    nv_bnam2      FORMAT "X(50)"  SKIP
                " nv_badd       ::   "    nv_badd       FORMAT "X(50)"  SKIP
                " nv_reship     ::   "    nv_reship     FORMAT "X(50)"  SKIP
                " nv_cdat       ::   "    nv_cdat       FORMAT "X(50)"  SKIP
                " nv_cdat_2     ::   "    nv_cdat_2     FORMAT "X(50)"  SKIP
                " nv_acctim     ::   "    nv_acctim     FORMAT "X(50)"  SKIP
                " nv_edat       ::   "    nv_edat       FORMAT "X(50)"  SKIP
                " nv_edat_2     ::   "    nv_edat_2     FORMAT "X(50)"  SKIP
                " nv_area1      ::   "    nv_area1      FORMAT "X(50)"  SKIP
                " nv_area2      ::   "    nv_area2      FORMAT "X(50)"  SKIP
                " nv_mbsi1      ::   "    nv_mbsi1      FORMAT "X(50)"  SKIP
                " n_tot123      ::   "    n_tot123      FORMAT "X(50)"  SKIP
                " nv_mbsi2      ::   "    nv_mbsi2      FORMAT "X(50)"  SKIP
                " nv_mbsi3      ::   "    nv_mbsi3      FORMAT "X(50)"  SKIP
                " nv_mb4wks     ::   "    nv_mb4wks     FORMAT "X(50)"  SKIP
                " nv_mbsi4      ::   "    nv_mbsi4      FORMAT "X(50)"  SKIP
                " nv_mbsi4_2    ::   "    nv_mbsi4_2    FORMAT "X(50)"  SKIP
                " nv_mbsi5_2    ::   "    nv_mbsi5_2    FORMAT "X(50)"  SKIP
                " nv_mbsi6_2    ::   "    nv_mbsi6_2    FORMAT "X(50)"  SKIP
                " nv_PMedi      ::   "    nv_PMedi      FORMAT "X(50)"  SKIP
                " nv_PB1        ::   "    nv_PB1        FORMAT "X(50)"  SKIP
                " nv_PB2        ::   "    nv_PB2        FORMAT "X(50)"  SKIP
                " nv_mb4ded     ::   "    nv_mb4ded     FORMAT "X(50)"  SKIP
                " nv_tot4       ::   "    nv_tot4       FORMAT "X(50)"  SKIP
                " nv_mb5wks     ::   "    nv_mb5wks     FORMAT "X(50)"  SKIP
                " nv_mbsi5      ::   "    nv_mbsi5      FORMAT "X(50)"  SKIP
                " nv_mb5ded     ::   "    nv_mb5ded     FORMAT "X(50)"  SKIP
                " nv_tot5       ::   "    nv_tot5       FORMAT "X(50)"  SKIP
                " nv_mbsi6      ::   "    nv_mbsi6      FORMAT "X(50)"  SKIP
                " nv_mb6ded     ::   "    nv_mb6ded     FORMAT "X(50)"  SKIP
                " nv_tot6       ::   "    nv_tot6       FORMAT "X(50)"  SKIP
                " nv_ad1        ::   "    nv_ad1        FORMAT "X(50)"  SKIP
                " nv_dsc2       ::   "    nv_dsc2       FORMAT "X(50)"  SKIP
                " nv_subtots    ::   "    nv_subtots    FORMAT "X(50)"  SKIP
                " nv_taxs       ::   "    nv_taxs       FORMAT "X(50)"  SKIP
                " nv_stamp1     ::   "    nv_stamp1     FORMAT "X(50)"  SKIP
                " nv_grands     ::   "    nv_grands     FORMAT "X(50)"  SKIP
                " nv_al123      ::   "    nv_al123      FORMAT "X(50)"  SKIP
                " nv_endatt     ::   "    nv_endatt     FORMAT "X(50)"  SKIP
                " nv_ag         ::   "    nv_ag         FORMAT "X(50)"  SKIP
                " nv_br         ::   "    nv_br         FORMAT "X(50)"  SKIP
                " nv_agtnam     ::   "    nv_agtnam     FORMAT "X(50)"  SKIP
                " nv_agtreg     ::   "    nv_agtreg     FORMAT "X(50)"  SKIP
                " nv_acno       ::   "    nv_acno       FORMAT "X(50)"  SKIP
                " nv_adat       ::   "    nv_adat       FORMAT "X(50)"  SKIP
                " nv_adat_2     ::   "    nv_adat_2     FORMAT "X(50)"  SKIP
                " nv_sdat       ::   "    nv_sdat       FORMAT "X(50)"  SKIP
                " nv_sdat_2     ::   "    nv_sdat_2     FORMAT "X(50)"  SKIP
                " nv_comdat     ::   "    nv_comdat     FORMAT "X(50)"  SKIP
                " nv_expdat     ::   "    nv_expdat     FORMAT "X(50)"  SKIP
                " nv_today      ::   "    nv_today      FORMAT "X(50)"  SKIP
                " nv_date       ::   "    nv_date       FORMAT "X(50)"  SKIP
                " nv_date_2     ::   "    nv_date_2     FORMAT "X(50)"  SKIP
                " nv_poltyp     ::   "    nv_poltyp     FORMAT "X(50)"  SKIP
                " nv_user       ::   "    nv_user       FORMAT "X(50)"  SKIP
                " nv_add11      ::   "    nv_add11      FORMAT "X(50)"  SKIP
                " nv_add12      ::   "    nv_add12      FORMAT "X(50)"  SKIP
                " nv_add13      ::   "    nv_add13      FORMAT "X(50)"  SKIP
                " nv_add14      ::   "    nv_add14      FORMAT "X(50)"  SKIP
                " nv_docno      ::   "    nv_docno      FORMAT "X(50)"  SKIP
                " nv_docno2     ::   "    nv_docno2     FORMAT "X(50)"  SKIP
                " nv_tel        ::   "    nv_tel        FORMAT "X(50)"  SKIP
                " nv_code       ::   "    nv_code       FORMAT "X(50)"  SKIP
                " nv_icno       ::   "    nv_icno       FORMAT "X(50)"  SKIP
                " nv_pic1       ::   "    nv_pic1       FORMAT "X(50)"  SKIP
                " nv_pic2       ::   "    nv_pic2       FORMAT "X(50)"  SKIP
                " nv_pic3       ::   "    nv_pic3       FORMAT "X(50)"  SKIP
                " nv_pic4       ::   "    nv_pic4       FORMAT "X(50)"  SKIP
                " nv_pic5       ::   "    nv_pic5       FORMAT "X(50)"  SKIP
                " nv_pic6       ::   "    nv_pic6       FORMAT "X(50)"  SKIP
                " nv_pic7       ::   "    nv_pic7       FORMAT "X(50)"  SKIP
                " nv_pic8       ::   "    nv_pic8       FORMAT "X(50)"  SKIP
                " nv_pic9       ::   "    nv_pic9       FORMAT "X(50)"  SKIP
                " nv_prvpol     ::   "    nv_prvpol     FORMAT "X(50)"  SKIP
                " nv_qrcode     ::   "    nv_qrcode     FORMAT "X(50)"  SKIP
                " nv_CoverSI1   ::   "    nv_CoverSI1   FORMAT "X(50)"  SKIP
                " nv_CoverSI2   ::   "    nv_CoverSI2   FORMAT "X(50)"  SKIP
                " nv_CoverSI3   ::   "    nv_CoverSI3   FORMAT "X(50)"  SKIP
                " nv_CoverSI4   ::   "    nv_CoverSI4   FORMAT "X(50)"  SKIP
                " nv_CoverSI5   ::   "    nv_CoverSI5   FORMAT "X(50)"  SKIP
                " nv_CoverSI6   ::   "    nv_CoverSI6   FORMAT "X(50)"  SKIP
                " nv_CoverSI7   ::   "    nv_CoverSI7   FORMAT "X(50)"  SKIP
                " nv_CoverSI8   ::   "    nv_CoverSI8   FORMAT "X(50)"  SKIP
                " nv_CampDesc   ::   "    nv_CampDesc   FORMAT "X(50)"  SKIP
                " nv_accdat     ::   "    nv_accdat     FORMAT "X(50)"  SKIP
                " nv_trndat     ::   "    nv_trndat     FORMAT "X(50)"  SKIP
                " nv_ma         ::   "    nv_ma         FORMAT "X(50)"  SKIP
                " nv_ma2        ::   "    nv_ma2        FORMAT "X(50)"  SKIP
                " nv_mc         ::   "    nv_mc         FORMAT "X(50)"  SKIP
                " nv_mc2        ::   "    nv_mc2        FORMAT "X(50)"  SKIP
                " nv_mbsi62     ::   "    nv_mbsi62     FORMAT "X(50)"  SKIP
                " nv_IDHType    ::   "    nv_IDHType    FORMAT "X(50)"  SKIP .            
           OUTPUT CLOSE.

           
END PROCEDURE .
