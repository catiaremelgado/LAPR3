CREATE OR REPLACE FUNCTION fnc_testar_tipo_numero (string IN VARCHAR2)
   RETURN INT
IS
   li_date DATE;
BEGIN
   li_date := TO_DATE(string, 'dd/mm/yyyy');
   RETURN 1;
EXCEPTION
WHEN OTHERS THEN
   RETURN 0;
END;