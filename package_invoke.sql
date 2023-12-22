declare
v_status boolean;
begin
v_status:=medha.sf_tax_eligibility(107);
dbms_output.put_line('Result: ' || CASE WHEN v_status THEN 'TRUE' ELSE 'FALSE' END);
END;
/
