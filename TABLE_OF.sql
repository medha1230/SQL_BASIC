declare
type type_emp_names is table of employees.first_name%type;
col_names type_emp_names:=type_emp_names();
v_counter pls_integer:=0;
begin
    col_names.extend(10);
for i in (select first_name from employees)
loop
col_names.extend(1);
v_counter:=v_counter+1;
col_names(v_counter):=i.first_name;
end loop;
dbms_output.put_line(col_names(1));
end;
/



