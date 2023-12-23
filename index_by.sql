DECLARE
   CURSOR cur_MaxSal_Dep IS
      (SELECT department_name, MAX (salary) max_sal FROM employees e, departments d
          WHERE e.department_id = d.department_id GROUP BY department_name);
   /*Defining new collection type for storing max. salary
   and to be retrieved using department name as index*/
   TYPE type_MaxSal_Dep IS TABLE OF NUMBER (8, 2)
      INDEX BY departments.department_name%TYPE;
   /*declared a collection called col_MaxSal_Dep,of type type_MaxSal_Dep */
   col_MaxSal_Dep   type_MaxSal_Dep;
BEGIN
   /*fetch all the department names and their respective
   highest salary from cursor and store into collection*/
   FOR rec_deps IN cur_MaxSal_Dep
   LOOP
      /*In associative array assigning a value on particular index for the first time it adds
      that to the colllection.Here index (department_name)is key and max_sal is value*/
      col_MaxSal_Dep (rec_deps.department_name) := rec_deps.max_sal;
   END LOOP;
   /*Retrieve and display elements in collection using key*/
   DBMS_OUTPUT.put_line (col_MaxSal_Dep ('Administration'));
   DBMS_OUTPUT.put_line (col_MaxSal_Dep ('Marketing'));
   DBMS_OUTPUT.put_line (col_MaxSal_Dep ('Purchasing'));
/*similarly other departments details added to the collection, can be retrieved using key*/
END;
