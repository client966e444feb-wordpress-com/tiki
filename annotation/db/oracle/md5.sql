CREATE OR REPLACE FUNCTION md5(input_string IN VARCHAR2) RETURN VARCHAR2
IS
	retval varchar2(32);
BEGIN
 	SELECT RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => input_string)) INTO retval FROM dual;
 	RETURN retval;
END;
