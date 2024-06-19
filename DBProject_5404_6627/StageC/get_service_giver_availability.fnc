create or replace function GET_SERVICE_GIVER_AVAILABILITY(p_SGM_id IN INT) return SYS_REFCURSOR  is
  availability_schedule SYS_REFCURSOR;
BEGIN
    OPEN availability_schedule FOR
        SELECT 
            T_dayOfWeek AS day_of_week,
            T_startTime AS start_time,
            T_endTime AS end_time,
            T_constraints AS constraints
        FROM 
            Times
        WHERE 
            SGM_id = p_SGM_id
        ORDER BY 
            T_dayOfWeek, T_startTime;
    
    RETURN availability_schedule;
end GET_SERVICE_GIVER_AVAILABILITY;
/
