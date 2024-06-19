CREATE OR REPLACE PROCEDURE Main2 AS
    v_cursor SYS_REFCURSOR;
    v_service_giver_id ServiceGiver.SGM_id%TYPE;
    v_average_rating NUMBER;
BEGIN
    -- Set the buffer size for DBMS_OUTPUT to a larger value (e.g., 1,000,000 bytes)
    DBMS_OUTPUT.ENABLE(1000000);

    -- Call the function to fetch service giver ratings
    v_cursor := get_service_giver_ratings;

    -- Print header for service giver ratings
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    DBMS_OUTPUT.PUT_LINE('| Service Giver ID | Average Rating   |');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');

    -- Fetch and print each row from the cursor
    LOOP
        FETCH v_cursor INTO v_service_giver_id, v_average_rating;
        EXIT WHEN v_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('| ' || RPAD(v_service_giver_id, 17) || ' | ' ||
                             RPAD(TO_CHAR(v_average_rating, '99990.99'), 15) || ' |');
    END LOOP;

    -- Close the cursor after fetching all rows
    CLOSE v_cursor;

    -- Call the procedure to calculate community statistics
    calculate_community_statistics;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END Main2;
/
