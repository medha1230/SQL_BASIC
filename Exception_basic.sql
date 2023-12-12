declare
v_name emp.ename%type;
begin
select ename into v_name from emp where deptno=10;
exception when no_data_found then
v_name:=null;
dbms_output.put_line('No data found');
when others then
dbms_output.put_line('Something went wrong!');
dbms_output.put_line('Error code'|| SQLCODE);
dbms_output.put_line('Error message'|| SQLERRM);
end;
/
