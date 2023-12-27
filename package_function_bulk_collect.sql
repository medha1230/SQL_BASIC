create or replace package pkg_details
IS
      type v_asso is table of number;
function medha2(p_location_id departments.location_id%type)
return v_asso;
end;
create or replace package body pkg_details IS 
  function medha2(p_location_id departments.location_id%type)
return v_asso
IS
    v_id v_asso;
Begin
select department_id bulk collect into v_id  from departments where location_id=p_location_id;
IF(v_id.COUNT=0) THEN
DBMS_OUTPUT.put_line('No departments in the location');
RETURN NULL;
END IF;
return v_id;
end;
end;
declare
v_id pkg_details.v_asso;
begin
v_id:=pkg_details.medha2(1700);
for i in v_id.first .. v_id.last
loop
dbms_output.put_line(v_id(i));
end loop;
end;
