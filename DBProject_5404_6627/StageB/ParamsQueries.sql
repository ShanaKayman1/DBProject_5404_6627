
--1. להציג את העוזרות בתחום מסוים(רשות) שעובדות ביום כלשהו(חובה) ובין שעות מסוימות(רשות): לפני שעת התחלה, אחרי שעת סיום
SELECT M.M_NAME, M.M_PHONE, S.SG_PRICE, T.T_DAYOFWEEK, T.T_STARTTIME, T.T_ENDTIME
FROM Cmember M 
JOIN Servicegiver S ON S.SGM_ID=M.M_ID
JOIN Babysitting B ON B.SGM_ID=M.M_ID
JOIN Times T ON T.SGM_ID=M.M_ID
WHERE &<name=mytable list="Consulting, Babysitting, Cleaning" prefix=" M.M_ID IN (SELECT SGM_ID FROM " suffix=") AND " restricted=yes hint="Optional">
      T.T_DAYOFWEEK = &<name=weekday type=string list="Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday" required=true restricted=yes>
      &<name=starttime prefix=" AND T.T_STARTTIME<=" type=string hint="Optional. Enter the start time (HH:MM)" >
      &<name=endtime prefix=" AND T.T_ENDTIME>=" type=string hint="Optional. Enter the end time (HH:MM)" >;

--2. להציג את העוזרות (ת.ז., שם, מספר טלפון, ממוצע דירוג, מחיר) ממוין לפי <דירוג ממוצע/מחיר> בסדר <עולה/יורד>ת
SELECT YS.SGM_ID, M.M_NAME, M.M_PHONE, ROUND(AVG(YS.YSG_RATING),1) AS avgRating, S.SG_PRICE AS price
FROM Cmember M
JOIN Servicegiver S ON S.SGM_ID=M.M_ID
JOIN Yoledetservicegiver YS ON S.SGM_ID=YS.SGM_ID
GROUP BY YS.SGM_ID, M.M_NAME, M.M_PHONE, S.SG_PRICE
ORDER BY &<name="order by" list="avgRating, price" restricted=true required=true> 
      &<name="check for descending order" checkbox="desc,">;

--3. להציג חברות קהילה שהצטרפו בין תאריכים (שם חברה, שם קהילה ומיקום, תאריך הצטרפות, מספר טלפון)
select M.M_ID, M.M_NAME, M.M_DATEOFJOINING
from cmember M
where M.M_DATEOFJOINING 
      between &<name=date_from type=date hint="Enter the start date DD/MM/YYYY">
      and &<name=date_to type=date hint="Enter the end date DD/MM/YYYY">
      order by M.M_DATEOFJOINING;

--4. להציג את כל החברות ששייכות לקהילה מסוימת
SELECT C.C_NAME, C.C_LOCATION, M.M_id, M.M_name
FROM Community C
JOIN Communitymember T ON C.C_ID=T.C_ID
JOIN Cmember M ON M.M_ID=T.M_ID
WHERE C.C_NAME=&<name=Cname type=string list="select c_name from community order by c_name">;


