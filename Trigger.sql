CREATE OR REPLACE TRIGGER trg_emp_sal_log
BEFORE UPDATE OF salary ON employees
FOR EACH ROW
DECLARE
    v_old_sal NUMBER := :old.salary;
    v_new_sal NUMBER := :new.salary;
BEGIN
    INSERT INTO emp_salary_log VALUES (:new.emp_id, systimestamp, v_old_sal, v_new_sal, 'medha');
    -- USER will retrieve the current login database user name
END;
/
UPDATE EMPLOYEES SET SALARY = SALARY*1.1 WHERE JOB_ID = 'AD_ASST';
 select * from emp_salary_log;
