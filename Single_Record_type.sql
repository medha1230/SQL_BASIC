declare
    type rec_details is record(
department_ID  departments.department_id%type, 
    department_name departments.department_name%type, 
    street_address locations.street_address%type,
    city locations.city%type,
state_province locations.state_province%type);
rec_detailss rec_details;
v_dept_id departments.department_id%type :=50;
begin
select department_ID,department_name,street_address,city,state_province  into rec_detailss from
departments  , locations  where departments.location_id=locations.location_id and department_id=v_dept_id;
dbms_output.put_line(rec_detailss.department_ID);
dbms_output.put_line(rec_detailss.department_name);
dbms_output.put_line(rec_detailss.street_address);
dbms_output.put_line(rec_detailss.city);
dbms_output.put_line(rec_detailss.state_province);
end;
/

