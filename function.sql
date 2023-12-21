Declare
v_name number;
begin
v_name:=sf_get_max_salary(30);
dbms_output.put_line(v_name);
end;
/create or replace function sf_get_max_salary(v_deptno emp.deptno%type)
    return number IS
v_max number;
begin
select max(sal) into v_max from emp group by deptno=v_deptno;
return v_max;
end;
/
