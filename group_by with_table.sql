DECLARE
   /*Declare a record TYPE having the structure to store region details*/
   TYPE type_region_detail IS RECORD
   (
      /*fields to store details*/   
      region_id       NUMBER (6),
      region_name        VARCHAR2 (20),
      no_of_countries   number(2)
   );
/*Defining new collection type for storingregions details of type_region_detail type records*/
TYPE type_region IS TABLE OF type_region_detail;
/*declared a collection called col_regions,of type type_region */
col_regions type_region:=type_region();
/*counter for indexing of collection, 
for storing and retrieving values in collection*/
v_index_position NUMBER(2):=1;
BEGIN
  /*fetch all the regions from cursor and store into collection*/
  FOR rec_region IN(  SELECT r.region_id, r.region_name, COUNT (c.country_id) no_of_countries
    FROM regions r, countries c WHERE r.region_id = c.region_id GROUP BY r.region_id, r.region_name)
  LOOP
    /*increase the size of a varray dynamically using the 
    EXTEND inbuild PL/SQL procedure upto defined limit */
    col_regions.EXTEND(1);
    /*store retrieved region name into collection*/
    col_regions(v_index_position).region_id:=rec_region.region_id;
    col_regions(v_index_position).region_name:=rec_region.region_name;
    col_regions(v_index_position).no_of_countries:=rec_region.no_of_countries;
    v_index_position:=v_index_position+1;
  END LOOP;
  /*display all stored region names in collection*/
  FOR v_index IN 1..col_regions.COUNT
  LOOP
    /*Retrieve and display elements in collection using index position*/ 
    dbms_output.put_line('Region ID : '||' '||col_regions(v_index).region_id);
    dbms_output.put_line('Region Name : '||' '||col_regions(v_index).region_name);
    dbms_output.put_line('No. Of Countries : '||' '||col_regions(v_index).no_of_countries);
    dbms_output.put_line('------------------------------------- ');
  END LOOP;
END;
