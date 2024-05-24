CREATE TABLE Community
(
  C_id INT NOT NULL, 
  C_name varchar2(20) NOT NULL,
  C_description varchar2(100),
  C_location varchar2(20) NOT NULL,
  C_numOfMembers INT NOT NULL,
  PRIMARY KEY (C_id)
);

CREATE TABLE CMember
(
  M_id INT NOT NULL,
  M_name varchar2(20) NOT NULL,
  M_dateOfJoining date NOT NULL,
  M_mail varchar2(50),
  M_phone INT NOT NULL,
  M_address varchar2(100) NOT NULL,
  PRIMARY KEY (M_id)
);

CREATE TABLE Yoledet
(
  Y_numOfChildern INT,
  YM_id INT NOT NULL,
  PRIMARY KEY (YM_id),
  FOREIGN KEY (YM_id) REFERENCES CMember(M_id)
);

CREATE TABLE ServiceGiver
(
  SG_price number,
  SG_details varchar2(100),
  SGM_id INT NOT NULL,
  PRIMARY KEY (SGM_id),
  FOREIGN KEY (SGM_id) REFERENCES CMember(M_id)
);

CREATE TABLE Consulting
(
  CNS_location varchar2(100),
  CNS_type varchar2(20) NOT NULL,
  CNS_yearsOfExperience INT NOT NULL,
  SGM_id INT NOT NULL,
  PRIMARY KEY (SGM_id),
  FOREIGN KEY (SGM_id) REFERENCES ServiceGiver(SGM_id)
);

CREATE TABLE Babysitting
(
  B_gender varchar2(1) NOT NULL,
  B_age number,
  B_yearsOfExperience INT,
  B_maxNumofChildren INT,
  SGM_id INT NOT NULL,
  PRIMARY KEY (SGM_id),
  FOREIGN KEY (SGM_id) REFERENCES ServiceGiver(SGM_id)
);

CREATE TABLE Cleaning
(
  CL_typeOfCleaning varchar2(20),
  SGM_id INT NOT NULL,
  PRIMARY KEY (SGM_id),
  FOREIGN KEY (SGM_id) REFERENCES ServiceGiver(SGM_id)
);

CREATE TABLE YoledetServiceGiver
(
  YSG_dateOfService date NOT NULL,
  YSG_startTime varchar2(5) NOT NULL,
  YSG_endTime varchar2(5) NOT NULL,
  YSG_rating INT,
  YM_id INT NOT NULL,
  SGM_id INT NOT NULL,
  PRIMARY KEY (YM_id, SGM_id),
  FOREIGN KEY (YM_id) REFERENCES Yoledet(YM_id),
  FOREIGN KEY (SGM_id) REFERENCES ServiceGiver(SGM_id)
);

CREATE TABLE CommunityMember
(
  C_id INT NOT NULL, 
  M_id INT NOT NULL,
  PRIMARY KEY (C_id, M_id),
  FOREIGN KEY (C_id) REFERENCES Community(C_id),
  FOREIGN KEY (M_id) REFERENCES CMember(M_id)
);

CREATE TABLE Times
(
  T_dayOfWeek varchar2(20) NOT NULL,
  T_startTime varchar2(5) NOT NULL,
  T_endTime varchar2(5) NOT NULL,
  T_num INT NOT NULL,
  T_constraints varchar2(100),
  SGM_id INT NOT NULL,
  PRIMARY KEY (T_num, SGM_id),
  FOREIGN KEY (SGM_id) REFERENCES ServiceGiver(SGM_id)
);
