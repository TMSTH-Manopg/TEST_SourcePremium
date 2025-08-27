USING System.Net.Http.*. 
USING System.Environment.
USING Progress.Lang.*. 
USING Progress.Json.ObjectModel.*. 
USING Progress.Json.ObjectModel.* FROM PROPATH.
USING Progress.IO.*.
{WS\PrnTBAPI.i}  // Parameter Temp-Table  
/* JSON VARIABLE */
DEFINE VARIABLE jsonMain        AS JsonObject NO-UNDO.
DEFINE VARIABLE jsonArray       AS JsonArray  NO-UNDO.
DEFINE VARIABLE jsonSubObj      AS JsonObject NO-UNDO.
DEFINE VARIABLE jsonclient      AS JsonObject NO-UNDO.  /* สร้าง ClientDetails เป็น Object ย่อย */
DEFINE VARIABLE jsonText        AS LONGCHAR   NO-UNDO.
DEFINE VARIABLE i               AS INTEGER    NO-UNDO.
DEFINE VARIABLE nv_filejson     AS CHAR INIT "".
DEFINE VARIABLE jsonRS          AS LONGCHAR .

// Data-RE
DEFINE VARIABLE data_Re       AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE resultCode    AS CHARACTER NO-UNDO.
DEFINE VARIABLE resultMsg     AS CHARACTER NO-UNDO.
DEFINE VARIABLE resultData    AS CHARACTER NO-UNDO.
DEFINE VARIABLE DataResponse  AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE nResult1      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nResult2      AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE nMessage1     AS CHARACTER NO-UNDO.




// ---- Input Paremeter
DEFINE INPUT PARAMETER nv_login         AS CHARACTER INIT "" NO-UNDO.
DEFINE INPUT PARAMETER nPolicyNumber    AS CHARACTER INIT "" NO-UNDO.
DEFINE INPUT PARAMETER TABLE FOR tHeader    .
DEFINE INPUT PARAMETER TABLE FOR ClientDetails .
DEFINE INPUT PARAMETER TABLE FOR AgentDetails .
DEFINE INPUT PARAMETER TABLE FOR PCLAUSE .
DEFINE INPUT PARAMETER TABLE FOR HeadCover.
DEFINE INPUT PARAMETER TABLE FOR UpperText.
DEFINE INPUT PARAMETER TABLE FOR RiskDetail.
DEFINE INPUT PARAMETER TABLE FOR PBenefit.
DEFINE INPUT PARAMETER TABLE FOR RiskCover.
DEFINE INPUT PARAMETER TABLE FOR VATDlts.
DEFINE INPUT PARAMETER TABLE FOR PrintDoc.
// --------------- Input Paremeter 

/* 
DEF VAR prtSCH        AS LOGICAL INIT False .
DEF VAR prtCER        AS LOGICAL INIT False .
DEF VAR prtRCP        AS LOGICAL INIT False .
DEF VAR prtATT        AS LOGICAL INIT False .
DEF VAR prtEXT        AS LOGICAL INIT False .
DEF VAR prtJKT        AS LOGICAL INIT False .
DEF VAR prtCRD        AS LOGICAL INIT False .
DEF VAR prtLST        AS LOGICAL INIT False .
DEF VAR prtOriginal   AS LOGICAL INIT False .
DEF VAR prtCopy       AS LOGICAL INIT False .

//เลือกเอกสารปริ้น   Default   หน้าตาราง ,  Attach ,  Receipt
ASSIGN  
prtSCH      =   TRUE    // หน้าตาราง
prtCER      =   FALSE   // Certify
prtRCP      =   TRUE    // Receipt
prtATT      =   TRUE    // Attach
prtEXT      =   FALSE   // EXT CLUS
prtJKT      =   FALSE   // JKT CLS
prtCRD      =   FALSE   // Card
prtLST      =   FALSE   //   ?? 
prtOriginal =   TRUE    //  ตัวจริง
prtCopy     =   FALSE . //  สำเนา
     */ 
/* สร้าง Object หลัก  jsonMain */
jsonMain   =  NEW JsonObject() .
jsonclient =  NEW JsonObject() .
jsonSubObj =  NEW JsonObject() .
jsonArray  =  NEW JsonArray().

FIND FIRST   tHeader  WHERE  tHeader.login        = nv_login AND 
                             tHeader.PolicyNumber = nPolicyNumber NO-LOCK .
IF AVAIL  tHeader THEN DO:
          // CREATE JSON  Header  /// วัน - เวลา คุ้มครอง
          jsonMain:Add("nv_ccomdat", tHeader.nv_ccomdat).
          jsonMain:Add("nv_cexpdat", tHeader.nv_cexpdat).
          jsonMain:Add("nv_caccdat", tHeader.nv_caccdat). 
          jsonMain:Add("nv_acctim", tHeader.nv_acctim).
          jsonMain:Add("nv_acctim2", tHeader.nv_acctim2).
          //  Policy Type Class 
          jsonMain:Add("PolicyType", tHeader.PolicyType).
          jsonMain:Add("PolicyNumber", tHeader.PolicyNumber).
          jsonMain:Add("Policyclass", tHeader.Policyclass). 
          jsonMain:Add("nv_prodesc", tHeader.nv_prodesc).
          jsonMain:Add("nv_product", tHeader.nv_product).
          // SumInsure - Premium Stamp Vat
          jsonMain:Add("Suminsured", tHeader.Suminsured).
          jsonMain:Add("SumPostGrossPm", tHeader.SumPostGrossPm).
          jsonMain:Add("SumPostSDuty", tHeader.SumPostSDuty). 
          jsonMain:Add("SumPostVAT", tHeader.SumPostVAT).
          jsonMain:Add("SumPostPmDue", tHeader.SumPostPmDue).
END. 
// ClientDetails  --------------------------
jsonclient =  NEW JsonObject() .
FOR EACH ClientDetails WHERE  ClientDetails.login  =   nv_login  NO-LOCK:
    jsonclient:Add("CntOwNm", ClientDetails.CntOwNm ).
    jsonclient:Add("CntOwNm2", ClientDetails.CntOwNm2).
    jsonclient:Add("CntOwNm3", ClientDetails.CntOwNm3).
    jsonclient:Add("CltAddr1", ClientDetails.CltAddr1).
    jsonclient:Add("CltAddr2", ClientDetails.CltAddr2).
    jsonclient:Add("CltAddr3", ClientDetails.CltAddr3).
    jsonclient:Add("CltAddr4", ClientDetails.CltAddr4). 
    jsonclient:Add("CntOwNo", ClientDetails.CntOwNo).    
    jsonclient:Add("nv_R003_3", ClientDetails.nv_R003_3).
    jsonclient:Add("nv_R003_4", ClientDetails.nv_R003_4).
    jsonclient:Add("nv_R003_5", ClientDetails.nv_R003_5).
    jsonclient:Add("nv_icno", ClientDetails.nv_icno). 
    jsonclient:Add("nv_tel", ClientDetails.nv_tel).
END.
jsonMain:Add("ClientDetails", jsonclient).   
// AgentDetails  --------------------------
jsonclient =  NEW JsonObject() .
FOR EACH AgentDetails WHERE  AgentDetails.login  =   nv_login  NO-LOCK:
    jsonclient:Add("Agntnum", AgentDetails.Agntnum ).
    jsonclient:Add("AgntName", AgentDetails.AgntName).
    jsonclient:Add("AgentLicenseNo", AgentDetails.AgentLicenseNo).
    jsonclient:Add("sp_agttyp", AgentDetails.sp_agttyp ).        
END.
jsonMain:Add("AgentDetails", jsonclient). 
// HeadCover    --------------------------
jsonArray = NEW JsonArray().
FOR EACH HeadCover WHERE HeadCover.login  =  nv_login NO-LOCK:      
    jsonclient = NEW JsonObject().
    jsonclient:ADD("Cover_Line", HeadCover.Cover_Line) .
    jsonclient:Add("Cover_Des", HeadCover.Cover_Des).     
    jsonclient:Add("Cover_SI", HeadCover.Cover_SI).
    jsonArray:Add(jsonclient).
END.  
jsonMain:Add("HeadCover", jsonArray). 
// Risk Detail  --------------------------
jsonclient =  NEW JsonObject() .
jsonArray = NEW JsonArray().
FOR EACH RiskDetail WHERE  RiskDetail.login  =   nv_login  NO-LOCK:
    jsonclient:Add("nv_iname", RiskDetail.nv_iname ).
    jsonclient:Add("nv_occup", RiskDetail.nv_occup ).
    jsonclient:Add("nv_iocctd", RiskDetail.nv_iocctd ).
    jsonclient:Add("nv_dob", RiskDetail.nv_dob ).
    jsonclient:Add("nv_cage", RiskDetail.nv_cage ).
    jsonclient:Add("nv_yrtyp", RiskDetail.nv_yrtyp ).
    
    jsonclient:Add("Membercode", RiskDetail.Membercode ).
    jsonclient:Add("Planname", RiskDetail.Planname ).
    jsonclient:Add("nv_cdisc", RiskDetail.nv_cdisc ).
    jsonclient:Add("nv_load", RiskDetail.nv_load ).
    jsonclient:Add("nv_ad1", RiskDetail.nv_ad1 ).
    jsonclient:Add("nv_endatt", RiskDetail.nv_endatt ).
    // Benefit    --------------------------
    FOR EACH PBenefit WHERE PBenefit.login    =   nv_login NO-LOCK :
        jsonSubObj = NEW JsonObject().
        jsonSubObj:ADD("Bname", PBenefit.Bname) .
        jsonSubObj:ADD("Breship", PBenefit.Breship) .
        jsonSubObj:Add("Percent", PBenefit.Bpercent).
    END.
    jsonclient:Add("BenefitDLT", jsonSubObj).
    // RiskCover    --------------------------
    FOR EACH RiskCover WHERE RiskCover.login  =  nv_login NO-LOCK:      
        jsonSubObj = NEW JsonObject().
        jsonSubObj:ADD("Cover_Code", RiskCover.Cover_Code) .
        jsonSubObj:ADD("Cover_Line", RiskCover.Cover_Line) .
        jsonSubObj:Add("Cover_Dec", RiskCover.Cover_Dec).     
        jsonSubObj:Add("Cover_SI", RiskCover.Cover_SI).
        jsonSubObj:Add("Cover_Prem", RiskCover.Cover_Prem).
        jsonArray:Add(jsonSubObj).
    END.  
    jsonclient:Add("RiskCover", jsonArray).
END.  
jsonMain:Add("Risk", jsonclient). 
/* ---- Clause   --------------------------
jsonArray = NEW JsonArray().
FOR EACH PCLAUSE WHERE PCLAUSE.login  =  nv_login NO-LOCK :      
    jsonclient = NEW JsonObject().
    jsonclient:ADD("ClauseSeqNo", PCLAUSE.ClauseSeqNo) .
    jsonclient:Add("ClauseDocType", PCLAUSE.ClauseDocType).     
    jsonclient:Add("ClauseCode", PCLAUSE.ClauseCode).
    jsonclient:Add("ClauseHeading", PCLAUSE.ClauseHeading).
    jsonArray:Add(jsonclient).
END.  
jsonMain:Add("CLAUSE", jsonArray).    ---*/
// Attach     --------------------------
jsonArray = NEW JsonArray().
FOR EACH UpperText WHERE UpperText.login  =  nv_login :
    jsonclient = NEW JsonObject().
    jsonclient:ADD("TXTline", UpperText.nline) .
    jsonclient:Add("TXT", UpperText.TXT).
    jsonArray:Add(jsonclient).
END.
jsonMain:Add("UpperText", jsonArray).
// Select Form     --------------------------
jsonclient = NEW JsonObject().  
FOR EACH PrintDoc WHERE PrintDoc.login  =  nv_login : 
    jsonclient:ADD("prtSCH", PrintDoc.prtSCH).
    jsonclient:ADD("prtCER", PrintDoc.prtCER).
    jsonclient:ADD("prtRCP", PrintDoc.prtRCP).   
    jsonclient:ADD("prtATT", PrintDoc.prtATT).  
    jsonclient:ADD("prtEXT", PrintDoc.prtEXT).
    jsonclient:ADD("prtJKT", PrintDoc.prtJKT).
    jsonclient:ADD("prtCRD", PrintDoc.prtCRD).
    jsonclient:ADD("prtLST", PrintDoc.prtLST).   
    jsonclient:ADD("prtOriginal", PrintDoc.prtOriginal).
    jsonclient:ADD("prtCopy", PrintDoc.prtCopy).
END.
jsonMain:ADD("PrintDoc", jsonclient).
// VAT DETAIL     --------------------------
jsonArray = NEW JsonArray().
FOR EACH VATDlts WHERE VATDlts.login  =  nv_login :
    jsonclient = NEW JsonObject().
    jsonclient:ADD("Sequence", VATDlts.VSequence) .
    jsonclient:Add("VatInvtyp", "S").
    jsonclient:Add("nv_docno1", VATDlts.nv_docno1).
    jsonclient:Add("nv_vtprtdat", VATDlts.nv_vtprtdat).
    jsonclient:Add("nv_cgstrat", VATDlts.nv_cgstrat).
    jsonclient:Add("VATctpstrat", VATDlts.VATctpstrat).
    jsonclient:Add("PrintBr", VATDlts.PrintBr).    
    jsonclient:Add("Payor_CntOwNm", VATDlts.Payor_CntOwNm).
    jsonclient:Add("Payor_CltAddr1", VATDlts.Payor_CltAddr1).
    jsonclient:Add("Payor_CltAddr2", VATDlts.Payor_CltAddr2).
    jsonclient:Add("Payor_occupn", VATDlts.Payor_occupn).
    jsonclient:Add("Payor_dtaxno", VATDlts.Payor_dtaxno).
    jsonclient:Add("Payor_Branch", VATDlts.Payor_Branch).    
    jsonArray:Add(jsonclient).
END.
jsonMain:Add("VATDlts", jsonArray).
/* -------------------------------------------------------------------------------------------*/  
  
 /* แปลงเป็น JSON Text */       
jsonText = jsonMain:GetJsonText().
jsonText = REPLACE(jsonText, '\', "").
jsonText = REPLACE(jsonText, '"[', "[").
jsonText = REPLACE(jsonText, ']"', "]").
jsonRs   = CODEPAGE-CONVERT(jsonText, SESSION:CHARSET, "UTF-8").
/* เขียนไฟล์ JSON */
nv_filejson = "".
nv_filejson = nPolicyNumber +  ".json".
// jsonMain:WriteFile(nv_filejson, TRUE). 

RUN ExportJsonTextToFile  ( INPUT jsonRs, INPUT nv_filejson  ).   //EXPORT 
jsonRs  =  "" .  
DELETE OBJECT jsonclient .
DELETE OBJECT jsonArray.
DELETE OBJECT jsonMain.  

/***************Send to Web service *******************************/

COPY-LOB FILE nv_filejson   TO data_Re.
DEFINE VARIABLE cFileName  AS CHARACTER NO-UNDO.
DEFINE VARIABLE decdmptr   AS MEMPTR   NO-UNDO.
DEFINE VARIABLE decdlngc   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE encdmptr   AS MEMPTR NO-UNDO.
           /*   Send to Web service  
RUN UpdateMotorType (INPUT  data_Re,
                     OUTPUT  DataResponse,
                     output  nResult1  , 
                     output  nResult2    ,   /* nResult2  , */
                     output  nMessage1 ).
nResult2  = REPLACE(nResult2,"!UTF-8!","").
nResult2  = REPLACE(nResult2,"\","").
         */ 
         
//MESSAGE n_err     STRING((TIME - nv_timein2 ),"HH:MM:SS")  VIEW-AS ALERT-BOX. 

// -----------------    PROCEDURE 
PROCEDURE ExportJsonTextToFile . 

DEFINE INPUT PARAMETER ipJsonText  AS LONGCHAR   NO-UNDO.
DEFINE INPUT PARAMETER ipFileName  AS CHARACTER  NO-UNDO.

/* เขียนไฟล์ JSON ด้วย UTF-8 */
COPY-LOB FROM ipJsonText TO FILE ipFileName .   // CONVERT TARGET CODEPAGE "UTF-8".
END PROCEDURE .

//-- - -- - - - - - - - -

PROCEDURE UpdateMotorType :

DEFINE VARIABLE HttpClient   AS CLASS System.Net.WebClient. 
DEFINE VARIABLE webResponse  AS LONGCHAR NO-UNDO. 
DEFINE VARIABLE cURL         AS LONGCHAR NO-UNDO.
DEFINE VARIABLE myParser     AS ObjectModelParser NO-UNDO. 
DEFINE VARIABLE ojson        AS JsonObject NO-UNDO. 
DEFINE INPUT PARAMETER Data          AS LONGCHAR  NO-UNDO.
DEFINE OUTPUT PARAMETER dataResponse AS LONGCHAR NO-UNDO.
DEFINE OUTPUT PARAMETER nResult      AS CHAR     NO-UNDO.
DEFINE OUTPUT PARAMETER nResult22    AS LONGCHAR NO-UNDO. 
DEFINE OUTPUT PARAMETER nMessage     AS CHAR     NO-UNDO.
DEFINE VAR access_token  AS CHAR  NO-UNDO.
DEFINE VARIABLE encdmptr  AS MEMPTR   NO-UNDO.
DEFINE VARIABLE encdlngc  AS LONGCHAR NO-UNDO.
DEFINE VARIABLE encdlngc2 AS LONGCHAR NO-UNDO.
DEFINE VARIABLE nvfilepdf AS CHAR.

Data = REPLACE(Data, "\/", "/").
ASSIGN
    // PATH  curl = "https://coreapis-aiu.tmith.net/EPRT/api/PolDocSet/pol64".
    //  cURL = "https://coreapis-aiu.tmith.net/EPRT/api/PolDocSet/pol64".
    System.Net.ServicePointManager:SecurityProtocol = System.Net.SecurityProtocolType:Tls12. 

FIX-CODEPAGE(webResponse) = "UTF-8".
HttpClient = NEW System.Net.WebClient().
//httpClient:headers:ADD("Transfer-Encoding:chunked").
httpClient:headers:ADD("content-type:application/json;charset=utf-8").

//MESSAGE  " 1:"            VIEW-AS ALERT-BOX.   
webResponse = HttpClient:UploadString(curl,data_Re).
HttpClient:Dispose().
DELETE OBJECT HttpClient.
OUTPUT TO "D:\webResponse-NonMotor.txt"  APPEND.
       EXPORT   webResponse . 
OUTPUT CLOSE. 

DEFINE VARIABLE myParser2     AS ObjectModelParser NO-UNDO. 
DEFINE VARIABLE ojson2        AS JsonObject NO-UNDO. 
myParser = NEW ObjectModelParser(). 
//ojson = CAST(myParser:Parse(STRING(webResponse)),JsonObject).
//ojson = CAST(myParser:Parse((webResponse)),JsonObject).
 ojson    = CAST(myParser:Parse((webResponse)),JsonObject). 
 nResult  =      string(ojson:GetJsonText("policyNumber"))  .
// nResult2  =     string(ojson:GetJsonText("class"))  .
  nResult22  =      ojson:GetJsonText("pdfBase64") . 
  nMessage   =     string(ojson:GetJsonText("effectiveDate")) . 
  nResult22  = REPLACE(nResult22,"!UTF-8!","").
  nResult22  = REPLACE(nResult22,"\","").

   //ojson2    = CAST(myParser2:Parse(ojson:GetJsonText("pdfBase64")),JsonObject). 
  DEF VAR nvtxt  AS CHAR FORMAT "x(150)".

//MESSAGE  LENGTH(nResult22) VIEW-AS ALERT-BOX. 
  decdmptr = BASE64-DECODE(nResult22).
  
  // COPY-LOB FROM decdmptr TO FILE "D:\testpin002.pdf". 
    nvfilepdf  = "d:\" + nPolicyNumber + ".pdf".
    COPY-LOB FROM decdmptr TO FILE nvfilepdf . 
/*
MESSAGE 
  " number :" nResult               SKIP 
  " effectiveDate:" nMessage                VIEW-AS ALERT-BOX.   */

RETURN.

END PROCEDURE.
