create or replace function sf_get_emp_id_by_deptid(p_dept_id dept.deptno%type)
return number
    is 
    v_empno emp.empno%type;
   v_status number;
v_count number;
begin
select count(empno) into v_count from emp where deptno=p_dept_id;
if (v_count >2 and v_count <3)then 
    v_status:=-2;
return v_status;
    elsif v_count >3 then
    v_status:=-3;
return v_status;
elsif v_count =1 then
    select empno into v_empno from emp where  deptno=p_dept_id;
    return v_empno;
else
dbms_output.put_line('something went wrong');
end if;
end;
/
