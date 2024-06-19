CREATE OR REPLACE PROCEDURE Main1 (
    p_sgm_id IN ServiceGiver.SGM_id%TYPE,
    p_member_id IN Cmember.M_id%TYPE,
    p_new_email IN Cmember.m_mail%TYPE,
    p_new_phone IN Cmember.m_phone%TYPE
) AS
    v_cursor SYS_REFCURSOR;
    v_day_of_week Times.T_dayOfWeek%TYPE;
    v_start_time Times.T_startTime%TYPE;
    v_end_time Times.T_endTime%TYPE;
    v_constraints Times.T_constraints%TYPE;
BEGIN
    -- Set the buffer size for DBMS_OUTPUT to a larger value (e.g., 1,000,000 bytes)
    DBMS_OUTPUT.ENABLE(1000000);

    -- Call the function to fetch service giver availability for a specific SGM_id
    v_cursor := GET_SERVICE_GIVER_AVAILABILITY(p_sgm_id);

    -- Print header for service giver availability
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('| Day of Week | Start Time | End Time | Constraints |');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');

    -- Fetch and print each row from the cursor
    LOOP
        FETCH v_cursor INTO v_day_of_week, v_start_time, v_end_time, v_constraints;
        EXIT WHEN v_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('| ' || RPAD(v_day_of_week, 12) || ' | ' ||
                             RPAD(v_start_time, 10) || ' | ' ||
                             RPAD(v_end_time, 8) || ' | ' ||
                             RPAD(v_constraints, 12) || ' |');
    END LOOP;

    -- Close the cursor after fetching all rows
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('');
    -- Call the procedure to update member details
    update_member_details(p_member_id, p_new_email, p_new_phone);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END Main1;
/
