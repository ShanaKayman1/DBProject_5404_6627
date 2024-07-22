-- << מבט של האגף האחר >> -----------------
CREATE VIEW person_delivery_info AS
SELECT
    p.m_name,
    p.m_phone AS key,
    dr.vehicle,
    dr.isAvailable,
    d.deliveryNum,
    d.status,
    d.deliveryDate,
    d.deliverfinisheddate,
    sd.needcooling,
    sd.providerphonenum,
    sd.provideraddress,
    fd.mealdescription,
    fd.kasrus,
    fd.typedm AS foodType
FROM
    person p
LEFT JOIN driver dr ON p.m_id = dr.m_id
LEFT JOIN delivery d ON d.m_id = dr.m_id
LEFT JOIN supplyDelivery sd ON d.deliveryNum = sd.deliveryNum
LEFT JOIN foodDelivery fd ON d.deliveryNum = fd.deliveryNum;


-- שאילתא 1
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the view, including driver personal information and details, 
delivery details, and specifics about the supply and food deliveries.
FROM Clause: Indicates the view (person_delivery_info) as the source of the data.
WHERE Clause: Filters the results to show only those deliveries where the status is 'deliverd'. */
SELECT
    m_name,
    key AS m_phone,
    vehicle,
    isAvailable,
    deliveryNum,
    status,
    deliveryDate,
    deliverfinisheddate
    needCooling,
    ProviderPhoneNum,
    ProviderAddress,
    mealDescription,
    kasrus,
    foodType
FROM
    person_delivery_info
WHERE
    status = 'deliverd';


-- שאילתא 2
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the view, including driver personal information and details, 
delivery details, and specifics about the food delivery.
FROM Clause: Indicates the view (person_delivery_info) as the source of the data.
WHERE Clause: Filters the results to show only deliveries where needColling is 'Yes', indicating deliveries that require cooling. */
SELECT
    m_name,
    key AS m_phone,
    vehicle,
    isAvailable,
    deliveryNum,
    status,
    deliveryDate,
    deliverfinisheddate
    needCooling,
    ProviderPhoneNum,
    ProviderAddress
FROM
    person_delivery_info
WHERE
    needCooling = 'Yes';


-- שאילתא 3
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the view, including driver personal information and details, 
delivery details, and specifics about the  supply delivery.
FROM Clause: Indicates the view (person_delivery_info) as the source of the data.
WHERE Clause: Filters the results to show only deliveries where the food type is 'M', indicating deliveries that are containing meat. */
SELECT
    m_name,
    key AS m_phone,
    vehicle,
    isAvailable,
    deliveryNum,
    status,
    deliveryDate,
    deliverfinisheddate
    mealDescription,
    kasrus,
    foodType
FROM
    person_delivery_info
WHERE
    foodtype = 'M';


-- << מבט של האגף שלנו >> -------------------------
CREATE VIEW member_babysitting_info AS
SELECT
    p.M_id AS member_id,
    p.M_name AS member_name,
    m.M_dateOfJoining AS member_date_of_joining,
    p.M_mail AS member_email,
    p.M_phone AS member_phone,
    p.M_address AS member_address,
    y.Y_numOfChildern AS member_num_of_kids,
    b.B_gender AS babysitting_gender,
    b.B_age AS babysitting_age,
    b.B_yearsOfExperience AS babysitting_experience,
    b.B_maxNumofChildren AS babysitting_max_kids
FROM
    person p
LEFT JOIN
    Cmember m ON p.m_id = m.m_id
LEFT JOIN
    Yoledet y ON m.M_id = y.ym_id
LEFT JOIN
    Babysitting b ON m.M_id = b.SGM_id;


-- שאילתא 1
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the member_babysitting_info view. These columns correspond to the fields selected in the 
view definition.
FROM Clause: Indicates the view name (member_babysitting_info) from which to retrieve data. */
SELECT
    member_id,
    member_name,
    member_date_of_joining,
    member_email,
    member_phone,
    member_address,
    member_num_of_kids,
    babysitting_gender,
    babysitting_age,
    babysitting_experience,
    babysitting_max_kids
FROM
    member_babysitting_info;


-- שאילתא 2
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the member_babysitting_info view, focusing on member name, email, babysitting experience, 
and maximum number of kids they can babysit.
FROM Clause: Indicates the view name (member_babysitting_info) from which to retrieve data.
WHERE Clause: Filters the results to include only those members who have babysitting experience of 3 years or more (babysitting_experience >= 3) 
and can babysit more than 2 kids (babysitting_max_kids > 2).*/
SELECT
    member_name,
    member_email,
    babysitting_experience,
    babysitting_max_kids
FROM
    member_babysitting_info
WHERE
    babysitting_experience >= 3
    AND babysitting_max_kids > 2;

-- שאילתא 3
/* Explanation:
SELECT Clause: Specifies the columns to retrieve from the query results, including member name, email, babysitting gender, age, and availability 
details (day of the week, start time, end time, constraints).
FROM Clause: Specifies the source of data, using the member_babysitting_info view aliased as mbi.
LEFT JOIN: Joins the Times table (t) to fetch availability details (Tdayofweek, Tstarttime, Tendtime, Tconstraints) for each member who offers 
babysitting services.
WHERE Clause: Filters the results to include only members who have defined availability (t.Tdayofweek IS NOT NULL).*/
SELECT
    member_name,
    member_email,
    babysitting_gender,
    babysitting_age,
    t.T_dayofweek AS availability_day,
    t.T_starttime AS availability_start_time,
    t.T_endtime AS availability_end_time,
    t.T_constraints AS availability_constraints
FROM
    member_babysitting_info mbi
LEFT JOIN
    Times t ON mbi.member_id = t.SGM_id
WHERE
    t.T_dayofweek IS NOT NULL;


