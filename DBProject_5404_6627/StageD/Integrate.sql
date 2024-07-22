-- << ייבוא של האגף החדש >> --

-- שינוי שמות שלנו לפני הרצת הייבוא שלהם
ALTER TABLE Communitymember
RENAME TO Communitymember0;
-- הרצת הייבוא שלהם
-- שינוי *כל* השמות שלהם בשביל הסדר
ALTER TABLE Person RENAME TO Person1;
ALTER TABLE Communitymember RENAME TO Communitymember1;
ALTER TABLE Birth RENAME TO Birth1;
ALTER TABLE Driver RENAME TO Driver1;
ALTER TABLE Delivery RENAME TO Delivery1;
ALTER TABLE FoodDelivery RENAME TO FoodDelivery1;
ALTER TABLE SupplysDelivery RENAME TO SupplysDelivery1;
-- שינוי השמות שלנו חזרה
ALTER TABLE Communitymember0
RENAME TO Communitymember;



-- << יצירת טבלאות >> --
CREATE TABLE Person
(
  M_id INT NOT NULL,
  M_name varchar2(20) NOT NULL,
  M_mail varchar2(50),
  M_phone INT NOT NULL,
  M_address varchar2(100) NOT NULL,
  PRIMARY KEY (M_id)
);

CREATE TABLE Driver
(
  vehicle varchar2(20) NOT NULL,
  isAvailable varchar2(3) NOT NULL,
  M_id INT NOT NULL,
  PRIMARY KEY (M_id),
  FOREIGN KEY (M_id) REFERENCES Person(M_id)
);

CREATE TABLE Delivery
(
  deliveryNum INT NOT NULL,
  status varchar2(20),
  deliveryDate DATE NOT NULL,
  deliverFinishedDate DATE,
  M_id INT NOT NULL,
  PRIMARY KEY (deliveryNum),
  FOREIGN KEY (M_id) REFERENCES Driver(M_id)
);

CREATE TABLE FoodDelivery
(
  mealDescription varchar2(20),
  kasrus varchar2(20),
  typedm varchar2(1),
  deliveryNum INT NOT NULL,
  PRIMARY KEY (deliveryNum),
  FOREIGN KEY (deliveryNum) REFERENCES Delivery(deliveryNum)
);

CREATE TABLE SupplyDelivery
(
  needCooling varchar2(3),
  ProviderPhoneNum INT NOT NULL,
  ProviderAddress varchar2(20) NOT NULL,
  deliveryNum INT NOT NULL,
  PRIMARY KEY (deliveryNum),
  FOREIGN KEY (deliveryNum) REFERENCES Delivery(deliveryNum)
);

CREATE TABLE Birth
(
  birthID INT NOT NULL,
  birthDate Date NOT NULL,
  numOfBabies INT NOT NULL,
  M_id INT NOT NULL,
  PRIMARY KEY (birthID),
  FOREIGN KEY (M_id) REFERENCES Yoledet(YM_id)
);


commit;


-- << אינטגרציה של טבלאות >> --

-- << PERSON >> --------------------------------------------------------------------
-- Cmember into Person
   -- id - as is
   -- name - as is
   -- mail - as is
   -- phone - as is
   -- address - as is
INSERT INTO Person (M_id, M_name, M_mail, M_phone, M_address)
SELECT M_id, M_name, M_mail, M_phone, M_address 
FROM Cmember;

-- Person1 into Person
   -- 1) alter Person1: add column id, generate id-nums different from id-nums from cmember
                     /* keep the highest id num already in cmember and make a running numbers */
ALTER TABLE person1 ADD id INT;

DECLARE
    v_new_id INT := 0;
BEGIN
    SELECT COALESCE(MAX(M_id), 0) + 1
    INTO v_new_id
    FROM Cmember;

    FOR rec IN (SELECT ROWID r_id FROM person1 ORDER BY ROWID) LOOP
        UPDATE person1
        SET id = v_new_id
        WHERE ROWID = rec.r_id;

        v_new_id := v_new_id + 1;
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;

   -- 2) copy from Person1 into Perosn:
      -- id, name - as is
      -- mail - concat: name "@gmail.com
      -- phone - keep the highest phone num already in person/cmember
               /* if phone already exist in person/cmember: change to highest phone num+1, update highest phone num
               else: as is */
      -- address - concat: city street zipcode
DECLARE
    v_new_phoneNum INT;
    v_phone_exists INT;
BEGIN
    SELECT COALESCE(MAX(M_phone), 0) + 1
    INTO v_new_phoneNum
    FROM Person;

    FOR rec IN (SELECT * FROM person1) LOOP
        v_phone_exists := 0;
        -- Check if rec.phoneNum already exists in Person table        
        SELECT COUNT(*)  
        INTO v_phone_exists
        FROM Person
        WHERE M_phone = rec.phoneNum;

        -- If no rows found, insert with original phoneNum
        IF v_phone_exists = 0 THEN
            INSERT INTO Person (M_id, M_name, M_mail, M_phone, M_address)
            VALUES (
                   rec.id, 
                   rec.name, 
                   rec.name || '@gmail.com', 
                   rec.phoneNum, 
                   rec.city || ' ' || rec.street || ' ' || COALESCE(rec.zipCode, '')
                   );
        ELSE
            -- If rows found, insert with new v_new_phoneNum
            INSERT INTO Person (M_id, M_name, M_mail, M_phone, M_address)
            VALUES (
                   rec.id, 
                   rec.name, 
                   rec.name || '@gmail.com', 
                   v_new_phoneNum, 
                   rec.city || ' ' || rec.street || ' ' || COALESCE(rec.zipCode, '')
                   );
            
            v_new_phoneNum := v_new_phoneNum + 1;
        END IF;
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;


-- << DRIVER >> --------------------------------------------------------------------
-- driver1 into driver
   -- id - for each phone in driver1, go to Person1 and find id of phone
INSERT INTO Driver (vehicle, isAvailable, M_id)
SELECT d1.vehicle, d1.isAvailable, p1.id
FROM driver1 d1
JOIN person1 p1 ON d1.phoneNum = p1.phoneNum;


-- << DELIVERY >> --------------------------------------------------------------------
-- delivery1 into delivery
   -- id - for each phone in delivery1, go to Person1 and find id of phone
INSERT INTO Delivery (deliveryNum, status, deliveryDate, deliverFinishedDate, M_id)
SELECT d1.deliveryNum, d1.status, d1.deliveryDate, d1.deliveryFinishedDate, p1.id
FROM delivery1 d1
JOIN person1 p1 ON d1.phoneNum = p1.phoneNum;


-- << FOODDELIVERY >> --------------------------------------------------------------------
-- fooddelivery1 into fooddelivery
INSERT INTO FoodDelivery (mealDescription, kasrus, typedm, deliveryNum)
SELECT mealDescription, kashrus, typeDM, deliveryNum
FROM foodDelivery1;


-- << SUPPLYDELIVERY >> --------------------------------------------------------------------
-- supplydelivery1 into supplydelivery
INSERT INTO SupplyDelivery (needCooling, ProviderPhoneNum, ProviderAddress, deliveryNum)
SELECT needsCooling, providerPhoneNum, providerAdress, deliveryNum
FROM SupplysDelivery1;


-- << CMEMBER >> --------------------------------------------------------------------
-- alter Cmember
   -- drop columns: name, mail, phone, address
ALTER TABLE CMember DROP COLUMN M_name;
ALTER TABLE CMember DROP COLUMN M_mail;
ALTER TABLE CMember DROP COLUMN M_phone;
ALTER TABLE CMember DROP COLUMN M_address;
   -- make column M_dateOfJoining NULLABLE
ALTER TABLE Cmember
MODIFY M_dateOfJoining DATE NULL;

-- CommunityMember1 into Cmember
   -- id - for each phone in CommunityMember1, go to Person1 and find id of phone
   -- date - null
INSERT INTO CMember (M_id, M_dateOfJoining)
SELECT p1.id,
       NULL AS M_dateOfJoining
FROM communityMember1 cm1
JOIN person1 p1 ON cm1.phoneNum = p1.phoneNum;


-- << YOLEDET >> --------------------------------------------------------------------
   -- add column delivery-num-recived  //WE DECIDED TO MAKE IT TO NULLABLE
ALTER TABLE Yoledet ADD deliveryNum_received INT;

   -- add data to column:
      -- for each phone in Birth1...
            -- id - go to Person1 and find id of phone
            -- num of kids - find "numOfBabies" + generated int
            -- delivery num - go to CommunityMember1 and find "deliveryNumTo"
INSERT INTO Yoledet (Y_numOfChildern, YM_id, deliveryNum_received)
SELECT b1.numberOfBabies,
       p1.id,
       cm1.deliveryNumTo
FROM birth1 b1
JOIN communityMember1 cm1 ON b1.phoneNum = cm1.phoneNum
JOIN person1 p1 ON cm1.phoneNum = p1.phoneNum;

   -- make column FK from fooddelivery
ALTER TABLE Yoledet
ADD CONSTRAINT fk_delivery_num_received
FOREIGN KEY (deliveryNum_received) REFERENCES foodDelivery(deliveryNum);


-- << BIRTH >> --------------------------------------------------------------------
-- birth1 into birth
   -- id - for each phone in birth1, go to Person1 and find id of phone
INSERT INTO Birth (birthID, birthDate, numOfBabies, M_id)
SELECT b1.birthID, b1.birtDate, b1.numberOfBabies, p1.id
FROM birth1 b1
JOIN person1 p1 ON b1.phoneNum = p1.phoneNum;


-- << SERVICEGIVER >> --------------------------------------------------------------------
   -- add column SUPPLYdelivery-num-recived  //WE DECIDED TO MAKE IT TO NULLABLE
   -- add column FOODdelivery-num-sent       //WE DECIDED TO MAKE IT TO NULLABLE
ALTER TABLE ServiceGiver
ADD (SUPPLYdeliveryNum_recived INT,
     FOODdeliveryNum_sent INT);

   -- add data to columns:
      -- for each phone in CommunityMember1...
         -- id - go to Person1 and find id of phone
         -- price - null
         -- details - generate/ constant some string
         -- SUPPLYdelivery-num-recived - go to CommunityMember1 and find "deliveryNum"
         -- FOODdelivery-num-sent - go to CommunityMember1 and find "foodDeliveryFromDeliveryNum"
INSERT INTO ServiceGiver (SG_price, SG_details, SGM_id, SUPPLYdeliveryNum_recived, FOODdeliveryNum_sent)
SELECT NULL AS SG_price,
       'Service Giver Details' AS SG_details,
       p1.id AS SGM_id,
       cm1.deliveryNum AS SUPPLYdeliveryNum_recived,
       cm1.foodDeliveryFromdeliveryNum AS FOODdeliveryNum_sent
FROM CommunityMember1 cm1
JOIN person1 p1 ON cm1.phoneNum = p1.phoneNum;

   -- make column SUPPLYdelivery-num-recived FK from supplydelivery
   -- make column FOODdelivery-num-sent FK from fooddelivery
ALTER TABLE ServiceGiver
ADD CONSTRAINT fk_supplydeliveryNum_recived
FOREIGN KEY (SUPPLYdeliveryNum_recived) REFERENCES supplydelivery(deliveryNum);

ALTER TABLE ServiceGiver
ADD CONSTRAINT fk_fooddeliveryNum_sent
FOREIGN KEY (FOODdeliveryNum_sent) REFERENCES fooddelivery(deliveryNum);



-- << מחיקה של טבלאות מיותרות >> --
DROP TABLE birth1;
DROP TABLE communityMember1;
DROP TABLE SupplysDelivery1;
DROP TABLE foodDelivery1;
DROP TABLE delivery1;
DROP TABLE driver1;
DROP TABLE person1;

