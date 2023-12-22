create or replace package medha1 
is
type rec_details is RECORD
(
    department_ID  departments.department_id%type, 
    department_name departments.department_name%type, 
    street_address locations.street_address%type,
    city locations.city%type,
    state_province locations.state_province%type
);
FUNCTION get_details(p_department_id departments.department_id%type) return rec_details;
end;
/



CREATE OR REPLACE PACKAGE BODY medha1 IS
    FUNCTION get_details(p_department_id departments.department_id%type) 
    RETURN rec_details IS
        rec_empInfo rec_details;
    BEGIN
        SELECT department_ID, department_name, street_address, city, state_province
        INTO rec_empInfo
        FROM departments, locations
        WHERE departments.location_id = locations.location_id
          AND department_id = p_department_id;
        RETURN rec_empInfo;

    end;
END;
/
Declare
v_name medha1.rec_details;
begin
v_name:=medha1.get_details(60);
dbms_output.put_line(v_name.city);
end;
/

