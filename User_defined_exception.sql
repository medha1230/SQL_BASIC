Declare
v_emp_id emp.empno%type;
v_salary emp.sal%type;
emp_loan_eligibilty exception;
begin
select sal into v_salary from emp where empno=7839;
if v_salary<60000 then
raise emp_loan_eligibilty;
else 
dbms_output.put_line('He is eligible for loan');
end if;
exception when emp_loan_eligibilty then
dbms_output.put_line('He is not eligible for loan');
when others then
dbms_output.put_line('Something went wrong!');
dbms_output.put_line('ERROR CODE'|| SQLCODE);
dbms_output.put_line('ERROR MESSAGE' || SQLERRM);
end;
/
