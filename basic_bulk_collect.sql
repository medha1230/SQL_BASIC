declare
type v_array is table of regions.region_name%type;
v_name v_array;
begin
select region_name bulk collect into v_name from regions;
for i in v_name.first..v_name.last
    loop
dbms_output.put_line(v_name(i));
end loop;
end;
/
