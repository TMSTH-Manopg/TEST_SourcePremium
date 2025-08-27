/* WctxPrn66WS.P  :  PERSONAL ACCIDENT FORM FOR A4  (WebService)                    */
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
/*                แสดงข้อความทั้งภาษาไทยและภาษาอังกฤษ คู่กัน      
------------------------------------------------------------------------------------                  
   Modify By : TANTAWAN Ch.   A67-0122   DATE : 09/07/2024
               - PA HIB  ประกันภัยชดเชยรายได้ส่วนบุคคล  Class : HBIE
                 คุ้มครองรายเดือน 
----------------------------------------------------------------------------------*/
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
DEFINE VAR  nv_CompanyNo  AS CHARACTER NO-UNDO INIT "4451".
DEFINE VAR  nv_policy     AS CHARACTER NO-UNDO INIT "M36667IG0005".
DEFINE VAR  nv_RenCnt     AS INTEGER   NO-UNDO INIT 0.
DEFINE VAR  nv_EedCnt     AS INTEGER   NO-UNDO INIT 0.
DEFINE VAR  nv_docno      AS CHARACTER NO-UNDO.
DEFINE VAR  nv_code       AS CHARACTER NO-UNDO.
DEFINE VAR  n_user        AS CHARACTER NO-UNDO.
DEFINE VAR  n_passwd      AS CHARACTER NO-UNDO.
DEFINE VAR  n_err         AS CHARACTER NO-UNDO.

nv_policy  =  "M36668IG0039"   .   //Policy New  M36668IG0039 , M36668IG0040 , M36668IG0041
// nv_policy  =  "M36668IG0042"   .   //Policy ReNew  M36668IG0042 
/*-------------- Reports -----------------*/
DEF VAR report-library       AS CHARACTER INIT "D:\WebOs\SteamServ\WS\WPRL\WCTXNON.PRL".
DEF VAR report-name          AS CHARACTER INIT "M66_HIB" .
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
DEF VAR nv_uwd105  AS INT.
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
DEF VAR nv_endatt  AS  CHAR  FORMAT "X(78)".
DEF VAR nv_ag      AS  CHAR  FORMAT "X".
DEF VAR nv_br      AS  CHAR  FORMAT "X".
DEF VAR nv_acno    AS  CHAR  FORMAT "X(10)".
DEF VAR nv_mbsi1   AS  CHAR  FORMAT "X(15)".
DEF VAR nv_mbsi2   AS  CHAR  FORMAT "X(15)".

DEF VAR n_m60      AS  CHAR  FORMAT "X".
DEF VAR n_m64      AS  CHAR  FORMAT "X".
DEF VAR n_m67      AS  CHAR  FORMAT "X".
DEF VAR nv_user    AS  CHAR.
def var nv_Receipt_fil AS RECID.
DEF VAR nv_Count1   AS INT.
DEF VAR nv_lineCins AS INT.
 nv_user = n_user.

DEF VAR nv_nam2    AS  CHAR  FORMAT "x(120)".
DEF VAR nv_badd1   AS  CHAR  FORMAT "X(50)".
DEF VAR nv_badd2   AS  CHAR  FORMAT "X(25)".

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
DEF VAR nv_pic9  AS CHAR INIT "".
DEF VAR nv_pic10 AS CHAR INIT "".
DEF VAR nv_pics  AS CHAR INIT "".
DEF VAR nv_pic   AS CHAR INIT "".

DEF VAR nv_comdat AS CHAR INIT "".
DEF VAR nv_expdat AS CHAR INIT "".
DEF VAR nv_today  AS CHAR INIT "".
DEF VAR nv_poltyp AS CHAR INIT "".
DEF VAR nv_add11  AS CHAR INIT "".
DEF VAR nv_add12  AS CHAR INIT "".
DEF VAR nv_add13  AS CHAR INIT "".
DEF VAR nv_add14  AS CHAR INIT "".
DEF VAR nv_tel    AS CHAR INIT "".
DEF VAR nv_docno2 AS CHAR INIT "".
/*05/08/2015*/

DEF VAR nv_idob       AS   CHAR.
DEF VAR nv_nam1       AS CHARACTER .
DEF VAR nv_addr1      AS CHARACTER .  /*uwm100.addr1        nv_addr1    =   EntTa68.InsuredRefAddr           */
DEF VAR nv_addr2      AS CHARACTER .  /*uwm100.addr2        nv_addr2    =   EntTa68.InsuredRefSubDistrict    */
DEF VAR nv_addr3      AS CHARACTER .  /*uwm100.addr3        nv_addr3    =   EntTa68.InsuredRefDistrict       */
DEF VAR nv_prov       AS CHARACTER .  /*uwm100.addr4        nv_prov     =   EntTa68.InsuredRefProvinc        */
DEF VAR nv_postcode   AS CHARACTER .  /*uwm100.postcd       nv_postcode =   EntTA68.InsuredRefPostalCode     */
//       Close Test SteamServe 
// DEF SHARED VAR gv_TypPermit    AS CHAR.
// DEF SHARED VAR gv_ReportName   AS CHAR.
// DEF SHARED VAR nv_PlanCode AS CHAR .
DEF VAR gv_TypPermit    AS CHAR.
DEF VAR gv_ReportName   AS CHAR.
DEF VAR nv_PlanCode     AS CHAR. /* A66-0263 */
/*-- A67-0122 --*/
DEF VAR nv_reship1    AS CHAR.
DEF VAR nv_reship2    AS CHAR.
DEF VAR nv_idxs       AS INT.
DEF VAR nv_append     AS CHAR.
/*-- A67-0122 --*/

// Manop G. SteamServe
DEF VAR  nv_login      AS CHAR  INIT "". 
DEF VAR  nv_rec120    AS  RECID  INIT ? . 
DEF VAR  nv_yrtyp     AS CHAR.     
DEF VAR  nv_poldes    AS CHAR.
DEF VAR  nv_taxno     AS CHAR .
DEF VAR  nv_rtevat    AS CHAR INIT "".
DEF VAR  nv_bicno     AS CHAR.    
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


OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3)
"        START : " nv_CompanyNo  FORMAT "X(10)"  n_user " / "  n_passwd  SKIP. OUTPUT CLOSE. 

ASSIGN
    nv_pic1 = "wimage\SignTM1_Sutichai.gif" /*Kridtiya i. 06/01/2020  */
    nv_pic2 = "wimage\stamp_TMSTH.gif"      /*Kridtiya i. 06/01/2020  */
    nv_pic3 = "wimage\SignTM1_Kiryu.gif"    /*Kridtiya i. 06/01/2020  */
    nv_pic4 = "WIMAGE\m60_200_new.gif"
    nv_pic5 = "WIMAGE\m60_200_1_new.gif"         
    nv_pic6 = "WIMAGE\stamp_new.gif"
    /*nv_pic7 = "WIMAGE\namey_suwanna.gif" */  /* K.Suwanna @01/09/2015*/  /*-- A67-0122 --*/
    nv_pic7 = "WIMAGE\K.Siri.gif"              /* K.Siri */ /*-- A67-0122 --*/
    /*nv_pic8 = "WIMAGE\headname_new.gif". */  /* Kridtiya i. 06/01/2020 */
    /*nv_pic8 = "WIMAGE\HeadTMSTH-black.gif" . /* Kridtiya i. 06/01/2020 */*/
    nv_pic8 = "WIMAGE\ScheduleHeader1.gif"     /* Tantwaan Ch. -- A63-0343 -- */
    nv_pic9 = "WIMAGE\square.gif"        /* A67-0122 */                  
    nv_pic10 = "WIMAGE\squarex_s.gif".   /* A67-0122 */                    

OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3).
PUT "WctxPrn66WS 1 : " nv_policy  FORMAT "X(20)" " Document : " nv_docno FORMAT "X(10)" SKIP.
OUTPUT CLOSE. 

nv_login  =  "" .
IF n_err = "" THEN DO:

    FIND FIRST uwm100 WHERE
               uwm100.policy = nv_policy /*AND
               uwm100.rencnt = nv_RenCnt AND
               uwm100.endcnt = nv_EedCnt*/ NO-ERROR.
    IF AVAIL uwm100 THEN DO:

OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
PUT "WctxPrn66WS 2 : " nv_policy  FORMAT "X(20)" " " STRING(uwm100.expdat) FORMAT "X(10)" " > "  STRING(uwm100.comdat) FORMAT "X(15)" SKIP.
OUTPUT CLOSE. 

      nv_docno2 = uwm100.trty11 + " " + uwm100.docno1. /* A67-0122 */
      nv_login   =  STRING(nv_policy) + STRING(DAY(TODAY)) + STRING(MONTH(TODAY)) + STRING(YEAR(TODAY)) + STRING(TIME) + STRING(MTIME) . 
      
      IF uwm100.expdat > uwm100.comdat THEN DO:

OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
 PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
 PUT "WctxPrn66WS 3 : " nv_policy  FORMAT "X(20)" " sch_p  : " STRING( uwm100.sch_p) FORMAT "X(5)" STRING( uwm100.drn_p) SKIP.
OUTPUT CLOSE.  

         /* IF uwm100.sch_p = NO AND      ปิดเทส  SteamServe Manop G. 
               uwm100.drn_p = NO THEN DO:  */
         
         IF uwm100.sch_p = YES AND 
            uwm100.drn_p = YES THEN DO:
         
             ASSIGN
                nv_uwd105  =  0      nv_addr1   =  ""      nv_addr2   =  ""
                nv_cdat    =  ""     nv_addr3   =  ""      nv_idob    =  "" 
                nv_edat    =  ""     nv_adat    =  ""      nv_sdat    =  ""
                nv_total   =  0      nv_be      =  0       nv_disc    =  0 
                nv_disc2   =  0      nv_add     =  0       nv_ad1     =  ""
                nv_dsc2    =  ""     nv_tax     =  0       nv_taxs    =  ""
                nv_subtot  =  0      nv_subtots =  ""      nv_stamp   =  0
                nv_stamp1  =  ""     nv_grand   =  0       nv_grands  =  ""
                nv_age     =  0      nv_aged    =  ""      nv_a       =  0
                nv_b       =  0      nv_c       =  0       nv_cday    =  0
                nv_cmonth  =  0      nv_iday    =  0       nv_imonth  =  0
                nv_occup   =  ""     nv_cnt     =  0       nv_bnam1   =  ""
                nv_bnam2   =  ""     nv_prtpol  =  ""      nv_agtnam  =  ""
                nv_agtreg  =  ""     nv_agttyp  =  ""      /*nv_nam1    =  ""*/
                nv_nam2    =  ""     nv_reship  =  ""      nv_badd    =  ""   
                nv_acctim  =  ""     nv_reship1 = ""       nv_reship2 =  ""  
                nv_endatt  =  ""     nv_ag      =  ""      nv_br      =  ""  
                nv_acno    =  ""     nv_mbsi1   =  ""      nv_mbsi2   =  "" 
                n_m60      =  ""     n_m64      =  ""      n_m67      =  ""     
                n_inam1    =  ""      n_inam2   =  ""      nv_append  =  "". 

            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                       uwm120.policy = uwm100.policy    AND
                       uwm120.rencnt = uwm100.rencnt    AND
                       uwm120.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
            IF NOT AVAIL uwm120 THEN DO :
                n_err = "ไม่พบข้อมูลกรมธรรม์ที่ UWM120".
                OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
                  PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
                  PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
                  PUT FILL("-",78) FORMAT "X(78)" SKIP.
                OUTPUT CLOSE.
                RETURN.
            END.

            FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
                       uwm130.policy = uwm100.policy    AND
                       uwm130.rencnt = uwm100.rencnt    AND
                       uwm130.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
            IF NOT AVAIL uwm130 THEN DO :
                n_err = "ไม่พบข้อมูลกรมธรรม์ที่ UWM130".
                OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
                  PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
                  PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
                  PUT FILL("-",78) FORMAT "X(78)" SKIP.
                OUTPUT CLOSE.
                RETURN.
            END.
            
            /*---begin by Chaiyong w. A58-0145 06/05/2015*/
            ASSIGN
            nv_class    =  uwm120.CLASS 
            nv_add11    =  uwm100.addr1
            nv_add12    =  uwm100.addr2
            nv_add13    =  uwm100.addr3
            nv_add14    =  TRIM(TRIM(uwm100.addr4) + " " + TRIM(uwm100.postcd))
            nv_comdat   =  STRING(uwm100.comdat,"99/99/9999")
            nv_expdat   =  STRING(uwm100.expdat,"99/99/9999")
            nv_today    =  STRING(TODAY,"99/99/9999")              
            nv_prtpol   =  uwm100.policy 
            nv_append   =  uwm100.cr_2  
            nv_language =  uwm100.langug 
            nv_acctim   =  uwm100.acctim 
            nv_taxno    =  uwm100.icno    
            nv_product  =  uwm100.cr_1
            nv_proddes  =  ""  
            nv_nam2     =  uwm100.name2
            nv_addr1    =  TRIM(uwm100.addr1) + " " + TRIM(uwm100.addr2)
            nv_addr2    =  TRIM(uwm100.addr3) + " " + TRIM(uwm100.addr4) + " " + TRIM(uwm100.postcd).

                 IF uwm100.ntitle <> "" AND uwm100.fname <> "" THEN nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.fname)  + " " + TRIM(uwm100.name1).
            ELSE IF uwm100.fname  <> "" THEN nv_nam1 = TRIM(uwm100.fname)  +  " " + TRIM(uwm100.name1).
            ELSE IF uwm100.ntitle <> "" THEN nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1). 
            ELSE    nv_nam1 = TRIM(uwm100.name1).
            
            // Date_1 
            IF uwm100.comdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.comdat,OUTPUT nv_cdat). IF SUBSTR(nv_cdat,1,1) = "0" THEN nv_cdat = SUBSTR(nv_cdat,2).
            IF uwm100.expdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.expdat,OUTPUT nv_edat). IF SUBSTR(nv_edat,1,1) = "0" THEN nv_edat = SUBSTR(nv_edat,2).
            IF uwm100.accdat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.accdat,OUTPUT nv_adat). IF SUBSTR(nv_adat,1,1) = "0" THEN nv_adat = SUBSTR(nv_adat,2).
            IF uwm100.trndat <> ? THEN RUN pd_matday(INPUT "1" ,nv_language,uwm100.trndat,OUTPUT nv_sdat). IF SUBSTR(nv_sdat,1,1) = "0" THEN nv_sdat = SUBSTR(nv_sdat,2).
            RUN pd_matday(INPUT "1" ,nv_language,TODAY,OUTPUT nv_date). IF SUBSTR(nv_date,1,1) = "0" THEN nv_date = SUBSTR(nv_date,2).
                        
            nv_subtot  = uwm100.prem_t.
            nv_subtots = string(nv_subtot,">>>,>>>,>>9.99-").             
            nv_tax   = uwm100.pfee + uwm100.ptax + uwm100.rfee_t + uwm100.rtax_t.
            nv_taxs  = string(nv_tax,">>>,>>>,>>9.99").
            nv_stamp = uwm100.pstp + uwm100.rstp_t. 
            RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_subtot      ,OUTPUT nv_subtots).
            RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_tax         ,OUTPUT nv_taxs).
            RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_stamp       ,OUTPUT nv_stamp1).
            RUN pd_cdeci(INPUT ""   ,INPUT "INT|B"   ,INPUT uwm100.gstrat  ,OUTPUT nv_rtevat).
            
            IF uwm100.pstp = 0 THEN nv_stamp1 =         string(nv_stamp,">>>,>>>,>>9.99-").
                               ELSE nv_stamp1 = "Dup" + STRING(uwm100.pstp,">>9") + " + " +
                                                   trim(string(uwm100.rstp_t,">,>>9")).

            nv_grand  = nv_subtot + nv_tax + nv_stamp.
            nv_grands = string(nv_grand,">>>,>>>,>>9.99").
            RUN pd_cdeci(INPUT "A"  ,INPUT ""        ,INPUT nv_grand       ,OUTPUT nv_grands).
            
            FIND FIRST xcpara49 USE-INDEX xcpara4901 WHERE
                     xcpara49.class   = "GRPPROD"  AND /*GRP.PRODUCT*/
                     xcpara49.type[1] = uwm100.cr_1 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE xcpara49 THEN nv_proddes = TRIM(xcpara49.type[7]).
             
               /* IF uwm100.poltyp = "M60" THEN n_m60 = "X".
            ELSE IF uwm100.poltyp = "M64" THEN n_m64 = "X".
            ELSE IF uwm100.poltyp = "M67" THEN n_m67 = "X". */

            FIND /*FIRST*/ xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR.
            IF AVAIL xmm031 THEN nv_poltyp = "Type of Policy........... " + xmm031.poldes.

            FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.insref NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN DO:
                ASSIGN
                    nv_tel  = xmm600.phone
                    nv_icno = xmm600.icno.
            END.
            
            FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
                ASSIGN
                    nv_agtreg = xmm600.agtreg
                    nv_agttyp = xmm600.acccod.
        
            IF uwm100.langug <> "" THEN DO:   /*thai*/
               FIND /*FIRST*/ xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = uwm100.agent NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL xtm600  THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME.
               ELSE DO:
                  FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno =  uwm100.agent    NO-LOCK NO-ERROR NO-WAIT.
                  IF AVAIL xmm600 THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME .
                                  ELSE nv_agtnam = "".
               END.
            END.
            ELSE DO:   /* eng */
               FIND /*FIRST*/ xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL xmm600 THEN nv_agtnam = xmm600.ntitle + " " + xmm600.NAME .
                               ELSE nv_agtnam = "".
            END.
        
            IF nv_agttyp  = "AG" THEN nv_ag = "X". ELSE nv_br = "X".            
            nv_acno   = "(" + uwm100.acno1 + ")".             
            
            /********************** not nv_multi **********************/
            FIND FIRST uwm307 USE-INDEX uwm30701 WHERE
                       uwm307.policy = uwm100.policy  AND
                       uwm307.rencnt = uwm100.rencnt  AND
                       uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
            IF AVAIL uwm307 THEN DO :

               IF uwm307.idob <> ? THEN DO:  
                   nv_age = YEAR(uwm100.comdat) - YEAR(uwm307.idob). 
                   nv_idob = STRING(DAY(uwm307.idob),"99")   + "/" +
                             STRING(MONTH(uwm307.idob),"99") + "/" +
                             STRING(YEAR(uwm307.idob),"9999").                  
               END.
               ELSE DO: 
                   IF uwm307.iyob <> 0 THEN  nv_age = YEAR(uwm100.comdat) - uwm307.iyob.  
                                       ELSE  nv_age = 0. 
               END.
               
               ASSIGN
                 nv_occup  = uwm307.iocc
                 nv_bnam1  = uwm307.bname1
                 nv_bnam2  = uwm307.bname2
                 nv_reship = uwm307.reship
                 nv_bicno  = uwm307.icno
                 nv_badd   = uwm307.badd1  + " " + uwm307.badd2
                 n_inam1   = uwm307.ifirst + " " + uwm307.iname
                 n_inam2   = "".

            END.
            ELSE RETURN.   // Avail uwm307
            
            nv_endatt = uwm307.endatt.
            IF uwm100.langug = "" THEN DO :
              IF nv_age <> 0 THEN ASSIGN nv_aged = STRING(nv_age) + " Years"    nv_yrtyp = " Years"  . 
            END.
            ELSE DO:
              IF nv_age <> 0 THEN ASSIGN nv_aged = STRING(nv_age) + " ปี/Years" nv_yrtyp = " ปี" .
            END.
            /***********************************************/
            
            /*------------------*/
            nv_idxs = 0.
            nv_idxs = index(uwm307.reship,",").
            IF nv_idxs <> 0 THEN DO:
               nv_reship1 = TRIM(SUBSTRING(uwm307.reship,1,nv_idxs - 1)) .
               nv_reship2 = TRIM(SUBSTRING(uwm307.reship,nv_idxs + 1))   .
            END.

                 IF uwm130.uom1_c = "HB" THEN nv_mbsi1 = string(uwm130.uom1_v, ">>>,>>9").
            ELSE IF uwm130.uom2_c = "HB" THEN nv_mbsi1 = string(uwm130.uom2_v, ">>>,>>9").
            ELSE IF uwm130.uom3_c = "HB" THEN nv_mbsi1 = string(uwm130.uom3_v, ">>>,>>9").
            ELSE IF uwm130.uom4_c = "HB" THEN nv_mbsi1 = string(uwm130.uom4_v, ">>>,>>9").
            ELSE IF uwm130.uom5_c = "HB" THEN nv_mbsi1 = string(uwm130.uom5_v, ">>>,>>9").
            
                 IF uwm130.uom1_c = "IC" THEN nv_mbsi2 = string(uwm130.uom1_v, ">>>,>>9").
            ELSE IF uwm130.uom2_c = "IC" THEN nv_mbsi2 = string(uwm130.uom2_v, ">>>,>>9").
            ELSE IF uwm130.uom3_c = "IC" THEN nv_mbsi2 = string(uwm130.uom3_v, ">>>,>>9").
            ELSE IF uwm130.uom4_c = "IC" THEN nv_mbsi2 = string(uwm130.uom4_v, ">>>,>>9").
            ELSE IF uwm130.uom5_c = "IC" THEN nv_mbsi2 = string(uwm130.uom5_v, ">>>,>>9").

            nv_PrnRCP  =  TRUE . 
            // Manop G.  Risk-Detail & Benefit 
            RUN pd_riskDetail (INPUT nv_login ,n_inam1 ,nv_occup ,"" ,""  , TRIM(STRING(nv_age)) ,nv_yrtyp ,"nv_jrny" ,"Membercode" ,"Planname" ,nv_dsc2 ,"nv_load" ,nv_ad1 ,nv_endatt).
            RUN pd_benefit  (INPUT nv_login ,nv_policy ,1 ,nv_bnam1 , nv_bicno ,nv_badd  , nv_bOccup ,nv_reship1 , "" ,nv_bDob ,TRIM(STRING(nv_age))).      
            RUN pd_riskcover (INPUT nv_login , 1 , "J1" , "ตามเอกสารแนบ" , "ตามเอกสารแนบ"   ,  TRIM(nv_mbsi2) , ""        ,  TRIM(nv_mbsi1) ) . 
            
            /*---- A63-0463 ----*/
            IF gv_TypPermit <> "" AND gv_ReportName <> "" THEN DO :
                report-name = gv_ReportName.
                    OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
                      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
                      PUT "WctxPrn66WS3.1: " nv_policy  FORMAT "X(20)" " ReportP: " Report-name FORMAT "X(15)" gv_TypPermit FORMAT "X(5)" n_user  " " n_passwd SKIP.
                    OUTPUT CLOSE.
            END.
            ELSE IF nv_class = "HBIE" THEN report-name = "M66_HIB".     /* A67-0122 */

            IF uwm100.rencnt > 0 THEN DO: 
               report-name = report-name + "R". /* ต่ออายุของ Igloo ต่ออายุไม่ gen หน้าตาราง gen เฉพาะใบเสร็จ*/ 
               nv_PrnSCH    =    FALSE .
               nv_PrnRCP    =    TRUE .     // Renew ปริ้นแต่ ใบเสร็จ 
               nv_PrnATT    =    FALSE .
               nv_PrnCard   =    FALSE .
            END.                    
                    OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
                      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
                      PUT "WctxPrn66WS3.2: " nv_policy  FORMAT "X(20)" " ReportF: " Report-name FORMAT "X(15)" nv_class FORMAT "X(5)" SKIP.
                    OUTPUT CLOSE.

            FIND FIRST dbtable WHERE dbtable.phyname = "stat"  OR dbtable.phyname = "form"   /*--- 27/10/2023 ---*/ NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL dbtable THEN DO:
                RB-DB-CONNECTION  = dbtable.unixpara /*+  " -U " + n_user + " -P " + n_passwd*/ .
            END.

OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3).
PUT "WctxPrn66WS 4 : " RB-DB-CONNECTION  FORMAT "X(100)"  SKIP.
OUTPUT CLOSE. 

            /*                         
        RUN  WCTX\wctxptax.P (INPUT RECID(uwm100),
                              INPUT-OUTPUT RB-OTHER-PARAMETERS).            */ 

           /*              
            uwm100.sch_p      =    YES .
            uwm100.drn_p      =    YES .   */ 
            
                RUN pd_tHeader       (INPUT nv_login, nv_cdat, nv_edat,     nv_adat,    nv_prtpol,  nv_class, nv_proddes ,nv_product , nv_mbsi1, nv_subtots, nv_stamp1, nv_taxs, nv_grands) . 
                RUN pd_AgentDet      (INPUT nv_login, nv_acno, nv_agtnam,   nv_agtreg,  nv_agttyp) .
                RUN pd_ClientDetails (INPUT nv_login, nv_nam1, nv_nam2,     nv_addr1,   nv_addr2,   nv_icno,    nv_tel ) .
                RUN pd_VATDet        (INPUT nv_login, nv_docno2 , nv_rtevat , nv_taxs , nv_nam1,  nv_nam2,    nv_addr1,   nv_addr2,    nv_icno ) .
                RUN pd_PrintDoc      (INPUT nv_login, nv_PrnSCH , FALSE , nv_PrnRCP , nv_PrnATT , FALSE , FALSE , nv_PrnCard , FALSE) . 
                RUN PD_Prn66WS .       // Create Temp-Talble   
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
            
            OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
              PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
              PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
              PUT FILL("-",78) FORMAT "X(78)" SKIP.
            OUTPUT CLOSE.
         END.
       END.
       ELSE DO:
           n_err = "ไม่สามารถพิมพ์ได้ เนื่องจากวันที่หมดอายุน้อยกว่าวันที่คุ้มครอง".
           OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
             PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
             PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
             PUT FILL("-",78) FORMAT "X(78)" SKIP.
           OUTPUT CLOSE.
       END.
    END.
    ELSE DO:
       n_err = "ไม่พบเลขที่กรมธรรม์นี้ กรุณาตรวจสอบและระบุเลขที่กรมธรรม์ใหม่".
       OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
         PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
         PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
         PUT FILL("-",78) FORMAT "X(78)" SKIP.
       OUTPUT CLOSE.
    END.
END. /* IF n_err = "" THEN DO: */
ELSE DO:
    /*n_err = "ไม่สามารถปริ้นกรมธรรม์ได้".*/
    OUTPUT TO VALUE("WctxPrn66WS.Err") APPEND.
      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
      PUT "WctxPrn66WS-Err " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
      PUT FILL("-",78) FORMAT "X(78)" SKIP.
    OUTPUT CLOSE.
END.

OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
PUT "WctxPrn66WS END " nv_policy  FORMAT "X(20)" " ERRROR : " n_err FORMAT "x(100)" SKIP.
PUT FILL("-",78) FORMAT "X(78)" SKIP.
OUTPUT CLOSE.

/***** END WCTXPRN64WS.P******/


PROCEDURE  PD_Prn66WS :   

                   
OUTPUT TO VALUE("WctxPrn66WS.TXT") APPEND.
PUT "report-name : " report-name FORMAT "x(35)" skip
    "n_m60     : "      n_m60        SKIP
    "nv_prtpol : "      nv_prtpol    skip
    "nv_nam1   : "      nv_nam1    FORMAT "X(25)"  skip
    "n_inam1   : "      n_inam1    FORMAT "X(25)"  skip
    "n_inam2   : "      n_inam2    FORMAT "X(25)"  skip
    "nv_nam2   : "      nv_nam2    FORMAT "X(25)"  skip
    "nv_idob   : "      string(nv_idob,"99/99/9999") FORMAT "X(20)"     skip
    "nv_addr1  : "      nv_addr1   FORMAT "X(25)"  skip
    "nv_addr2  : "      nv_addr2   FORMAT "X(25)"  skip
    "nv_occup  : "      nv_occup   FORMAT "X(25)"  skip
    "nv_age    : "      string(nv_age)    FORMAT "X(3)" SKIP
    "nv_append : "      nv_append  FORMAT "X(25)"  SKIP
    "nv_bnam1  : "      nv_bnam1   FORMAT "X(25)"  skip
    "nv_bnam2  : "      nv_bnam2   FORMAT "X(25)"   skip
    "nv_reship1: "      nv_reship1 FORMAT "X(25)"  SKIP
    "nv_reship2: "      nv_reship2 FORMAT "X(25)"  skip
    "nv_cdat   : "      nv_cdat    FORMAT "X(25)"  skip
    "nv_acctim : "      nv_acctim  FORMAT "X(25)"  skip
    "nv_edat   : "      nv_edat    FORMAT "X(25)"  skip
    "nv_mbsi1  : "      nv_mbsi1   FORMAT "X(25)"  skip
    "nv_mbsi2  : "      nv_mbsi2   FORMAT "X(25)"  skip
    "nv_ad1    : "      nv_ad1     FORMAT "X(25)"  skip
    "nv_subtots: "      nv_subtots FORMAT "X(25)"  skip
    "nv_taxs   : "      nv_taxs    FORMAT "X(25)"  skip
    "nv_stamp1 : "      nv_stamp1  FORMAT "X(25)"  skip
    "nv_grands : "      nv_grands  FORMAT "X(25)"  skip
    "nv_endatt : "      nv_endatt  FORMAT "X(25)"  skip
    "nv_ag     : "      nv_ag      FORMAT "X(25)"  skip
    "nv_br     : "      nv_br      FORMAT "X(25)"  skip
    "nv_agtnam : "      nv_agtnam  FORMAT "X(25)"  skip
    "nv_agtreg : "      nv_agtreg  FORMAT "X(25)"  skip
    "nv_acno   : "      nv_acno    FORMAT "X(25)"  skip
    "nv_adat   : "      nv_adat    FORMAT "X(25)"  skip
    "nv_sdat   : "      nv_sdat    FORMAT "X(25)"  skip
    "nv_comdat : "      nv_comdat  FORMAT "X(25)"  skip
    "nv_expdat : "      nv_expdat  FORMAT "X(25)"  skip
    "nv_today  : "      nv_today   FORMAT "X(25)"  skip
    "nv_date   : "      nv_date    FORMAT "X(25)"  skip
    "nv_poltyp : "      nv_poltyp  FORMAT "X(25)"  skip
    "nv_user   : "      nv_user    FORMAT "X(25)"  skip
    "nv_add11  : "      nv_add11   FORMAT "X(25)"  skip
    "nv_add12  : "      nv_add12   FORMAT "X(25)"  skip
    "nv_add13  : "      nv_add13   FORMAT "X(25)"  skip
    "nv_add14  : "      nv_add14   FORMAT "X(25)"  skip
    "nv_docno  : "      nv_docno   FORMAT "X(25)"  skip
    "nv_docno2 : "      nv_docno2  FORMAT "X(25)"  skip
    "nv_tel    : "      nv_tel     FORMAT "X(25)"  skip
    "nv_code   : "      nv_code    FORMAT "X(25)"  skip
    "nv_icno   : "      nv_icno    FORMAT "X(25)"  skip
    "nv_pic1   : "      nv_pic1    FORMAT "X(45)"  skip
    "nv_pic2   : "      nv_pic2    FORMAT "X(45)"  skip
    "nv_pic3   : "      nv_pic3    FORMAT "X(45)"  skip
    "nv_pic4   : "      nv_pic4    FORMAT "X(45)"  skip
    "nv_pic5   : "      nv_pic5    FORMAT "X(45)"  skip
    "nv_pic6   : "      nv_pic6    FORMAT "X(45)"  skip 
    "nv_pic7   : "      nv_pic7    FORMAT "X(45)"  skip 
    "nv_pic8   : "      nv_pic8    FORMAT "X(45)"  skip   
    "nv_pic9   : "      nv_pic9    FORMAT "X(45)"  skip
    "nv_pic10  : "      nv_pic10   FORMAT "X(45)"  skip       .
OUTPUT CLOSE.


END. 
