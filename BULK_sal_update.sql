DECLARE
   TYPE type_emp_details IS TABLE OF NUMBER (6);
  -- A collection to store all employee_ids
   col_emp_details    type_emp_details;
   v_hikepercentage NUMBER (3) := 10;
   -- givinig 10% hike
   v_hike NUMBER (3, 2) := 1 + v_hikepercentage / 100;
  /* salary will be salary(1 + v_hikepercentage/100).
  instead of calculating for every row use this variable to calculate at once
  */
BEGIN
   --use bulk collect retreive collection of senior employees
    SELECT employee_id BULK COLLECT INTO col_emp_details FROM EMPLOYEES
    WHERE TO_NUMBER (TO_CHAR (SYSDATE, 'yyyy')) - TO_NUMBER ( (TO_CHAR (hire_date, 'yyyy'))) >= 25;
   /*FORALL is used to bind all pl/sql values to sql in one context switch
    collection.first .. collection.last though looks like a loop but not a loop.
    Instead, this is used to bind all collection values at once
     save exceptions will save the exception if any and continues the execution*/
   FORALL emp_id IN col_emp_details.FIRST .. col_emp_details.LAST SAVE EXCEPTIONS
      UPDATE employees SET salary = salary * v_hike WHERE employee_id = col_emp_details (emp_id);
 EXCEPTION
   WHEN OTHERS THEN
    --SQL%BULK_EXCEPTIONS.COUNT will return the number of execptions occured during execution of DML statement
      v_error_count := SQL%BULK_EXCEPTIONS.COUNT;
      DBMS_OUTPUT.put_line ('Number Of Exceptions' || v_error_count);
     -- loop to traverse through the collection SQL%BULK_EXCEPTIONS
      FOR i IN 1 .. v_error_count
      LOOP
      -- For every exception in the collection SQL%BULK_EXCEPTIONS (i).ERROR_INDEX will give index value
      -- For every exception in the collection SQLERRM (SQL%BULK_EXCEPTIONS (i).ERROR_CODE) will give error message
         DBMS_OUTPUT.put_line ('Index: '|| SQL%BULK_EXCEPTIONS (i).ERROR_INDEX|| ' Message: '
            || SQLERRM (-SQL%BULK_EXCEPTIONS (i).ERROR_CODE));
      END LOOP;
END;
