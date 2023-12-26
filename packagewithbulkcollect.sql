create or replace PACKAGE p_emp_details
    AS
    TYPE employee_id_type is table of number;
--c_employee_id_type employee_id_type:=employee_id_type();
 function medha1(p_manager_id employees.manager_id%type) return employee_id_type;
end;

create or replace PACKAGE body p_emp_details 
AS
 function medha1(p_manager_id employees.manager_id%type) return employee_id_type
IS
    c_employee_id_type employee_id_type;
BEGIN
select employee_id BULK COLLECT INTO c_employee_id_type from employees where manager_id=p_manager_id;
return c_employee_id_type;
end;
end;

Declare
     v_col p_emp_details.employee_id_type;
BEGIN
v_col:=p_emp_details.medha1(103);
FOR i in v_col.first..v_col.last
    loop
dbms_output.put_line(v_col(i));
end loop;
end;




