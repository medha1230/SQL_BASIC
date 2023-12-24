DECLARE
   TYPE type_EMS_roles IS TABLE OF VARCHAR2 (25);
   col_EMS_roles type_EMS_roles:= type_EMS_roles ('Employee','Adviser','Manager','HR Manager');
   v_index_position   NUMBER (2) := col_EMS_roles.FIRST;
BEGIN
   
   col_EMS_roles.DELETE (2);
   WHILE (v_index_position IS NOT NULL AND col_EMS_roles.LAST >= v_index_position)
   LOOP
        dbms_output.put_line(v_index_position);
      DBMS_OUTPUT.put_line (col_EMS_roles (v_index_position));
     v_index_position := col_EMS_roles.NEXT (v_index_position);
    dbms_output.put_line(col_EMS_roles(1));
   END LOOP;
END;
/
