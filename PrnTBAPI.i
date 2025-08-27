
DEFINE TEMP-TABLE tHeader   NO-UNDO
    FIELD   login           AS CHAR
    FIELD   nv_ccomdat      AS CHAR 
    FIELD   nv_cexpdat      AS CHAR 
    FIELD   nv_caccdat      AS CHAR 
    FIELD   nv_acctim       AS CHAR
    FIELD   nv_acctim2      AS CHAR
    FIELD   PolicyNumber    AS CHAR 
    FIELD   PolicyType      AS CHAR 
    FIELD   PolicyClass     AS CHAR
    FIELD   nv_prodesc      AS CHAR
    FIELD   nv_product      AS CHAR 
    FIELD   Suminsured      AS CHAR
    FIELD   SumPostGrossPm  AS CHAR
    FIELD   SumPostSDuty    AS CHAR
    FIELD   SumPostVAT      AS CHAR
    FIELD   SumPostPmDue    AS CHAR  .

/* ClientDetails */
DEFINE TEMP-TABLE ClientDetails NO-UNDO
    FIELD login         AS CHAR
    FIELD CntOwNm       AS CHAR
    FIELD CntOwNm2      AS CHAR
    FIELD CntOwNm3      AS CHAR
    FIELD CltAddr1      AS CHAR
    FIELD CltAddr2      AS CHAR
    FIELD CltAddr3      AS CHAR
    FIELD CltAddr4      AS CHAR
    FIELD CntOwNo       AS CHAR
    FIELD nv_R003_3     AS CHAR
    FIELD nv_R003_4     AS CHAR
    FIELD nv_R003_5     AS CHAR
    FIELD nv_icno       AS CHAR
    FIELD nv_tel        AS CHAR.
/* AgentDetails */
DEFINE TEMP-TABLE AgentDetails NO-UNDO
    FIELD login             AS CHAR
    FIELD Agntnum           AS CHAR
    FIELD AgntName          AS CHAR
    FIELD AgentLicenseNo    AS CHAR
    FIELD sp_agttyp         AS CHAR     . 
    
/* HeadCover */   
DEFINE TEMP-TABLE HeadCover   NO-UNDO
    FIELD login AS CHARACTER 
    FIELD Cover_Line  AS CHARACTER  
    FIELD Cover_Des   AS CHARACTER  
    FIELD COver_SI    AS CHARACTER.
/* Risk_Detail */  
DEFINE TEMP-TABLE RiskDetail NO-UNDO
    FIELD  login         AS CHARACTER
    FIELD  nv_iname      AS CHARACTER
    FIELD  nv_occup      AS CHARACTER
    FIELD  nv_iocctd     AS CHARACTER
    FIELD  nv_dob        AS CHARACTER
    FIELD  nv_cage       AS CHARACTER
    FIELD  nv_yrtyp      AS CHARACTER
    FIELD  nv_jrny       AS CHARACTER
    FIELD  Membercode    AS CHARACTER
    FIELD  Planname      AS CHARACTER
    FIELD  nv_cdisc      AS CHARACTER
    FIELD  nv_load       AS CHARACTER
    FIELD  nv_ad1        AS CHARACTER
    FIELD  nv_endatt     AS CHARACTER .
/* Risk_Cover */
DEFINE TEMP-TABLE RiskCover NO-UNDO
    FIELD login         AS CHARACTER 
    FIELD Cover_Code    AS CHARACTER
    FIELD Cover_Line    AS CHARACTER
    FIELD Cover_Des     AS CHARACTER
    FIELD Cover_Dec     AS CHARACTER
    FIELD Cover_wek     AS CHARACTER
    FIELD Cover_SI      AS CHARACTER
    FIELD Cover_ded     AS CHARACTER
    FIELD Cover_Prem    AS CHARACTER. 
    
/* PCLAUSE */
DEFINE TEMP-TABLE PCLAUSE NO-UNDO
    FIELD login AS CHARACTER 
    FIELD Policynumber  AS CHARACTER
    FIELD ClauseSeqNo AS CHARACTER
    FIELD ClauseDocType AS CHARACTER
    FIELD ClauseType AS CHARACTER
    FIELD ClauseCode AS CHARACTER
    FIELD ClauseHeading AS CHARACTER
    FIELD ClauseText1 AS CHARACTER
    FIELD ClauseText2 AS CHARACTER.

/* Benefit Detail */     
DEFINE TEMP-TABLE PBenefit    NO-UNDO  
    FIELD login         AS CHARACTER
    FIELD BPolicy       AS CHARACTER
    FIELD Bno           AS CHARACTER
    FIELD Bname         AS CHARACTER 
    FIELD BICno         AS CHARACTER
    FIELD Baddr         AS CHARACTER
    FIELD Boccup        AS CHARACTER
    FIELD Breship       AS CHARACTER
    FIELD Bpercent      AS CHARACTER
    FIELD BDob          AS CHARACTER
    FIELD Bage          AS CHARACTER . 
/*  VAT-Recipt Detail */    
DEFINE TEMP-TABLE VATDlts   NO-UNDO 
    FIELD login             AS CHARACTER
    FIELD VSequence         AS INT
    FIELD VatInvtyp         AS CHARACTER
    FIELD nv_docno1         AS CHARACTER
    FIELD nv_vtprtdat       AS CHARACTER
    FIELD nv_cgstrat        AS CHARACTER
    FIELD VATctpstrat       AS CHARACTER
    FIELD PrintBr           AS CHARACTER
    FIELD Payor_CntOwNm     AS CHARACTER
    FIELD Payor_CltAddr1    AS CHARACTER
    FIELD Payor_CltAddr2    AS CHARACTER
    FIELD Payor_occupn      AS CHARACTER
    FIELD Payor_dtaxno      AS CHARACTER
    FIELD Payor_Branch      AS CHARACTER .
/* Upper Text */   
DEFINE TEMP-TABLE UpperText   NO-UNDO
    FIELD login AS CHARACTER
    FIELD nline AS CHARACTER  
    FIELD TXT   AS CHARACTER  .
/*  PrintDoc  */   
DEFINE TEMP-TABLE PrintDoc    NO-UNDO
    FIELD login        AS CHARACTER
    FIELD prtSCH       AS LOG INIT FALSE 
    FIELD prtCER       AS LOG INIT FALSE 
    FIELD prtRCP       AS LOG INIT FALSE 
    FIELD prtATT       AS LOG INIT FALSE 
    FIELD prtEXT       AS LOG INIT FALSE 
    FIELD prtJKT       AS LOG INIT FALSE 
    FIELD prtCRD       AS LOG INIT FALSE 
    FIELD prtLST       AS LOG INIT FALSE 
    FIELD prtOriginal  AS LOG INIT FALSE 
    FIELD prtCopy      AS LOG INIT FALSE .
    /*   
/* PWSCHED */
DEFINE TEMP-TABLE PWSCHED NO-UNDO
    FIELD login          AS CHARACTER
    FIELD PolicyNumber   AS CHARACTER 
    FIELD PolicyType     AS CHARACTER 
    FIELD PolicyClass    AS CHARACTER
    FIELD CntOwNm        AS CHARACTER
    FIELD CntOwNm2       AS CHARACTER
    FIELD CntOwNm3       AS CHARACTER
    FIELD CltAddr1       AS CHARACTER
    FIELD CltAddr2       AS CHARACTER
    FIELD CltAddr3       AS CHARACTER
    FIELD CltAddr4       AS CHARACTER
    FIELD nv_nam1        AS CHARACTER 
    FIELD nv_nam2        AS CHARACTER 
    FIELD n_inam1        AS CHARACTER 
    FIELD n_inam2        AS CHARACTER
    FIELD nv_cage        AS CHARACTER
    FIELD nv_yrtyp       AS CHARACTER
    FIELD nv_age         AS CHARACTER 
    FIELD nv_addr1       AS CHARACTER 
    FIELD nv_addr2       AS CHARACTER 
    FIELD nv_addr3       AS CHARACTER 
    FIELD nv_addr4       AS CHARACTER 
    FIELD nv_occup       AS CHARACTER 
    FIELD nv_bnam1       AS CHARACTER   //Bname
    FIELD nv_bnam2       AS CHARACTER 
    FIELD nv_badd        AS CHARACTER 
    FIELD nv_reship      AS CHARACTER 
    FIELD nv_reship1     AS CHARACTER 
    FIELD nv_reship2     AS CHARACTER 
    FIELD Percent        AS CHARACTER
    FIELD nv_bicno       AS CHARACTER 
    FIELD nv_date        AS CHARACTER 
    FIELD nv_date_2      AS CHARACTER 
    FIELD nv_cdat        AS CHARACTER
    FIELD nv_cdat_2      AS CHARACTER 
    FIELD nv_acctim      AS CHARACTER
    FIELD nv_acctim2     AS CHARACTER
    FIELD nv_edat        AS CHARACTER
    FIELD nv_edat_2      AS CHARACTER 
    FIELD nv_area1       AS CHARACTER 
    FIELD nv_area2       AS CHARACTER 
    FIELD Suminsured     AS CHARACTER
    FIELD SumPostGrossPm AS CHARACTER
    FIELD SumPostSDuty   AS CHARACTER
    FIELD SumPostVAT     AS CHARACTER
    FIELD SumPostPmDue   AS CHARACTER
    FIELD nv_mbsi1       AS CHARACTER 
    FIELD n_tot123       AS CHARACTER 
    FIELD nv_mbsi2       AS CHARACTER 
    FIELD nv_mbsi3       AS CHARACTER 
    FIELD nv_mb4wks      AS CHARACTER 
    FIELD nv_mbsi4       AS CHARACTER 
    FIELD nv_mbsi4_2     AS CHARACTER 
    FIELD nv_mb4ded      AS CHARACTER 
    FIELD nv_tot4        AS CHARACTER 
    FIELD nv_mb5wks      AS CHARACTER 
    FIELD nv_mbsi5       AS CHARACTER 
    FIELD nv_mbsi5_2     AS CHARACTER 
    FIELD nv_mb5ded      AS CHARACTER 
    FIELD nv_tot5        AS CHARACTER 
    FIELD nv_mbsi6       AS CHARACTER 
    FIELD nv_mbsi6_2     AS CHARACTER 
    FIELD nv_mb6ded      AS CHARACTER 
    FIELD nv_tot6        AS CHARACTER 
    FIELD nv_ad1         AS CHARACTER 
    FIELD nv_dsc2        AS CHARACTER 
    FIELD nv_subtots     AS CHARACTER 
    FIELD nv_taxs        AS CHARACTER 
    FIELD nv_stamp1      AS CHARACTER 
    FIELD nv_grands      AS CHARACTER 
    FIELD nv_endatt      AS CHARACTER 
    FIELD nv_ag          AS CHARACTER 
    FIELD nv_br          AS CHARACTER 
    FIELD AgentLicenseNo AS CHARACTER  //nv_agtnam
    FIELD AgntName       AS CHARACTER  //AgentLicenseNo
    FIELD Agntnum        AS CHARACTER  //Agntnum
    FIELD Agttyp         AS CHARACTER 
    FIELD nv_R0039       AS CHARACTER 
    FIELD nv_adat        AS CHARACTER 
    FIELD nv_adat_2      AS CHARACTER 
    FIELD nv_sdat        AS CHARACTER 
    FIELD nv_sdat_2      AS CHARACTER 
    FIELD nv_journey     AS CHARACTER 
    FIELD nv_conam       AS CHARACTER 
    FIELD nv_prvpol      AS CHARACTER 
    FIELD nv_idob        AS CHARACTER 
    FIELD nv_iocc        AS CHARACTER 
    FIELD nv_icno        AS CHARACTER 
    FIELD nv_apsp        AS CHARACTER 
    FIELD nv_apyp        AS CHARACTER 
    FIELD nv_docno       AS CHARACTER 
    FIELD nv_pasen       AS CHARACTER 
    FIELD nv_pasca       AS CHARACTER 
    FIELD nv_Prem_Per1   AS CHARACTER 
    FIELD nv_qrcode      AS CHARACTER 
    FIELD nv_comdat      AS CHARACTER
    FIELD nv_ccomdat     AS CHARACTER
    FIELD nv_expdat      AS CHARACTER
    FIELD nv_cexpdat     AS CHARACTER
    FIELD nv_today       AS CHARACTER 
    FIELD nv_poltyp      AS CHARACTER 
    FIELD nv_poldes      AS CHARACTER
    FIELD nv_add11       AS CHARACTER 
    FIELD nv_add12       AS CHARACTER 
    FIELD nv_add13       AS CHARACTER 
    FIELD nv_add14       AS CHARACTER 
    FIELD nv_tel         AS CHARACTER 
    FIELD nv_code        AS CHARACTER 
    FIELD nv_accdat      AS CHARACTER 
    FIELD nv_issdat      AS CHARACTER
    FIELD nv_trndat      AS CHARACTER 
    FIELD nv_ww1         AS CHARACTER 
    FIELD nv_ww2         AS CHARACTER 
    FIELD nv_ww3         AS CHARACTER 
    FIELD nv_ww4         AS CHARACTER 
    FIELD nv_ww5         AS CHARACTER 
    FIELD nv_ww6         AS CHARACTER 
    FIELD nv_ww7         AS CHARACTER 
    FIELD nv_ww8         AS CHARACTER 
    FIELD nv_ww9         AS CHARACTER 
    FIELD nv_ww10        AS CHARACTER 
    FIELD nv_ww11        AS CHARACTER 
    FIELD nv_ww12        AS CHARACTER 
    FIELD nv_ww13        AS CHARACTER 
    FIELD nv_ww14        AS CHARACTER 
    FIELD nv_ww15        AS CHARACTER 
    FIELD nv_ww16        AS CHARACTER 
    FIELD nv_ww17        AS CHARACTER 
    FIELD nv_ww18        AS CHARACTER 
    FIELD nv_ww19        AS CHARACTER 
    FIELD nv_ww20        AS CHARACTER 
    FIELD nv_plantxt     AS CHARACTER 
    FIELD nv_PMedi       AS CHARACTER 
    FIELD nv_PB1         AS CHARACTER 
    FIELD nv_PB2         AS CHARACTER 
    FIELD nv_al123       AS CHARACTER 
    FIELD nv_ma          AS CHARACTER 
    FIELD nv_ma2         AS CHARACTER 
    FIELD nv_mc          AS CHARACTER 
    FIELD nv_mc2         AS CHARACTER   .
     */ 
DEF TEMP-TABLE tclause
    FIELD nline   AS INT   INIT 0
    FIELD nrecid  AS RECID INIT ?
    FIELD clstyp  AS INT   INIT 0
    FIELD clause  AS CHAR  INIT "".
   
    
/* PolicyTxt - HeadCover*/    
DEFINE TEMP-TABLE PolicyTxt    NO-UNDO 
    FIELD login     AS CHARACTER 
    FIELD ptxline   AS CHARACTER 
    FIELD ptxSI     AS CHARACTER
    FIELD ptxUOM    AS CHARACTER 
    FIELD ptxTxt    AS CHARACTER 
    FIELD prxCover  AS CHARACTER .
    


/* --- PROCEDURE  ---------------------------------------------------------*/
PROCEDURE pd_tHeader  :
DEF INPUT PARAMETER nv_login        AS  CHARACTER .
DEF INPUT PARAMETER nv_cdat         AS  CHARACTER .
DEF INPUT PARAMETER nv_edat         AS  CHARACTER .
DEF INPUT PARAMETER nv_adat         AS  CHARACTER .
DEF INPUT PARAMETER nv_prtpol       AS  CHARACTER .
DEF INPUT PARAMETER nv_class        AS  CHARACTER .
DEF INPUT PARAMETER nv_prodesc      AS  CHARACTER .
DEF INPUT PARAMETER nv_product      AS  CHARACTER .
DEF INPUT PARAMETER nv_mbsi1        AS  CHARACTER .
DEF INPUT PARAMETER nv_subtots      AS  CHARACTER .
DEF INPUT PARAMETER nv_stamp1       AS  CHARACTER .
DEF INPUT PARAMETER nv_taxs         AS  CHARACTER .
DEF INPUT PARAMETER nv_grands       AS  CHARACTER .
     CREATE  tHeader .  
     ASSIGN  tHeader.login                =      nv_login
             tHeader.nv_ccomdat           =      nv_cdat
             tHeader.nv_cexpdat           =      nv_edat
             tHeader.nv_caccdat           =      nv_adat
             tHeader.nv_acctim            =      "16:30"
             tHeader.nv_acctim2           =      "16:30"
             tHeader.PolicyNumber         =      nv_prtpol
             tHeader.PolicyType           =      uwm100.poltyp
             tHeader.PolicyClass          =      nv_class
             tHeader.nv_prodesc           =      nv_prodesc 
             tHeader.nv_product           =      nv_product 
             tHeader.Suminsured           =      TRIM(nv_mbsi1)   
             tHeader.SumPostGrossPm       =      TRIM(nv_subtots) 
             tHeader.SumPostSDuty         =      TRIM(nv_stamp1)  
             tHeader.SumPostVAT           =      TRIM(nv_taxs)    
             tHeader.SumPostPmDue         =      TRIM(nv_grands)  .
        
END PROCEDURE . 
/* ................................................................ */
PROCEDURE pd_AgentDet :
DEF INPUT PARAMETER nv_login         AS  CHARACTER . 
DEF INPUT PARAMETER nv_acno          AS  CHARACTER . 
DEF INPUT PARAMETER nv_agtnam        AS  CHARACTER . 
DEF INPUT PARAMETER nv_agtreg        AS  CHARACTER . 
DEF INPUT PARAMETER nv_agttyp        AS  CHARACTER . 

      CREATE  AgentDetails . 
      ASSIGN  AgentDetails.login            =   nv_login
              AgentDetails.Agntnum          =   nv_acno
              AgentDetails.AgntName         =   nv_agtnam
              AgentDetails.AgentLicenseNo   =   nv_agtreg
              AgentDetails.sp_agttyp        =   nv_agttyp .       
END PROCEDURE . 
/* ................................................................ */
PROCEDURE pd_ClientDetails :
DEF INPUT PARAMETER nv_login        AS  CHARACTER . 
DEF INPUT PARAMETER nv_nam1         AS  CHARACTER . 
DEF INPUT PARAMETER nv_nam2         AS  CHARACTER . 
DEF INPUT PARAMETER nv_addr1        AS  CHARACTER . 
DEF INPUT PARAMETER nv_addr2        AS  CHARACTER . 
DEF INPUT PARAMETER nv_icno         AS  CHARACTER . 
DEF INPUT PARAMETER nv_tel          AS  CHARACTER . 
      CREATE  ClientDetails . 
      ASSIGN  ClientDetails.login        =      nv_login
              ClientDetails.CntOwNm      =      nv_nam1 
              ClientDetails.CntOwNm2     =      nv_nam2
              ClientDetails.CntOwNm3     =      ""
              ClientDetails.CltAddr1     =      nv_addr1
              ClientDetails.CltAddr2     =      nv_addr2
              ClientDetails.CltAddr3     =      ""
              ClientDetails.CltAddr4     =      ""
              ClientDetails.CntOwNo      =      ""
              ClientDetails.nv_R003_3    =      "" 
              ClientDetails.nv_R003_4    =      "" 
              ClientDetails.nv_R003_5    =      "" 
              ClientDetails.nv_icno      =      nv_icno
              ClientDetails.nv_tel       =      nv_tel   .       
END PROCEDURE .
/* ................................................................ */
PROCEDURE pd_uwd120:   //  Uppter ext 
    DEF INPUT PARAMETER nv_login    AS CHARACTER .
    DEF INPUT PARAMETER nv_policynumber AS CHARACTER INIT "" .
    DEF VAR nv_fptr    AS RECID INIT ?.
    DEF VAR nv_i       AS INT   INIT 0.
    DEF VAR nv_clstyp  AS INT   INIT 0.   
  
    nv_fptr = uwm120.fptr01.
    IF nv_fptr = 0 THEN DO:
        RETURN.        
    END.
    loop_uwd120:
    REPEAT:       
         FIND uwd120 Where Recid(uwd120) = nv_fptr No-Lock No-Error No-Wait.
         IF Avail uwd120 Then Do:
            IF uwm120.policy <> uwd120.policy THEN  LEAVE loop_uwd120. 
            FIND FIRST tclause WHERE 
                       tclause.nrecid =  RECID(uwd120) NO-LOCK NO-ERROR.
            IF NOT AVAIL tclause THEN DO:
               nv_i = nv_i + 1.                   
                CREATE  tclause.
                ASSIGN
                    tclause.nline   =  nv_i
                    tclause.nrecid  =  RECID(uwd120).                
                CREATE  UpperText . 
                ASSIGN  UpperText.login     =    nv_login
                        UpperText.nline     =    STRING(nv_i)
                        UpperText.TXT       =    TRIM(STRING(uwd120.ltext)) .
                        
                
            END.   
            ELSE LEAVE loop_uwd120.
            
            IF  nv_fptr = uwd120.fptr THEN LEAVE loop_uwd120.  
            nv_fptr = uwd120.fptr.
            IF nv_fptr = ? OR nv_fptr = 0 THEN LEAVE loop_uwd120. 
            
         END. // uwd120 
         ELSE LEAVE loop_uwd120.
         
    END. // Repeat 
    
    RELEASE tclause NO-ERROR.    

END PROCEDURE . 
/* ................................................................ */
PROCEDURE pd_uomdes:
    DEF INPUT  PARAMETER nv_iuom_c   AS CHAR INIT "".
    DEF INPUT  PARAMETER nv_ulanguag AS CHAR INIT "".
    DEF OUTPUT PARAMETER nv_ouomdes   AS CHAR INIT "".
    FIND xmm017 USE-INDEX xmm01701 WHERE                        
                 xmm017.uom_c = nv_iuom_c NO-LOCK NO-ERROR.                      
    IF AVAILABLE xmm017 THEN DO:  
        IF nv_ulanguag = "" THEN nv_ouomdes  = xmm017.uom_dl.  
        ELSE nv_ouomdes  = xmm017.uomdlt.       
    END.
    nv_ouomdes = TRIM(nv_ouomdes).
    
END PROCEDURE.
/* ................................................................ */
PROCEDURE pd_riskDetail:   //  Risk  DEtail
DEF INPUT PARAMETER nv_login    AS CHARACTER . 
DEF INPUT PARAMETER nv_iname    AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_occup    AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_iocctd   AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_dob      AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_cage     AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_yrtyp    AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_jrny     AS CHARACTER INIT "" .
DEF INPUT PARAMETER Membercode  AS CHARACTER INIT "" .
DEF INPUT PARAMETER Planname    AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_cdisc    AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_load     AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_ad1      AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_endatt   AS CHARACTER INIT "" . 
CREATE RiskDetail . 
ASSIGN RiskDetail.login         =    nv_login    
       RiskDetail.nv_iname      =    nv_iname    
       RiskDetail.nv_occup      =    nv_occup    
       RiskDetail.nv_iocctd     =    nv_iocctd   
       RiskDetail.nv_dob        =    nv_dob      
       RiskDetail.nv_cage       =    nv_cage     
       RiskDetail.nv_yrtyp      =    nv_yrtyp    
       RiskDetail.nv_jrny       =    nv_jrny     
       RiskDetail.Membercode    =    Membercode  
       RiskDetail.Planname      =    Planname    
       RiskDetail.nv_cdisc      =    nv_cdisc    
       RiskDetail.nv_load       =    nv_load     
       RiskDetail.nv_ad1        =    nv_ad1      
       RiskDetail.nv_endatt     =    nv_endatt .       
       RELEASE RiskDetail . 
END PROCEDURE .     
/* ................................................................ */ 
PROCEDURE pd_benefit    :
DEF INPUT PARAMETER nv_login         AS CHARACTER .
DEF INPUT PARAMETER nv_policynumber  AS CHARACTER  INIT "" .
DEF INPUT PARAMETER nline            AS INT .
DEF INPUT PARAMETER nBname           AS CHARACTER .
DEF INPUT PARAMETER nBICno           AS CHARACTER .
DEF INPUT PARAMETER nBaddr           AS CHARACTER .
DEF INPUT PARAMETER nBoccup          AS CHARACTER .
DEF INPUT PARAMETER nBreship         AS CHARACTER .
DEF INPUT PARAMETER nBpercent        AS CHARACTER .
DEF INPUT PARAMETER nBDob            AS CHARACTER .
DEF INPUT PARAMETER nBage            AS CHARACTER .
DEF VAR nv_line       AS INT   INIT 0.    
    
  CREATE PBenefit . 
  ASSIGN PBenefit.login      =   nv_login
         PBenefit.BPolicy    =   nv_policynumber
         PBenefit.Bno        =   STRING(nline)
         PBenefit.Bname      =   nBname   
         PBenefit.BICno      =   nBICno   
         PBenefit.Baddr      =   nBaddr   
         PBenefit.Boccup     =   nBoccup  
         PBenefit.Breship    =   nBreship 
         PBenefit.Bpercent   =   nBpercent
         PBenefit.BDob       =   nBDob    
         PBenefit.Bage       =   nBage    .
  RELEASE PBenefit. 
  
END PROCEDURE .
/* ................................................................ */
PROCEDURE pd_ptxcover :   // Text Cover 
DEF INPUT PARAMETER nv_login    AS CHARACTER . 
DEF INPUT PARAMETER nfptr       AS RECID . 
DEF INPUT PARAMETER nv_chkSI    AS INT   .
DEF INPUT PARAMETER nv_chkUOM   AS INT   .
DEF INPUT PARAMETER nv_CoverSI  AS CHARACTER INIT "".  
DEF VAR  nvline      AS INT  INIT 0 .

CREATE HeadCover . 
ASSIGN HeadCover.login          =   nv_login
       HeadCover.Cover_Line     =   STRING(nvline)    
       HeadCover.Cover_SI       =   STRING(nv_chkSI)
       HeadCover.Cover_Des      =   STRING(nv_chkUOM) .       
       RELEASE HeadCover . 
END PROCEDURE .  
/* ................................................................ */
PROCEDURE pd_riskcover:   // Risk Cover 
DEF INPUT PARAMETER nv_login    AS CHARACTER . 
DEF INPUT PARAMETER nvline      AS INT . 
DEF INPUT PARAMETER nv_covcode  AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_covdes   AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_mbwks    AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_mbsi     AS CHARACTER INIT "" . 
DEF INPUT PARAMETER nv_mbded    AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_tot      AS CHARACTER INIT "" . 

CREATE RiskCover . 
ASSIGN RiskCover.login         =   nv_login          
       RiskCover.Cover_Line    =   STRING(nvline)
       RiskCover.Cover_Code    =   nv_covcode 
       RiskCover.Cover_Dec     =   nv_covdes
       RiskCover.Cover_wek     =   nv_mbwks
       RiskCover.Cover_SI      =   nv_mbsi
       RiskCover.Cover_ded     =   nv_mbded   
       RiskCover.Cover_Prem    =   nv_tot  .        
       RELEASE RiskCover . 
END PROCEDURE .     
/* ................................................................ */
PROCEDURE pd_bookxml:   // Clasue
    DEF INPUT PARAMETER nv_login        AS CHARACTER .
    DEF INPUT PARAMETER nv_policynumber AS CHARACTER  INIT "" .
    DEF VAR nv_fptr    AS RECID INIT ?.
    DEF VAR nv_i       AS INT   INIT 0.
    DEF VAR nv_clstyp  AS INT   INIT 0.     
      
    nv_fptr = uwm100.fptr03.
    IF nv_fptr = 0 THEN DO:
        RETURN.        
    END.
    loop_uwd105:
    REPEAT:
        Find uwd105 Where Recid(uwd105) = nv_fptr No-Lock No-Error No-Wait.
        IF Avail uwd105 Then Do:  
            IF trim(uwd105.clause) <> "" THEN DO:
            FIND FIRST tclause WHERE 
                    tclause.nrecid =  RECID(uwd105) NO-LOCK NO-ERROR.
                IF NOT AVAIL tclause THEN DO:
                    nv_i = nv_i + 1.
                    IF substr(TRIM(uwd105.clause),1,2) = "BK" THEN  nv_clstyp = 1.
                    ELSE  nv_clstyp = 2.
                    CREATE  tclause.
                    ASSIGN
                        tclause.nline   =  nv_i
                        tclause.nrecid  =  RECID(uwd105)
                        tclause.clstyp  =  nv_clstyp
                        tclause.clause  =  trim(uwd105.clause)  .
                        
                    RUN pd_bookxml2 (INPUT nv_login , nv_policynumber ).
                END.
                ELSE LEAVE loop_uwd105 .
        END.    
        IF  nv_fptr = uwd105.fptr THEN LEAVE loop_uwd105.  
            nv_fptr = uwd105.fptr.
            IF nv_fptr = ? OR nv_fptr = 0 THEN LEAVE loop_uwd105.  
        END.    
        ELSE LEAVE loop_uwd105.
    END.
    RELEASE tclause NO-ERROR.
END PROCEDURE .
/* ................................................................ */
PROCEDURE pd_bookxml2:  //Clasue2   
    DEF INPUT PARAMETER nv_login AS CHARACTER INIT "" .
    DEF INPUT PARAMETER nv_policynumber AS CHARACTER INIT "" .
    DEF VAR nv_clstypcode AS CHAR INIT "".
    DEF VAR nv_clstypdesc AS CHAR INIT "".
    
    def var nv_clshead    AS CHAR INIT "".
    def var nv_clstxt1    AS CHAR INIT "".
    def var nv_clstxt2    AS CHAR INIT "".
    
    ASSIGN
        nv_clstypcode   = "EXT"
        nv_clstypdesc   = "EXTEND".
    
    IF tclause.clstyp = 1 THEN DO:
        ASSIGN
            nv_clstypcode   = "JKT"
            nv_clstypdesc   = "BOOK".    
    END.
    
    FIND xmm059 WHERE xmm059.clause = tclause.clause NO-LOCK NO-ERROR.
    IF AVAILABLE xmm059 THEN nv_clshead  = xmm059.cltitl.
    
        CREATE  PCLAUSE . 
        ASSIGN  PCLAUSE.login           =   nv_login
                PCLAUSE.Policynumber    =   STRING(nv_policynumber)
                PCLAUSE.ClauseSeqNo     =   TRIM(STRING(tclause.nline))
                PCLAUSE.ClauseDocType   =   TRIM(STRING(nv_clstypcode))
                PCLAUSE.ClauseType      =   TRIM(STRING(nv_clstypdesc))
                PCLAUSE.ClauseCode      =   TRIM(STRING(tclause.clause))
                PCLAUSE.ClauseHeading   =   TRIM(STRING(nv_clshead))
                PCLAUSE.ClauseText1     =   TRIM(STRING(nv_clstxt1)) 
                PCLAUSE.ClauseText2     =   TRIM(STRING(nv_clstxt2)) .  
       RELEASE  PCLAUSE.  
    
END  PROCEDURE  .
/* ................................................................ */
PROCEDURE pd_VATDet :       // Print VAT 
DEF INPUT PARAMETER nv_login AS CHARACTER INIT "" .
DEF INPUT PARAMETER nv_docno    AS CHARACTER .
DEF INPUT PARAMETER nv_cgstrat  AS CHARACTER .
DEF INPUT PARAMETER VATctpstrat AS CHARACTER  .
DEF INPUT PARAMETER nv_nam1     AS CHARACTER .
DEF INPUT PARAMETER nv_nam2     AS CHARACTER .
DEF INPUT PARAMETER nv_addr1    AS CHARACTER .
DEF INPUT PARAMETER nv_addr2    AS CHARACTER .
DEF INPUT PARAMETER nv_icno     AS CHARACTER .
    CREATE VATDlts . 
    ASSIGN VATDlts.login             =    nv_login
           VATDlts.VSequence         =    1
           VATDlts.VatInvtyp         =    "S"
           VATDlts.nv_docno1         =    nv_docno
           VATDlts.nv_vtprtdat       =    STRING(TODAY,"99/99/9999")
           VATDlts.nv_cgstrat        =    nv_cgstrat
           VATDlts.VATctpstrat       =    TRIM(STRING(VATctpstrat))
           VATDlts.PrintBr           =    "สำนักงานใหญ่"
           VATDlts.Payor_CntOwNm     =    nv_nam1
           VATDlts.Payor_CltAddr1    =    nv_addr1
           VATDlts.Payor_CltAddr2    =    nv_addr2
           VATDlts.Payor_occupn      =    ""
           VATDlts.Payor_dtaxno      =    nv_icno
           VATDlts.Payor_Branch      =    ""  .
    RELEASE VATDlts .
END PROCEDURE . 
/* ................................................................ */
PROCEDURE pd_PrintDoc :       // Print VAT 
DEF INPUT PARAMETER nv_login    AS CHARACTER INIT "" .
DEF INPUT PARAMETER SCH         AS LOGICAL .
DEF INPUT PARAMETER CER         AS LOGICAL .
DEF INPUT PARAMETER RCP         AS LOGICAL .
DEF INPUT PARAMETER ATT         AS LOGICAL .
DEF INPUT PARAMETER EXT         AS LOGICAL .
DEF INPUT PARAMETER JKT         AS LOGICAL .
DEF INPUT PARAMETER CRD         AS LOGICAL .
DEF INPUT PARAMETER LST         AS LOGICAL .

    CREATE PrintDoc . 
    ASSIGN PrintDoc.login       =   nv_login
           PrintDoc.prtSCH      =   SCH 
           PrintDoc.prtCER      =   CER 
           PrintDoc.prtRCP      =   RCP 
           PrintDoc.prtATT      =   ATT 
           PrintDoc.prtEXT      =   EXT 
           PrintDoc.prtJKT      =   JKT 
           PrintDoc.prtCRD      =   CRD 
           PrintDoc.prtLST      =   LST  
           PrintDoc.prtOriginal =   TRUE 
           PrintDoc.prtCopy     =   FALSE .
    RELEASE PrintDoc .
END PROCEDURE . 

