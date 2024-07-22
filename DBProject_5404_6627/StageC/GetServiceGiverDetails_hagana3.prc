CREATE OR REPLACE PROCEDURE GetServiceGiverDetails(
    yoledetID IN NUMBER,
    dayOfWeek IN VARCHAR2,
    startTime IN VARCHAR2,
    endTime IN VARCHAR2,
    serviceType IN VARCHAR2
)
AS
    communityID NUMBER;
    serviceGiverID NUMBER;
    alternativeServiceGiverID NUMBER;
    errorMsg VARCHAR2(4000);
    sgPrice NUMBER;
    sgDetails VARCHAR2(4000);
    notFound EXCEPTION;
    v_cursor SYS_REFCURSOR;
    v_day_of_week Times.T_dayOfWeek%TYPE;
    v_start_time Times.T_startTime%TYPE;
    v_end_time Times.T_endTime%TYPE;
    v_constraints Times.T_constraints%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    
    -- Get the community ID of the given Yoledet
    SELECT CM.C_id INTO communityID
    FROM CommunityMember CM
    JOIN Yoledet Y ON CM.M_id = Y.yM_id
    WHERE Y.yM_id = yoledetID
    FETCH FIRST ROW ONLY;

    -- Find a matching ServiceGiver in the same community
    BEGIN
        SELECT SG.sgM_id INTO serviceGiverID
        FROM ServiceGiver SG
        JOIN CommunityMember CM ON SG.sgM_id = CM.M_id
        JOIN Times T ON SG.sgM_id = T.sgM_id
        WHERE CM.C_id = communityID
          AND T.T_dayofweek = dayOfWeek
          AND T.T_starttime <= startTime
          AND T.T_endtime >= endTime
          AND (
              (serviceType = 'Babysitting' AND SG.sgM_id IN (SELECT sgM_id FROM Babysitting))
              OR
              (serviceType = 'Cleaning' AND SG.sgM_id IN (SELECT sgM_id FROM Cleaning))
              OR
              (serviceType = 'Consulting' AND SG.sgM_id IN (SELECT sgM_id FROM Consulting))
          )
        FETCH FIRST ROW ONLY;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            serviceGiverID := NULL;
    END;

    -- If no ServiceGiver found in the same community, find an alternative
    IF serviceGiverID IS NULL THEN
        BEGIN
            -- Select an alternative ServiceGiver from a different community
            SELECT SG.sgM_id INTO alternativeServiceGiverID
            FROM ServiceGiver SG
            JOIN CommunityMember CM ON SG.sgM_id = CM.M_id
            JOIN Times T ON SG.sgM_id = T.sgM_id
            WHERE CM.C_id != communityID
              AND T.T_dayofweek = dayOfWeek
              AND T.T_starttime <= startTime
              AND T.T_endtime >= endTime
              AND (
                  (serviceType = 'Babysitting' AND SG.sgM_id IN (SELECT sgM_id FROM Babysitting))
                  OR
                  (serviceType = 'Cleaning' AND SG.sgM_id IN (SELECT sgM_id FROM Cleaning))
                  OR
                  (serviceType = 'Consulting' AND SG.sgM_id IN (SELECT sgM_id FROM Consulting))
              )
            FETCH FIRST ROW ONLY;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE notFound;
        END;

        -- Retrieve the details of the alternative ServiceGiver
        SELECT SG.SG_price, SG.SG_details INTO sgPrice, sgDetails
        FROM ServiceGiver SG
        WHERE SG.sgM_id = alternativeServiceGiverID;

        errorMsg := 'Service giver not found in the same community. ' ||
                    'Alternative service giver from another community: ' ||
                    'ID: ' || alternativeServiceGiverID ||
                    ', Price: ' || sgPrice ||
                    ', Details: ' || sgDetails;

        RAISE_APPLICATION_ERROR(-20001, errorMsg);
    ELSE
        -- Retrieve and print the details of the found ServiceGiver
        SELECT SG.SG_price, SG.SG_details INTO sgPrice, sgDetails
        FROM ServiceGiver SG
        WHERE SG.sgM_id = serviceGiverID;

        DBMS_OUTPUT.PUT_LINE('ID: ' || serviceGiverID);
        DBMS_OUTPUT.PUT_LINE('Price: ' || sgPrice);
        DBMS_OUTPUT.PUT_LINE('Details: ' || sgDetails);
        
        -- Call the function to fetch service giver availability for a specific SGM_id
        v_cursor := GET_SERVICE_GIVER_AVAILABILITY(serviceGiverID);

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
        END IF;

EXCEPTION
    WHEN notFound THEN
        RAISE_APPLICATION_ERROR(-20001, 'No service giver found in any community');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'An unexpected error occurred: ' || SQLERRM);
END GetServiceGiverDetails;
/
