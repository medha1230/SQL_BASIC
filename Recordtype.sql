DECLARE
    TYPE rec_details IS RECORD (
        emp employees.employee_id%TYPE,
        job jobs.job_title%TYPE,
        depart employees.department_id%TYPE,
        sal employees.salary%TYPE
    );
    rec_emp_details rec_details;
    CURSOR medha IS
        SELECT  employee_id, job_title, department_id, salary
        FROM employees e
        JOIN jobs j ON e.job_id = j.job_id
        ORDER BY salary DESC;
BEGIN
    OPEN medha;
    LOOP
        FETCH medha INTO rec_emp_details;
        EXIT WHEN medha%ROWCOUNT > 3;

        -- Explicit conversion of salary to a string
        dbms_output.put_line('Employee ID: ' || rec_emp_details.emp);
        dbms_output.put_line('Job Title: ' || rec_emp_details.job);
        dbms_output.put_line('Department: ' || rec_emp_details.depart);
        dbms_output.put_line('Salary: ' || rec_emp_details.sal);
        dbms_output.put_line('...........................');
    END LOOP;
    CLOSE medha;
END;
/
