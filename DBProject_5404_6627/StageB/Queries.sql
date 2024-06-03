------ SELECT ------

--1. להציג עוזרות שנתנו שירותים בין שני תאריכים ספציפיים
select Y.SGM_ID, M.M_NAME, Y.YSG_DATEOFSERVICE
from yoledetservicegiver Y, cmember M
where M.M_ID=Y.SGM_ID and Y.YSG_DATEOFSERVICE 
      between to_date('01/01/2020','dd/mm/yyyy') 
      and to_date('01/01/2021','dd/mm/yyyy');

--2. להציג כל העובדות שנותנות בדיוק 3 שירותים
SELECT m.m_id, m.m_name
FROM Cmember m
LEFT JOIN Babysitting b ON m.m_id = b.sgm_id
LEFT JOIN Cleaning c ON m.m_id = c.sgm_id
LEFT JOIN Consulting con ON m.m_id = con.sgm_id
WHERE b.sgm_id IS NOT NULL OR c.sgm_id IS NOT NULL OR con.sgm_id IS NOT NULL
GROUP BY m.m_id, m.m_name;

--3. להציג את כל היולדות שיש להן שלושה ילדים או יותר, ביחד עם כל הבייביסיטריות שהן בנות
select *
from (select b.sgm_id, m1.m_name, b.b_gender
     from Babysitting b JOIN cmember m1 ON b.sgm_id = m1.M_id
     WHERE b.b_gender = 'F'),    
     (select y. ym_id, m2.m_name, y.y_numofchildern
     from cmember m2 JOIN Yoledet y ON y.ym_id = m2.M_id
     where y.ym_id IN (SELECT y2.ym_id
                  FROM Yoledet y2
                  WHERE y2.y_numofchildern >= 3));
                  
--4. להציג את כל זוגות <יולדת,עוזרת> שקיבלו/נתנו שירות והן הצטרפו לקהילה באותה שנה
SELECT 
    ys.ym_id AS YoledetID,
    m1.m_name AS YoledetName,
    ys.sgm_id AS ServiceGiverID,
    m2.m_name AS ServiceGiverName,
    extract(year from m1.m_dateofjoining) AS JoinYear
FROM 
    YoledetServiceGiver ys
JOIN 
    cmember m1 ON ys.ym_id = m1.M_id
JOIN 
    cmember m2 ON ys.sgm_id = m2.M_id
WHERE 
    m1.M_id <> m2.M_id
    AND
    extract(year from m1.m_dateofjoining) = extract(year from m2.m_dateofjoining);


------ DELETE ------

--5. למחוק את הזמן עבור עוזרות שעובדות ביום ראשון אחרי השעה 18:00
DELETE FROM Times
WHERE 
    T_dayofweek = 'Sunday' 
    AND T_endtime > '18:00';

--6, למחוק את הבייביסיטריות שקטנות מגיל 12 ומסיימות לעבוד ב23:00 או אחרי
DELETE FROM Babysitting b
WHERE 
    b.b_age <=5
    AND b.sgm_id in (select b2.sgm_id
         from Babysitting b2 , Times t
         where b2.sgm_id=t.sgm_id
         and t.t_endtime >= '23:00');


------ UPDATE ------

--7. לעדכן עבור כל היולדות שהצטרפו לפני שנת 2005 את מספר הילדים לילד אחד פחות
UPDATE yoledet y
SET y.y_numofchildern = y.y_numofchildern - 1
WHERE y.y_numofchildern >=1
      AND y.ym_id in (select y2.ym_id
                      from Yoledet y2, Cmember m
                      where y2.ym_id=m.m_id
                      and m.m_dateofjoining <= to_date('01/01/2005','dd/mm/yyyy'));

--8. לעדכן עבור העוזרות שקיבלו דירוג 5, אם קיים מחיר והוא קטן או שווה ל70, להעלות את המחיר ב5
UPDATE ServiceGiver sg
SET sg.sg_price = sg.sg_price + 5
WHERE sg.sg_price IS NOT NULL
  AND sg.sg_price < 70
  AND sg.sgm_id in (select distinct ysg.sgm_id
                    from YoledetServiceGiver ysg
                    where ysg.ysg_rating = 5);

