create or replace PACKAGE pkg_emp_details IS
TYPE v_type_employee_id is table of employees.employee_id%type;
FUNCTION get_details(p_department_id departments.department_id%type) 
RETURN v_type_employee_id;
PROCEDURE update_salary(p_table v_type_employee_id);
end;
create or replace PACKAGE body pkg_emp_details IS
FUNCTION get_details(p_department_id departments.department_id%type) 
RETURN v_type_employee_id
IS
    v_asso_table v_type_employee_id :=v_type_employee_id();
BEGIN
    select employee_id bulk collect into v_asso_table from employees where department_id=p_department_id;
    return v_asso_table;
end;
PROCEDURE update_salary(p_table v_type_employee_id)
IS
BEGIN
FORALL i in p_table.first..p_table.last
update employees set salary=salary+2000 where employee_id=p_table(i);
commit;
end;
end;
DECLARE
my_collection pkg_emp_details.v_type_employee_id;
BEGIN
my_collection:=	pkg_emp_details.get_details(90);
pkg_emp_details.update_salary(my_collection);
end;
drop trigger TRG_EMP_SAL_LOG;
select salary from employees where department_id=90;
