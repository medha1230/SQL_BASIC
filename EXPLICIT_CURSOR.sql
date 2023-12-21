DECLARE
  --declaring a cursor
  CURSOR cur_emp_in_dept
  IS
    SELECT employee_id,salary,hire_date FROM employees WHERE department_id=20 ;
  --declaring variables to retrieve the value 
  v_emp_id employees.employee_id%TYPE;
  v_salary employees.salary%TYPE;
  v_hire_date employees.hire_date%TYPE;
BEGIN
  --cursor is opened
  OPEN cur_emp_in_dept;
  --loop for fetching multiple rows
  LOOP
    --retrieving the values using FETCH statement into the variables 
    FETCH cur_emp_in_dept INTO v_emp_id,v_salary,v_hire_date;
   --Exit condition for loop
    EXIT
  WHEN cur_emp_in_dept%NOTFOUND;
    DBMS_OUTPUT.put_line ('Employee ID: ' || v_emp_id);
    DBMS_OUTPUT.put_line ('Salary: ' || v_salary);
    DBMS_OUTPUT.put_line ('Joining date: ' || v_hire_date);
    DBMS_OUTPUT.put_line ('----------------------------');
  END LOOP;
  --cursor is closed 
  CLOSE cur_emp_in_dept;
END;
