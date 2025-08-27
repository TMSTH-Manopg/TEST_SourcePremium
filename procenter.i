// Procedure  Center  
DEF VAR n_day              AS CHAR INIT "".
DEF VAR n_month            AS CHAR INIT "".
DEF VAR n_year             AS CHAR INIT "".


PROCEDURE pd_cdeci:
    DEF INPUT PARAMETER nv_abol   AS CHAR INIT "".
    DEF INPUT PARAMETER nv_stde   AS CHAR INIT "".
    DEF INPUT PARAMETER nv_ideci  AS DECI INIT 0.
    DEF OUTPUT PARAMETER nv_ochar AS CHAR INIT "".

    IF LOOKUP("B",nv_stde,"|") <> 0  THEN DO:
        IF nv_ideci = 0 THEN nv_ochar = "".
        ELSE DO:
            IF LOOKUP("INT",nv_stde,"|") <> 0 AND nv_ideci - TRUNCATE(nv_ideci,0) = 0  THEN DO:
                IF nv_abol = "A" THEN nv_ochar = TRIM(STRING(ABSOLUTE(nv_ideci),"->>>,>>>,>>>,>>9")).
                ELSE                  nv_ochar = TRIM(STRING(nv_ideci,"->>>,>>>,>>>,>>9")).
            END.
            ELSE DO:
                IF nv_abol = "A" THEN nv_ochar = TRIM(STRING(ABSOLUTE(nv_ideci),"->>>,>>>,>>>,>>9.99")).
                ELSE                  nv_ochar = TRIM(STRING(nv_ideci,"->>>,>>>,>>>,>>9.99")).
            END.
        END.
    END.
    ELSE IF nv_stde = "INT" OR LOOKUP("INT",nv_stde,"|") <> 0 THEN DO:
        IF nv_abol = "A" THEN nv_ochar = TRIM(STRING(ABSOLUTE(nv_ideci),"->>>,>>>,>>>,>>9")).
        ELSE                  nv_ochar = TRIM(STRING(nv_ideci,"->>>,>>>,>>>,>>9")).
    END.
    ELSE DO:
        IF nv_abol = "A" THEN nv_ochar = TRIM(STRING(ABSOLUTE(nv_ideci),"->>>,>>>,>>>,>>9.99")).
        ELSE                  nv_ochar = TRIM(STRING(nv_ideci,"->>>,>>>,>>>,>>9.99")).
    END.

END PROCEDURE .
/////////////////
PROCEDURE pd_matday:
    DEF INPUT  PARAMETER  n_from     AS   CHAR INIT "".             
    DEF INPUT  PARAMETER  n_lang     AS   CHAR INIT "".            
    DEF INPUT  PARAMETER  nv_date    AS   DATE FORMAT "99/99/9999".
    DEF OUTPUT PARAMETER  nv_date1   AS   CHAR . 
    DEF VAR nv_month AS CHAR FORMAT "x(9)" EXTENT 12 .
    DEF VAR thai_month AS   CHAR FORMAT "x(10)" EXTENT 12 INIT 
        ["มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"].
    DEF VAR eng_month AS CHAR FORMAT "x(9)" EXTENT 12 INIT 
        ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY", "AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"].

    IF LENGTH(n_from) > 1  AND nv_date <> ? THEN DO:
        IF SUBSTR(n_from,1,1) = "E" THEN n_from = SUBSTR(n_from,2,1).
        IF DAY(nv_date)   = 29 AND MONTH(nv_date) = 2 THEN DO: 
            ASSIGN
                n_day     = "01"
                n_month   = "03"
                n_year    = string(YEAR(nv_date) + 1,"9999").
        END.
        ELSE DO:
            ASSIGN
                n_day     = string(DAY(nv_date),"99" ) 
                n_month   = string(MONTH(nv_date),"99")
                n_year    = string(YEAR(nv_date) + 1,"9999").
        END.
    END.
    ELSE DO:
        ASSIGN
            n_day     = string(DAY(nv_date),"99" ) 
            n_month   = string(MONTH(nv_date),"99")
            n_year    = string(YEAR(nv_date) ,"9999").
    END.
    IF n_lang = "T" THEN DO:
        ASSIGN 
            n_year   = STRING(INT(n_year) + 543,"9999")
            nv_date1 =  n_day + "/" + n_month + "/" + n_year.
    END.
    ELSE nv_date1 = n_day + "/" + n_month + "/" + n_year.
    CASE n_from:
        WHEN "1" THEN DO:
            CASE n_lang:
                WHEN "T" THEN nv_date1 = n_day  + " "  + thai_month[INTE(n_month)] + " "  + n_year.
                WHEN ""  THEN nv_date1 = n_day  + " "  + eng_month[INTE(n_month)] + " "  + n_year.
            END CASE.
    END.
    WHEN "2" THEN DO:
        CASE n_lang:
            WHEN "T" THEN nv_date1 = n_day  + " "  + thai_month[INTE(n_month)] + " "  + n_year.
            WHEN ""  THEN nv_date1 = eng_month[INTE(n_month)] + " "  + n_day  + ", " + n_year.
        END CASE.
    END.
    WHEN "3" THEN DO:
        CASE n_lang:
            WHEN "" THEN DO: 
                RUN pd_day.
                nv_date1 = n_day + " " + eng_month[INTE(n_month)] + " " + n_year.
            END.
        END CASE.
    END. 
    WHEN "4" THEN DO:
         CASE n_lang:
             WHEN "T" THEN nv_date1 = n_day + "/" + n_month + "/" + n_year.
             WHEN ""  THEN nv_date1 = n_day + "/" + n_month + "/" + n_year.
         END CASE.
    END.
END CASE.
END PROCEDURE.
//////////////////////
PROCEDURE pd_day:
    CASE n_day:
        WHEN "01" THEN n_day = "1st" .
        WHEN "02" THEN n_day = "2nd" .
        WHEN "03" THEN n_day = "3rd" .
        WHEN "11" THEN n_day = "11th".
        WHEN "12" THEN n_day = "12th".
        WHEN "13" THEN n_day = "13th".
        WHEN "21" THEN n_day = "21st".
        WHEN "22" THEN n_day = "22nd".
        WHEN "23" THEN n_day = "23rd".
        WHEN "31" THEN n_day = "31st".
        OTHERWISE n_day = n_day + "th".
    END CASE.
END PROCEDURE.
