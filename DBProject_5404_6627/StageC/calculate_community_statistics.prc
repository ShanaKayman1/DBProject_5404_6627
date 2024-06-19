CREATE OR REPLACE PROCEDURE calculate_community_statistics IS
    CURSOR c_communities IS
        SELECT C_id, C_name
        FROM Community;

    v_community_id Community.C_id%TYPE;
    v_community_name Community.C_name%TYPE;
    v_total_members NUMBER;
    v_average_kids_per_community NUMBER;
BEGIN
    -- Set the buffer size for DBMS_OUTPUT to a larger value (e.g., 1,000,000 bytes)
    DBMS_OUTPUT.ENABLE(1000000);
    -- Open the cursor for Communities
    OPEN c_communities;

    -- Print header for the table-like format
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('| Community ID | Community Name | Total Members | Avg. # of Kids |');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');

    -- Loop through each Community
    LOOP
        FETCH c_communities INTO v_community_id, v_community_name;
        EXIT WHEN c_communities%NOTFOUND;

        -- Calculate total members in the current Community
        SELECT COUNT(cm.M_id)
        INTO v_total_members
        FROM CommunityMember cm
        WHERE cm.C_id = v_community_id;

        -- Calculate average number of kids per Yoledet in the current Community
        SELECT ROUND(AVG(NVL(y.y_numofchildern, 0)),1)  -- Handle NULL values with NVL
        INTO v_average_kids_per_community
        FROM Yoledet y
        JOIN Cmember m ON y.YM_id = m.M_id
        JOIN CommunityMember cm ON m.M_id = cm.M_id
        WHERE cm.C_id = v_community_id;

        -- Output Community statistics in table format
        DBMS_OUTPUT.PUT_LINE('| ' || RPAD(v_community_id, 13) || ' | ' ||
                             RPAD(v_community_name, 15) || ' | ' ||
                             RPAD(v_total_members, 13) || ' | ' ||
                             RPAD(NVL(v_average_kids_per_community, 0), 25) || ' |');
    END LOOP;

    -- Close the cursor
    CLOSE c_communities;

    -- Print footer for the table-like format
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No communities found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        CLOSE c_communities; -- Close cursor in case of error
END calculate_community_statistics;
/
