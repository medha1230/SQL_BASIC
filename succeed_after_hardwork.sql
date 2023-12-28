create or replace PACKAGE pkg_job_details is
  TYPE v_nested_table IS TABLE OF jobs%ROWTYPE;
FUNCTION job_details return v_nested_table;
procedure get_details;
end;
create or replace PACKAGE body pkg_job_details is
    FUNCTION job_details return v_nested_table
    IS
  v_nested_table_variable v_nested_table := v_nested_table();
BEGIN
  v_nested_table_variable.EXTEND();
  v_nested_table_variable(1).job_id := 'SL_MAN';
  v_nested_table_variable(1).job_title := 'SALES_PERSON';
  v_nested_table_variable(1).min_salary := 96666;
  v_nested_table_variable(1).max_salary := 20000;
  
  v_nested_table_variable.EXTEND();
  v_nested_table_variable(2).job_id := 'SL_MAN_p';
  v_nested_table_variable(2).job_title := 'SALES_PERSON';
  v_nested_table_variable(2).min_salary := 96666;
  v_nested_table_variable(2).max_salary := 20000;
  return v_nested_table_variable;
END;
procedure get_details
    IS
my_collection v_nested_table;
BEGIN
    my_collection:=job_details();
FORALL i in my_collection.first..my_collection.last
    insert into jobs values(my_collection(i).job_id,my_collection(i).job_title,my_collection(i).min_salary,
    my_collection(i).max_salary);
commit;
end;
end;
declare
begin
pkg_job_details.get_details;
end;
select * from jobs;
