Declare
type v_asso is table of employees.employee_id%type;
v_empno v_asso;
sorry_didnt_found exception;
begin
select employee_id bulk collect into v_empno from employees where hire_date between  '01-JAN-99' and sysdate;
if v_empno is null then
    raise sorry_didnt_found;
end if;
for i in v_empno.first .. v_empno.last
    loop
dbms_output.put_line(v_empno(i));
end loop;
exception
when sorry_didnt_found then
dbms_output.put_line('Sorry didnt found!!!');
end ;
