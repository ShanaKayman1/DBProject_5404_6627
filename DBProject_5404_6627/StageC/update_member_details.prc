-- Procedure to update member details (consolidated into one procedure)
create or replace procedure update_member_details(
    p_member_id IN Cmember.M_id%TYPE,
    p_new_email IN Cmember.m_mail%TYPE,
    p_new_phone IN Cmember.m_phone%TYPE) is
    v_member_count NUMBER;
begin
  -- Check if member exists
    SELECT COUNT(*)
    INTO v_member_count
    FROM cmember
    WHERE M_id = p_member_id;

    IF v_member_count > 0 THEN
        -- Update member email and phone
        UPDATE cmember
        SET m_mail = p_new_email, 
            m_phone = p_new_phone
        WHERE M_id = p_member_id;

        -- Check if the update was successful
        IF SQL%ROWCOUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Member details updated successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Member not found or not updated.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Member not found');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the given member ID');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
end update_member_details;
/
