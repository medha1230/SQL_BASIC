declare 
v_salary emp.sal%type;
v_comm emp.comm%type;
v_mgr emp.mgr%type;
e_home_elibility exception;
begin
select comm into v_comm from emp where ename ='KING';
select sal into v_salary from emp where ename='SCOTT' or comm=v_comm;
dbms_output.put_line(v_salary);
if v_salary <8000 then
    raise e_home_elibility;
end if;
exception
     when  no_data_found then
    dbms_output.put_line('NO data');
v_salary:=null;
    when e_home_elibility then
      dbms_output.put_line('NOt eligible');
when others then
     dbms_output.put_line('Something went wrong');
 dbms_output.put_line('Error code'|| SQLCODE);
 dbms_output.put_line('Error Message'|| SQLERRM);
end;
/
