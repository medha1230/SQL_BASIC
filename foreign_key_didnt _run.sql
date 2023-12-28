create or replace PACKAGE pkg_job_id IS
TYPE job_nested_table_structure IS RECORD(
    employee_id employees.employee_id%type,
    email employees.email%type,
    new_job_id employees.job_id%type
);
TYPE v_job_nested_table_structure is table of job_nested_table_structure;
PROCEDURE get_details(p_table v_job_nested_table_structure);
end;
create or replace PACKAGE BODY pkg_job_id  IS
    PROCEDURE get_details(p_table v_job_nested_table_structure)
    IS
    BEGIN
    FORALL i IN p_table.FIRST..p_table.LAST 
    UPDATE employees set job_id=p_table(i).new_job_id where 

    commit;
end;
end;

DECLARE
v_nested_table pkg_job_id.v_job_nested_table_structure:=pkg_job_id.v_job_nested_table_structure();
BEGIN
v_nested_table.EXTEND();
v_nested_table(1).employee_id:=110;
v_nested_table(1).EMAIL:='JCHEN';
v_nested_table(1).NEW_JOB_ID:='FL_MGR';
v_nested_table.EXTEND();
v_nested_table(2).employee_id:=112;
v_nested_table(2).EMAIL:='JMURMAN';
v_nested_table(2).NEW_JOB_ID:='FL_MGR';
pkg_job_id.GET_DETAILS(v_nested_table);
END; 
drop trigger TRG_EMP_SAL_LOG;
select * from employees where employee_id=110;
select * from jobs;
