/* WCTXPrn69WS.P  :  Worldwide Travel Insurance                                     */
/* PRINT SCHEDULE POLICY FORM A4 LINE 69                                            */
/* CREATE By  : TANTAWAN CH.  @15/02/2017                                           */
/* ASSIGN No. : A60-0090                                                            */
/**************************************************************                     */
/* MIDIFY By  : TANTAWAN CH.  4/10/2018  เปลี่ยนลายเซ็นหน้าตาราง                    */ 
/* Modify By  : Tantawan Ch.  A60-0019  DATE : 15/01/2020                           */
/*              - เปลี่ยนมาใช้ Document no 10 หลัก                                  
                - เปลี่ยนหัวมาเป็น TMSTH , เปลี่นลายเซ็นต์                          */
/*              - เพิ่ม QRCode ที่หน้าตาราง สำหรับงาน Non-Motor                     */
/* MIDIFY By  : TANTAWAN CH.  11/08/2020                                            */ 
/* ASSIGN No. : A63-0343                                                            */
/*             - เปลี่ยนที่อยู่หัวกระดาษ เปลี่ยนชื่อไฟล์ให้เหมือนกัน                */
/************************************************************************************/

/*1*/ DEFINE INPUT  PARAMETER nv_CompanyNo  AS CHARACTER NO-UNDO. /*'793'*/
/*2*/ DEFINE INPUT  PARAMETER nv_policy     AS CHARACTER NO-UNDO. /*"d07257bb0322"*/
/*3*/ DEFINE INPUT  PARAMETER nv_RenCnt     AS INTEGER   NO-UNDO.
/*4*/ DEFINE INPUT  PARAMETER nv_EedCnt     AS INTEGER   NO-UNDO.
/*5*/ DEFINE INPUT  PARAMETER nv_docno      AS CHARACTER NO-UNDO. /*"2000122"*/
/*6*/ DEFINE INPUT  PARAMETER nv_code       AS CHARACTER NO-UNDO. /*"201-01-5-57"*/
/*7*/ DEFINE INPUT  PARAMETER n_user        AS CHARACTER NO-UNDO. /*"cmluk0".*/
/*8*/ DEFINE INPUT  PARAMETER n_passwd      AS CHARACTER NO-UNDO. /*"luk0".*/
/*9*/ DEFINE OUTPUT PARAMETER n_err         AS CHARACTER NO-UNDO.

/*-------------- Reports -----------------*/
DEF VAR report-library       AS CHARACTER INIT "WCTX\WPRL\WCTXNON.PRL".
DEF VAR report-name          AS CHARACTER INIT "M69" .
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
DEF VAR RB-DISPLAY-ERRORS    AS LOGICAL INIT YES.
DEF VAR RB-DISPLAY-STATUS    AS LOGICAL INIT YES.
DEF VAR RB-NO-WAIT           AS LOGICAL INIT NO.
DEF VAR RB-OTHER-PARAMETERS  AS CHARACTER .
/*===================================*/

DEF VAR nv_multi   AS  LOGI.
/*------------------*/
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

DEF VAR nv_date             AS  CHAR  FORMAT "X(10)".    /*wantanee*/
DEF VAR nv_numdate     AS  INTE  .                       /*wantanee*/
DEF VAR nv_cdat    AS  CHAR  FORMAT "X(20)".             
DEF VAR nv_edat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_adat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_sdat    AS  CHAR  FORMAT "X(20)".
DEF VAR nv_total   AS  DECI  FORMAT ">>,>>>,>>9.99-" EXTENT 6.
DEF VAR nv_disc    AS  DECI  FORMAT ">>,>>>,>>9.99-".
DEF VAR nv_disc2   AS  DECI  FORMAT ">>,>>>,>>9.99".
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
DEF VAR nv_age     AS  CHAR .
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
DEF VAR nv_nam2    AS  CHAR  FORMAT "x(120)".
DEF VAR n_inam1    AS  CHAR  FORMAT "x(120)".
DEF VAR n_inam2    AS  CHAR  FORMAT "x(120)".
DEF VAR nv_reship  AS  CHAR  FORMAT "X(50)".
DEF VAR nv_badd    AS  CHAR  FORMAT "X(80)".
DEF VAR nv_acctim  AS  CHAR  FORMAT "X(5)".
DEF VAR nv_area1   AS  CHAR  FORMAT "X(65)".
DEF VAR nv_endatt  AS  CHAR  FORMAT "X(78)".
DEF VAR nv_ag      AS  CHAR  FORMAT "X".
DEF VAR nv_br      AS  CHAR  FORMAT "X".
DEF VAR nv_acno    AS  CHAR  FORMAT "X(10)".
DEF VAR n_m300     AS  CHAR  FORMAT "X".
DEF VAR n_m400     AS  CHAR  FORMAT "X".
DEF VAR nv_journey AS   CHAR FORMAT "x(70)".
DEF VAR nv_idob    AS   CHAR.
DEF VAR nv_iocc    AS   CHAR. 
DEF VAR nv_bname1  LIKE uwm307.bname1.        
DEF VAR nv_bname2  LIKE uwm307.bname2.  
DEF VAR nv_apsp    AS   CHAR FORMAT "X(1)".      
DEF VAR nv_apyp    AS   CHAR FORMAT "X(1)".  
DEF VAR nv_iname   AS   CHAR FORMAT "X(80)". 
DEF VAR nv_conam   LIKE sym003.conam.   
DEF VAR n_si       LIKE uwm130.uom1_v. 
DEF VAR nv_s100    AS CHAR FORMAT "X(15)".  
DEF VAR nv_prvpol  LIKE uwm100.prvpol.   
/*-------------------*/
DEF VAR nv_Receipt_fil AS RECID.
DEF VAR nv_Count1      AS INT.
DEF VAR nv_lineCins    AS INT.

nv_multi = No.

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
DEF VAR nv_pic11 AS CHAR INIT "".
DEF VAR nv_chk   AS CHAR INIT "".

DEF VAR nv_qrcode  AS CHAR INIT "". /* QRCode Image -- A60-0019 --*/

DEF VAR nv_nam1       AS CHARACTER .
DEF VAR nv_addr1      AS CHARACTER .  /*nv_addr1    = EntTa68.InsuredRefAddr         uwm100.addr1      =    IntPol68.Addr          */
DEF VAR nv_prov       AS CHARACTER .  /*nv_prov     = EntTa68.InsuredRefProvinc      uwm100.addr4      =    IntPol68.Province      */
DEF VAR nv_postcode   AS CHARACTER .  /*nv_postcode = EntTA68.InsuredRefPostalCode   uwm100.postcd     =    IntPol68.PostalCode    */

/*-- Tantawan Ch. - For TA69-Worldwide --*/
DEF VAR nv_plan    AS CHAR .
DEF VAR nv_plantxt AS CHAR .
DEF VAR nv_ww1        AS CHAR.
DEF VAR nv_ww2        AS CHAR.
DEF VAR nv_ww3        AS CHAR.
DEF VAR nv_ww4        AS CHAR.
DEF VAR nv_ww5        AS CHAR.
DEF VAR nv_ww6        AS CHAR.
DEF VAR nv_ww7        AS CHAR.
DEF VAR nv_ww8        AS CHAR.
DEF VAR nv_ww9        AS CHAR.
DEF VAR nv_ww10       AS CHAR.
DEF VAR nv_ww11       AS CHAR.
DEF VAR nv_ww12       AS CHAR.
DEF VAR nv_ww13       AS CHAR.
DEF VAR nv_ww14       AS CHAR.
DEF VAR nv_Eww14      AS CHAR.
DEF VAR nv_ww15       AS CHAR.
DEF VAR nv_Eww15       AS CHAR.
DEF VAR nv_ww16       AS CHAR.
DEF VAR nv_ww17       AS CHAR.

DEF VAR nv_airTtxt1    AS CHAR.
DEF VAR nv_airEtxt1    AS CHAR.
DEF VAR nv_airTtxt2    AS CHAR.
DEF VAR nv_airEtxt2    AS CHAR.
DEF VAR nv_covertxt    AS CHAR.
DEF VAR nv_ncovertxt   AS CHAR.

DEF VAR  nv_ww4T AS CHAR FORMAT "X(50)".
DEF VAR  nv_ww4E AS CHAR FORMAT "X(50)".

DEF VAR nv_iicno  AS CHAR INIT "".    
DEF VAR nv_fptr AS RECID.  
DEF VAR nv_icno2  AS CHAR INIT "".

n_err = "".
IF n_err = "" THEN DO:

    FIND FIRST uwm100 WHERE
               uwm100.policy = nv_policy AND
               uwm100.rencnt = nv_RenCnt AND
               uwm100.endcnt = nv_EedCnt NO-ERROR.
    IF AVAIL uwm100 THEN DO:

            nv_policy = uwm100.policy.

       IF uwm100.expdat >= uwm100.comdat THEN DO:  /* TA เดินทาง เช้าไป - เย็นกลับ ได้*/

            OUTPUT TO "WctxPrn69WS.Txt" APPEND.
            PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
            PUT "WCTXPrn69WS 3 : " nv_policy  FORMAT "X(20)" "Sch/Dr_p         : " STRING( uwm100.sch_p) FORMAT "X(5)" STRING( uwm100.drn_p) SKIP.
            OUTPUT CLOSE.
         
         IF uwm100.sch_p = NO AND 
            uwm100.drn_p = NO THEN DO:
         
            ASSIGN
              nv_addr1   =  ""                            
              nv_date    =  ""     nv_cdat    =  ""      nv_edat    =  ""     nv_adat    =  ""      nv_sdat    =  ""
              nv_total   =  0      nv_ad1     =  ""      nv_dsc2    =  ""     nv_disc    = 0
              nv_disc2   =  0      nv_tax     =  0       nv_taxs    =  ""
              nv_subtot  =  0      nv_subtots =  ""      nv_stamp   =  0
              nv_stamp1  =  ""     nv_grand   =  0       nv_grands  =  ""
              nv_age     =  ""     nv_aged    =  ""      nv_a       =  0
              nv_b       =  0      nv_c       =  0       nv_cday    =  0
              nv_cmonth  =  0      nv_iday    =  0       nv_imonth  =  0
              nv_occup   =  ""     nv_cnt     =  0       nv_bnam1   =  ""
              nv_bnam2   =  ""     nv_prtpol  =  ""      nv_agtnam  =  ""
              nv_agtreg  =  ""     nv_agttyp  =  ""      nv_nam1    =  ""
              nv_nam2    =  ""     nv_reship  =  ""      nv_badd    =  ""
              nv_acctim  =  ""     nv_area1   =  ""      
              nv_endatt  =  ""     nv_ag      =  ""      nv_br      =  ""
              nv_acno    =  ""     n_m300     =  ""      n_m400     = ""
              n_inam1    =  ""     n_inam2    =  ""  
              /*---wa468101---*/
              nv_idob    = ""      nv_iocc    = ""       nv_apsp    = ""               
              nv_apyp    = ""      nv_conam   = ""       nv_icno    = ""        
              nv_plan    = ""      nv_plantxt  = ""      nv_icno2   = ""
              nv_ww1     = ""      nv_ww2      = ""  nv_ww3      = ""  nv_ww4      = "" 
              nv_ww5     = ""      nv_ww6      = ""  nv_ww7      = ""  nv_ww8      = "" 
              nv_ww9     = ""      nv_ww10     = ""  nv_ww11     = ""  nv_ww12     = "" 
              nv_ww13    = ""      nv_ww14     = ""  nv_ww15     = ""  nv_ww16     = "" 
                                   nv_Eww14    = ""  nv_Eww15    = ""  nv_ww4T     = ""   nv_ww4E      = ""
              nv_ww17    = ""      nv_airTtxt1 = ""  nv_airTtxt2 = ""  nv_airEtxt1  = ""  nv_airEtxt2  = "" 
              nv_iicno    = "" .

            FIND FIRST uwm307 USE-INDEX uwm30701 WHERE
                                uwm307.policy = uwm100.policy  AND
                                uwm307.rencnt = uwm100.rencnt  AND
                                uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
            IF AVAIL uwm307 THEN DO :
                /*- Tantawan Ch. --22/02/2017 -*/
                IF uwm307.mbsi[6] <> 0 THEN DO:   /*WW1 = Medical Expenses*/
                   ASSIGN nv_ww1    = TRIM(STRING(uwm307.mbsi[6],">,>>>,>>>,>>9")).
                END.

                IF uwm307.mbsi[1] <> 0 THEN DO:
                   ASSIGN nv_ww2    = TRIM(STRING(uwm307.mbsi[1],">,>>>,>>>,>>9")).
                END.
                /*- Tantawan Ch. --22/02/2017 -*/

                ASSIGN
                     nv_occup  = substring(uwm100.occupn,1,5)     /*wantanee -->Time Last*/
                     nv_disc   = nv_disc + uwm307.abpd[4]
                     nv_bnam1  = uwm307.bname1
                     nv_bnam2  = uwm307.bname2

                     nv_reship = uwm307.reship
                     nv_badd   = uwm307.badd1  + " " + uwm307.badd2
                     n_inam1   = uwm307.ifirst + " " + uwm307.iname
                     n_inam2   = "".
                     
                IF uwm307.icno <> "" THEN nv_iicno = "(ID No. " + uwm307.icno + ")".
                IF nv_iicno <> "" THEN n_inam1 = n_inam1 + nv_iicno.

                IF uwm307.idob  <> ? THEN DO :
                   nv_a      = YEAR(uwm100.comdat).
                   nv_b      = YEAR(uwm307.idob).
                   nv_cday   = DAY(uwm100.comdat).
                   nv_cmonth = MONTH(uwm100.comdat).
                   nv_iday   = DAY(uwm307.idob).
                   nv_imonth = MONTH(uwm307.idob).

                        IF nv_cmonth > nv_imonth THEN nv_c = 0.
                   ELSE IF nv_cmonth = nv_imonth THEN DO :

                        IF nv_cday  >= nv_iday THEN nv_c = 0.
                                               ELSE nv_c = 1.
                   END.
                   ELSE nv_c = 1.
                
                   nv_age = STRING(nv_a - nv_b + nv_c).
                
                END.
                ELSE IF uwm307.iyob <> 0 THEN DO :
                   nv_a   = YEAR(uwm100.comdat).
                   nv_age = STRING(nv_a - uwm307.iyob).
                END.
                ELSE nv_age = "".

                FIND NEXT uwm307 USE-INDEX uwm30701 WHERE
                          uwm307.policy = uwm100.policy    AND
                          uwm307.rencnt = uwm100.rencnt    AND
                          uwm307.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
                IF AVAIL uwm307 THEN nv_multi = YES. /* TA Group */
            END.
        
            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                       uwm120.policy = uwm100.policy    AND
                       uwm120.rencnt = uwm100.rencnt    AND
                       uwm120.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
            IF AVAIL uwm120 THEN DO:
                /*
                IF uwm120.class = "P200" OR
                   uwm120.class = "P300"      THEN n_m400 = "X" .
                ELSE IF uwm120.class = "P100" THEN n_m300 = "X" .
                */
                nv_class = uwm120.CLASS.
                nv_fptr = 0.
                nv_fptr =   uwm120.fptr01.
            END.
            nv_prtpol = uwm100.policy.

            IF uwm100.ntitle <> "" AND uwm100.fname <> "" THEN 
               nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.fname)  + " " +
                         TRIM(uwm100.name1).

            ELSE IF uwm100.fname <> "" THEN 
               nv_nam1 = TRIM(uwm100.fname)  +  " " + TRIM(uwm100.name1).

            ELSE IF uwm100.ntitle <> "" THEN 
               nv_nam1 = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1). 

            ELSE nv_nam1 = TRIM(uwm100.name1).
                 nv_nam2 = uwm100.name2.
            
            nv_addr1  = TRIM(uwm100.addr1) + " " + TRIM(uwm100.addr2) + " " +
                        TRIM(uwm100.addr3) + " " + TRIM(uwm100.addr4) +
                        " " + uwm100.postcd.

            IF uwm100.opnpol <> "" THEN DO: 
                ASSIGN nv_plan = uwm100.opnpol.
            
                FIND FIRST sym100 USE-INDEX sym10001 WHERE 
                           sym100.tabcod = "U013" AND
                           sym100.itmcod = uwm100.opnpol  NO-LOCK NO-ERROR.
                IF AVAIL sym100 THEN DO:
            
                      ASSIGN nv_plantxt = "แผน " + sym100.itmdes /*+ "* /."*/ .
                  END.
            END.
            ELSE ASSIGN nv_plan    = "" 
                        nv_plantxt = "".

            /********************** not nv_multi **********************/
            
            IF NOT nv_multi THEN DO :  /* Individual */ 

               IF uwm100.langug = "" THEN DO :
                 IF nv_age <> "" THEN nv_aged = STRING(nv_age) + " Years".
               END.
               ELSE DO:
                 IF nv_age <> "" THEN nv_aged = STRING(nv_age) + " ปี".
               END.
            END.  /*<>nv_multi*/ 

            IF nv_multi THEN DO: /*-- Tantawan @2016-04-20 --*/

                IF uwm100.langug = "" THEN DO :   /*Eng*/
                  FIND xmd179 USE-INDEX xmd17901 WHERE
                        xmd179.docno  = "008" AND
                        xmd179.poltyp = ""    AND
                        xmd179.headno = "007" NO-LOCK NO-ERROR.  /* 057 - AS ATTACHED */ 
                  IF AVAIL xmd179 THEN               
                    ASSIGN
                     nv_aged    = xmd179.head
                     nv_journey = xmd179.head
                     nv_area1   = xmd179.head
                     nv_bnam1   = xmd179.head 
                     n_inam1    = xmd179.head .
                     
                END.
                ELSE DO :    /*Thai*/
                   FIND xmd179 USE-INDEX xmd17901 WHERE
                         xmd179.docno  = "008" AND    
                         xmd179.poltyp = ""    AND
                         xmd179.headno = "058" NO-LOCK NO-ERROR.  /*ตามรายการแนบ*/
                   IF AVAIL xmd179 THEN
                     ASSIGN
                       nv_aged    =  xmd179.head
                       nv_journey =  xmd179.head
                       nv_area1   =  xmd179.head
                       nv_bnam1   =  xmd179.head                
                       n_inam1    =  xmd179.head .
                END.
            END.

            ASSIGN nv_airEtxt1  = "One-way Economy Airfare"
                   nv_airEtxt2  = "Two-way Economy Airfare"
                   nv_airTtxt1   = "ตั๋วเครื่องบินกลับชั้นประหยัด"
                   nv_airTtxt2   = "ตั๋วเครื่องบินไป-กลับชั้นประหยัด"

                   nv_covertxt  = "คุ้มครอง (Covered)"
                   nv_ncovertxt  = "ไม่คุ้มครอง (Not Covered)"

                   /* Tantawan -- @ 19/03/2018 --*/
                   nv_ww4T   = "รวมอยู่ใน ข้อตกลงคุ้มครอง ข้อ 3"
                   nv_ww4E   = "Included in Insuring Agreement No.3"
                .

            
            FIND FIRST uwm307 USE-INDEX uwm30701 WHERE
                       uwm307.policy = uwm100.policy  AND
                       uwm307.rencnt = uwm100.rencnt  AND
                       uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
            REPEAT:
               IF AVAIL uwm307 THEN DO :

                  nv_disc = nv_disc + uwm307.abpd[4].
                  IF uwm307.bname1 <> "" THEN nv_cnt = nv_cnt + 1.
                  FIND NEXT uwm307 USE-INDEX uwm30701 WHERE
                            uwm307.policy = uwm100.policy  AND
                            uwm307.rencnt = uwm100.rencnt  AND
                            uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
               END.   /*uwm307*/
               ELSE LEAVE.
            END.   /*repeat*/

            /*AS PER LIST ATTACHED*/

            /**/
            FIND FIRST uwd120  WHERE RECID(uwd120)   =   nv_fptr NO-LOCK.
            IF AVAIL uwd120 THEN nv_journey = uwd120.ltext.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW3"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                   ASSIGN nv_ww3 = IF xmm106.min_si <> 0 THEN "สูงสุด Max USD " + TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE "ไม่คุ้มครอง (Not Covered)".
            END.
            ELSE nv_ww3 = "ไม่คุ้มครอง (Not Covered)".

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW4"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                   ASSIGN nv_ww4 = IF xmm106.min_si <> 0 THEN "สูงสุด Max USD " + TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww4 = nv_ncovertxt.
            
            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW5"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww5 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww5 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW6"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww6 = IF xmm106.min_si <> 0 THEN TRIM(TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9"))) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww6 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW7"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww7 = IF xmm106.min_si <> 0 THEN TRIM(TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9"))) + "/" + TRIM(STRING(xmm106.basesi,">>>")) 
                                      + " ชม. Hrs. สูงสุด Max " + TRIM(STRING(xmm106.max_si,">,>>>,>>>,>>9"))  ELSE nv_ncovertxt.
            END.
            ELSE nv_ww7 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW8"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                   ASSIGN nv_ww8 = IF xmm106.min_si <> 0 THEN TRIM(TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9"))) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww8 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff = "1"      AND
                     xmm106.bencod  = "WW9"    AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww9 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.                  
            END.
            ELSE nv_ww9 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW10"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww10 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww10 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW11"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww11 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww11 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW12"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww12 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww12 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW13"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww13 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww13 = nv_ncovertxt.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW14"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww14  = IF TRIM(xmm106.comp_cod) = "1"  THEN nv_airTtxt1  ELSE nv_airTtxt2 .
                       nv_Eww14 = IF TRIM(xmm106.comp_cod) = "1"  THEN nv_airEtxt1  ELSE nv_airEtxt2 .
            END.
            ELSE ASSIGN nv_ww14  = nv_airTtxt2
                        nv_Eww14 = nv_airEtxt2.
            
            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW15"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww15  = IF TRIM(xmm106.comp_cod) = "1" THEN nv_airTtxt1  ELSE nv_airTtxt2.
                       nv_Eww15 = IF TRIM(xmm106.comp_cod) = "1" THEN nv_airEtxt1  ELSE nv_airEtxt2.
            END.
            ELSE ASSIGN nv_ww15  = nv_airTtxt2
                        nv_Eww15 = nv_airEtxt2.

            FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW16"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww16 = IF xmm106.appinc = 1 THEN nv_covertxt ELSE nv_ncovertxt.
            END.
            ELSE nv_ww16 = nv_ncovertxt.

           FIND LAST xmm106 USE-INDEX xmm10601
               WHERE xmm106.tariff  = "1"      AND
                     xmm106.bencod  = "WW17"   AND
                     xmm106.CLASS   = nv_class AND
                     xmm106.covcod  = nv_plan  AND 
                     xmm106.effdat <= uwm100.comdat NO-LOCK NO-ERROR .
            IF AVAIL xmm106 THEN DO:
                ASSIGN nv_ww17 = IF xmm106.min_si <> 0 THEN TRIM(STRING(xmm106.MIN_si,">,>>>,>>>,>>9")) ELSE nv_ncovertxt.
            END.
            ELSE nv_ww17 = nv_ncovertxt.

            /*END.  /*nv_multi*/*/
            /*****************************************************************/
            /*****************************************************************/

            IF nv_occup = " " THEN
               nv_occup = "12:00".
               
               IF (SUBSTRING(nv_occup,1,1) <> "0" AND
                  SUBSTRING(nv_occup,1,1) <> "1" AND
                  SUBSTRING(nv_occup,1,1) <> "2" AND
                  SUBSTRING(nv_occup,1,1) <> "3" AND
                  SUBSTRING(nv_occup,1,1) <> "4" AND
                  SUBSTRING(nv_occup,1,1) <> "5" AND
                  SUBSTRING(nv_occup,1,1) <> "6" AND
                  SUBSTRING(nv_occup,1,1) <> "7" AND
                  SUBSTRING(nv_occup,1,1) <> "8" AND
                  SUBSTRING(nv_occup,1,1) <> "9")  THEN
                   nv_occup = "12:00".
            /***********************************************/
            IF uwm100.langug = "" THEN DO :
              nv_cdat=   STRING(DAY(uwm100.comdat),"99")    + "/" +
                         STRING(MONTH(uwm100.comdat),"99")  + "/" +
                         STRING(YEAR(uwm100.comdat),"9999").
        
               nv_edat = STRING(DAY(uwm100.expdat),"99")    + "/" +
                         STRING(MONTH(uwm100.expdat),"99") + "/" +
                         STRING(YEAR(uwm100.expdat),"9999").
            END.
            ELSE DO :
               nv_cdat = STRING(DAY(uwm100.comdat),"99")    + "/" +
                         STRING(MONTH(uwm100.comdat),"99")  + "/" +
                         STRING(YEAR(uwm100.comdat) + 543,"9999").
        
               nv_edat = STRING(DAY(uwm100.expdat),"99")    + "/" +
                         STRING(MONTH(uwm100.expdat),"99") + "/" +
                         STRING(YEAR(uwm100.expdat) + 543,"9999").
            END.
        
            /*------------------*/
            FOR EACH uwm130 USE-INDEX uwm13001     WHERE
                          uwm130.policy = uwm100.policy  AND
                          uwm130.rencnt = uwm100.rencnt  AND
                          uwm130.endcnt = uwm100.endcnt NO-LOCK.
                     n_si = n_si + uwm130.uom1_v.
            END. /*uwm130*/
        
            nv_s100    = TRIM(STRING(n_si,"->,>>>,>>>,>>9.99")).

            nv_numdate = uwm100.expdat - uwm100.comdat.             /*wantanee*/
            IF nv_numdate <> 365 AND nv_numdate <> 366 THEN 
                 nv_numdate = nv_numdate + 1.
            
            /*nv_date =  string((uwm100.expdat - uwm100.comdat)   + 1).*/     
            nv_date   = String(nv_numdate).  
            nv_acctim = uwm100.acctim.
            
            IF nv_class = "APYP"  OR nv_class = "APSP" THEN DO:
                ASSIGN
                    nv_acctim = SUBSTR(uwm100.acctim,1,2) + ":" + SUBSTR(uwm100.acctim,4,2).
                IF nv_acctim = "00:00" THEN nv_acctim = "".
                ELSE nv_acctim = nv_acctim.   
            
                IF uwm100.prvpol <> "" THEN nv_prvpol = uwm100.prvpol.             
                ELSE nv_prvpol = "".      

                IF uwm100.poltyp = "M68" THEN report-name = "M68_3A".
                                         ELSE report-name = "M69".

                FIND FIRST uwm307 USE-INDEX uwm30701 WHERE
                                  uwm307.policy = uwm100.policy  AND
                                  uwm307.rencnt = uwm100.rencnt  AND
                                  uwm307.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
                IF AVAIL uwm307 THEN DO:
                    ASSIGN   
                      nv_iocc   = uwm307.iocc
                      nv_bname1 = uwm307.bname1
                      nv_bname2 = uwm307.bname2
                      nv_reship = TRIM(STRING(uwm307.reship))
                      nv_iname  = TRIM(uwm307.ifirst) + " " + TRIM(uwm307.iname).
                      
                    IF uwm307.iyob <> 0 THEN nv_age = STRING((YEAR(uwm100.comdat) - uwm307.iyob)).
                    ELSE nv_age = "ตามรายการแนบ".
                
                    IF uwm307.idob <> ? THEN DO: 
                       nv_idob = STRING(DAY(uwm307.idob),"99") + "/" +
                                 STRING(MONTH(uwm307.idob),"99") + "/" +
                                 STRING(YEAR(uwm307.idob),"9999").
                    END.
                    ELSE nv_idob = "".
                    /*-----------------------------------*/
                END.

                IF nv_class = "APSP" THEN nv_apsp  = "X".     
                IF nv_class = "APYP" THEN nv_apyp  = "X".     

                FIND sym003 USE-INDEX sym00301 WHERE sym003.co = "00".
                IF AVAIL sym003 THEN nv_conam = sym003.conam. ELSE nv_conam = "".       

            END.
            ELSE DO:
                IF nv_class = "P100" OR 
                   nv_class = "P200" OR 
                   nv_class = "P300"      THEN report-name = "M68_1A" .
                ELSE IF nv_class = "P500" THEN report-name = "M68_2A" .
            END.

            IF nv_disc = 0 THEN DO:
               nv_dsc2 = "-".
               nv_disc2 = 0.
            END.
            ELSE DO:
               nv_disc2 =  - nv_disc.
               nv_dsc2 = STRING(nv_disc2, ">>,>>>,>>9.99").
            END.

            nv_subtot = uwm100.prem_t.
            nv_subtots = string(nv_subtot,">>>,>>>,>>9.99-").

            IF nv_class = "APYP" OR nv_class = "APSP" THEN nv_tax = uwm100.pfee + uwm100.ptax + uwm100.rfee_t + uwm100.rtax_t.  /*---wa468101---*/
            ELSE  nv_tax = uwm120.rtax_r.

            nv_taxs = string(nv_tax,">>>,>>>,>>9.99").
            nv_stamp  = uwm100.pstp + uwm100.rstp_t.
            /*-----*/

            IF uwm100.pstp = 0 THEN DO:
              nv_stamp1 = string(nv_stamp,">>>,>>>,>>9.99-").
            END.
            ELSE DO:
              nv_stamp1 = "Dup" + string(uwm100.pstp,">>9") + " + " +
                             trim(string(uwm100.rstp_t,">,>>9")).                
            END.
            nv_grand = nv_subtot + nv_tax + nv_stamp.
            nv_grands = string(nv_grand,">>>,>>>,>>9.99").
        
            nv_endatt = uwm307.endatt.
        
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = uwm100.insref NO-LOCK  NO-ERROR.
            IF AVAIL xmm600 THEN ASSIGN nv_icno = " (ID No. " + xmm600.icno + ")"
                                        nv_icno = xmm600.icno.

            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = uwm100.agent NO-LOCK  NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN nv_agtreg = xmm600.agtreg
                      nv_agttyp = xmm600.acccod
                      nv_agtnam = xmm600.ntitle + " " + xmm600.NAME.
        
            IF uwm100.langug <> " " THEN DO:   /*thai*/
               FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                          xtm600.acno = uwm100.agent NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL xtm600  THEN nv_agtnam = xtm600.ntitle + " " + xtm600.name.
            END.
        
            IF nv_agttyp  = "AG" THEN nv_ag = "X".
                                 ELSE nv_br = "X".

            nv_acno = "(" + uwm100.acno1 + ")".
            nv_nam1 = nv_nam1 +  nv_icno.
        
            /*---web service----*/
            IF uwm100.acno1 = "B300301" OR
               uwm100.acno1 = "B300302" OR
               uwm100.acno1 = "B300303" OR   
               uwm100.acno1 = "B300304" THEN DO:
              ASSIGN
                  nv_agtnam = nv_acno
                  nv_acno  = "".
            END.
            /*---web service----*/
        
            IF uwm100.langug = "" THEN DO :
               /*---- เปลี่ยนเป็น ชื่อเดือน  มกราคม ---*/
               nv_adat =  STRING(DAY(uwm100.accdat),"99") + "/" +
                          STRING(MONTH(uwm100.accdat),"99") + "/" +
                          STRING(YEAR(uwm100.accdat),"9999").
        
               nv_sdat =  STRING(DAY(uwm100.trndat),"99") + "/" +
                          STRING(MONTH(uwm100.trndat),"99")  + "/" +
                          STRING(YEAR(uwm100.trndat),"9999").
            END.
            ELSE DO :
                nv_adat = STRING(DAY(uwm100.accdat),"99") + "/" +
                         STRING(MONTH(uwm100.accdat),"99") + "/" +
                         STRING(YEAR(uwm100.accdat) + 543,"9999").
        
               nv_sdat = STRING(DAY(uwm100.trndat),"99") + "/" +
                         STRING(MONTH(uwm100.trndat),"99") + "/" +
                         STRING(YEAR(uwm100.trndat) + 543,"9999").
            END.    
            /*---A51-0228--*/   
            IF report-name  = "M69"  THEN DO:

                nv_chk = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99") + "|" + 
                         STRING(MTIME,"9999999999") + "|" + nv_class + "|" + uwm100.policy + "|"  + USERID(LDBNAME(1)).

                /* Clear Old Data*/
                FOR EACH formtmp.ren_fil USE-INDEX ren_fil06
                    WHERE ren_fil.policy = uwm100.policy
                    AND   ren_fil.rencnt = uwm100.rencnt
                    AND   ren_fil.endcnt = uwm100.endcnt
                    AND   ren_fil.compno = nv_chk.

                    DELETE ren_fil.
                    RELEASE ren_fil.
                END. 

                FIND FIRST ren_fil USE-INDEX ren_fil06
                    WHERE ren_fil.policy = uwm100.policy
                    AND   ren_fil.rencnt = uwm100.rencnt
                    AND   ren_fil.endcnt = uwm100.endcnt
                    AND   ren_fil.LINE   = 0 
                    AND   ren_fil.compno = nv_chk NO-LOCK NO-ERROR.
                IF NOT AVAIL ren_fil THEN DO:
                    CREATE ren_fil.
                    ASSIGN
                        ren_fil.compno = nv_chk
                        ren_fil.policy = uwm100.policy
                        ren_fil.rencnt = uwm100.rencnt
                        ren_fil.endcnt = uwm100.endcnt
                        ren_fil.LINE   = 0      .      
                    
                    RELEASE ren_fil.
                END.

                FIND FIRST ren_fil USE-INDEX ren_fil06
                    WHERE ren_fil.policy = uwm100.policy
                    AND   ren_fil.rencnt = uwm100.rencnt
                    AND   ren_fil.endcnt = uwm100.endcnt
                    AND   ren_fil.LINE   = 1 
                    AND   ren_fil.compno = nv_chk NO-LOCK NO-ERROR.
                IF NOT AVAIL ren_fil THEN DO:
                    CREATE ren_fil.
                    ASSIGN
                        ren_fil.compno = nv_chk       
                        ren_fil.policy = uwm100.policy
                        ren_fil.rencnt = uwm100.rencnt
                        ren_fil.endcnt = uwm100.endcnt
                        ren_fil.LINE   = 1      . 
                    RELEASE ren_fil.
                END.

                RUN WCTX\wctxPJourney.p (INPUT RECID(uwm100),
                                         INPUT nv_cnt ,
                                         INPUT nv_chk).   
            END.

            FIND FIRST dbtable WHERE /*dbtable.phyname = "stat" OR*/ dbtable.phyname = "form" NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL dbtable THEN
               ASSIGN
                  n_User   = " "
                  n_passwd = " ".
            
            RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + n_user + " -P " + n_passwd.
            /*
            RB-DB-CONNECTION  = "-db formtmp -N tcp -H 16.90.20.201 -S 9081" +  " -U " + "" + " -P " + "". 
            */
            
            RB-OTHER-PARAMETERS =
                     /*"rb_m300         ="  + n_m300      +
                     "~nrb_m400       ="  + n_m400      +*/
                       "rb_prtpol     ="  + nv_prtpol   +
                     "~nrb_nam1       ="  + nv_nam1     +
                     "~nrb_inam1      ="  + n_inam1     +
                     "~nrb_inam2      ="  + n_inam2     +
                     "~nrb_addr1      ="  + nv_addr1    +
                     "~nrb_occup      ="  + nv_occup    +
                     "~nrb_bnam1      ="  + nv_bnam1    +
                     "~nrb_badd       ="  + nv_badd     +
                     "~nrb_date       ="  + nv_date     +   
                     "~nrb_cdat       ="  + nv_cdat     +
                     "~nrb_acctim     ="  + nv_acctim   +
                     "~nrb_edat       ="  + nv_edat     +
                     "~nrb_ad1        ="  + nv_ad1      +
                     "~nrb_dsc2       ="  + nv_dsc2     +
                     "~nrb_subtots    ="  + nv_subtots  +
                     "~nrb_taxs       ="  + nv_taxs     +
                     "~nrb_stamp1     ="  + nv_stamp1   +
                     "~nrb_grands     ="  + nv_grands   +
                     "~nrb_ag         ="  + nv_ag       +
                     "~nrb_br         ="  + nv_br       +
                     "~nrb_agtnam     ="  + nv_agtnam   +
                     "~nrb_agtreg     ="  + nv_agtreg   +
                     "~nrb_acno       ="  + nv_acno     + 
                     "~nrb_adat       ="  + nv_adat     +
                     "~nrb_journey    ="  + nv_journey  +  
                     "~nrb_sdat       ="  + nv_sdat     +    
                    /*---wa468101---*/                                      
                     "~nrb_conam      ="  + nv_conam    +   
                     "~nrb_prvpol     ="  + nv_prvpol   +              
                     "~nrb_iocc       ="  + nv_iocc     +   
                     "~nrb_apsp       ="  + nv_apsp     +   
                     "~nrb_apyp       ="  + nv_apyp     +   
                     "~nrb_sumins     ="  + nv_s100     +     
                     "~nrb_iname      ="  + n_inam1     +  
                     "~nrb_nv_chk     ="  + nv_chk      +
                    /*----web service---*/  
                     "~nrb_pic1       ="  + nv_pic1     +
                     "~nrb_pic2       ="  + nv_pic2     +
                     "~nrb_pic3       ="  + nv_pic3     +
                     "~nrb_pic4       ="  + nv_pic4     +
                     "~nrb_pic5       ="  + nv_pic5     +
                     "~nrb_pic6       ="  + nv_pic6     +
                     "~nrb_pic7       ="  + nv_pic7     +
                     "~nrb_pic8       ="  + nv_pic8     +
                     "~nrb_pic9       ="  + nv_pic9     +
                     "~nrb_pic10      ="  + nv_pic10    +
                     "~nrb_pic11      ="  + nv_pic11    +
                     "~nrb_code       ="  + nv_code     +       
                     "~nrb_docno      ="  + nv_docno    + 
                     "~nrb_docno2     ="  + "M" + nv_docno  +
                     "~nrb_ww1        ="  + nv_ww1     +
                     "~nrb_ww2        ="  + nv_ww2     +
                     "~nrb_ww3        ="  + nv_ww3     +
                     "~nrb_ww4T       ="  + nv_ww4T    +
                     "~nrb_ww4E       ="  + nv_ww4E    +
                     "~nrb_ww5        ="  + nv_ww5     +
                     "~nrb_ww6        ="  + nv_ww6     +
                     "~nrb_ww7        ="  + nv_ww7     +
                     "~nrb_ww8        ="  + nv_ww8     +
                     "~nrb_ww9        ="  + nv_ww9     +
                     "~nrb_ww10       ="  + nv_ww10    +
                     "~nrb_ww11       ="  + nv_ww11    +
                     "~nrb_ww12       ="  + nv_ww12    +
                     "~nrb_ww13       ="  + nv_ww13    +
                     "~nrb_ww14       ="  + nv_ww14    +
                     "~nrb_Eww14      ="  + nv_Eww14   +
                     "~nrb_ww15       ="  + nv_ww15    +
                     "~nrb_Eww15      ="  + nv_Eww15   +
                     "~nrb_ww16       ="  + nv_ww16    +
                     "~nrb_ww17       ="  + nv_ww17    +
                     "~nrb_plantxt    ="  + nv_plantxt +
                     "~nrb_qrcode     ="  + nv_qrcode   +
                     "~nrb_cnt        ="  + string(nv_cnt) .

            RUN  WCTX\wctxptax.P (INPUT RECID(uwm100),
                                  INPUT-OUTPUT RB-OTHER-PARAMETERS).
            RUN   _printrb(
                           report-library,
                           report-name,
                           RB-DB-CONNECTION,
                           RB-INCLUDE-RECORDS,
                           "",
                           RB-MEMO-FILE,
                           RB-PRINT-DESTINATION  ,
                           RB-PRINTER-NAME,
                           RB-PRINTER-PORT,
                           RB-OUTPUT-FILE,
                           RB-NUMBER-COPIES,
                           RB-BEGIN-PAGE,
                           RB-END-PAGE,
                           RB-TEST-PATTERN,
                           RB-WINDOW-TITLE,
                           RB-DISPLAY-ERRORS,
                           RB-DISPLAY-STATUS,
                           RB-NO-WAIT,
                           RB-OTHER-PARAMETERS).
            /*---*/
            IF uwm100.poltyp = "M69" THEN DO:

                 FOR EACH ren_fil USE-INDEX ren_fil06
                     WHERE ren_fil.policy = uwm100.policy
                     AND   ren_fil.rencnt = uwm100.rencnt
                     AND   ren_fil.endcnt = uwm100.endcnt
                     AND   ren_fil.compno = nv_chk .
             
                      DELETE ren_fil.
            
                 END.
                 RELEASE ren_fil.
            END.
            
            /*--- Tantawan --- @14/09/2016 ---*/
            uwm100.sch_p      =    YES .
            uwm100.drn_p      =    YES .

         
         END.
         /*
         IF uwm100.sch_p = NO AND 
           uwm100.drn_p = NO THEN DO:
         END.
         */
         ELSE DO:
             n_err = "กรุณาระบุเลขที่กรมธรรม์ใหม่ เนื่องจากมีการพิมพ์หน้าตารางกรมธรรม์แล้ว".
         END.
       END.
       /*
       IF uwm100.expdat > uwm100.comdat THEN DO:
       END.
       */
       ELSE DO:
           n_err = "ไม่สามารถพิมพ์ได้ เนื่องจากวันที่หมดอายุน้อยกว่าวันที่คุ้มครอง" .

       END.
    END.
    /*
    IF AVAIL uwm100 THEN DO:
    END.
    */
    ELSE DO:
       n_err = "ไม่พบเลขที่กรมธรรม์นี้ กรุณาตรวจสอบและระบุเลขที่กรมธรรม์ใหม่".

    END. 
END. 
/*
IF n_err = "" THEN DO: 
END.
*/
ELSE DO:
    n_err = "ไม่สามารถปริ้นกรมธรรม์ได้ : " + n_err. 
END.  

OUTPUT TO "WctxPrn69WS.Txt" APPEND.
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3). 
PUT "WCTXPrn69WS END " nv_policy  FORMAT "X(20)" "ERRROR           : " n_err FORMAT "x(100)" SKIP.
PUT FILL("-",80) FORMAT "X(80)" SKIP.
OUTPUT CLOSE.

/***** END WCTXPRN64WS.P******/


