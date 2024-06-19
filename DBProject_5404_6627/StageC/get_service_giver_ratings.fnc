CREATE OR REPLACE NONEDITIONABLE FUNCTION get_service_giver_ratings RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    -- Open a cursor to fetch ServiceGiver IDs
    OPEN v_cursor FOR
        SELECT sg.SGM_id AS service_giver_id, AVG(ysg.YSG_rating) AS average_rating
        FROM ServiceGiver sg
        LEFT JOIN YoledetServiceGiver ysg ON sg.SGM_id = ysg.SGM_id
        GROUP BY sg.SGM_id;

    RETURN v_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
        CLOSE v_cursor; -- Close cursor in case of no data found
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        CLOSE v_cursor; -- Close cursor in case of other errors
        RETURN NULL;
END get_service_giver_ratings;
/
CREATE OR REPLACE NONEDITIONABLE FUNCTION get_service_giver_ratings RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
    --v_service_giver_id ServiceGiver.SGM_id%TYPE;
    --v_average_rating NUMBER;
BEGIN
    -- Open a cursor to fetch ServiceGiver IDs
    OPEN v_cursor FOR
        SELECT sg.SGM_id AS service_giver_id, AVG(ysg.YSG_rating) AS average_rating
        FROM ServiceGiver sg
        LEFT JOIN YoledetServiceGiver ysg ON sg.SGM_id = ysg.SGM_id
        GROUP BY sg.SGM_id;

    RETURN v_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
        CLOSE v_cursor; -- Close cursor in case of no data found
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        CLOSE v_cursor; -- Close cursor in case of other errors
        RETURN NULL;
END get_service_giver_ratings;
/
