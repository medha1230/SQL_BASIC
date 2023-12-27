Declare
type v_array is table of varchar2(30);
v_name v_array;
begin
    select first_name bulk collect into v_name from employees;
for i in v_name.first ..v_name.last 
    loop
    dbms_output.put_line(v_name(i));
end loop;
end;
/
