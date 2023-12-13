DECLARE
  v_job_id jobs.job_id%TYPE       := 'CLERK';
  v_min_sal jobs.min_salary%TYPE  :=5000;
  v_max_sal jobs.max_salary%TYPE  :=12000;
  e_null EXCEPTION;
  PRAGMA EXCEPTION_INIT (e_null, -01400);
BEGIN
  INSERT INTO jobs(job_id,min_salary,max_salary) VALUES(v_job_id, v_min_sal,v_max_sal);
EXCEPTION
WHEN e_null THEN
  DBMS_OUTPUT.PUT_LINE ( 'Cannot insert null value to the column with not null constraint');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE ('Something went wrong!!');
  DBMS_OUTPUT.PUT_LINE ('Error Code: ' || SQLCODE);
  DBMS_OUTPUT.PUT_LINE ('Error Message: ' || SQLERRM);
END;
