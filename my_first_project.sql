create OR REPLACE PACKAGE  pkg_TravelBooking IS
    PROCEDURE Booking(
        p_user_id letsgo_users.user_id%TYPE,
        p_vehicle_id vehicle.vehicle_id%TYPE,
        NO_OF_ADULTS NUMBER,
        NO_OF_CHILDREN NUMBER
    );
    PROCEDURE CancelBooking(
       p_user_id  letsgo_users.user_id%TYPE,
       p_reservation_id reservation.reservation_id%type,
       v_status OUT number
    );
    TYPE vehicleDetails_tab IS TABLE OF VEHICLE%ROWTYPE;
    FUNCTION sf_RetrieveVehicleDetails(
        p_start_point vehicle.from_stn%type,
        p_destination vehicle.to_stn%type,
        p_departure_time vehicle.departure_time%type
        ) return vehicleDetails_tab;
end;

CREATE OR REPLACE PACKAGE BODY pkg_TravelBooking IS
    FUNCTION CalculateFare(
        p_vehicle_id vehicle.vehicle_id%TYPE,
        p_NO_OF_ADULTS NUMBER,
        p_NO_OF_CHILDREN NUMBER
    ) RETURN DECIMAL IS
        v_total_fare DECIMAL;
        v_adult_fare vehicle.adult_fare%TYPE;
        v_child_fare vehicle.child_fare%TYPE;
    BEGIN
        SELECT adult_fare, child_fare
        INTO v_adult_fare, v_child_fare
        FROM vehicle
        WHERE vehicle_id = p_vehicle_id;

        v_total_fare := (p_NO_OF_ADULTS * v_adult_fare) + (p_NO_OF_CHILDREN * v_child_fare);
        RETURN v_total_fare;
    END CalculateFare;

    PROCEDURE Booking(
        p_user_id letsgo_users.user_id%TYPE,
        p_vehicle_id vehicle.vehicle_id%TYPE,
        NO_OF_ADULTS NUMBER,
        NO_OF_CHILDREN NUMBER
    ) IS
        v_total_fare DECIMAL;
        v_AVAILABLE_SEATS vehicle.AVAILABLE_SEATS%TYPE;
    BEGIN
        SELECT AVAILABLE_SEATS
        INTO v_AVAILABLE_SEATS
        FROM vehicle
        WHERE vehicle_id = p_vehicle_id;

        IF v_AVAILABLE_SEATS IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Sorry! No seats are available.');
        ELSE
            v_total_fare := CalculateFare(p_vehicle_id, NO_OF_ADULTS, NO_OF_CHILDREN);
            DBMS_OUTPUT.PUT_LINE('The total fare is ' || v_total_fare);
            INSERT INTO reservation
            VALUES (seq_ReservationId.NEXTVAL, p_user_id, p_vehicle_id, NO_OF_ADULTS, NO_OF_CHILDREN, 'CNF');
            DBMS_OUTPUT.PUT_LINE('The Reservation Id is ' || seq_ReservationId.CURRVAL || ' The total fare is ' || v_total_fare);
        END IF;
    END Booking;
PROCEDURE CancelBooking(
       p_user_id  letsgo_users.user_id%TYPE,
       p_reservation_id reservation.reservation_id%type,
       v_status OUT number 
    ) IS
         v_reservation_id reservation.reservation_id%type;
         v_user_id reservation.user_id%type;
    BEGIN
        if p_user_id is null then
        v_status:=-1;
        elsif p_reservation_id is null then 
            v_status:=-2;
       else
       select reservation_id, user_id into v_reservation_id  ,v_user_id from reservation 
        where reservation_id=p_reservation_id and user_id=p_user_id;
                  IF v_reservation_id IS NOT NULL AND v_user_id IS NOT NULL THEN
                  update reservation set status='CAN' WHERE reservation_id = p_reservation_id AND user_id = p_user_id;
                   v_status := 0; -- success
                   end if;
end if;
EXCEPTION when no_data_found THEN
DBMS_OUTPUT.PUT_LINE('v_status is -3');
when others THEN
DBMS_OUTPUT.PUT_LINE('Something went wrong!!!');
END;

    FUNCTION sf_RetrieveVehicleDetails(
        p_start_point vehicle.from_stn%type,
        p_destination vehicle.to_stn%type,
        p_departure_time vehicle.departure_time%type
        ) return vehicleDetails_tab
        IS
        v_asso vehicleDetails_tab;
    BEGIN
        select * bulk collect into v_asso from vehicle where from_stn=p_start_point and 
        to_stn=p_destination and departure_time=p_departure_time;
       return v_asso;
        end;
END pkg_TravelBooking;
CREATE OR REPLACE TRIGGER trg_cancellation
AFTER UPDATE Of AVAILABLE_SEATS ON VEHICLE
FOR EACH ROW
DECLARE
  v_vehicle_id VEHICLE.vehicle_id%TYPE;
  V_AVAILABLE_SEAT VEHICLE.AVAILABLE_SEATS%TYPE;
BEGIN
  -- Get the vehicle ID and number of reserved seats from the deleted row
  v_vehicle_id := :old.vehicle_id;
  V_AVAILABLE_SEAT := :old.AVAILABLE_SEATS;

  -- Update the available seats in the vehicle table
  UPDATE vehicle
  SET available_seats = available_seats + V_AVAILABLE_SEAT
  WHERE vehicle_id = v_vehicle_id;
END;
   
select * from vehicle;
DECLARE
  v_status number; -- declare output variable
BEGIN
  -- call the procedure using positional notation
  pkg_TravelBooking.CancelBooking(2,7023,v_status); 
  -- display the output variable
  DBMS_OUTPUT.PUT_LINE('The status is ' || v_status); 
END;
declare
    v_asso pkg_TravelBooking.vehicleDetails_tab;
v_vehicle_details vehicle%rowtype;
    begin
  v_asso:=pkg_TravelBooking.sf_RetrieveVehicleDetails('CHENNAI', 'MYSORE',10);
for i in v_asso.first..v_asso.last
    loop
    v_vehicle_details:=v_asso(i);
    dbms_output.put_line('The vehicle id is'||' '||v_vehicle_details.vehicle_id);
     DBMS_OUTPUT.PUT_LINE('Vehicle Type: ' || v_vehicle_details.vehicle_type);
    DBMS_OUTPUT.PUT_LINE('Capacity: ' || v_vehicle_details.from_stn);
    DBMS_OUTPUT.PUT_LINE('Departure Time: ' || v_vehicle_details.to_stn);
    DBMS_OUTPUT.PUT_LINE('Departure Time: ' || v_vehicle_details.departure_time);
    DBMS_OUTPUT.PUT_LINE('Departure Time: ' || v_vehicle_details.arrival_time);
    DBMS_OUTPUT.PUT_LINE('-----------------');

end loop;
end;
select *  from vehicle; where reservation_id=7002 and user_id=1;
