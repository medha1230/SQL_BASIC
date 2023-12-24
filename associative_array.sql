DECLARE
    TYPE v_asso_department IS TABLE OF departments.department_name%type  INDEX BY PLS_INTEGER;
v_asso v_asso_department;
v_key number;
CURSOR  cur is
SELECT department_id,department_name from DEPARTMENTS;
BEGIN
FOR I IN CUR
loop
v_asso(i.department_id):=i.department_name;
dbms_output.put_line(v_asso.last ||'    '|| v_asso(i.department_id));
end loop;
/*v_key := v_asso.FIRST;
   WHILE (v_key!=0)
   LOOP
      DBMS_OUTPUT.PUT_LINE (v_key || ' : ' || v_asso(v_key));
      v_key := v_asso.NEXT (v_key);
   END LOOP;*/
END;

/

