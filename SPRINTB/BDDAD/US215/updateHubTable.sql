
CREATE OR REPLACE PROCEDURE prc_update_hub_table (input_info IN VARCHAR2)
IS

   CURSOR c_lines_of_file IS    SELECT REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) AS parts
                                FROM dual
                                CONNECT BY REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) IS NOT NULL;
    li_count number;
    li_line VARCHAR2(1000);
    li_count_line number;
    li_is_number number;

    li_id varchar2(25);
    li_lat number;
    li_lng number;
    li_entity varchar2(25);

BEGIN

    SELECT COUNT(REGEXP_SUBSTR(input_info, '[^ ]+', 1, level))
    INTO li_count
    FROM dual
    CONNECT BY REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) IS NOT NULL;

    DBMS_OUTPUT.PUT_LINE(li_count);

    IF(li_count<>0) THEN
        OPEN c_lines_of_file;

        li_count_line:=0;

        LOOP
            FETCH c_lines_of_file INTO li_line;
            EXIT WHEN c_lines_of_file%notfound;

            DBMS_OUTPUT.PUT_LINE(li_line);

            IF(li_count_line<>0) THEN

                SELECT REGEXP_SUBSTR(li_line, '[^;]+', 1, 4) INTO li_entity
                FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                DBMS_OUTPUT.PUT_LINE(li_entity);

                SELECT SUBSTR(li_entity, 1, 1) INTO li_entity FROM DUAL;

                DBMS_OUTPUT.PUT_LINE(li_entity);

                IF(li_entity!='C')THEN

                SELECT REGEXP_SUBSTR(li_line, '[^;]+', 1, 1) INTO li_id
                FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                SELECT TO_NUMBER(REGEXP_SUBSTR(li_line, '[^;]+', 1, 2)) INTO li_lat
                FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                SELECT TO_NUMBER(REGEXP_SUBSTR(li_line, '[^;]+', 1, 3)) INTO li_lng
                FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                DBMS_OUTPUT.PUT_LINE(li_id);
                DBMS_OUTPUT.PUT_LINE(li_lat);
                DBMS_OUTPUT.PUT_LINE(li_lng);

                INSERT INTO Hub(ID_Hub_pk,lat_Hub,lang_Hub) VALUES (li_id,li_lat,li_lng);

                END IF;

            END IF;

            li_count_line:=li_count_line+1;


        END LOOP;
        CLOSE c_lines_of_file;

    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');
    END IF;

EXCEPTION

    WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('A latitude ou longitude estão no formato errado!');


    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Algo correu mal!');
END;
















create table Hub (
    ID_Hub_pk varchar2(25)  not null,
    lat_Hub   number(10,4) not null,
    lang_Hub  number(10,4) not null,
    primary key (ID_Hub_pk));

CREATE OR REPLACE FUNCTION fnc_verify_hub (string IN VARCHAR2)
   RETURN INT
IS
   num NUMBER;
BEGIN
   SELECT COUNT(*) INTO num FROM Hub WHERE ID_HUB_PK LIKE string;
   RETURN num;
END;

CREATE OR REPLACE PROCEDURE prc_update_hub_table (input_info IN VARCHAR2)
IS

   CURSOR c_lines_of_file IS    SELECT REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) AS parts
                                FROM dual
                                CONNECT BY REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) IS NOT NULL;
    li_count number;
    li_line VARCHAR2(1000);
    li_count_line number;
    li_exists number;

    li_id varchar2(25);
    li_lat number;
    li_lng number;
    li_entity varchar2(25);

BEGIN

    SELECT COUNT(REGEXP_SUBSTR(input_info, '[^ ]+', 1, level))
    INTO li_count
    FROM dual
    CONNECT BY REGEXP_SUBSTR(input_info, '[^ ]+', 1, level) IS NOT NULL;

    IF(li_count<>0) THEN
        OPEN c_lines_of_file;

        li_count_line:=0;

        LOOP
            FETCH c_lines_of_file INTO li_line;
            EXIT WHEN c_lines_of_file%notfound;

            IF(li_count_line<>0) THEN

                SELECT REGEXP_SUBSTR(li_line, '[^;]+', 1, 4) INTO li_entity
                FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                SELECT SUBSTR(li_entity, 1, 1) INTO li_entity FROM DUAL;

                IF(li_entity!='C')THEN

                    SELECT LTRIM(REGEXP_SUBSTR(li_line, '[^;]+', 1, 1),CHR (10)) INTO li_id
                    FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                    SELECT TO_NUMBER(REGEXP_SUBSTR(li_line, '[^;]+', 1, 2)) INTO li_lat
                    FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                    SELECT TO_NUMBER(REGEXP_SUBSTR(li_line, '[^;]+', 1, 3)) INTO li_lng
                    FROM dual CONNECT BY REGEXP_SUBSTR('i,i,i,i', '[^,]+',4, 4) IS NOT NULL;

                   li_exists:=fnc_verify_hub(li_id);

                    IF(li_exists=0) THEN

                        INSERT INTO Hub(ID_Hub_pk,lat_Hub,lang_Hub) VALUES (li_id,li_lat,li_lng);

                    ELSE

                        UPDATE Hub SET lat_Hub=li_lat,lang_Hub=li_lng WHERE ID_Hub_pk LIKE li_Id;

                    END IF;

                END IF;

            END IF;

            li_count_line:=li_count_line+1;


        END LOOP;
        CLOSE c_lines_of_file;

    ELSE
     DBMS_OUTPUT.PUT_LINE('Não foram encontrados dados!');
    END IF;

EXCEPTION

    WHEN INVALID_NUMBER THEN
    DBMS_OUTPUT.PUT_LINE('A latitude ou longitude estão no formato errado! Nada foi inserido, tente novamente...');


END;


call prc_update_hub_table ('Loc id;lat;lng;Clientes-Produtores
CT1;40.6389;2;C1
CT2;38.0333;-7.8833;C2
CT14;38.5243;-8.8926;E1
CT11;39.3167;1123;E2
CT10;39.7444;-8.8072;P3');

SELECT * FROM HUB;

DELETE FROM HUB WHERE Id_hub_pk LIKE 'CT14';

DELETE FROM HUB WHERE Id_hub_pk LIKE 'CT11';

DELETE FROM HUB WHERE Id_hub_pk LIKE 'CT10';



