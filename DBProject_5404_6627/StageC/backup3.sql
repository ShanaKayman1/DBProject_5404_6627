prompt PL/SQL Developer Export Tables for user EFRAT@XE
prompt Created by efrat on יום רביעי 19 יוני 2024
set feedback off
set define off

prompt Creating CMEMBER...
create table CMEMBER
(
  m_id            INTEGER not null,
  m_name          VARCHAR2(20) not null,
  m_dateofjoining DATE not null,
  m_mail          VARCHAR2(50),
  m_phone         INTEGER not null,
  m_address       VARCHAR2(100) not null
)
;
alter table CMEMBER
  add primary key (M_ID)
;

prompt Creating SERVICEGIVER...
create table SERVICEGIVER
(
  sg_price   NUMBER,
  sg_details VARCHAR2(100),
  sgm_id     INTEGER not null
)
;
alter table SERVICEGIVER
  add primary key (SGM_ID)
;
alter table SERVICEGIVER
  add foreign key (SGM_ID)
  references CMEMBER (M_ID);

prompt Creating BABYSITTING...
create table BABYSITTING
(
  b_gender            VARCHAR2(1) not null,
  b_age               NUMBER,
  b_yearsofexperience INTEGER,
  b_maxnumofchildren  INTEGER,
  sgm_id              INTEGER not null
)
;
alter table BABYSITTING
  add primary key (SGM_ID)
;
alter table BABYSITTING
  add foreign key (SGM_ID)
  references SERVICEGIVER (SGM_ID);

prompt Creating CLEANING...
create table CLEANING
(
  cl_typeofcleaning VARCHAR2(20),
  sgm_id            INTEGER not null
)
;
alter table CLEANING
  add primary key (SGM_ID)
;
alter table CLEANING
  add foreign key (SGM_ID)
  references SERVICEGIVER (SGM_ID);

prompt Creating COMMUNITY...
create table COMMUNITY
(
  c_id           INTEGER not null,
  c_name         VARCHAR2(20) not null,
  c_description  VARCHAR2(100),
  c_location     VARCHAR2(20),
  c_numofmembers INTEGER not null
)
;
alter table COMMUNITY
  add primary key (C_ID)
;

prompt Creating COMMUNITYMEMBER...
create table COMMUNITYMEMBER
(
  c_id INTEGER not null,
  m_id INTEGER not null
)
;
alter table COMMUNITYMEMBER
  add primary key (C_ID, M_ID)
;
alter table COMMUNITYMEMBER
  add foreign key (C_ID)
  references COMMUNITY (C_ID);
alter table COMMUNITYMEMBER
  add foreign key (M_ID)
  references CMEMBER (M_ID);

prompt Creating CONSULTING...
create table CONSULTING
(
  cns_location          VARCHAR2(100),
  cns_type              VARCHAR2(20) not null,
  cns_yearsofexperience INTEGER not null,
  sgm_id                INTEGER not null
)
;
alter table CONSULTING
  add primary key (SGM_ID)
;
alter table CONSULTING
  add foreign key (SGM_ID)
  references SERVICEGIVER (SGM_ID);

prompt Creating TIMES...
create table TIMES
(
  t_dayofweek   VARCHAR2(20) not null,
  t_starttime   VARCHAR2(5) not null,
  t_endtime     VARCHAR2(5) not null,
  t_num         INTEGER not null,
  t_constraints VARCHAR2(100),
  sgm_id        INTEGER not null
)
;
alter table TIMES
  add primary key (T_NUM, SGM_ID)
;
alter table TIMES
  add foreign key (SGM_ID)
  references SERVICEGIVER (SGM_ID);

prompt Creating YOLEDET...
create table YOLEDET
(
  y_numofchildern INTEGER default 1,
  ym_id           INTEGER not null
)
;
alter table YOLEDET
  add primary key (YM_ID)
;
alter table YOLEDET
  add foreign key (YM_ID)
  references CMEMBER (M_ID);

prompt Creating YOLEDETSERVICEGIVER...
create table YOLEDETSERVICEGIVER
(
  ysg_dateofservice DATE not null,
  ysg_starttime     VARCHAR2(5) not null,
  ysg_endtime       VARCHAR2(5) not null,
  ysg_rating        INTEGER,
  ym_id             INTEGER not null,
  sgm_id            INTEGER not null
)
;
alter table YOLEDETSERVICEGIVER
  add primary key (YM_ID, SGM_ID)
;
alter table YOLEDETSERVICEGIVER
  add foreign key (YM_ID)
  references YOLEDET (YM_ID);
alter table YOLEDETSERVICEGIVER
  add foreign key (SGM_ID)
  references SERVICEGIVER (SGM_ID);
alter table YOLEDETSERVICEGIVER
  add constraint CHECK_DIFFERENT_MEMBERS
  check (YM_id != SGM_id);

prompt Disabling triggers for CMEMBER...
alter table CMEMBER disable all triggers;
prompt Disabling triggers for SERVICEGIVER...
alter table SERVICEGIVER disable all triggers;
prompt Disabling triggers for BABYSITTING...
alter table BABYSITTING disable all triggers;
prompt Disabling triggers for CLEANING...
alter table CLEANING disable all triggers;
prompt Disabling triggers for COMMUNITY...
alter table COMMUNITY disable all triggers;
prompt Disabling triggers for COMMUNITYMEMBER...
alter table COMMUNITYMEMBER disable all triggers;
prompt Disabling triggers for CONSULTING...
alter table CONSULTING disable all triggers;
prompt Disabling triggers for TIMES...
alter table TIMES disable all triggers;
prompt Disabling triggers for YOLEDET...
alter table YOLEDET disable all triggers;
prompt Disabling triggers for YOLEDETSERVICEGIVER...
alter table YOLEDETSERVICEGIVER disable all triggers;
prompt Disabling foreign key constraints for SERVICEGIVER...
alter table SERVICEGIVER disable constraint SYS_C008591;
prompt Disabling foreign key constraints for BABYSITTING...
alter table BABYSITTING disable constraint SYS_C008600;
prompt Disabling foreign key constraints for CLEANING...
alter table CLEANING disable constraint SYS_C008603;
prompt Disabling foreign key constraints for COMMUNITYMEMBER...
alter table COMMUNITYMEMBER disable constraint SYS_C008615;
alter table COMMUNITYMEMBER disable constraint SYS_C008616;
prompt Disabling foreign key constraints for CONSULTING...
alter table CONSULTING disable constraint SYS_C008596;
prompt Disabling foreign key constraints for TIMES...
alter table TIMES disable constraint SYS_C008623;
prompt Disabling foreign key constraints for YOLEDET...
alter table YOLEDET disable constraint SYS_C008588;
prompt Disabling foreign key constraints for YOLEDETSERVICEGIVER...
alter table YOLEDETSERVICEGIVER disable constraint SYS_C008630;
alter table YOLEDETSERVICEGIVER disable constraint SYS_C008631;
prompt Deleting YOLEDETSERVICEGIVER...
delete from YOLEDETSERVICEGIVER;
commit;
prompt Deleting YOLEDET...
delete from YOLEDET;
commit;
prompt Deleting TIMES...
delete from TIMES;
commit;
prompt Deleting CONSULTING...
delete from CONSULTING;
commit;
prompt Deleting COMMUNITYMEMBER...
delete from COMMUNITYMEMBER;
commit;
prompt Deleting COMMUNITY...
delete from COMMUNITY;
commit;
prompt Deleting CLEANING...
delete from CLEANING;
commit;
prompt Deleting BABYSITTING...
delete from BABYSITTING;
commit;
prompt Deleting SERVICEGIVER...
delete from SERVICEGIVER;
commit;
prompt Deleting CMEMBER...
delete from CMEMBER;
commit;
prompt Loading CMEMBER...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (222417749, 'Ema Sheal', to_date('16-03-2001', 'dd-mm-yyyy'), 'newmail@g.com', 57777777, '95 Westport Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (756337633, 'Dorita Hempshall', to_date('04-08-2016', 'dd-mm-yyyy'), 'doritahempshall@free.fr', 544732230, '94009 4th Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (661216534, 'Katheryn Ouchterlony', to_date('02-07-2011', 'dd-mm-yyyy'), 'katherynouchterlony@shutterfly.com', 532263780, '3910 Debs Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (343057735, 'Sal Pappi', to_date('19-11-2008', 'dd-mm-yyyy'), 'salpappi@wikipedia.org', 536975238, '9514 Meadow Vale Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (488493128, 'Devora Gouldsmith', to_date('05-04-2013', 'dd-mm-yyyy'), 'devoragouldsmith@taobao.com', 559750444, '4414 Valley Edge Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (384575759, 'Gayleen Bolzmann', to_date('24-02-2006', 'dd-mm-yyyy'), 'gayleenbolzmann@dmoz.org', 509507613, '90 Bay Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (682304864, 'Layla Jenkin', to_date('22-02-2017', 'dd-mm-yyyy'), 'laylajenkin@arstechnica.com', 521387446, '982 Straubel Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (872402104, 'Petunia Rustadge', to_date('08-10-2008', 'dd-mm-yyyy'), 'petuniarustadge@slideshare.net', 540232924, '42730 Garrison Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (140417983, 'Jada McCaughran', to_date('04-07-2007', 'dd-mm-yyyy'), 'jadamccaughran@slate.com', 501874166, '42462 Badeau Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (157540214, 'Morena Dyter', to_date('27-01-2012', 'dd-mm-yyyy'), 'morenadyter@163.com', 516620576, '928 Shelley Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (138567468, 'Oralia Arrigo', to_date('24-12-2019', 'dd-mm-yyyy'), 'oraliaarrigo@people.com.cn', 549460588, '1018 Ludington Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (727479428, 'Eveleen Becker', to_date('15-07-2011', 'dd-mm-yyyy'), 'eveleenbecker@oracle.com', 584873465, '724 Hauk Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (351074926, 'Virgina Jzhakov', to_date('23-07-2015', 'dd-mm-yyyy'), 'virginajzhakov@canalblog.com', 580814133, '2076 Jenifer Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (879054575, 'Sheeree Ivanshintsev', to_date('26-06-2002', 'dd-mm-yyyy'), 'sheereeivanshintsev@va.gov', 565756679, '76032 Roxbury Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (815488313, 'Mareah MacMeekan', to_date('24-12-2008', 'dd-mm-yyyy'), 'mareahmacmeekan@microsoft.com', 553819669, '7 Macpherson Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (810050808, 'Peg Jurczyk', to_date('14-02-2014', 'dd-mm-yyyy'), 'pegjurczyk@mapy.cz', 561115556, '68997 Jay Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (667176850, 'Lanna Baxill', to_date('08-09-2013', 'dd-mm-yyyy'), 'lannabaxill@1688.com', 540079180, '99384 Straubel Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (900192875, 'Nola Curman', to_date('12-08-2007', 'dd-mm-yyyy'), 'nolacurman@sphinn.com', 543928107, '125 Rutledge Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (741076529, 'Leda Mac Giany', to_date('17-04-2017', 'dd-mm-yyyy'), 'ledamac giany@techcrunch.com', 534149927, '04 Karstens Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (892581778, 'Carlen Sibbering', to_date('11-01-2018', 'dd-mm-yyyy'), 'carlensibbering@paypal.com', 564789115, '378 Cordelia Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (995273588, 'Jessika Nissle', to_date('23-04-2004', 'dd-mm-yyyy'), 'jessikanissle@nytimes.com', 521314337, '292 Bluejay Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (279868753, 'Bert Richemont', to_date('05-08-2014', 'dd-mm-yyyy'), 'bertrichemont@nytimes.com', 573297657, '25 Trailsway Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (146897612, 'Cecilla Gedge', to_date('10-11-2004', 'dd-mm-yyyy'), 'cecillagedge@cnet.com', 590303624, '232 Red Cloud Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (386928076, 'Shirlee McTerlagh', to_date('21-03-2010', 'dd-mm-yyyy'), 'shirleemcterlagh@bravesites.com', 563398766, '95 Declaration Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (374356341, 'Lorianna Vertigan', to_date('14-12-2013', 'dd-mm-yyyy'), 'loriannavertigan@discovery.com', 506111915, '428 Acker Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (216264525, 'Arabela Bovaird', to_date('30-11-2004', 'dd-mm-yyyy'), 'arabelabovaird@reference.com', 540923316, '4492 Karstens Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (204794274, 'Phillie Uman', to_date('15-04-2006', 'dd-mm-yyyy'), 'phillieuman@unicef.org', 508082094, '39 Kipling Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (653939281, 'Estrella Caston', to_date('04-03-2018', 'dd-mm-yyyy'), 'estrellacaston@unc.edu', 574939670, '689 Blackbird Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (387092329, 'Kassia Wandrack', to_date('07-09-2008', 'dd-mm-yyyy'), 'kassiawandrack@dmoz.org', 588612633, '71 Trailsway Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (414190148, 'Lyn Rizzetti', to_date('04-08-2002', 'dd-mm-yyyy'), 'lynrizzetti@chronoengine.com', 513787795, '3832 Bartelt Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (823717446, 'Selle Wakefield', to_date('17-01-2004', 'dd-mm-yyyy'), 'sellewakefield@youtube.com', 516023414, '9405 Grayhawk Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (714440128, 'Charlean Donizeau', to_date('07-01-2009', 'dd-mm-yyyy'), 'charleandonizeau@youtube.com', 555139860, '93 Crownhardt Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (826269184, 'Dorree Burnard', to_date('12-08-2009', 'dd-mm-yyyy'), 'dorreeburnard@mapquest.com', 575786482, '89743 Saint Paul Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (509387616, 'Gianina Boyde', to_date('22-12-2019', 'dd-mm-yyyy'), 'gianinaboyde@meetup.com', 512803404, '1 Dovetail Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (271482442, 'Alejandrina Stearn', to_date('28-12-2018', 'dd-mm-yyyy'), 'alejandrinastearn@eepurl.com', 581554051, '28581 2nd Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (888269770, 'Dorothee Oliva', to_date('01-12-2017', 'dd-mm-yyyy'), 'dorotheeoliva@sina.com.cn', 508353883, '99 Derek Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (991065502, 'Faunie Mawer', to_date('12-08-2011', 'dd-mm-yyyy'), 'fauniemawer@prnewswire.com', 587988146, '39 Forest Dale Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (326694357, 'Jeanette Siehard', to_date('08-10-2019', 'dd-mm-yyyy'), 'jeanettesiehard@china.com.cn', 546868596, '30049 Bay Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (254392497, 'Friederike Barbosa', to_date('30-10-2017', 'dd-mm-yyyy'), 'friederikebarbosa@cdbaby.com', 539323666, '880 Northview Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (315456383, 'Kelcey Shakle', to_date('18-04-2007', 'dd-mm-yyyy'), 'kelceyshakle@apple.com', 515876034, '1730 Norway Maple Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (492052662, 'Clemmy Kurtis', to_date('22-05-2016', 'dd-mm-yyyy'), 'clemmykurtis@unesco.org', 538470365, '45 Badeau Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (488864046, 'Winona McTague', to_date('20-03-2015', 'dd-mm-yyyy'), 'winonamctague@xrea.com', 541032929, '1 Laurel Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (133984187, 'Keri Gonzalo', to_date('01-01-2001', 'dd-mm-yyyy'), 'kerigonzalo@dedecms.com', 518593752, '02 Tennyson Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (214684922, 'Romy Godain', to_date('09-04-2018', 'dd-mm-yyyy'), 'romygodain@senate.gov', 587209432, '8882 Canary Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (242113481, 'Devi Warin', to_date('17-02-2006', 'dd-mm-yyyy'), 'deviwarin@opensource.org', 577947094, '8472 Susan Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (206312322, 'Pegeen Petzolt', to_date('11-12-2008', 'dd-mm-yyyy'), 'pegeenpetzolt@linkedin.com', 527829022, '14246 Claremont Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (604613699, 'Jeane Southworth', to_date('15-12-2006', 'dd-mm-yyyy'), 'jeanesouthworth@t.co', 532778805, '23 Westport Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (728382339, 'Max Liddiatt', to_date('20-12-2003', 'dd-mm-yyyy'), 'maxliddiatt@netvibes.com', 544467664, '75 Katie Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (694034701, 'Rozelle Fley', to_date('22-05-2016', 'dd-mm-yyyy'), 'rozellefley@adobe.com', 588719170, '0 Messerschmidt Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (533177138, 'Marci Pedrollo', to_date('05-04-2006', 'dd-mm-yyyy'), 'marcipedrollo@gizmodo.com', 541738274, '1 Morningstar Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (806840454, 'Roseann De Meyer', to_date('20-01-2007', 'dd-mm-yyyy'), 'roseannde meyer@nhs.uk', 580030160, '80 Havey Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (581307727, 'Therine Petrenko', to_date('28-12-2012', 'dd-mm-yyyy'), 'therinepetrenko@miitbeian.gov.cn', 515444167, '412 Karstens Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (382883037, 'Quinn Birdwistle', to_date('05-01-2003', 'dd-mm-yyyy'), 'quinnbirdwistle@odnoklassniki.ru', 585760933, '055 Meadow Vale Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (577184322, 'Penny Sturgis', to_date('11-04-2011', 'dd-mm-yyyy'), 'pennysturgis@engadget.com', 502201565, '344 Drewry Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (191356229, 'Mirella Pechell', to_date('06-06-2014', 'dd-mm-yyyy'), 'mirellapechell@eepurl.com', 525980589, '1 Darwin Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (826802360, 'Patricia Fulun', to_date('01-08-2007', 'dd-mm-yyyy'), 'patriciafulun@wikispaces.com', 578011209, '673 Swallow Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (838232400, 'Gabriela Pritchett', to_date('13-12-2007', 'dd-mm-yyyy'), 'gabrielapritchett@xrea.com', 532781954, '8 Dawn Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (396481548, 'Edithe Jakel', to_date('31-10-2016', 'dd-mm-yyyy'), 'edithejakel@geocities.jp', 564532954, '3305 Warner Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (200971969, 'Carolin Nowell', to_date('20-08-2010', 'dd-mm-yyyy'), 'carolinnowell@yelp.com', 559519059, '98 Riverside Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (565182304, 'Dona Dawnay', to_date('24-04-2005', 'dd-mm-yyyy'), 'donadawnay@amazonaws.com', 546718604, '36573 Dunning Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (300117638, 'Chelsea MacGregor', to_date('04-07-2009', 'dd-mm-yyyy'), 'chelseamacgregor@ameblo.jp', 550006206, '2 Superior Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (306244196, 'Yvette Worster', to_date('09-07-2014', 'dd-mm-yyyy'), 'yvetteworster@addtoany.com', 578982550, '67 Fisk Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (811695961, 'Xena Shewery', to_date('13-03-2011', 'dd-mm-yyyy'), 'xenashewery@redcross.org', 530747699, '89 Logan Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (471939757, 'Alisun Fleckno', to_date('21-11-2007', 'dd-mm-yyyy'), 'alisunfleckno@spotify.com', 535432047, '1 Hazelcrest Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (751419335, 'Kirbie Garber', to_date('14-03-2000', 'dd-mm-yyyy'), 'kirbiegarber@joomla.org', 543969555, '73557 Dennis Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (303150867, 'Cassaundra Verity', to_date('06-01-2004', 'dd-mm-yyyy'), 'cassaundraverity@hibu.com', 534637136, '8 Badeau Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (901502896, 'Adrianne Chaplain', to_date('07-05-2007', 'dd-mm-yyyy'), 'adriannechaplain@howstuffworks.com', 538841973, '1382 Fuller Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (944530975, 'Loreen Ricioppo', to_date('19-05-2010', 'dd-mm-yyyy'), 'loreenricioppo@independent.co.uk', 504066123, '5 Shelley Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (337376936, 'Steffi Spellsworth', to_date('12-12-2000', 'dd-mm-yyyy'), 'steffispellsworth@eventbrite.com', 578810293, '5287 Grover Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (768584445, 'Bethena Reinmar', to_date('23-05-2007', 'dd-mm-yyyy'), 'bethenareinmar@1688.com', 566110521, '782 Merry Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (506994358, 'Charyl Gerritsma', to_date('14-06-2004', 'dd-mm-yyyy'), 'charylgerritsma@weebly.com', 541382055, '5767 Fairview Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (504048563, 'Suzanne Vasiliev', to_date('28-03-2003', 'dd-mm-yyyy'), 'suzannevasiliev@sciencedirect.com', 569433729, '96 Luster Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (359817344, 'Lishe Housbey', to_date('19-08-2013', 'dd-mm-yyyy'), 'lishehousbey@admin.ch', 516219794, '451 Manitowish Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (232516560, 'Juliane Thurston', to_date('16-11-2003', 'dd-mm-yyyy'), 'julianethurston@jimdo.com', 508980339, '663 Browning Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (867204119, 'Augusta Kimpton', to_date('19-04-2004', 'dd-mm-yyyy'), 'augustakimpton@cornell.edu', 534477296, '80479 Namekagon Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (208196098, 'Elyn Guidotti', to_date('06-02-2004', 'dd-mm-yyyy'), 'elynguidotti@biglobe.ne.jp', 529571640, '02 Tennessee Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (572028348, 'Stephannie Sutter', to_date('17-06-2003', 'dd-mm-yyyy'), 'stephanniesutter@xinhuanet.com', 584712469, '78161 Glacier Hill Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (276868998, 'Gaye Masedon', to_date('08-05-2019', 'dd-mm-yyyy'), 'gayemasedon@etsy.com', 538704400, '680 Morrow Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (627097219, 'Dosi Fellenor', to_date('14-07-2016', 'dd-mm-yyyy'), 'dosifellenor@answers.com', 554263329, '13 Saint Paul Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (737512334, 'Gilberte Vicent', to_date('20-05-2004', 'dd-mm-yyyy'), 'gilbertevicent@acquirethisname.com', 510621394, '77 Union Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (580351317, 'Odele Pearton', to_date('30-03-2008', 'dd-mm-yyyy'), 'odelepearton@toplist.cz', 544343190, '93 Maryland Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (215457724, 'Margarette Ramiro', to_date('14-07-2014', 'dd-mm-yyyy'), 'margaretteramiro@unc.edu', 560381518, '24 Ridgeview Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (820477303, 'Corry Meegan', to_date('09-07-2007', 'dd-mm-yyyy'), 'corrymeegan@apache.org', 587631039, '32 West Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (553025263, 'Leslie Demeter', to_date('09-05-2017', 'dd-mm-yyyy'), 'lesliedemeter@fema.gov', 514993256, '36 Dovetail Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (570993504, 'Junie Merrikin', to_date('09-09-2001', 'dd-mm-yyyy'), 'juniemerrikin@a8.net', 525458582, '11979 Pierstorff Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (656798857, 'Corliss Barbour', to_date('15-04-2009', 'dd-mm-yyyy'), 'corlissbarbour@lulu.com', 513515025, '27778 Algoma Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (174074529, 'Kittie Messham', to_date('29-08-2011', 'dd-mm-yyyy'), 'kittiemessham@japanpost.jp', 539068520, '0 Westridge Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (775317838, 'Etheline Mundie', to_date('26-10-2000', 'dd-mm-yyyy'), 'ethelinemundie@thetimes.co.uk', 579033705, '41 Mendota Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (878361050, 'Dulcy Burtenshaw', to_date('09-10-2006', 'dd-mm-yyyy'), 'dulcyburtenshaw@1und1.de', 521822612, '834 Russell Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (470423071, 'Mercedes Girodias', to_date('30-09-2012', 'dd-mm-yyyy'), 'mercedesgirodias@purevolume.com', 537485733, '4790 Artisan Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (267080645, 'Gus Scammonden', to_date('29-06-2019', 'dd-mm-yyyy'), 'gusscammonden@ustream.tv', 589880060, '9774 Amoth Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (818499054, 'Fidelia Housaman', to_date('27-08-2016', 'dd-mm-yyyy'), 'fideliahousaman@squarespace.com', 556333494, '28 Londonderry Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (826062368, 'Essie Knappen', to_date('17-04-2003', 'dd-mm-yyyy'), 'essieknappen@theguardian.com', 507511558, '327 Raven Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (708612515, 'Minne Hands', to_date('27-11-2014', 'dd-mm-yyyy'), 'minnehands@house.gov', 558665274, '30 Vidon Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (615892339, 'Siana Veazey', to_date('15-05-2019', 'dd-mm-yyyy'), 'sianaveazey@tripod.com', 540067923, '475 Toban Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (901702266, 'Lacy Kloisner', to_date('30-05-2019', 'dd-mm-yyyy'), 'lacykloisner@imdb.com', 587882345, '43 Jenna Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (642289450, 'Novelia Petrovsky', to_date('10-07-2002', 'dd-mm-yyyy'), 'noveliapetrovsky@canalblog.com', 572857792, '75042 Mesta Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (234029909, 'Ethelyn Dobbin', to_date('11-04-2003', 'dd-mm-yyyy'), 'ethelyndobbin@devhub.com', 553022348, '390 Mendota Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (974400788, 'Rena Adamczewski', to_date('18-09-2001', 'dd-mm-yyyy'), 'renaadamczewski@yelp.com', 586756276, '35 Kensington Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (879861476, 'Reina Thalmann', to_date('29-06-2005', 'dd-mm-yyyy'), 'reinathalmann@yellowbook.com', 580906886, '10 Pine View Hill');
commit;
prompt 100 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (936769324, 'Philly Eydel', to_date('15-03-2010', 'dd-mm-yyyy'), 'phillyeydel@engadget.com', 552038660, '21468 8th Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (135014039, 'Sarette Manchester', to_date('24-10-2009', 'dd-mm-yyyy'), 'sarettemanchester@mac.com', 581086908, '382 Evergreen Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (310279833, 'Gwenette Antonias', to_date('02-11-2002', 'dd-mm-yyyy'), 'gwenetteantonias@macromedia.com', 528080565, '4877 Walton Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (986676799, 'Blake Longthorn', to_date('16-09-2001', 'dd-mm-yyyy'), 'blakelongthorn@ihg.com', 579909840, '31703 Scofield Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (524148126, 'Loree Schaumaker', to_date('05-04-2004', 'dd-mm-yyyy'), 'loreeschaumaker@vistaprint.com', 590469419, '91 Anderson Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (350723928, 'Nariko Crewe', to_date('24-10-2002', 'dd-mm-yyyy'), 'narikocrewe@nbcnews.com', 512787518, '78207 Talisman Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (547111578, 'Con Peddar', to_date('22-09-2018', 'dd-mm-yyyy'), 'conpeddar@gov.uk', 579963013, '377 Crownhardt Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (388509855, 'Cristabel Barthod', to_date('19-05-2005', 'dd-mm-yyyy'), 'cristabelbarthod@mail.ru', 501933673, '84355 Truax Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (889445318, 'Blythe Yanez', to_date('20-03-2010', 'dd-mm-yyyy'), 'blytheyanez@tripadvisor.com', 534140516, '862 Roxbury Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (487955324, 'Dode Salazar', to_date('28-06-2001', 'dd-mm-yyyy'), 'dodesalazar@newyorker.com', 510043001, '6489 5th Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (638472575, 'Jerry Taylerson', to_date('12-07-2014', 'dd-mm-yyyy'), 'jerrytaylerson@mysql.com', 560100458, '0 Randy Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (663196582, 'Ruthe Kilfeder', to_date('11-01-2014', 'dd-mm-yyyy'), 'ruthekilfeder@nature.com', 559103394, '95521 Reinke Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (326324737, 'Luz Wyldbore', to_date('04-03-2006', 'dd-mm-yyyy'), 'luzwyldbore@bloglines.com', 507876252, '19 Tomscot Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (578729163, 'Xena Tootal', to_date('02-07-2015', 'dd-mm-yyyy'), 'xenatootal@thetimes.co.uk', 527894146, '50 Fairview Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (595707449, 'Veronica Steed', to_date('25-05-2014', 'dd-mm-yyyy'), 'veronicasteed@macromedia.com', 584467120, '354 Hanover Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (913264381, 'Deirdre Schaffel', to_date('13-01-2019', 'dd-mm-yyyy'), 'deirdreschaffel@parallels.com', 511597048, '64719 Service Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (797524319, 'Wilhelmine Tolfrey', to_date('18-06-2009', 'dd-mm-yyyy'), 'wilhelminetolfrey@unblog.fr', 558929324, '579 Springview Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (182765780, 'Augustine Kubicek', to_date('17-08-2018', 'dd-mm-yyyy'), 'augustinekubicek@foxnews.com', 533920323, '5 Center Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (945448417, 'Dedie Birkwood', to_date('10-01-2005', 'dd-mm-yyyy'), 'dediebirkwood@vkontakte.ru', 547920550, '3880 Old Gate Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (310735882, 'Ines Bampford', to_date('07-04-2014', 'dd-mm-yyyy'), 'inesbampford@weibo.com', 518671724, '16314 Bluestem Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (555936029, 'Amandi Issett', to_date('19-10-2005', 'dd-mm-yyyy'), 'amandiissett@dot.gov', 519043324, '764 Lillian Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (478765875, 'Elene Maskall', to_date('11-06-2013', 'dd-mm-yyyy'), 'elenemaskall@seesaa.net', 569570316, '6 Spaight Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (943569264, 'Lillis Schindler', to_date('07-08-2015', 'dd-mm-yyyy'), 'lillisschindler@themeforest.net', 545805075, '073 Ludington Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (233045254, 'Nadean Hardin', to_date('26-01-2002', 'dd-mm-yyyy'), 'nadeanhardin@mysql.com', 504341791, '7716 Drewry Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (890819891, 'Bekki Phare', to_date('11-03-2014', 'dd-mm-yyyy'), 'bekkiphare@walmart.com', 508598445, '783 Stang Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (742378510, 'Bree Tremathick', to_date('28-07-2005', 'dd-mm-yyyy'), 'breetremathick@sciencedirect.com', 574907009, '14524 Truax Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (751450151, 'Josey Arthurs', to_date('14-09-2001', 'dd-mm-yyyy'), 'joseyarthurs@constantcontact.com', 569487201, '67264 Maple Wood Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (826640267, 'Ainslie Reddecliffe', to_date('19-09-2005', 'dd-mm-yyyy'), 'ainsliereddecliffe@discovery.com', 561408752, '7 Muir Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (402986300, 'Marge Higginbottam', to_date('22-01-2019', 'dd-mm-yyyy'), 'margehigginbottam@narod.ru', 566666121, '1 Leroy Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (473903044, 'Maryellen Paulich', to_date('11-10-2001', 'dd-mm-yyyy'), 'maryellenpaulich@webmd.com', 582049702, '11 Eagan Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (651934519, 'Tisha De Bruin', to_date('19-11-2011', 'dd-mm-yyyy'), 'tishade bruin@amazon.co.uk', 573044859, '29 Michigan Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (962501060, 'Lindy Ghilardi', to_date('31-12-2019', 'dd-mm-yyyy'), 'lindyghilardi@multiply.com', 527244710, '446 Sunfield Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (400057384, 'Evvie Manford', to_date('26-07-2010', 'dd-mm-yyyy'), 'evviemanford@ucoz.com', 564735422, '1369 Doe Crossing Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (236023849, 'Miquela Cropton', to_date('23-10-2004', 'dd-mm-yyyy'), 'miquelacropton@sbwire.com', 501353237, '9101 Harbort Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (234449706, 'Opal Houston', to_date('05-11-2002', 'dd-mm-yyyy'), 'opalhouston@statcounter.com', 570472455, '354 Cardinal Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (462236022, 'Billy Tytler', to_date('20-03-2009', 'dd-mm-yyyy'), 'billytytler@mashable.com', 534637218, '9 Jenna Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (926537995, 'Lynett Hubbold', to_date('28-12-2004', 'dd-mm-yyyy'), 'lynetthubbold@wsj.com', 553526886, '747 Bellgrove Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (120818128, 'Rheta Schout', to_date('19-04-2004', 'dd-mm-yyyy'), 'rhetaschout@domainmarket.com', 574759531, '7 Stuart Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (650627337, 'Elicia Colbrun', to_date('02-05-2016', 'dd-mm-yyyy'), 'eliciacolbrun@list-manage.com', 509329990, '94 Lillian Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (326809666, 'Corabella Antonov', to_date('27-01-2014', 'dd-mm-yyyy'), 'corabellaantonov@issuu.com', 563839421, '32075 Old Gate Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (547106878, 'Raven McKinless', to_date('25-03-2002', 'dd-mm-yyyy'), 'ravenmckinless@homestead.com', 585816040, '02645 Bultman Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (686236374, 'Marcelia Dunaway', to_date('03-02-2019', 'dd-mm-yyyy'), 'marceliadunaway@theatlantic.com', 561557535, '376 Hovde Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (174600853, 'Rafaela Ellams', to_date('11-12-2000', 'dd-mm-yyyy'), 'rafaelaellams@aboutads.info', 556753473, '86 Graedel Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (654126598, 'Dollie Ellams', to_date('14-08-2002', 'dd-mm-yyyy'), 'dollieellams@github.io', 516022867, '285 Starling Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (815342732, 'Jacinda Lendon', to_date('22-01-2003', 'dd-mm-yyyy'), 'jacindalendon@google.it', 560958631, '6 Carioca Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (301145806, 'Katha Seath', to_date('15-09-2009', 'dd-mm-yyyy'), 'kathaseath@wordpress.com', 546890609, '59 Homewood Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (385313476, 'Kati Wilber', to_date('21-06-2018', 'dd-mm-yyyy'), 'katiwilber@live.com', 513244834, '6 Butterfield Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (369293915, 'Jocelin Olivas', to_date('31-01-2005', 'dd-mm-yyyy'), 'jocelinolivas@state.gov', 578189539, '683 Melody Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (159358320, 'Amara Zywicki', to_date('19-04-2012', 'dd-mm-yyyy'), 'amarazywicki@amazonaws.com', 549628091, '75 Moland Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (364362923, 'Alyce De Stoop', to_date('28-01-2000', 'dd-mm-yyyy'), 'alycede stoop@discovery.com', 540238371, '50523 Esch Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (846842975, 'Stevana Scain', to_date('25-05-2016', 'dd-mm-yyyy'), 'stevanascain@goo.gl', 568991690, '8 Fisk Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (723305141, 'Editha Hodjetts', to_date('16-01-2002', 'dd-mm-yyyy'), 'edithahodjetts@wp.com', 575766234, '09 Hazelcrest Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (619987847, 'Lorelei Gludor', to_date('30-03-2004', 'dd-mm-yyyy'), 'loreleigludor@jalbum.net', 520255311, '51560 Mcguire Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (605627994, 'Marci Clayfield', to_date('22-10-2007', 'dd-mm-yyyy'), 'marciclayfield@delicious.com', 563685585, '10450 Hauk Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (807314354, 'Emelyne Goretti', to_date('31-10-2018', 'dd-mm-yyyy'), 'emelynegoretti@hud.gov', 548306314, '51 Russell Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (451638714, 'Vivienne Kingsworth', to_date('11-09-2005', 'dd-mm-yyyy'), 'viviennekingsworth@a8.net', 521390955, '9 Service Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (206213664, 'Sherline Shermar', to_date('04-02-2008', 'dd-mm-yyyy'), 'sherlineshermar@nationalgeographic.com', 501161896, '51 Dawn Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (166897367, 'Kelsy Fishe', to_date('03-09-2003', 'dd-mm-yyyy'), 'kelsyfishe@hibu.com', 555000374, '02 Del Sol Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (490172289, 'Helge Worling', to_date('17-11-2015', 'dd-mm-yyyy'), 'helgeworling@dmoz.org', 510951059, '59 Sutherland Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (894869026, 'Tillie Hammor', to_date('22-01-2010', 'dd-mm-yyyy'), 'tilliehammor@apache.org', 504951153, '03 Bluestem Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (612699405, 'Ursa Axcell', to_date('21-08-2014', 'dd-mm-yyyy'), 'ursaaxcell@liveinternet.ru', 544952203, '1356 Arkansas Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (249640786, 'Glynis Cream', to_date('12-06-2000', 'dd-mm-yyyy'), 'glyniscream@usnews.com', 564023247, '88785 Jay Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (496859662, 'Roobbie Blakely', to_date('16-08-2003', 'dd-mm-yyyy'), 'roobbieblakely@ed.gov', 550919676, '82 Harbort Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (326667328, 'Vonny Augar', to_date('15-04-2017', 'dd-mm-yyyy'), 'vonnyaugar@upenn.edu', 581501298, '9538 Eliot Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (878995495, 'Anet Astman', to_date('18-06-2017', 'dd-mm-yyyy'), 'anetastman@dailymail.co.uk', 513751725, '9 Spaight Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (175518300, 'Chad Bladge', to_date('01-11-2000', 'dd-mm-yyyy'), 'chadbladge@sakura.ne.jp', 581516185, '3 8th Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (485986553, 'Pearl Sussems', to_date('06-11-2002', 'dd-mm-yyyy'), 'pearlsussems@exblog.jp', 554125536, '05363 Twin Pines Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (722932897, 'Florence Rameaux', to_date('24-04-2010', 'dd-mm-yyyy'), 'florencerameaux@howstuffworks.com', 504157540, '1386 Evergreen Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (139741096, 'Emelda Pigden', to_date('03-01-2018', 'dd-mm-yyyy'), 'emeldapigden@timesonline.co.uk', 568739679, '5 Stephen Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (885521932, 'Clary Millam', to_date('25-07-2019', 'dd-mm-yyyy'), 'clarymillam@virginia.edu', 502926484, '55801 Esch Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (747163297, 'Alanah Farnhill', to_date('16-11-2001', 'dd-mm-yyyy'), 'alanahfarnhill@mtv.com', 574545298, '2269 Meadow Valley Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (318059796, 'Bobette Lubbock', to_date('20-12-2014', 'dd-mm-yyyy'), 'bobettelubbock@wired.com', 511865067, '4 South Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (682573186, 'Erda Lamond', to_date('01-08-2009', 'dd-mm-yyyy'), 'erdalamond@dailymotion.com', 583096440, '550 Farmco Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (402230125, 'Carissa Lillie', to_date('24-02-2007', 'dd-mm-yyyy'), 'carissalillie@clickbank.net', 536991005, '2 Coolidge Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (266606670, 'Brunhilda Jado', to_date('13-09-2003', 'dd-mm-yyyy'), 'brunhildajado@unblog.fr', 589644994, '4 Canary Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (753413531, 'Merrile Corcoran', to_date('20-02-2017', 'dd-mm-yyyy'), 'merrilecorcoran@nps.gov', 577553036, '1 Butternut Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (856012405, 'Cari Weeds', to_date('14-06-2014', 'dd-mm-yyyy'), 'cariweeds@ehow.com', 527752321, '66 Quincy Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (750212736, 'Olimpia Sprigin', to_date('20-06-2003', 'dd-mm-yyyy'), 'olimpiasprigin@weather.com', 551715156, '99140 Daystar Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (315016381, 'Erin Blaker', to_date('15-11-2003', 'dd-mm-yyyy'), 'erinblaker@oracle.com', 530211264, '882 Judy Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (718189291, 'Doroteya Daughtery', to_date('04-04-2007', 'dd-mm-yyyy'), 'doroteyadaughtery@princeton.edu', 536169570, '09090 Crownhardt Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (816251377, 'Sashenka Wais', to_date('31-12-2004', 'dd-mm-yyyy'), 'sashenkawais@jugem.jp', 520648603, '9827 1st Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (994000381, 'Benedicta Painten', to_date('16-12-2019', 'dd-mm-yyyy'), 'benedictapainten@aol.com', 538758114, '773 Sheridan Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (639121639, 'Ulla Hambrook', to_date('01-11-2011', 'dd-mm-yyyy'), 'ullahambrook@skyrock.com', 551761502, '43 Division Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (305926726, 'Ame Hearty', to_date('30-09-2019', 'dd-mm-yyyy'), 'amehearty@vistaprint.com', 582250232, '6 Summer Ridge Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (449140830, 'Therine Dunley', to_date('11-04-2009', 'dd-mm-yyyy'), 'therinedunley@wisc.edu', 541835157, '8630 Trailsway Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (487397320, 'Chantal Lindeboom', to_date('22-01-2008', 'dd-mm-yyyy'), 'chantallindeboom@cam.ac.uk', 581364018, '2 Superior Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (343015765, 'Tanitansy Hounsom', to_date('28-07-2008', 'dd-mm-yyyy'), 'tanitansyhounsom@unblog.fr', 575620649, '186 7th Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (774685658, 'Brigida Hardstaff', to_date('28-02-2018', 'dd-mm-yyyy'), 'brigidahardstaff@adobe.com', 560373051, '79 Jenifer Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (794769332, 'Aeriell Matiewe', to_date('14-03-2012', 'dd-mm-yyyy'), 'aeriellmatiewe@economist.com', 587938956, '95898 Canary Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (957537094, 'Renae Dabrowski', to_date('01-12-2006', 'dd-mm-yyyy'), 'renaedabrowski@nymag.com', 581208086, '9931 Trailsway Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (854805518, 'Harmony Fishpoole', to_date('23-09-2011', 'dd-mm-yyyy'), 'harmonyfishpoole@ed.gov', 575520022, '967 Little Fleur Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (529348579, 'Polly Caddick', to_date('09-07-2001', 'dd-mm-yyyy'), 'pollycaddick@cdbaby.com', 556646260, '4153 Towne Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (840341264, 'Natasha Hugnot', to_date('10-05-2002', 'dd-mm-yyyy'), 'natashahugnot@baidu.com', 509468604, '38 Lindbergh Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (347912421, 'Lucretia Todd', to_date('11-07-2005', 'dd-mm-yyyy'), 'lucretiatodd@163.com', 510763057, '4678 Talmadge Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (347035403, 'Nanny Drane', to_date('28-06-2013', 'dd-mm-yyyy'), 'nannydrane@state.gov', 586838488, '531 Rieder Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (522734503, 'Daisi Stiger', to_date('07-10-2007', 'dd-mm-yyyy'), 'daisistiger@bizjournals.com', 567499075, '97326 Warner Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (615422014, 'Janeen Olivier', to_date('18-12-2008', 'dd-mm-yyyy'), 'janeenolivier@theglobeandmail.com', 550353051, '962 School Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (877677760, 'Johnette Lamputt', to_date('27-08-2008', 'dd-mm-yyyy'), 'johnettelamputt@census.gov', 581989101, '2 Reindahl Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (802904951, 'Maurene Baxter', to_date('19-02-2004', 'dd-mm-yyyy'), 'maurenebaxter@1und1.de', 555996131, '26122 Bartillon Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (476308716, 'Fania Toy', to_date('03-11-2009', 'dd-mm-yyyy'), 'faniatoy@cyberchimps.com', 566119366, '9560 Raven Park');
commit;
prompt 200 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (485682956, 'Ashleigh Biddiss', to_date('09-01-2010', 'dd-mm-yyyy'), 'ashleighbiddiss@t.co', 575248708, '11418 Garrison Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (512652034, 'Kathryne Skelton', to_date('20-06-2014', 'dd-mm-yyyy'), 'kathryneskelton@nydailynews.com', 543304507, '93783 Ludington Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (396469378, 'Karil Baguley', to_date('26-01-2006', 'dd-mm-yyyy'), 'karilbaguley@nasa.gov', 577018088, '370 Drewry Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (902058409, 'Almira Lukes', to_date('15-04-2015', 'dd-mm-yyyy'), 'almiralukes@wisc.edu', 536599250, '212 Northland Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (293210110, 'Silvana Matiebe', to_date('29-09-2012', 'dd-mm-yyyy'), 'silvanamatiebe@slashdot.org', 575322182, '39 Pine View Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (215074393, 'Kellie Kissick', to_date('20-04-2002', 'dd-mm-yyyy'), 'kelliekissick@wikia.com', 515312963, '3991 Parkside Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (779757808, 'Beverlee Berggren', to_date('21-11-2017', 'dd-mm-yyyy'), 'beverleeberggren@desdev.cn', 578197217, '22 Cordelia Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (485862308, 'Dixie McCaskell', to_date('09-03-2018', 'dd-mm-yyyy'), 'dixiemccaskell@narod.ru', 563160679, '98945 Duke Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (876495432, 'Adan MacLeese', to_date('17-05-2018', 'dd-mm-yyyy'), 'adanmacleese@boston.com', 507581424, '6560 Hooker Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (645064381, 'Harriett Vennart', to_date('20-07-2007', 'dd-mm-yyyy'), 'harriettvennart@ucoz.com', 524711351, '769 Hayes Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (285418152, 'Velma Ovenden', to_date('29-12-2005', 'dd-mm-yyyy'), 'velmaovenden@xrea.com', 547617785, '7 Jenifer Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (687464649, 'Zena Huncoot', to_date('02-08-2017', 'dd-mm-yyyy'), 'zenahuncoot@cnet.com', 539562900, '308 Westport Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (277855177, 'Vivyan Wager', to_date('22-04-2016', 'dd-mm-yyyy'), 'vivyanwager@dedecms.com', 533474065, '4 Scoville Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (359211432, 'Sonja Manion', to_date('09-08-2004', 'dd-mm-yyyy'), 'sonjamanion@tumblr.com', 541924062, '0 Hooker Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (254571947, 'Elfrieda Nieass', to_date('15-01-2002', 'dd-mm-yyyy'), 'elfriedanieass@pagesperso-orange.fr', 505299540, '75692 Derek Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (478438487, 'Shelly Champniss', to_date('01-03-2006', 'dd-mm-yyyy'), 'shellychampniss@nymag.com', 574917849, '73 Novick Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (739747358, 'Chrissie Mabbot', to_date('04-05-2004', 'dd-mm-yyyy'), 'chrissiemabbot@jugem.jp', 534418946, '8 Jay Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (267556727, 'Devina Mendes', to_date('07-03-2001', 'dd-mm-yyyy'), 'devinamendes@edublogs.org', 586412005, '601 Charing Cross Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (204329406, 'Anatola Read', to_date('06-02-2003', 'dd-mm-yyyy'), 'anatolaread@narod.ru', 589951588, '979 American Ash Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (731977144, 'Hortense Ivanikov', to_date('17-09-2004', 'dd-mm-yyyy'), 'hortenseivanikov@china.com.cn', 533848595, '5137 Sutteridge Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (234814837, 'Donielle Benedetti', to_date('18-04-2019', 'dd-mm-yyyy'), 'doniellebenedetti@examiner.com', 530567837, '17 Mccormick Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (683067812, 'Guillema Nequest', to_date('19-08-2017', 'dd-mm-yyyy'), 'guillemanequest@google.de', 502262542, '6039 Hansons Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (541784559, 'Janaya Lidgerton', to_date('27-10-2004', 'dd-mm-yyyy'), 'janayalidgerton@is.gd', 518743573, '59935 Bluejay Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (583838247, 'Tallou Pretsel', to_date('28-09-2000', 'dd-mm-yyyy'), 'talloupretsel@alexa.com', 566466184, '7690 Hoard Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (456215620, 'Annette Liddel', to_date('04-08-2012', 'dd-mm-yyyy'), 'annetteliddel@dion.ne.jp', 576229729, '817 Browning Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (496967655, 'Tania Adamik', to_date('15-07-2014', 'dd-mm-yyyy'), 'taniaadamik@sciencedirect.com', 543767493, '425 Prairieview Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (841688466, 'Hollyanne Thornewell', to_date('18-10-2007', 'dd-mm-yyyy'), 'hollyannethornewell@sfgate.com', 529275627, '184 Laurel Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (685512872, 'Idette Douthwaite', to_date('21-08-2011', 'dd-mm-yyyy'), 'idettedouthwaite@reference.com', 504517921, '3 Southridge Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (696579829, 'Giana Severns', to_date('15-02-2016', 'dd-mm-yyyy'), 'gianaseverns@soup.io', 574800642, '24 Chinook Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (271443539, 'Deedee Droogan', to_date('26-05-2016', 'dd-mm-yyyy'), 'deedeedroogan@hugedomains.com', 559794449, '33015 Sugar Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (515439710, 'Sherill Gytesham', to_date('11-09-2010', 'dd-mm-yyyy'), 'sherillgytesham@ftc.gov', 556030770, '668 Old Shore Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (687579680, 'Eloisa Micka', to_date('18-02-2010', 'dd-mm-yyyy'), 'eloisamicka@theguardian.com', 521300715, '2570 Maryland Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (463440005, 'Ruthi Yukhin', to_date('02-04-2016', 'dd-mm-yyyy'), 'ruthiyukhin@godaddy.com', 538525575, '0134 Buena Vista Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (566318538, 'Katee Canwell', to_date('17-12-2013', 'dd-mm-yyyy'), 'kateecanwell@ow.ly', 564871803, '6438 Dovetail Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (276224889, 'Quintina Deathridge', to_date('04-07-2014', 'dd-mm-yyyy'), 'quintinadeathridge@xinhuanet.com', 547658098, '7 Victoria Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (648872364, 'Flora Perigeaux', to_date('09-05-2016', 'dd-mm-yyyy'), 'floraperigeaux@craigslist.org', 511507112, '151 Mifflin Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (730570311, 'Coleen Gilchrest', to_date('24-06-2003', 'dd-mm-yyyy'), 'coleengilchrest@google.de', 525094372, '088 Red Cloud Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (579654604, 'Venita Judge', to_date('27-12-2018', 'dd-mm-yyyy'), 'venitajudge@ebay.com', 586752548, '4 Judy Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (227242697, 'Rubi Jinkinson', to_date('14-12-2001', 'dd-mm-yyyy'), 'rubijinkinson@multiply.com', 557758187, '15 Blue Bill Park Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (337816724, 'Blair Ormistone', to_date('09-01-2005', 'dd-mm-yyyy'), 'blairormistone@yahoo.co.jp', 584893050, '96 Veith Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (776623460, 'Ardisj Syrett', to_date('31-01-2019', 'dd-mm-yyyy'), 'ardisjsyrett@sitemeter.com', 542788800, '101 Marcy Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (536750145, 'Kip Moyser', to_date('17-11-2017', 'dd-mm-yyyy'), 'kipmoyser@who.int', 528040316, '1 Sycamore Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (717787972, 'Myrtie Hancill', to_date('07-11-2002', 'dd-mm-yyyy'), 'myrtiehancill@cbc.ca', 539276018, '4 Westerfield Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (183639285, 'Pandora Derry', to_date('22-03-2004', 'dd-mm-yyyy'), 'pandoraderry@cnn.com', 555402729, '062 Manufacturers Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (818728280, 'Cordy Valler', to_date('01-05-2003', 'dd-mm-yyyy'), 'cordyvaller@livejournal.com', 541074903, '8056 Vernon Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (951075931, 'Joela Reach', to_date('16-11-2000', 'dd-mm-yyyy'), 'joelareach@apple.com', 560515623, '5 Loomis Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (584640968, 'Francoise Mullord', to_date('22-03-2012', 'dd-mm-yyyy'), 'francoisemullord@nbcnews.com', 559819252, '387 Westerfield Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (874834733, 'Tiffy Wicher', to_date('24-12-2014', 'dd-mm-yyyy'), 'tiffywicher@imageshack.us', 510913551, '9 Briar Crest Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (570953732, 'Cindy Mogie', to_date('04-12-2001', 'dd-mm-yyyy'), 'cindymogie@unblog.fr', 541689037, '095 Summerview Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (871846808, 'Barby Meakin', to_date('28-10-2002', 'dd-mm-yyyy'), 'barbymeakin@arizona.edu', 513356770, '5140 Kingsford Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (406508183, 'Elane Godart', to_date('16-08-2015', 'dd-mm-yyyy'), 'elanegodart@clickbank.net', 571751427, '36 Schurz Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (602026165, 'Nerty Weedall', to_date('27-09-2006', 'dd-mm-yyyy'), 'nertyweedall@imgur.com', 557306521, '473 Hollow Ridge Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (860551807, 'Alli Mosdall', to_date('02-02-2018', 'dd-mm-yyyy'), 'allimosdall@mit.edu', 513167556, '9986 Loftsgordon Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (699214173, 'Tami Joannic', to_date('28-01-2001', 'dd-mm-yyyy'), 'tamijoannic@google.nl', 521337978, '28 Dayton Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (358460781, 'Jennilee Poag', to_date('12-01-2003', 'dd-mm-yyyy'), 'jennileepoag@slideshare.net', 507275527, '2 Toban Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (453064263, 'Michel Ceschini', to_date('22-12-2004', 'dd-mm-yyyy'), 'michelceschini@usda.gov', 538300246, '614 Mariners Cove Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (259933017, 'Maressa Norsister', to_date('16-10-2008', 'dd-mm-yyyy'), 'maressanorsister@huffingtonpost.com', 560589583, '8 Marcy Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (649501080, 'Averil Carrel', to_date('05-02-2015', 'dd-mm-yyyy'), 'averilcarrel@jiathis.com', 501167187, '85969 Bartelt Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (850393521, 'Hetti Hubball', to_date('08-03-2013', 'dd-mm-yyyy'), 'hettihubball@cyberchimps.com', 569497792, '744 Ruskin Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (871722354, 'Clareta Maypother', to_date('17-06-2010', 'dd-mm-yyyy'), 'claretamaypother@google.es', 586592361, '1356 Dovetail Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (729277013, 'Nari Dimond', to_date('21-10-2018', 'dd-mm-yyyy'), 'naridimond@weibo.com', 510100078, '9905 Brickson Park Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (942515529, 'Celina Casin', to_date('13-11-2019', 'dd-mm-yyyy'), 'celinacasin@oracle.com', 513514478, '754 Dwight Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (137205302, 'Reggi Pepin', to_date('09-09-2000', 'dd-mm-yyyy'), 'reggipepin@guardian.co.uk', 554935300, '18 Springview Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (725424742, 'Fredelia Trask', to_date('10-07-2019', 'dd-mm-yyyy'), 'fredeliatrask@reference.com', 527833766, '9166 Rockefeller Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (294004123, 'Mariellen Knivett', to_date('01-10-2009', 'dd-mm-yyyy'), 'mariellenknivett@marketwatch.com', 549524566, '8050 Reindahl Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (532385675, 'Raina Yakuntzov', to_date('25-02-2017', 'dd-mm-yyyy'), 'rainayakuntzov@hc360.com', 568521304, '515 Leroy Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (790221207, 'Peta Clarridge', to_date('18-06-2000', 'dd-mm-yyyy'), 'petaclarridge@ebay.com', 578854585, '7617 Corben Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (612546655, 'Lishe Caslake', to_date('13-01-2016', 'dd-mm-yyyy'), 'lishecaslake@noaa.gov', 522862996, '88862 Fremont Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (622700951, 'Aloise Stower', to_date('07-10-2016', 'dd-mm-yyyy'), 'aloisestower@fotki.com', 516453717, '0602 Hanson Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (492313313, 'Lucine Greensides', to_date('21-10-2000', 'dd-mm-yyyy'), 'lucinegreensides@techcrunch.com', 579972389, '1775 South Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (889678021, 'Vitia Kuhnke', to_date('13-03-2013', 'dd-mm-yyyy'), 'vitiakuhnke@fotki.com', 559636475, '91 Springview Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (448882818, 'Junette Stride', to_date('27-07-2000', 'dd-mm-yyyy'), 'junettestride@weebly.com', 573179027, '408 Mitchell Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (635968955, 'Torey Beaty', to_date('28-04-2004', 'dd-mm-yyyy'), 'toreybeaty@bbc.co.uk', 543844008, '348 Nobel Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (141926107, 'Katine Rennox', to_date('14-09-2011', 'dd-mm-yyyy'), 'katinerennox@constantcontact.com', 545202316, '79 Brown Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (504390279, 'Sharla Haylor', to_date('21-10-2002', 'dd-mm-yyyy'), 'sharlahaylor@tinypic.com', 564123841, '10 David Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (158783600, 'Evy Lafayette', to_date('15-07-2010', 'dd-mm-yyyy'), 'evylafayette@mtv.com', 576202813, '36 Beilfuss Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (887429256, 'Sabine Stidson', to_date('08-07-2003', 'dd-mm-yyyy'), 'sabinestidson@oracle.com', 534541241, '61964 Jenifer Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (733840300, 'Darrelle Simonazzi', to_date('02-03-2014', 'dd-mm-yyyy'), 'darrellesimonazzi@wufoo.com', 539665353, '4 Lindbergh Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (254647820, 'Alethea Bonar', to_date('04-09-2013', 'dd-mm-yyyy'), 'aletheabonar@scientificamerican.com', 501822997, '754 Huxley Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (199668456, 'Cariotta Lude', to_date('20-08-2006', 'dd-mm-yyyy'), 'cariottalude@myspace.com', 516607412, '147 Talmadge Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (892744392, 'Jannelle Daynter', to_date('21-03-2004', 'dd-mm-yyyy'), 'jannelledaynter@marriott.com', 506096674, '2 Mitchell Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (449337529, 'Siana Buckle', to_date('08-10-2000', 'dd-mm-yyyy'), 'sianabuckle@cmu.edu', 543578737, '803 Buhler Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (446811236, 'Fan Twizell', to_date('28-11-2009', 'dd-mm-yyyy'), 'fantwizell@csmonitor.com', 545553471, '0 Glendale Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (171853644, 'Corey Pedrollo', to_date('17-10-2005', 'dd-mm-yyyy'), 'coreypedrollo@free.fr', 590001821, '9 Crowley Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (488283015, 'Marita Brawn', to_date('11-02-2017', 'dd-mm-yyyy'), 'maritabrawn@pinterest.com', 558755328, '61 Crescent Oaks Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (720258585, 'Linet Feather', to_date('23-10-2016', 'dd-mm-yyyy'), 'linetfeather@goodreads.com', 534672079, '3 Fallview Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (546869010, 'Hynda Stanlike', to_date('17-08-2011', 'dd-mm-yyyy'), 'hyndastanlike@google.ca', 542787295, '02922 Charing Cross Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (811608430, 'Ami McGrah', to_date('03-05-2011', 'dd-mm-yyyy'), 'amimcgrah@admin.ch', 547635861, '4 Knutson Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (197218839, 'Daffy Helix', to_date('19-08-2003', 'dd-mm-yyyy'), 'daffyhelix@smh.com.au', 522310483, '1099 Kedzie Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (148198111, 'Audrey Coniam', to_date('20-04-2018', 'dd-mm-yyyy'), 'audreyconiam@eventbrite.com', 525989564, '533 Glacier Hill Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (710261527, 'Margo Wint', to_date('26-03-2000', 'dd-mm-yyyy'), 'margowint@alibaba.com', 557209862, '101 Helena Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (532306379, 'Robbyn Ockendon', to_date('06-06-2010', 'dd-mm-yyyy'), 'robbynockendon@oaic.gov.au', 548357737, '3 Di Loreto Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (554489252, 'Mona Potticary', to_date('09-05-2017', 'dd-mm-yyyy'), 'monapotticary@google.com.hk', 557869077, '48562 Waywood Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (164659178, 'Sibbie Ainley', to_date('21-06-2013', 'dd-mm-yyyy'), 'sibbieainley@furl.net', 566536470, '2 Pine View Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (971401539, 'Kassandra Honsch', to_date('11-09-2003', 'dd-mm-yyyy'), 'kassandrahonsch@admin.ch', 520052576, '2 Schlimgen Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (360115867, 'Randi Seleway', to_date('02-10-2015', 'dd-mm-yyyy'), 'randiseleway@gizmodo.com', 558616460, '34 Ridgeway Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (176236963, 'Jillane Collcutt', to_date('21-10-2002', 'dd-mm-yyyy'), 'jillanecollcutt@list-manage.com', 506555919, '69 Bluejay Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (543909374, 'Salomi Pringour', to_date('05-01-2012', 'dd-mm-yyyy'), 'salomipringour@networksolutions.com', 556420712, '05413 Waxwing Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (778935652, 'Carlina Kirkham', to_date('20-06-2000', 'dd-mm-yyyy'), 'carlinakirkham@paginegialle.it', 531017527, '0415 Fremont Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (753024805, 'Aleta Dalgety', to_date('05-06-2008', 'dd-mm-yyyy'), 'aletadalgety@amazonaws.com', 546383053, '0 Golf Course Parkway');
commit;
prompt 300 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (105762273, 'Elmira Minchi', to_date('03-09-2014', 'dd-mm-yyyy'), 'elmiraminchi@networkadvertising.org', 585752957, '48901 Crownhardt Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (170846994, 'Krystyna Goter', to_date('12-07-2003', 'dd-mm-yyyy'), 'krystynagoter@mayoclinic.com', 535661683, '4 Loeprich Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (669449784, 'Elsbeth Mattersley', to_date('16-05-2005', 'dd-mm-yyyy'), 'elsbethmattersley@ucsd.edu', 503118945, '21283 Hoffman Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (615586328, 'Karil Feldon', to_date('08-10-2004', 'dd-mm-yyyy'), 'karilfeldon@cmu.edu', 577487085, '43152 Buhler Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (563999692, 'Tana Blincko', to_date('19-10-2008', 'dd-mm-yyyy'), 'tanablincko@symantec.com', 558967443, '2 Eliot Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (874216918, 'Roxanna Berendsen', to_date('17-04-2018', 'dd-mm-yyyy'), 'roxannaberendsen@hp.com', 568514707, '51036 Wayridge Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (433173537, 'Kris Vequaud', to_date('25-10-2006', 'dd-mm-yyyy'), 'krisvequaud@cbslocal.com', 572004093, '709 Golden Leaf Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (872713068, 'Rycca Dufaire', to_date('03-02-2013', 'dd-mm-yyyy'), 'ryccadufaire@naver.com', 524872413, '764 Westport Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (551526087, 'Sal Hanney', to_date('13-01-2019', 'dd-mm-yyyy'), 'salhanney@squarespace.com', 526967285, '249 Daystar Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (399360066, 'Chelsea Rudyard', to_date('25-12-2000', 'dd-mm-yyyy'), 'chelsearudyard@washingtonpost.com', 571355389, '58 Carpenter Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (660043671, 'Cathyleen Nolte', to_date('18-01-2004', 'dd-mm-yyyy'), 'cathyleennolte@newyorker.com', 528230719, '02 Merchant Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (436478397, 'Ariana O''Keaveny', to_date('19-09-2001', 'dd-mm-yyyy'), 'arianao''keaveny@networksolutions.com', 520729091, '4049 Darwin Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (737627430, 'Almira Benoi', to_date('31-08-2001', 'dd-mm-yyyy'), 'almirabenoi@noaa.gov', 561754577, '5594 Claremont Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (250253966, 'Fania Kidney', to_date('01-01-2000', 'dd-mm-yyyy'), 'faniakidney@sakura.ne.jp', 564352634, '9 Stoughton Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (962072334, 'Auberta Leckey', to_date('06-05-2014', 'dd-mm-yyyy'), 'aubertaleckey@xing.com', 509012085, '016 Aberg Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (762821548, 'Katee Dibbe', to_date('09-08-2017', 'dd-mm-yyyy'), 'kateedibbe@spotify.com', 527562676, '63 Nobel Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (108592361, 'Annissa Chanson', to_date('25-03-2008', 'dd-mm-yyyy'), 'annissachanson@redcross.org', 571463320, '87767 Tony Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (432667348, 'Moll Oram', to_date('19-08-2018', 'dd-mm-yyyy'), 'molloram@illinois.edu', 557245791, '2 Transport Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (181676281, 'Myra Toretta', to_date('15-11-2015', 'dd-mm-yyyy'), 'myratoretta@oaic.gov.au', 523147974, '6 Monument Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (824563037, 'Rosana McHarry', to_date('09-04-2010', 'dd-mm-yyyy'), 'rosanamcharry@usgs.gov', 533703726, '95332 Banding Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (918190109, 'Cecil Wooton', to_date('19-04-2002', 'dd-mm-yyyy'), 'cecilwooton@lycos.com', 540423214, '0 Doe Crossing Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (481552416, 'Tani Spellecy', to_date('09-07-2009', 'dd-mm-yyyy'), 'tanispellecy@about.me', 519208663, '10305 Monterey Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (259281637, 'Shir Batchelar', to_date('06-04-2014', 'dd-mm-yyyy'), 'shirbatchelar@51.la', 561354026, '6284 Hooker Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (557605097, 'Leigh Mahon', to_date('08-07-2009', 'dd-mm-yyyy'), 'leighmahon@sun.com', 585202895, '07 Rigney Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (614694861, 'Vilma Bento', to_date('10-12-2006', 'dd-mm-yyyy'), 'vilmabento@goodreads.com', 555304138, '00126 Logan Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (518048280, 'Grayce Shuard', to_date('17-04-2012', 'dd-mm-yyyy'), 'grayceshuard@arizona.edu', 587750864, '71 Lunder Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (625557611, 'Tammie Darte', to_date('23-03-2017', 'dd-mm-yyyy'), 'tammiedarte@altervista.org', 504503701, '044 Homewood Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (789087097, 'Almeria Cust', to_date('22-10-2012', 'dd-mm-yyyy'), 'almeriacust@hhs.gov', 567876115, '05 Pine View Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (279785948, 'Constantia Gobeau', to_date('29-10-2017', 'dd-mm-yyyy'), 'constantiagobeau@ox.ac.uk', 555514717, '3833 Debra Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (370249439, 'Sallee Kennelly', to_date('07-06-2004', 'dd-mm-yyyy'), 'salleekennelly@eventbrite.com', 543241049, '3844 John Wall Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (120974857, 'Phebe D''Oyly', to_date('24-06-2011', 'dd-mm-yyyy'), 'phebed''oyly@cbc.ca', 512321180, '52607 Schurz Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (806611140, 'Maurise Crosskell', to_date('16-12-2007', 'dd-mm-yyyy'), 'maurisecrosskell@adobe.com', 558639943, '3770 Thackeray Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (721527128, 'Carmela Delwater', to_date('23-08-2012', 'dd-mm-yyyy'), 'carmeladelwater@vkontakte.ru', 551971355, '0 Morningstar Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (372489438, 'Wilma Cinavas', to_date('26-11-2005', 'dd-mm-yyyy'), 'wilmacinavas@smugmug.com', 504000208, '36 Barby Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (444894245, 'Rebe Smillie', to_date('14-07-2016', 'dd-mm-yyyy'), 'rebesmillie@t-online.de', 505064920, '69 Tomscot Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (318609792, 'Dre Dewbury', to_date('23-03-2008', 'dd-mm-yyyy'), 'dredewbury@reverbnation.com', 584208189, '9236 Nevada Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (154242474, 'Arden Hatt', to_date('02-05-2019', 'dd-mm-yyyy'), 'ardenhatt@twitpic.com', 532929356, '52 Thierer Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (787229074, 'Darbie Shambrooke', to_date('29-02-2012', 'dd-mm-yyyy'), 'darbieshambrooke@desdev.cn', 531791035, '28763 Sutherland Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (952669174, 'Fina Duligal', to_date('29-07-2006', 'dd-mm-yyyy'), 'finaduligal@ft.com', 580713778, '8448 Lindbergh Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (455135434, 'Teresina Troughton', to_date('17-04-2009', 'dd-mm-yyyy'), 'teresinatroughton@domainmarket.com', 559026140, '7741 Vahlen Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (506163412, 'Malynda Oliveti', to_date('12-12-2000', 'dd-mm-yyyy'), 'malyndaoliveti@t-online.de', 576032803, '8 Laurel Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (590478640, 'Dorothy Jansa', to_date('25-06-2008', 'dd-mm-yyyy'), 'dorothyjansa@sun.com', 530116213, '6 Lien Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (734673425, 'Corella Ackenson', to_date('26-08-2011', 'dd-mm-yyyy'), 'corellaackenson@ihg.com', 543402797, '5834 Sloan Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (390050758, 'Catina Gonzalo', to_date('21-05-2009', 'dd-mm-yyyy'), 'catinagonzalo@cnbc.com', 566945466, '4 Clove Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (997569877, 'Cecilia Vondracek', to_date('23-01-2017', 'dd-mm-yyyy'), 'ceciliavondracek@creativecommons.org', 560839133, '23321 Northfield Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (260871702, 'Orelle Milne', to_date('08-10-2007', 'dd-mm-yyyy'), 'orellemilne@weibo.com', 511021444, '9433 Manitowish Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (193082739, 'Britte De-Ville', to_date('19-05-2008', 'dd-mm-yyyy'), 'brittede-ville@japanpost.jp', 553623711, '5830 Merchant Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (465842181, 'Cassondra MacInnes', to_date('27-11-2007', 'dd-mm-yyyy'), 'cassondramacinnes@ask.com', 563689897, '98 Reindahl Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (553517298, 'Flore Sproston', to_date('10-11-2011', 'dd-mm-yyyy'), 'floresproston@t-online.de', 521031786, '251 Declaration Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (246273069, 'Sara-ann Facer', to_date('15-02-2014', 'dd-mm-yyyy'), 'sara-annfacer@photobucket.com', 510749823, '1 Mayer Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (257691173, 'Ingrid Ardley', to_date('09-07-2019', 'dd-mm-yyyy'), 'ingridardley@springer.com', 528377500, '4 Ruskin Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (731631935, 'Chiquia Wilcocke', to_date('07-05-2014', 'dd-mm-yyyy'), 'chiquiawilcocke@yandex.ru', 581021100, '92 Barnett Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441896465, 'Seana Heathfield', to_date('14-03-2015', 'dd-mm-yyyy'), 'seanaheathfield@theglobeandmail.com', 537276255, '1 New Castle Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (784915922, 'Adrianne Wadie', to_date('01-03-2011', 'dd-mm-yyyy'), 'adriannewadie@devhub.com', 558957501, '355 Parkside Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (434361920, 'Jamima Laise', to_date('18-12-2014', 'dd-mm-yyyy'), 'jamimalaise@nih.gov', 569474426, '7 Mayer Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (821749542, 'Danit Darracott', to_date('13-12-2011', 'dd-mm-yyyy'), 'danitdarracott@ebay.com', 584789223, '5543 Mcguire Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (712214343, 'Janis Deverille', to_date('01-09-2002', 'dd-mm-yyyy'), 'janisdeverille@economist.com', 538523006, '2 La Follette Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (605127111, 'Raquel Billinge', to_date('15-12-2009', 'dd-mm-yyyy'), 'raquelbillinge@meetup.com', 521802697, '5 Fallview Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (402132441, 'Tamma O'' Markey', to_date('15-06-2001', 'dd-mm-yyyy'), 'tammao'' markey@cbc.ca', 524717688, '53 American Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (989941934, 'Carrissa McCarly', to_date('08-03-2004', 'dd-mm-yyyy'), 'carrissamccarly@icq.com', 528542203, '54 Talmadge Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (370336079, 'Maxie Kelly', to_date('23-12-2016', 'dd-mm-yyyy'), 'maxiekelly@etsy.com', 569812047, '0927 Westridge Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (838763998, 'Lia Scarlon', to_date('09-08-2003', 'dd-mm-yyyy'), 'liascarlon@hugedomains.com', 556302720, '9 Starling Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (516162245, 'May Fackney', to_date('23-02-2000', 'dd-mm-yyyy'), 'mayfackney@cnn.com', 552625797, '45 Springview Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (185360775, 'Fifi Mebius', to_date('12-05-2017', 'dd-mm-yyyy'), 'fifimebius@wp.com', 532939354, '5287 Village Green Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (462028344, 'Shirlene Aldus', to_date('17-10-2003', 'dd-mm-yyyy'), 'shirlenealdus@sina.com.cn', 529713738, '8 Meadow Valley Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (874886684, 'Saudra Petofi', to_date('22-04-2019', 'dd-mm-yyyy'), 'saudrapetofi@alexa.com', 553456632, '867 Corry Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (331919904, 'Sabine Puttock', to_date('17-02-2014', 'dd-mm-yyyy'), 'sabineputtock@independent.co.uk', 549065112, '3065 Linden Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (999065018, 'Lorena Ker', to_date('23-11-2004', 'dd-mm-yyyy'), 'lorenaker@altervista.org', 547991601, '077 Mesta Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (156162327, 'Verna Aronovich', to_date('12-10-2006', 'dd-mm-yyyy'), 'vernaaronovich@ucoz.com', 553681784, '321 Tennessee Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (541868230, 'Fanchette La Vigne', to_date('01-11-2013', 'dd-mm-yyyy'), 'fanchettela vigne@bluehost.com', 563463767, '7251 Bayside Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (522204111, 'Ninetta Ratazzi', to_date('21-04-2008', 'dd-mm-yyyy'), 'ninettaratazzi@ebay.com', 511716550, '8506 Heath Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (938406845, 'Clemmie Ellison', to_date('06-06-2014', 'dd-mm-yyyy'), 'clemmieellison@cocolog-nifty.com', 535379673, '539 Barby Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (694803403, 'Paulette Morigan', to_date('15-09-2011', 'dd-mm-yyyy'), 'paulettemorigan@sbwire.com', 510054835, '87516 Almo Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (864487983, 'Lorinda Rylands', to_date('08-12-2005', 'dd-mm-yyyy'), 'lorindarylands@yandex.ru', 587021822, '36 Talmadge Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (283264539, 'Nicky Hodcroft', to_date('27-08-2009', 'dd-mm-yyyy'), 'nickyhodcroft@discovery.com', 571689274, '2 Buell Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (775266141, 'Becca Sharkey', to_date('30-03-2008', 'dd-mm-yyyy'), 'beccasharkey@comcast.net', 554092019, '4 Stuart Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (265633696, 'Yoshi Lendrem', to_date('10-04-2004', 'dd-mm-yyyy'), 'yoshilendrem@diigo.com', 535846043, '568 Autumn Leaf Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (523949424, 'Sandi Chander', to_date('09-05-2003', 'dd-mm-yyyy'), 'sandichander@about.com', 582364898, '1372 Waubesa Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (565469376, 'Holly-anne Fussie', to_date('01-12-2005', 'dd-mm-yyyy'), 'holly-annefussie@sakura.ne.jp', 583904528, '379 Beilfuss Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (638446105, 'Zsa zsa Heffernan', to_date('05-10-2006', 'dd-mm-yyyy'), 'zsa zsaheffernan@quantcast.com', 529824221, '4879 Spaight Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (554661104, 'Nettle Skokoe', to_date('01-02-2004', 'dd-mm-yyyy'), 'nettleskokoe@ox.ac.uk', 589105049, '3389 Tony Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (861070252, 'Dominica Mibourne', to_date('17-06-2011', 'dd-mm-yyyy'), 'dominicamibourne@boston.com', 578333957, '4229 Troy Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (386637107, 'Yoshiko Reucastle', to_date('17-12-2004', 'dd-mm-yyyy'), 'yoshikoreucastle@tinyurl.com', 580269105, '5679 Lunder Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (482986698, 'Aeriela Addington', to_date('14-01-2011', 'dd-mm-yyyy'), 'aerielaaddington@chronoengine.com', 565001113, '765 Boyd Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (573087122, 'Helga Arunowicz', to_date('12-04-2011', 'dd-mm-yyyy'), 'helgaarunowicz@google.es', 582819422, '508 Loomis Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (251279284, 'Addie McReynolds', to_date('10-08-2002', 'dd-mm-yyyy'), 'addiemcreynolds@yelp.com', 532487207, '88 Caliangt Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (273451063, 'Luci Schoular', to_date('11-02-2004', 'dd-mm-yyyy'), 'lucischoular@nba.com', 534183074, '743 Bunker Hill Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (439190057, 'Claudelle Snedden', to_date('05-08-2016', 'dd-mm-yyyy'), 'claudellesnedden@shareasale.com', 536052446, '0559 Golden Leaf Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (387289289, 'Wallis Benedek', to_date('27-04-2008', 'dd-mm-yyyy'), 'wallisbenedek@goodreads.com', 584995679, '50144 Dayton Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (860545515, 'Bibbie Tonks', to_date('29-07-2017', 'dd-mm-yyyy'), 'bibbietonks@ebay.com', 509210317, '7515 Hansons Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (668312397, 'Vonnie Fearon', to_date('03-07-2016', 'dd-mm-yyyy'), 'vonniefearon@paginegialle.it', 579435425, '6 Elgar Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (619980182, 'Kellyann Polini', to_date('23-04-2008', 'dd-mm-yyyy'), 'kellyannpolini@paypal.com', 552029696, '124 Bluestem Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (358818051, 'Marleah Sandle', to_date('27-12-2011', 'dd-mm-yyyy'), 'marleahsandle@sciencedaily.com', 540390628, '44130 Dunning Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (730534343, 'Hyacintha Bowld', to_date('21-02-2001', 'dd-mm-yyyy'), 'hyacinthabowld@ucoz.ru', 545599469, '02668 Crescent Oaks Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (214271290, 'Selinda Slowey', to_date('06-05-2000', 'dd-mm-yyyy'), 'selindaslowey@odnoklassniki.ru', 538141041, '8 Alpine Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (105836606, 'Sydel Cousen', to_date('25-01-2004', 'dd-mm-yyyy'), 'sydelcousen@fotki.com', 549161354, '68001 Welch Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (189535699, 'Emelda July', to_date('28-09-2000', 'dd-mm-yyyy'), 'emeldajuly@newyorker.com', 518032681, '67854 Manley Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (183828210, 'Ailene Bonn', to_date('12-07-2002', 'dd-mm-yyyy'), 'ailenebonn@meetup.com', 568998497, '55 Melody Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (164877394, 'Gabriell MacDonough', to_date('15-07-2015', 'dd-mm-yyyy'), 'gabriellmacdonough@china.com.cn', 546757795, '4272 Oak Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (466988754, 'Clemmy Trevett', to_date('06-11-2009', 'dd-mm-yyyy'), 'clemmytrevett@mashable.com', 511136748, '5368 Marquette Trail');
commit;
prompt 400 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (282259005, 'Jennifer O''Devey', to_date('27-11-2002', 'dd-mm-yyyy'), 'jennifero''devey@cbsnews.com', 563105896, '081 Glendale Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (942044626, 'Caryn Colleymore', to_date('13-08-2005', 'dd-mm-yyyy'), 'caryncolleymore@cam.ac.uk', 541942266, '5002 Fair Oaks Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (175567621, 'Brinn Sleeford', to_date('22-04-2000', 'dd-mm-yyyy'), 'brinnsleeford@amazonaws.com', 509919030, '172 Thompson Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (639036860, 'Glenna Stirrip', to_date('13-04-2018', 'dd-mm-yyyy'), 'glennastirrip@feedburner.com', 542318781, '99724 Mariners Cove Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (557466349, 'Vittoria Cowie', to_date('28-08-2006', 'dd-mm-yyyy'), 'vittoriacowie@facebook.com', 581345428, '616 Johnson Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (604494486, 'Adrea Manser', to_date('30-07-2016', 'dd-mm-yyyy'), 'adreamanser@google.ca', 568044313, '09996 Forest Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (962866648, 'Yovonnda Burke', to_date('17-11-2013', 'dd-mm-yyyy'), 'yovonndaburke@businessweek.com', 517985741, '0 Rutledge Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (116462353, 'Juliana Haynes', to_date('30-10-2011', 'dd-mm-yyyy'), 'julianahaynes@latimes.com', 554421127, '8 Melvin Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (107444785, 'Xenia Preedy', to_date('01-01-2016', 'dd-mm-yyyy'), 'xeniapreedy@domainmarket.com', 515426512, '32 Little Fleur Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (216352282, 'Devonne Dulany', to_date('26-01-2004', 'dd-mm-yyyy'), 'devonnedulany@people.com.cn', 527592991, '2664 Caliangt Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (505992549, 'Merilee Ganter', to_date('22-02-2011', 'dd-mm-yyyy'), 'merileeganter@forbes.com', 588256040, '8015 Aberg Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (422056449, 'Regan Casely', to_date('05-12-2018', 'dd-mm-yyyy'), 'regancasely@dedecms.com', 516771929, '332 Scott Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (902558637, 'Tove Josefsohn', to_date('13-11-2014', 'dd-mm-yyyy'), 'tovejosefsohn@4shared.com', 577407474, '22256 Mifflin Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (844173763, 'Josefina Mesant', to_date('22-08-2014', 'dd-mm-yyyy'), 'josefinamesant@usda.gov', 502887622, '119 Novick Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (795314245, 'Zita Copestick', to_date('06-08-2005', 'dd-mm-yyyy'), 'zitacopestick@photobucket.com', 542983136, '68919 Kropf Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (897443171, 'Lorain Westhead', to_date('17-05-2003', 'dd-mm-yyyy'), 'lorainwesthead@scribd.com', 578808632, '6 Haas Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (878452649, 'Evelyn Pavlishchev', to_date('04-06-2014', 'dd-mm-yyyy'), 'evelynpavlishchev@theglobeandmail.com', 507014231, '99888 Grasskamp Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (559292166, 'Fan Hewell', to_date('27-08-2002', 'dd-mm-yyyy'), 'fanhewell@virginia.edu', 561536086, '2328 Sachtjen Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (952750374, 'Joellen Remon', to_date('18-01-2019', 'dd-mm-yyyy'), 'joellenremon@jimdo.com', 522692598, '5 Novick Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (672588466, 'Tamma Clampett', to_date('01-02-2009', 'dd-mm-yyyy'), 'tammaclampett@chron.com', 575802963, '9 Surrey Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (178737651, 'Darelle Robotham', to_date('13-12-2008', 'dd-mm-yyyy'), 'darellerobotham@bloglovin.com', 559148297, '6 Clove Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (167172437, 'Aloisia Epine', to_date('13-07-2019', 'dd-mm-yyyy'), 'aloisiaepine@opensource.org', 518196709, '089 Cordelia Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (259923743, 'Myrtle Castana', to_date('03-06-2013', 'dd-mm-yyyy'), 'myrtlecastana@acquirethisname.com', 564570134, '6504 Almo Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (543857648, 'Jenna Budnk', to_date('25-12-2019', 'dd-mm-yyyy'), 'jennabudnk@umich.edu', 515755350, '80 Mayfield Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (353145125, 'Shandy Tanguy', to_date('30-11-2014', 'dd-mm-yyyy'), 'shandytanguy@mapquest.com', 565311019, '58 Porter Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (511819336, 'Consuelo Kitt', to_date('22-02-2001', 'dd-mm-yyyy'), 'consuelokitt@wordpress.org', 526855373, '751 Scoville Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (380288743, 'Jenda Mussington', to_date('22-03-2019', 'dd-mm-yyyy'), 'jendamussington@youtube.com', 570299518, '14 Norway Maple Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (496971214, 'Nat Strowan', to_date('22-09-2015', 'dd-mm-yyyy'), 'natstrowan@icio.us', 574448992, '72617 Kedzie Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (643623729, 'Meghan Penticost', to_date('16-04-2018', 'dd-mm-yyyy'), 'meghanpenticost@goo.gl', 571534427, '16260 Milwaukee Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (205397955, 'Rozamond Outerbridge', to_date('17-05-2017', 'dd-mm-yyyy'), 'rozamondouterbridge@springer.com', 560629459, '1 Valley Edge Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (487861711, 'Megan Balogh', to_date('10-09-2016', 'dd-mm-yyyy'), 'meganbalogh@hubpages.com', 562674879, '50260 Swallow Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (995631486, 'Lainey Scarsbrooke', to_date('05-06-2003', 'dd-mm-yyyy'), 'laineyscarsbrooke@toplist.cz', 552689214, '93 Ruskin Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (529508663, 'Minnie Gadault', to_date('20-08-2001', 'dd-mm-yyyy'), 'minniegadault@rakuten.co.jp', 590289892, '9 Rigney Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (912774864, 'Manya Iggo', to_date('02-11-2014', 'dd-mm-yyyy'), 'manyaiggo@moonfruit.com', 551580035, '17091 Roth Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (732364554, 'Sayre Milne', to_date('24-06-2002', 'dd-mm-yyyy'), 'sayremilne@goodreads.com', 505746176, '16867 Mcguire Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (428983287, 'Christabel Ridgewell', to_date('27-11-2014', 'dd-mm-yyyy'), 'christabelridgewell@edublogs.org', 556802052, '3908 Harper Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (801616613, 'Gianina Cazalet', to_date('11-11-2006', 'dd-mm-yyyy'), 'gianinacazalet@auda.org.au', 537266777, '1 John Wall Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (894501335, 'Natty Paybody', to_date('16-02-2011', 'dd-mm-yyyy'), 'nattypaybody@loc.gov', 551669504, '832 Lake View Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (994167808, 'Heather Bottjer', to_date('23-02-2017', 'dd-mm-yyyy'), 'heatherbottjer@imageshack.us', 515986586, '9 Barby Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (377585071, 'Almeta Ivanenkov', to_date('16-02-2014', 'dd-mm-yyyy'), 'almetaivanenkov@alexa.com', 583653643, '95 Gale Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (925270311, 'Leshia Clayworth', to_date('22-08-2007', 'dd-mm-yyyy'), 'leshiaclayworth@ocn.ne.jp', 542416861, '25107 Ridgeway Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (467965675, 'Magda Gabits', to_date('25-11-2014', 'dd-mm-yyyy'), 'magdagabits@123-reg.co.uk', 580980985, '44687 Talisman Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (360000709, 'Carmelle Densumbe', to_date('19-12-2013', 'dd-mm-yyyy'), 'carmelledensumbe@yahoo.co.jp', 550313148, '91 Moulton Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (389621535, 'Monika Dymott', to_date('04-07-2013', 'dd-mm-yyyy'), 'monikadymott@nationalgeographic.com', 555987381, '8239 Green Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (672677177, 'Maura Lynett', to_date('08-02-2005', 'dd-mm-yyyy'), 'mauralynett@ameblo.jp', 564165696, '279 Claremont Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (708135979, 'Terrijo Zwicker', to_date('18-04-2007', 'dd-mm-yyyy'), 'terrijozwicker@friendfeed.com', 573515457, '47880 Nevada Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (866234023, 'Brunhilda Yokel', to_date('25-09-2011', 'dd-mm-yyyy'), 'brunhildayokel@businessweek.com', 556478420, '9023 Kings Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (208673611, 'Irene Probbings', to_date('26-11-2006', 'dd-mm-yyyy'), 'ireneprobbings@bloglines.com', 546427004, '0 Hagan Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (297102804, 'Vivianna Lucks', to_date('14-10-2003', 'dd-mm-yyyy'), 'viviannalucks@blogger.com', 524979724, '2 Spohn Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (317144977, 'Mellie Scrooby', to_date('06-08-2012', 'dd-mm-yyyy'), 'melliescrooby@bandcamp.com', 571542182, '0 Declaration Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (817026839, 'Valaria Fortoun', to_date('17-07-2002', 'dd-mm-yyyy'), 'valariafortoun@altervista.org', 589942200, '97 Lotheville Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (291379350, 'Nadiya Winterbotham', to_date('26-05-2003', 'dd-mm-yyyy'), 'nadiyawinterbotham@wikia.com', 505973140, '8123 Marquette Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (663430400, 'Mireielle Rosettini', to_date('03-02-2000', 'dd-mm-yyyy'), 'mireiellerosettini@comsenz.com', 585590068, '3 Del Sol Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (286942816, 'Rachelle Cristofano', to_date('05-10-2000', 'dd-mm-yyyy'), 'rachellecristofano@npr.org', 552478276, '376 Stephen Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (104602934, 'Marlo Elnaugh', to_date('01-08-2013', 'dd-mm-yyyy'), 'marloelnaugh@mozilla.org', 586472129, '0778 Bunting Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (715916459, 'Gavrielle Gockeler', to_date('19-04-2012', 'dd-mm-yyyy'), 'gavriellegockeler@google.com.au', 542128505, '9464 Riverside Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (282560191, 'Elsey Weond', to_date('07-01-2005', 'dd-mm-yyyy'), 'elseyweond@prweb.com', 515842611, '12 Bultman Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (588368340, 'Sharla Leddy', to_date('15-01-2011', 'dd-mm-yyyy'), 'sharlaleddy@webnode.com', 581149909, '59 Corben Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (841499510, 'Kandy Spincks', to_date('12-01-2012', 'dd-mm-yyyy'), 'kandyspincks@bigcartel.com', 523828816, '21 Reindahl Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (218193438, 'Norah Todeo', to_date('20-04-2007', 'dd-mm-yyyy'), 'norahtodeo@wufoo.com', 547972731, '361 Sugar Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (777063364, 'Bonnee Kolushev', to_date('23-06-2010', 'dd-mm-yyyy'), 'bonneekolushev@ask.com', 516397630, '636 Myrtle Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (529485293, 'Sonnie Remnant', to_date('10-08-2010', 'dd-mm-yyyy'), 'sonnieremnant@zimbio.com', 542018379, '9 Mariners Cove Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (617533806, 'Chrystal Pietraszek', to_date('20-04-2004', 'dd-mm-yyyy'), 'chrystalpietraszek@pen.io', 575319177, '169 Susan Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (329158441, 'Jojo Lesly', to_date('01-07-2002', 'dd-mm-yyyy'), 'jojolesly@bigcartel.com', 585674025, '02 Barby Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (567016150, 'Micaela Philp', to_date('27-03-2017', 'dd-mm-yyyy'), 'micaelaphilp@opera.com', 521046487, '9 Eagan Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441037044, 'Shannon Binner', to_date('03-03-2010', 'dd-mm-yyyy'), 'shannonbinner@artisteer.com', 551756555, '17 Rusk Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (785307559, 'Mari Crighton', to_date('30-07-2019', 'dd-mm-yyyy'), 'maricrighton@ftc.gov', 534126990, '61 Menomonie Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (628747616, 'Karil Gilpin', to_date('26-10-2008', 'dd-mm-yyyy'), 'karilgilpin@blog.com', 511516231, '0 Golf View Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (815910963, 'Dorette Sentinella', to_date('07-01-2005', 'dd-mm-yyyy'), 'dorettesentinella@wikispaces.com', 550270535, '09 5th Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (131889804, 'Mirella Hunting', to_date('09-08-2000', 'dd-mm-yyyy'), 'mirellahunting@cpanel.net', 501192342, '6439 Northview Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (261226610, 'Ingaberg Cockshot', to_date('12-04-2010', 'dd-mm-yyyy'), 'ingabergcockshot@about.me', 554653497, '6287 American Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (619767996, 'Thia Klimontovich', to_date('10-07-2016', 'dd-mm-yyyy'), 'thiaklimontovich@hhs.gov', 531515063, '10614 Emmet Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (967138840, 'Philippe Bilbrooke', to_date('24-10-2018', 'dd-mm-yyyy'), 'philippebilbrooke@shareasale.com', 555856055, '35872 Jenna Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (805558047, 'Kyla Fromont', to_date('28-12-2001', 'dd-mm-yyyy'), 'kylafromont@phoca.cz', 565254079, '78481 New Castle Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (967115372, 'Marys Caizley', to_date('03-10-2017', 'dd-mm-yyyy'), 'maryscaizley@theglobeandmail.com', 575567401, '66310 Becker Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (792482323, 'Darlleen Mounter', to_date('06-01-2002', 'dd-mm-yyyy'), 'darlleenmounter@paginegialle.it', 559604444, '201 Trailsway Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (738839959, 'Adrian Ybarra', to_date('08-01-2008', 'dd-mm-yyyy'), 'adrianybarra@examiner.com', 533182369, '42 Kinsman Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (644116143, 'Hertha Blase', to_date('20-09-2000', 'dd-mm-yyyy'), 'herthablase@disqus.com', 505411093, '66 Scofield Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (216359243, 'Sylvia Kidman', to_date('10-01-2009', 'dd-mm-yyyy'), 'sylviakidman@ftc.gov', 559455159, '222 Blackbird Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (901120266, 'Isabella Tures', to_date('13-09-2005', 'dd-mm-yyyy'), 'isabellatures@usda.gov', 571813022, '546 West Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (685494264, 'Deedee McGoldrick', to_date('02-03-2006', 'dd-mm-yyyy'), 'deedeemcgoldrick@flavors.me', 517074358, '819 Beilfuss Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (377729240, 'Saba Spurdle', to_date('29-01-2001', 'dd-mm-yyyy'), 'sabaspurdle@nsw.gov.au', 558288770, '422 Ronald Regan Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (770298802, 'Rivalee Markl', to_date('02-06-2002', 'dd-mm-yyyy'), 'rivaleemarkl@lulu.com', 582708744, '15234 Ridge Oak Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (216090090, 'Alanna Garnsworth', to_date('01-01-2016', 'dd-mm-yyyy'), 'alannagarnsworth@altervista.org', 568304770, '0440 Mallard Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (725612282, 'Ninnette Joppich', to_date('21-08-2015', 'dd-mm-yyyy'), 'ninnettejoppich@cdc.gov', 537698849, '31 Rowland Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (245705265, 'Cynthea Woodley', to_date('27-10-2003', 'dd-mm-yyyy'), 'cyntheawoodley@ehow.com', 586941684, '8 Toban Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (425812173, 'Aeriel Lanston', to_date('26-06-2015', 'dd-mm-yyyy'), 'aeriellanston@indiegogo.com', 520120551, '6481 Browning Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (766683811, 'Lucia Pre', to_date('24-11-2000', 'dd-mm-yyyy'), 'luciapre@opera.com', 542185734, '3658 Delladonna Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (171796939, 'Laurena Umbers', to_date('23-01-2018', 'dd-mm-yyyy'), 'laurenaumbers@multiply.com', 537884752, '7986 Graceland Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (633701333, 'Analiese Itzakovitz', to_date('15-12-2015', 'dd-mm-yyyy'), 'analieseitzakovitz@blogtalkradio.com', 571673201, '722 Lakewood Gardens Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (677269787, 'Shaine Hodge', to_date('30-09-2008', 'dd-mm-yyyy'), 'shainehodge@studiopress.com', 563564003, '04 Debs Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (936169503, 'Gratia Kyrkeman', to_date('06-04-2003', 'dd-mm-yyyy'), 'gratiakyrkeman@uol.com.br', 568824075, '9139 Glacier Hill Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (339493176, 'Xena Gott', to_date('19-09-2018', 'dd-mm-yyyy'), 'xenagott@nhs.uk', 503779338, '89550 Maple Wood Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (694209395, 'Becki Tremeer', to_date('03-02-2012', 'dd-mm-yyyy'), 'beckitremeer@sciencedirect.com', 531768280, '3 Ludington Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (912577195, 'Elva Rivlin', to_date('21-03-2001', 'dd-mm-yyyy'), 'elvarivlin@scientificamerican.com', 544749200, '1 Continental Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (332847604, 'Robinett Bromont', to_date('27-07-2016', 'dd-mm-yyyy'), 'robinettbromont@canalblog.com', 573752159, '443 Iowa Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (115967722, 'Marty Sheffield', to_date('17-08-2006', 'dd-mm-yyyy'), 'martysheffield@psu.edu', 544627174, '6 Basil Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (749018448, 'Helaine MacColl', to_date('24-09-2001', 'dd-mm-yyyy'), 'helainemaccoll@linkedin.com', 551975080, '99705 Bellgrove Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (651855962, 'Corena Udell', to_date('08-08-2009', 'dd-mm-yyyy'), 'corenaudell@wikispaces.com', 520466867, '535 Butternut Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (696812757, 'Ira Pedler', to_date('03-02-2018', 'dd-mm-yyyy'), 'irapedler@washingtonpost.com', 506580480, '496 Karstens Place');
commit;
prompt 500 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (170305645, 'Micki Perritt', to_date('23-12-2019', 'dd-mm-yyyy'), 'mickiperritt@goo.gl', 526247850, '25023 Division Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (154779331, 'Gwendolen Triplow', to_date('07-06-2017', 'dd-mm-yyyy'), 'gwendolentriplow@clickbank.net', 567239553, '159 Boyd Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (976175712, 'Merridie Begbie', to_date('28-04-2016', 'dd-mm-yyyy'), 'merridiebegbie@yolasite.com', 535875609, '305 Coolidge Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (228322646, 'Caro MacPeice', to_date('18-04-2004', 'dd-mm-yyyy'), 'caromacpeice@sciencedirect.com', 505175888, '01554 Arkansas Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (848489360, 'Mariska Spaducci', to_date('01-10-2005', 'dd-mm-yyyy'), 'mariskaspaducci@4shared.com', 546720465, '26032 Longview Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (143333666, 'Mallory Laffan', to_date('03-12-2003', 'dd-mm-yyyy'), 'mallorylaffan@aboutads.info', 574578773, '2 Portage Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (615928170, 'Justine Guilloneau', to_date('11-09-2011', 'dd-mm-yyyy'), 'justineguilloneau@tripod.com', 556298142, '4617 Waxwing Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (479537259, 'Shena Blanket', to_date('08-02-2015', 'dd-mm-yyyy'), 'shenablanket@51.la', 564182692, '28230 Towne Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (698624693, 'Latrina Havick', to_date('11-07-2017', 'dd-mm-yyyy'), 'latrinahavick@shutterfly.com', 589197711, '4 Corry Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (551407504, 'Manda Veitch', to_date('18-10-2010', 'dd-mm-yyyy'), 'mandaveitch@weebly.com', 546780849, '92795 Roth Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (876541800, 'Evangelia Pitcock', to_date('14-09-2010', 'dd-mm-yyyy'), 'evangeliapitcock@economist.com', 513911764, '177 Pleasure Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (831988156, 'Elli Bernocchi', to_date('22-08-2006', 'dd-mm-yyyy'), 'ellibernocchi@usa.gov', 576211350, '25081 Havey Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (118236069, 'Calida Bewley', to_date('24-02-2018', 'dd-mm-yyyy'), 'calidabewley@ehow.com', 522755721, '0 Spenser Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (200188458, 'Catlaina Randell', to_date('15-10-2001', 'dd-mm-yyyy'), 'catlainarandell@booking.com', 586640016, '0048 Eastwood Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (683894482, 'Tracy Audley', to_date('11-08-2001', 'dd-mm-yyyy'), 'tracyaudley@furl.net', 580902269, '7582 Paget Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (263723091, 'Micheline Ruoss', to_date('03-12-2015', 'dd-mm-yyyy'), 'michelineruoss@reference.com', 540354436, '71 Mcguire Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (468477800, 'Ianthe Shouler', to_date('06-12-2008', 'dd-mm-yyyy'), 'iantheshouler@ow.ly', 530726118, '38284 Shasta Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (449060241, 'Lilian Weeds', to_date('03-03-2017', 'dd-mm-yyyy'), 'lilianweeds@bbc.co.uk', 503983082, '5881 Village Green Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (917191761, 'Chickie Stooke', to_date('06-05-2011', 'dd-mm-yyyy'), 'chickiestooke@chronoengine.com', 521135812, '78 Moulton Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (722081406, 'Glenn Stiggers', to_date('22-09-2009', 'dd-mm-yyyy'), 'glennstiggers@redcross.org', 521481267, '40 Sherman Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (880283169, 'Pollyanna Dartnell', to_date('27-03-2018', 'dd-mm-yyyy'), 'pollyannadartnell@narod.ru', 549528995, '8 Drewry Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (595271596, 'Ketty Wilkie', to_date('22-02-2019', 'dd-mm-yyyy'), 'kettywilkie@com.com', 585258239, '644 Eastwood Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (816505320, 'Johna Salmons', to_date('16-10-2005', 'dd-mm-yyyy'), 'johnasalmons@hubpages.com', 575414769, '5682 Union Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (166217087, 'Janella Phlipon', to_date('13-05-2008', 'dd-mm-yyyy'), 'janellaphlipon@mtv.com', 554707559, '01 Shasta Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (274807987, 'Emeline Parkhouse', to_date('29-02-2004', 'dd-mm-yyyy'), 'emelineparkhouse@japanpost.jp', 583002638, '2525 Schmedeman Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (465156888, 'Raf Boodle', to_date('13-08-2019', 'dd-mm-yyyy'), 'rafboodle@ameblo.jp', 543551769, '0 Parkside Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (113103849, 'Paloma Safont', to_date('01-10-2014', 'dd-mm-yyyy'), 'palomasafont@accuweather.com', 555930423, '94 Welch Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (309690308, 'Danette Stronach', to_date('13-03-2014', 'dd-mm-yyyy'), 'danettestronach@eventbrite.com', 567518932, '6887 Clarendon Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (129195321, 'Raina Surplice', to_date('11-08-2005', 'dd-mm-yyyy'), 'rainasurplice@seattletimes.com', 522472257, '65 Reinke Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (438885298, 'Katharina Longthorn', to_date('14-11-2007', 'dd-mm-yyyy'), 'katharinalongthorn@goo.gl', 538579197, '8355 Drewry Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (576647580, 'Mariya Atter', to_date('03-10-2006', 'dd-mm-yyyy'), 'mariyaatter@imageshack.us', 583254665, '111 Westerfield Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (785202161, 'Berthe Francesconi', to_date('28-03-2006', 'dd-mm-yyyy'), 'berthefrancesconi@vimeo.com', 574288136, '41088 Coolidge Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (532032180, 'Julita Elnaugh', to_date('12-04-2000', 'dd-mm-yyyy'), 'julitaelnaugh@cocolog-nifty.com', 575157628, '05201 Service Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (774978403, 'Noami Benneton', to_date('14-03-2018', 'dd-mm-yyyy'), 'noamibenneton@mozilla.org', 521520433, '13 Pawling Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (997071337, 'Joline Castanos', to_date('23-04-2017', 'dd-mm-yyyy'), 'jolinecastanos@disqus.com', 526708515, '083 Steensland Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (693685227, 'Enrika Garmans', to_date('15-04-2008', 'dd-mm-yyyy'), 'enrikagarmans@un.org', 523519947, '14100 David Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (892467506, 'Rosabella Lapthorn', to_date('01-11-2002', 'dd-mm-yyyy'), 'rosabellalapthorn@bing.com', 538311128, '91984 Troy Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (681850365, 'Lydie Chaffin', to_date('26-05-2018', 'dd-mm-yyyy'), 'lydiechaffin@go.com', 552688305, '7 Riverside Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (557616226, 'Lilias Bettridge', to_date('03-06-2012', 'dd-mm-yyyy'), 'liliasbettridge@amazon.com', 508097894, '830 2nd Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (355146666, 'Marigold Gooch', to_date('28-09-2016', 'dd-mm-yyyy'), 'marigoldgooch@moonfruit.com', 541832899, '229 Springs Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (173398008, 'Fredi Sheach', to_date('01-10-2003', 'dd-mm-yyyy'), 'fredisheach@vistaprint.com', 588995449, '76514 Arkansas Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (849923350, 'Starla Mazey', to_date('14-07-2012', 'dd-mm-yyyy'), 'starlamazey@pen.io', 583327879, '5 Jenifer Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (847523648, 'Idelle Mulryan', to_date('24-04-2010', 'dd-mm-yyyy'), 'idellemulryan@tuttocitta.it', 532038799, '3 Mosinee Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (981543943, 'Monah Grigolon', to_date('06-03-2006', 'dd-mm-yyyy'), 'monahgrigolon@blog.com', 502249646, '42920 Schmedeman Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (803132293, 'Marthena Cordeiro', to_date('11-10-2001', 'dd-mm-yyyy'), 'marthenacordeiro@telegraph.co.uk', 513310449, '7 Basil Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (498768696, 'Manda Fish', to_date('10-11-2003', 'dd-mm-yyyy'), 'mandafish@hp.com', 532914067, '08885 Lake View Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (314544963, 'Fulvia Mochan', to_date('24-07-2019', 'dd-mm-yyyy'), 'fulviamochan@admin.ch', 578117656, '4800 New Castle Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (549920959, 'Moria Gecke', to_date('21-12-2005', 'dd-mm-yyyy'), 'moriagecke@accuweather.com', 535447459, '5397 Monica Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (545493618, 'Ilsa Fiddymont', to_date('09-08-2004', 'dd-mm-yyyy'), 'ilsafiddymont@taobao.com', 566192023, '25 Buhler Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (816391512, 'Allyson Brumfield', to_date('13-10-2012', 'dd-mm-yyyy'), 'allysonbrumfield@51.la', 532855626, '35 Anhalt Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (425485955, 'Valaree Sidebotham', to_date('11-07-2004', 'dd-mm-yyyy'), 'valareesidebotham@friendfeed.com', 540285636, '43413 Lotheville Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (756476008, 'Alexi Ottawell', to_date('08-06-2011', 'dd-mm-yyyy'), 'alexiottawell@cloudflare.com', 505392738, '34 Mariners Cove Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (309169041, 'Crista Villalta', to_date('31-12-2015', 'dd-mm-yyyy'), 'cristavillalta@multiply.com', 568573362, '10 Springview Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (953132895, 'Ursa Feehan', to_date('05-04-2019', 'dd-mm-yyyy'), 'ursafeehan@jiathis.com', 584062506, '182 Carioca Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (261358978, 'Elinore Dimitriev', to_date('13-09-2006', 'dd-mm-yyyy'), 'elinoredimitriev@cocolog-nifty.com', 527645565, '198 Bunting Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (579018697, 'Annmaria Binch', to_date('20-12-2013', 'dd-mm-yyyy'), 'annmariabinch@livejournal.com', 533365339, '9708 Rutledge Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (180021901, 'Allina Brokenshaw', to_date('06-01-2005', 'dd-mm-yyyy'), 'allinabrokenshaw@ustream.tv', 546994025, '365 Reinke Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (829260788, 'Cecilla Kingsnod', to_date('09-11-2004', 'dd-mm-yyyy'), 'cecillakingsnod@soup.io', 516803728, '677 School Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (595247363, 'Fidelity Antcliff', to_date('05-05-2015', 'dd-mm-yyyy'), 'fidelityantcliff@patch.com', 535818490, '6 Springs Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (370498675, 'Ealasaid Brookesbie', to_date('16-08-2017', 'dd-mm-yyyy'), 'ealasaidbrookesbie@tuttocitta.it', 511410872, '15422 Anthes Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (238002042, 'Yovonnda Emett', to_date('14-12-2006', 'dd-mm-yyyy'), 'yovonndaemett@so-net.ne.jp', 511806706, '049 Sunnyside Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (410848744, 'Kevina Doerren', to_date('04-01-2001', 'dd-mm-yyyy'), 'kevinadoerren@hp.com', 512293055, '871 Meadow Valley Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (480996732, 'Cody Mapother', to_date('28-07-2018', 'dd-mm-yyyy'), 'codymapother@edublogs.org', 582634090, '89378 Hazelcrest Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (140359430, 'Ailsun Gogin', to_date('07-10-2012', 'dd-mm-yyyy'), 'ailsungogin@altervista.org', 551256638, '22 Manitowish Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (557714154, 'Phaedra Cass', to_date('24-02-2014', 'dd-mm-yyyy'), 'phaedracass@goo.gl', 520002148, '309 Pine View Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (386404707, 'Kathlin Charlewood', to_date('27-03-2003', 'dd-mm-yyyy'), 'kathlincharlewood@nhs.uk', 536805423, '12489 Clarendon Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (667916897, 'Teddy Stratley', to_date('13-11-2005', 'dd-mm-yyyy'), 'teddystratley@go.com', 551262221, '5676 Upham Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (100148653, 'Bunni Manus', to_date('09-05-2010', 'dd-mm-yyyy'), 'bunnimanus@dailymail.co.uk', 508766669, '7 Hazelcrest Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (992615606, 'Ortensia McQuillen', to_date('28-02-2019', 'dd-mm-yyyy'), 'ortensiamcquillen@phoca.cz', 566974361, '406 East Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (649236513, 'Jena Nettles', to_date('28-02-2010', 'dd-mm-yyyy'), 'jenanettles@huffingtonpost.com', 584547833, '9 Acker Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (779764377, 'Maribel Fernez', to_date('06-04-2017', 'dd-mm-yyyy'), 'maribelfernez@meetup.com', 529076298, '4068 Marquette Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441752575, 'Chelsy Curteis', to_date('14-09-2018', 'dd-mm-yyyy'), 'chelsycurteis@indiegogo.com', 586089641, '55 Carberry Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (603790477, 'Marcy Bielby', to_date('02-09-2005', 'dd-mm-yyyy'), 'marcybielby@blogs.com', 518385854, '8 Old Shore Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (821874383, 'Adel Dallicoat', to_date('13-12-2009', 'dd-mm-yyyy'), 'adeldallicoat@a8.net', 513962706, '61 Maple Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (788322275, 'Cristine Wiper', to_date('10-01-2016', 'dd-mm-yyyy'), 'cristinewiper@myspace.com', 586448302, '9 Artisan Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (244957874, 'Guinevere Meneur', to_date('14-03-2015', 'dd-mm-yyyy'), 'guineveremeneur@istockphoto.com', 541515568, '605 Armistice Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (742612917, 'Elisha Liddicoat', to_date('22-01-2004', 'dd-mm-yyyy'), 'elishaliddicoat@theglobeandmail.com', 535998896, '59 Coolidge Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (391598548, 'Bendite Bernardt', to_date('25-08-2016', 'dd-mm-yyyy'), 'benditebernardt@ifeng.com', 566526066, '7667 Mallard Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (832343421, 'Kettie Solon', to_date('06-11-2012', 'dd-mm-yyyy'), 'kettiesolon@ft.com', 527756552, '64 Prairie Rose Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (349109407, 'Maureene Harner', to_date('10-10-2009', 'dd-mm-yyyy'), 'maureeneharner@berkeley.edu', 543937141, '55 Westend Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (931619511, 'Athena Salazar', to_date('12-08-2014', 'dd-mm-yyyy'), 'athenasalazar@sphinn.com', 509636894, '11205 Gale Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (227135671, 'Sally Mackney', to_date('19-04-2017', 'dd-mm-yyyy'), 'sallymackney@odnoklassniki.ru', 541034175, '9 Green Ridge Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (214932549, 'Karlie Sotheron', to_date('11-02-2005', 'dd-mm-yyyy'), 'karliesotheron@i2i.jp', 563935301, '91661 Moulton Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (849633047, 'Abbi Gudgin', to_date('08-04-2003', 'dd-mm-yyyy'), 'abbigudgin@amazon.co.uk', 587098851, '78485 Linden Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (474353737, 'Marrissa Cater', to_date('09-05-2015', 'dd-mm-yyyy'), 'marrissacater@tmall.com', 508777276, '307 Gateway Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (410929065, 'Lara Smallpeice', to_date('25-08-2000', 'dd-mm-yyyy'), 'larasmallpeice@unblog.fr', 566656413, '857 Del Mar Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (794342149, 'Karrie De Domenici', to_date('12-10-2018', 'dd-mm-yyyy'), 'karriede domenici@stumbleupon.com', 575031904, '8966 Victoria Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (804309217, 'Lindsey Drake', to_date('03-03-2007', 'dd-mm-yyyy'), 'lindseydrake@shutterfly.com', 536094624, '40031 Susan Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (338247817, 'Bonnibelle Benne', to_date('04-02-2019', 'dd-mm-yyyy'), 'bonnibellebenne@ted.com', 505498499, '1 Surrey Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (194549335, 'Larisa Wylie', to_date('18-02-2016', 'dd-mm-yyyy'), 'larisawylie@usatoday.com', 550156542, '2896 Kensington Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (500813208, 'Bibbye Natt', to_date('24-04-2003', 'dd-mm-yyyy'), 'bibbyenatt@slate.com', 524028010, '06404 Hoffman Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (960965084, 'Tanitansy Roughey', to_date('25-10-2003', 'dd-mm-yyyy'), 'tanitansyroughey@360.cn', 528992811, '16509 Dryden Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (240771738, 'Elsinore Wimsett', to_date('03-07-2011', 'dd-mm-yyyy'), 'elsinorewimsett@walmart.com', 527386657, '67698 Vernon Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (399864090, 'Lucia Lincoln', to_date('04-09-2000', 'dd-mm-yyyy'), 'lucialincoln@constantcontact.com', 509678862, '841 Grayhawk Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (485506309, 'Donelle Decreuze', to_date('18-01-2014', 'dd-mm-yyyy'), 'donelledecreuze@ifeng.com', 554093003, '82418 Stoughton Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (226292015, 'Shelly Jevon', to_date('20-10-2008', 'dd-mm-yyyy'), 'shellyjevon@blinklist.com', 520788545, '794 Russell Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (602119198, 'Betteanne Ailmer', to_date('29-06-2006', 'dd-mm-yyyy'), 'betteanneailmer@prnewswire.com', 583111670, '9136 Arapahoe Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (153649997, 'Kimmi Tulloch', to_date('22-07-2018', 'dd-mm-yyyy'), 'kimmitulloch@gnu.org', 534786358, '6 Red Cloud Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (648581103, 'Bert Mattheus', to_date('14-09-2002', 'dd-mm-yyyy'), 'bertmattheus@auda.org.au', 529218849, '6 Florence Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (440396543, 'Genovera Bahlmann', to_date('27-05-2014', 'dd-mm-yyyy'), 'genoverabahlmann@facebook.com', 589476817, '8 Lien Center');
commit;
prompt 600 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (577904602, 'Bryna Burnsides', to_date('20-01-2019', 'dd-mm-yyyy'), 'brynaburnsides@cnn.com', 542746909, '35510 Kim Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (552297292, 'Arlyn Spillard', to_date('19-11-2011', 'dd-mm-yyyy'), 'arlynspillard@instagram.com', 522365458, '0782 Washington Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (701139371, 'Leisha Ebbin', to_date('21-10-2017', 'dd-mm-yyyy'), 'leishaebbin@elpais.com', 553585316, '055 Ohio Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (471686465, 'Leigha Evison', to_date('04-10-2003', 'dd-mm-yyyy'), 'leighaevison@europa.eu', 538363335, '338 Anhalt Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (837052178, 'Laurice Trelease', to_date('13-02-2004', 'dd-mm-yyyy'), 'lauricetrelease@nhs.uk', 575542146, '71 2nd Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (724109514, 'Lulita Goulder', to_date('21-12-2012', 'dd-mm-yyyy'), 'lulitagoulder@weebly.com', 581799859, '8549 Straubel Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (458125190, 'Dorisa Sepey', to_date('14-10-2014', 'dd-mm-yyyy'), 'dorisasepey@slashdot.org', 531179605, '86275 Fremont Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (885809424, 'Oneida Reckhouse', to_date('01-05-2011', 'dd-mm-yyyy'), 'oneidareckhouse@usgs.gov', 567691062, '263 Sheridan Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (666662014, 'Kikelia Masser', to_date('31-08-2002', 'dd-mm-yyyy'), 'kikeliamasser@domainmarket.com', 577916819, '0508 Meadow Vale Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (753638601, 'Delila Jzhakov', to_date('09-06-2007', 'dd-mm-yyyy'), 'delilajzhakov@dyndns.org', 510145136, '026 Fairfield Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (235280458, 'Ruthy Healeas', to_date('19-03-2013', 'dd-mm-yyyy'), 'ruthyhealeas@goodreads.com', 564430451, '422 American Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (911869430, 'Anabal Bessey', to_date('04-11-2010', 'dd-mm-yyyy'), 'anabalbessey@skype.com', 535363523, '44 Redwing Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (598623933, 'Ursola Rhubottom', to_date('23-11-2000', 'dd-mm-yyyy'), 'ursolarhubottom@cbslocal.com', 571695521, '2354 Mccormick Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (157482297, 'Jemie Aykroyd', to_date('11-10-2014', 'dd-mm-yyyy'), 'jemieaykroyd@businesswire.com', 572403294, '324 Hermina Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (914847250, 'Claudelle Aizlewood', to_date('05-12-2014', 'dd-mm-yyyy'), 'claudelleaizlewood@shop-pro.jp', 510617579, '81 Fair Oaks Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (123959939, 'Eden Porcher', to_date('26-09-2005', 'dd-mm-yyyy'), 'myupdatedmail@mail.il', 50000000, '725 Duke Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (370571857, 'Robinet Dickson', to_date('16-04-2010', 'dd-mm-yyyy'), 'robinetdickson@sfgate.com', 519891583, '62928 Dexter Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (506915991, 'Rosalyn Shiel', to_date('07-01-2005', 'dd-mm-yyyy'), 'rosalynshiel@wiley.com', 506479972, '938 Harbort Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (590261410, 'Reina Kernermann', to_date('01-03-2013', 'dd-mm-yyyy'), 'reinakernermann@squidoo.com', 565156331, '11066 Montana Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (297288231, 'Devan Massingberd', to_date('23-08-2018', 'dd-mm-yyyy'), 'devanmassingberd@fema.gov', 580287030, '968 Loeprich Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (169659515, 'Garnette Simeoli', to_date('24-10-2014', 'dd-mm-yyyy'), 'garnettesimeoli@discovery.com', 509779290, '0394 Thackeray Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (215499619, 'Sib Childerhouse', to_date('27-03-2003', 'dd-mm-yyyy'), 'sibchilderhouse@berkeley.edu', 580004102, '55 Anzinger Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (490041641, 'Nannette Magwood', to_date('07-05-2011', 'dd-mm-yyyy'), 'nannettemagwood@theguardian.com', 571166225, '03 Killdeer Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (233791357, 'Meredithe Guillond', to_date('29-01-2003', 'dd-mm-yyyy'), 'mereditheguillond@bbb.org', 581735520, '8 Menomonie Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (603975264, 'Meta Soff', to_date('08-01-2016', 'dd-mm-yyyy'), 'metasoff@mediafire.com', 538342197, '4646 Dexter Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (972229832, 'Jasmin Hedney', to_date('01-03-2019', 'dd-mm-yyyy'), 'jasminhedney@about.me', 555441646, '317 Parkside Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (116069857, 'Brynne Newick', to_date('28-04-2017', 'dd-mm-yyyy'), 'brynnenewick@instagram.com', 575700158, '68 Steensland Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (484656686, 'Daria Berrie', to_date('22-07-2013', 'dd-mm-yyyy'), 'dariaberrie@marriott.com', 502302692, '23095 Algoma Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (951821196, 'Helen Bikker', to_date('14-12-2014', 'dd-mm-yyyy'), 'helenbikker@webs.com', 546030005, '645 Jay Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (126762133, 'Mireille McQuarter', to_date('19-04-2017', 'dd-mm-yyyy'), 'mireillemcquarter@g.co', 515515268, '291 David Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (779283595, 'Agace Casaro', to_date('10-12-2009', 'dd-mm-yyyy'), 'agacecasaro@buzzfeed.com', 523921045, '46 Debs Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (616311456, 'Pearle Anderl', to_date('19-07-2009', 'dd-mm-yyyy'), 'pearleanderl@sbwire.com', 519571265, '435 Waubesa Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (124420100, 'Delphinia Alecock', to_date('09-02-2009', 'dd-mm-yyyy'), 'delphiniaalecock@cnn.com', 523051340, '43376 Blackbird Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (437929378, 'Elsey Stienham', to_date('17-07-2007', 'dd-mm-yyyy'), 'elseystienham@statcounter.com', 551707219, '175 Mayer Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (944613878, 'Ralina Yurlov', to_date('09-07-2015', 'dd-mm-yyyy'), 'ralinayurlov@yellowbook.com', 534167502, '331 Arkansas Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (562560915, 'Rasia Chamberlin', to_date('29-04-2016', 'dd-mm-yyyy'), 'rasiachamberlin@pagesperso-orange.fr', 517347882, '188 Clemons Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (542084528, 'Marielle Ruste', to_date('06-07-2002', 'dd-mm-yyyy'), 'marielleruste@techcrunch.com', 510230684, '787 Blue Bill Park Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (316640446, 'Carry Oliphand', to_date('26-03-2011', 'dd-mm-yyyy'), 'carryoliphand@jigsy.com', 502525365, '1 Roth Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (682245522, 'Kirstin Phette', to_date('29-03-2006', 'dd-mm-yyyy'), 'kirstinphette@fastcompany.com', 525212719, '7310 Monterey Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (483122626, 'Birgitta Crossfield', to_date('13-07-2015', 'dd-mm-yyyy'), 'birgittacrossfield@dailymotion.com', 590087952, '4829 Carpenter Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (856694332, 'Lib Rowett', to_date('12-09-2005', 'dd-mm-yyyy'), 'librowett@dot.gov', 578625740, '82985 Gerald Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (899139967, 'Joanne Ceccoli', to_date('12-09-2006', 'dd-mm-yyyy'), 'joannececcoli@dagondesign.com', 553818503, '2 Hanson Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (593938967, 'Rosana Burr', to_date('10-03-2005', 'dd-mm-yyyy'), 'rosanaburr@yandex.ru', 589753831, '91 Derek Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (418481619, 'Beitris De Mattei', to_date('04-02-2018', 'dd-mm-yyyy'), 'beitrisde mattei@discuz.net', 565082985, '6469 Laurel Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (443991351, 'Olga Blackwood', to_date('09-08-2012', 'dd-mm-yyyy'), 'olgablackwood@github.com', 579734196, '6 Lerdahl Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (451171514, 'Doralia Carme', to_date('09-08-2018', 'dd-mm-yyyy'), 'doraliacarme@globo.com', 540287984, '548 Butternut Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (702330680, 'Jaquenette Wither', to_date('03-12-2002', 'dd-mm-yyyy'), 'jaquenettewither@abc.net.au', 535434591, '05547 Roth Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (149248623, 'Cosetta Esberger', to_date('09-05-2005', 'dd-mm-yyyy'), 'cosettaesberger@hp.com', 513973765, '11 Little Fleur Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (906671114, 'Clarette Edon', to_date('01-08-2012', 'dd-mm-yyyy'), 'claretteedon@tuttocitta.it', 534319369, '01 Waubesa Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (858481074, 'Anthe Grigg', to_date('20-11-2015', 'dd-mm-yyyy'), 'anthegrigg@ning.com', 575814950, '2144 Glendale Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (952352618, 'Ninette Ridolfi', to_date('23-07-2019', 'dd-mm-yyyy'), 'ninetteridolfi@fda.gov', 524728066, '01 Gateway Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (975744831, 'Emelda Richmont', to_date('20-08-2000', 'dd-mm-yyyy'), 'emeldarichmont@miibeian.gov.cn', 578254451, '82110 Manufacturers Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (815540940, 'Peg Yurov', to_date('03-08-2006', 'dd-mm-yyyy'), 'pegyurov@barnesandnoble.com', 585504661, '194 Vahlen Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (173927735, 'Valma Scintsbury', to_date('19-08-2005', 'dd-mm-yyyy'), 'valmascintsbury@tinypic.com', 568394391, '93347 Stuart Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (138503193, 'Christal Burndred', to_date('05-04-2015', 'dd-mm-yyyy'), 'christalburndred@weather.com', 580156094, '84 Oak Valley Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (420154025, 'Charmain Skelhorn', to_date('09-02-2004', 'dd-mm-yyyy'), 'charmainskelhorn@stanford.edu', 564827936, '1889 Prairie Rose Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (891928720, 'Dione Potten', to_date('15-01-2002', 'dd-mm-yyyy'), 'dionepotten@cbc.ca', 573807220, '2167 Erie Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (185101463, 'Ebonee Gregine', to_date('30-08-2015', 'dd-mm-yyyy'), 'eboneegregine@pen.io', 501997253, '05 School Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (687537052, 'Tomasina Fitzpatrick', to_date('25-06-2005', 'dd-mm-yyyy'), 'tomasinafitzpatrick@tumblr.com', 516052144, '04 Twin Pines Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (577977760, 'Mallissa Le Gassick', to_date('08-12-2014', 'dd-mm-yyyy'), 'mallissale gassick@godaddy.com', 564226282, '357 Spenser Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (611218507, 'Ada Elies', to_date('30-01-2003', 'dd-mm-yyyy'), 'adaelies@hugedomains.com', 528739371, '956 Shoshone Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (970123677, 'Robyn Jenoure', to_date('12-12-2015', 'dd-mm-yyyy'), 'robynjenoure@simplemachines.org', 533705889, '9540 Carioca Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (811595988, 'Channa Moquin', to_date('18-12-2010', 'dd-mm-yyyy'), 'channamoquin@webmd.com', 547406165, '592 Victoria Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (408789796, 'Madeline McFfaden', to_date('20-05-2012', 'dd-mm-yyyy'), 'madelinemcffaden@mlb.com', 556343389, '82 Melrose Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (333507467, 'Brittaney Apthorpe', to_date('02-01-2002', 'dd-mm-yyyy'), 'brittaneyapthorpe@washington.edu', 549680134, '16153 Forster Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (931697691, 'Caralie Threlkeld', to_date('26-01-2004', 'dd-mm-yyyy'), 'caraliethrelkeld@skyrock.com', 580678926, '25 Reinke Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (873783034, 'Mirabel Dulanty', to_date('07-08-2016', 'dd-mm-yyyy'), 'mirabeldulanty@nifty.com', 514199286, '1543 Center Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (747428052, 'Sheilah Jaimez', to_date('18-02-2010', 'dd-mm-yyyy'), 'sheilahjaimez@unblog.fr', 549212900, '00610 Upham Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (112292585, 'Shena Hutt', to_date('12-08-2013', 'dd-mm-yyyy'), 'shenahutt@engadget.com', 540957571, '52 Dovetail Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (763909026, 'Catina Vellden', to_date('01-03-2018', 'dd-mm-yyyy'), 'catinavellden@cnet.com', 535593480, '1 Tennessee Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (968243817, 'Willette Clewett', to_date('02-05-2006', 'dd-mm-yyyy'), 'willetteclewett@naver.com', 575452745, '5375 Melby Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (771368977, 'Anjanette Ferby', to_date('06-10-2002', 'dd-mm-yyyy'), 'anjanetteferby@springer.com', 561624990, '49 Florence Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (874114945, 'Carri Jeanenet', to_date('29-11-2014', 'dd-mm-yyyy'), 'carrijeanenet@apple.com', 553704230, '1994 Rutledge Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (683617507, 'Eachelle Thomke', to_date('16-03-2012', 'dd-mm-yyyy'), 'eachellethomke@is.gd', 588955656, '6921 Corry Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (995849472, 'Alyce Aires', to_date('06-11-2002', 'dd-mm-yyyy'), 'alyceaires@archive.org', 552223347, '423 Lien Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (525588342, 'Sidonia Eddison', to_date('12-08-2010', 'dd-mm-yyyy'), 'sidoniaeddison@meetup.com', 510916107, '49295 Hagan Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (518817006, 'Vickie Eacott', to_date('15-11-2016', 'dd-mm-yyyy'), 'vickieeacott@opensource.org', 516287870, '8589 Raven Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (915559018, 'Casey Bisley', to_date('01-05-2012', 'dd-mm-yyyy'), 'caseybisley@webmd.com', 554005125, '523 Butterfield Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (667562726, 'Codie Josham', to_date('17-10-2016', 'dd-mm-yyyy'), 'codiejosham@xinhuanet.com', 548312958, '42867 Darwin Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (421119444, 'Kassi Hanretty', to_date('25-04-2019', 'dd-mm-yyyy'), 'kassihanretty@apache.org', 566401260, '7484 Sycamore Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (169524150, 'Lilllie Kemmey', to_date('09-01-2002', 'dd-mm-yyyy'), 'lillliekemmey@imgur.com', 530524610, '37 Carpenter Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (454248607, 'Orly Colgan', to_date('29-04-2007', 'dd-mm-yyyy'), 'orlycolgan@discuz.net', 535825245, '710 Green Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (294013453, 'Calypso Kiln', to_date('10-03-2014', 'dd-mm-yyyy'), 'calypsokiln@lulu.com', 572976225, '1 Huxley Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (177060427, 'Meggie Wudeland', to_date('20-02-2005', 'dd-mm-yyyy'), 'meggiewudeland@sfgate.com', 561031092, '26774 Bartillon Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (490850485, 'Mable Kerwin', to_date('01-05-2003', 'dd-mm-yyyy'), 'mablekerwin@deliciousdays.com', 504080191, '65124 Gale Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (720417144, 'Kara-lynn Bagot', to_date('27-02-2009', 'dd-mm-yyyy'), 'kara-lynnbagot@bloomberg.com', 520980712, '2 Huxley Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (763055828, 'Kassie Corre', to_date('10-10-2016', 'dd-mm-yyyy'), 'kassiecorre@wikispaces.com', 556439000, '6470 Waywood Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (451921990, 'Libbi Gilling', to_date('18-01-2011', 'dd-mm-yyyy'), 'libbigilling@uiuc.edu', 548093172, '53 Jay Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (744764697, 'Idette Lints', to_date('18-09-2006', 'dd-mm-yyyy'), 'idettelints@stumbleupon.com', 579586604, '6 Ridgeway Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (287920615, 'Zaneta Rosenvasser', to_date('02-06-2000', 'dd-mm-yyyy'), 'zanetarosenvasser@mapquest.com', 522817159, '48 Magdeline Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (697015085, 'Clementina Spellecy', to_date('13-05-2002', 'dd-mm-yyyy'), 'clementinaspellecy@macromedia.com', 532589569, '5 Huxley Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (734366943, 'Karrah Budik', to_date('08-05-2015', 'dd-mm-yyyy'), 'karrahbudik@abc.net.au', 544446098, '6 Mitchell Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (895629963, 'Guenevere Tidswell', to_date('20-10-2015', 'dd-mm-yyyy'), 'gueneveretidswell@omniture.com', 545942797, '09409 Dexter Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (770754632, 'Bobbee Feake', to_date('28-09-2018', 'dd-mm-yyyy'), 'bobbeefeake@sun.com', 562323013, '56556 Red Cloud Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (284087405, 'Jannelle Deverale', to_date('21-09-2010', 'dd-mm-yyyy'), 'jannelledeverale@jigsy.com', 588251037, '1 Steensland Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (644414827, 'Jyoti Matchitt', to_date('13-12-2018', 'dd-mm-yyyy'), 'jyotimatchitt@psu.edu', 514061563, '2 Sauthoff Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (937043198, 'Thea Condict', to_date('11-07-2014', 'dd-mm-yyyy'), 'theacondict@about.com', 544278978, '244 Surrey Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (311528328, 'Eimile Ingles', to_date('21-12-2005', 'dd-mm-yyyy'), 'eimileingles@sina.com.cn', 561198389, '86002 Hovde Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (386354445, 'Dela Vedmore', to_date('11-09-2000', 'dd-mm-yyyy'), 'delavedmore@bbb.org', 545912747, '3518 Spenser Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (799597846, 'Jamima Dobbings', to_date('21-07-2015', 'dd-mm-yyyy'), 'jamimadobbings@google.cn', 519850829, '96538 Scofield Plaza');
commit;
prompt 700 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (816505821, 'Lina Klimes', to_date('17-01-2004', 'dd-mm-yyyy'), 'linaklimes@berkeley.edu', 546221579, '68353 Corry Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (269953905, 'Idalina Conahy', to_date('24-09-2009', 'dd-mm-yyyy'), 'idalinaconahy@altervista.org', 566338533, '52160 Debra Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (670980747, 'Susie Jados', to_date('13-02-2000', 'dd-mm-yyyy'), 'susiejados@goo.gl', 562893269, '39125 Golf View Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (165069233, 'Gloriana Stoak', to_date('15-09-2009', 'dd-mm-yyyy'), 'glorianastoak@mac.com', 505620282, '0 Hanson Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (299747885, 'Joellyn Miranda', to_date('25-02-2014', 'dd-mm-yyyy'), 'joellynmiranda@cnbc.com', 506372053, '8207 American Ash Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (466239135, 'Luz Treadger', to_date('10-01-2003', 'dd-mm-yyyy'), 'luztreadger@wordpress.org', 571476877, '8416 Scoville Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (403567464, 'Edi Scough', to_date('16-06-2011', 'dd-mm-yyyy'), 'ediscough@geocities.jp', 512002205, '4557 Sloan Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (815054512, 'Gabriellia Pennyman', to_date('28-07-2002', 'dd-mm-yyyy'), 'gabrielliapennyman@list-manage.com', 580906426, '0756 Sunnyside Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (356625533, 'Ginnifer Whitney', to_date('09-12-2000', 'dd-mm-yyyy'), 'ginniferwhitney@scribd.com', 510724145, '85 Pepper Wood Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (768831807, 'Debra Stampe', to_date('23-05-2018', 'dd-mm-yyyy'), 'debrastampe@nydailynews.com', 527562886, '38 Quincy Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (805723700, 'Doro Spellard', to_date('22-03-2006', 'dd-mm-yyyy'), 'dorospellard@twitter.com', 564962205, '170 Blackbird Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (640098230, 'Joan Opfer', to_date('20-09-2012', 'dd-mm-yyyy'), 'joanopfer@who.int', 562280645, '260 Emmet Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (422389418, 'Annabell Holberry', to_date('03-04-2016', 'dd-mm-yyyy'), 'annabellholberry@canalblog.com', 577356641, '1 Pawling Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (481788951, 'Kathryne Rodliff', to_date('08-12-2016', 'dd-mm-yyyy'), 'kathrynerodliff@wisc.edu', 527604470, '14286 Paget Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (680526159, 'Fran Shapcott', to_date('19-11-2008', 'dd-mm-yyyy'), 'franshapcott@lulu.com', 515004484, '062 Transport Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (308829624, 'Elbertine Newdick', to_date('08-12-2006', 'dd-mm-yyyy'), 'elbertinenewdick@usnews.com', 562989410, '015 Melvin Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (363820511, 'Millisent Gorman', to_date('06-02-2019', 'dd-mm-yyyy'), 'millisentgorman@livejournal.com', 568315151, '42 Corry Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (296735164, 'Kally Mulgrew', to_date('16-08-2018', 'dd-mm-yyyy'), 'kallymulgrew@mashable.com', 532475011, '354 Hollow Ridge Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (513603889, 'Bibby Tiddeman', to_date('30-01-2000', 'dd-mm-yyyy'), 'bibbytiddeman@washington.edu', 554396044, '9 Schlimgen Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (522099376, 'Minny Grand', to_date('15-07-2014', 'dd-mm-yyyy'), 'minnygrand@vk.com', 580694365, '590 Sloan Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (204825426, 'Amalia Sherreard', to_date('31-10-2019', 'dd-mm-yyyy'), 'amaliasherreard@drupal.org', 568124239, '7 Eagan Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (428745222, 'Hannis Paul', to_date('25-10-2019', 'dd-mm-yyyy'), 'hannispaul@godaddy.com', 502974508, '8011 Vermont Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (746398682, 'Gwenette Weigh', to_date('05-07-2001', 'dd-mm-yyyy'), 'gwenetteweigh@spiegel.de', 540307828, '3150 Bashford Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (607668294, 'Ki Lardge', to_date('05-07-2017', 'dd-mm-yyyy'), 'kilardge@cocolog-nifty.com', 560818441, '0196 Northview Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (452104744, 'Ora Fuzzey', to_date('26-08-2009', 'dd-mm-yyyy'), 'orafuzzey@nih.gov', 550126623, '49 Scott Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (171170060, 'Sheelagh Sparks', to_date('10-02-2004', 'dd-mm-yyyy'), 'sheelaghsparks@comcast.net', 513196909, '7968 Almo Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (105283129, 'Delphinia MacAndie', to_date('24-04-2004', 'dd-mm-yyyy'), 'delphiniamacandie@hp.com', 508179410, '6286 Dapin Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (357643935, 'Nariko Elldred', to_date('17-01-2003', 'dd-mm-yyyy'), 'narikoelldred@lycos.com', 532090706, '6 Kinsman Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (357723571, 'Celene Bottjer', to_date('01-07-2017', 'dd-mm-yyyy'), 'celenebottjer@addthis.com', 578033512, '2698 Dryden Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (907424842, 'Wenonah Hutchinges', to_date('20-12-2018', 'dd-mm-yyyy'), 'wenonahhutchinges@tiny.cc', 532591120, '90 Quincy Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (527686504, 'Lauretta Kedwell', to_date('12-05-2007', 'dd-mm-yyyy'), 'laurettakedwell@phoca.cz', 520592689, '30894 Hayes Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (418300944, 'Keelia Ginsie', to_date('27-07-2011', 'dd-mm-yyyy'), 'keeliaginsie@gnu.org', 560316083, '9 Lyons Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (433116488, 'Gertrud Middup', to_date('18-02-2001', 'dd-mm-yyyy'), 'gertrudmiddup@nyu.edu', 558040424, '4339 Ramsey Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (795466385, 'Kaleena Curror', to_date('21-02-2000', 'dd-mm-yyyy'), 'kaleenacurror@fema.gov', 538106306, '39 Tomscot Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (351699289, 'Cristina Snoxell', to_date('10-01-2019', 'dd-mm-yyyy'), 'cristinasnoxell@sourceforge.net', 514340875, '70 Jenna Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (765327686, 'Elane Rowcliffe', to_date('17-07-2014', 'dd-mm-yyyy'), 'elanerowcliffe@lycos.com', 508240348, '4778 South Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (271296079, 'Chanda Hanburry', to_date('25-02-2006', 'dd-mm-yyyy'), 'chandahanburry@quantcast.com', 559134874, '91238 Talmadge Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (466010638, 'Laetitia Kovacs', to_date('29-03-2009', 'dd-mm-yyyy'), 'laetitiakovacs@t.co', 569631009, '08234 Stuart Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (323888942, 'Sayre Chandler', to_date('09-08-2003', 'dd-mm-yyyy'), 'sayrechandler@deliciousdays.com', 507632245, '09 Independence Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (427746575, 'Elaine Horsell', to_date('08-02-2009', 'dd-mm-yyyy'), 'elainehorsell@ebay.com', 536308844, '5 Florence Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (301184346, 'Traci Crehan', to_date('04-03-2001', 'dd-mm-yyyy'), 'tracicrehan@bizjournals.com', 550906077, '19 Acker Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (699262710, 'Moina Jewett', to_date('21-04-2011', 'dd-mm-yyyy'), 'moinajewett@bloglines.com', 508507108, '02 Spohn Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (240921696, 'Sharleen Winger', to_date('30-04-2015', 'dd-mm-yyyy'), 'sharleenwinger@ocn.ne.jp', 533902363, '3 Anniversary Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (926497407, 'Cora Elby', to_date('04-11-2010', 'dd-mm-yyyy'), 'coraelby@wix.com', 510931264, '82714 Caliangt Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (661315918, 'Maryellen Maddaford', to_date('22-09-2000', 'dd-mm-yyyy'), 'maryellenmaddaford@cam.ac.uk', 586739353, '321 Macpherson Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (103639039, 'Angela Kingscote', to_date('01-07-2013', 'dd-mm-yyyy'), 'angelakingscote@clickbank.net', 557727237, '28558 Jenifer Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (411001240, 'Dotty Bonfield', to_date('02-08-2008', 'dd-mm-yyyy'), 'dottybonfield@techcrunch.com', 518151240, '16568 Briar Crest Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (373140049, 'Aeriell Nasey', to_date('23-11-2013', 'dd-mm-yyyy'), 'aeriellnasey@flavors.me', 579644910, '8 Hayes Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (107286193, 'Lisbeth Crosskill', to_date('25-04-2003', 'dd-mm-yyyy'), 'lisbethcrosskill@hp.com', 562875800, '87513 Lukken Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (492827855, 'Tiffanie Normand', to_date('09-04-2009', 'dd-mm-yyyy'), 'tiffanienormand@soup.io', 535499347, '66 Stone Corner Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (163103742, 'Corella Lorenzini', to_date('25-04-2008', 'dd-mm-yyyy'), 'corellalorenzini@sitemeter.com', 514484320, '79068 Valley Edge Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (324906557, 'Jemie Probets', to_date('29-09-2006', 'dd-mm-yyyy'), 'jemieprobets@slashdot.org', 517556474, '88 4th Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (948875262, 'Jordan Eagell', to_date('23-08-2011', 'dd-mm-yyyy'), 'jordaneagell@npr.org', 524435849, '03 Bunting Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (925234625, 'Clare Doumer', to_date('09-10-2015', 'dd-mm-yyyy'), 'claredoumer@stanford.edu', 551383357, '56 Algoma Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (982076921, 'Herta Beckett', to_date('10-05-2008', 'dd-mm-yyyy'), 'hertabeckett@fema.gov', 562543103, '28268 Magdeline Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (846802745, 'Willa Melody', to_date('20-05-2007', 'dd-mm-yyyy'), 'willamelody@go.com', 552859033, '40560 Golf Course Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (656802060, 'Willow Hamnett', to_date('24-05-2004', 'dd-mm-yyyy'), 'willowhamnett@netlog.com', 543263368, '3 Lake View Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (463520539, 'Fara Longo', to_date('14-12-2007', 'dd-mm-yyyy'), 'faralongo@jimdo.com', 575677586, '731 Hallows Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (359642256, 'Lucia Tropman', to_date('19-12-2014', 'dd-mm-yyyy'), 'luciatropman@dedecms.com', 555571448, '6 Artisan Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (382678745, 'Dayle Monkton', to_date('19-04-2017', 'dd-mm-yyyy'), 'daylemonkton@freewebs.com', 529616495, '76 Village Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (738309645, 'Nat Rediers', to_date('09-05-2015', 'dd-mm-yyyy'), 'natrediers@bloglovin.com', 568625452, '381 Muir Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (652916189, 'Ingunna Blight', to_date('28-01-2018', 'dd-mm-yyyy'), 'ingunnablight@squarespace.com', 519272098, '31188 Claremont Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (238831365, 'Carita Strang', to_date('01-05-2002', 'dd-mm-yyyy'), 'caritastrang@independent.co.uk', 529118127, '2931 Coolidge Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (108400326, 'Tandie Steinor', to_date('07-03-2019', 'dd-mm-yyyy'), 'tandiesteinor@aboutads.info', 519424829, '940 Washington Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (991789435, 'Germain Kirvell', to_date('17-09-2007', 'dd-mm-yyyy'), 'germainkirvell@stumbleupon.com', 565132122, '1 Cascade Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (407933782, 'Ainslee Enever', to_date('26-08-2001', 'dd-mm-yyyy'), 'ainsleeenever@sakura.ne.jp', 565633261, '1960 Dovetail Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (508814603, 'Isabelle Kollach', to_date('12-02-2013', 'dd-mm-yyyy'), 'isabellekollach@github.com', 538448018, '41308 Stoughton Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (442274284, 'Aime Shellcross', to_date('13-01-2004', 'dd-mm-yyyy'), 'aimeshellcross@wufoo.com', 560960940, '936 Upham Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (513923427, 'Johannah MacTimpany', to_date('03-04-2008', 'dd-mm-yyyy'), 'johannahmactimpany@vinaora.com', 538064885, '168 Clarendon Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (284519851, 'Romona Ferry', to_date('18-11-2013', 'dd-mm-yyyy'), 'romonaferry@imageshack.us', 532892287, '5 Crest Line Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (226019979, 'Vitia Goulden', to_date('03-05-2017', 'dd-mm-yyyy'), 'vitiagoulden@springer.com', 556816742, '88 Pierstorff Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (451356256, 'Tressa Bedson', to_date('09-02-2016', 'dd-mm-yyyy'), 'tressabedson@rakuten.co.jp', 548419808, '7849 Hanson Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (773608536, 'Blanch Pietruszka', to_date('13-10-2008', 'dd-mm-yyyy'), 'blanchpietruszka@unicef.org', 564509330, '871 Cherokee Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (143766014, 'Shoshanna Grigore', to_date('08-01-2017', 'dd-mm-yyyy'), 'shoshannagrigore@cbsnews.com', 579016034, '8 Summit Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (607902262, 'Cam Kier', to_date('14-09-2019', 'dd-mm-yyyy'), 'camkier@list-manage.com', 501128599, '165 Paget Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (666288551, 'Corinne Boyington', to_date('03-08-2002', 'dd-mm-yyyy'), 'corinneboyington@princeton.edu', 507760448, '5 Bunker Hill Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (438150346, 'Madelyn Roon', to_date('20-06-2002', 'dd-mm-yyyy'), 'madelynroon@youtu.be', 588660871, '36597 Melvin Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (413834362, 'Harriott Meatyard', to_date('09-02-2002', 'dd-mm-yyyy'), 'harriottmeatyard@amazon.co.jp', 521937036, '873 Leroy Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441996211, 'Brit Giovanetti', to_date('24-02-2011', 'dd-mm-yyyy'), 'britgiovanetti@youtube.com', 577370555, '45 Waywood Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (346192718, 'Kaye McKiddin', to_date('28-05-2015', 'dd-mm-yyyy'), 'kayemckiddin@time.com', 566697544, '60072 Colorado Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (301254976, 'Kippy Corryer', to_date('22-04-2007', 'dd-mm-yyyy'), 'kippycorryer@indiatimes.com', 505768452, '034 Mallory Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (427084310, 'Selena Osgar', to_date('27-01-2012', 'dd-mm-yyyy'), 'selenaosgar@prweb.com', 576385247, '33496 Cordelia Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (175441465, 'Elfrieda Shewry', to_date('14-06-2019', 'dd-mm-yyyy'), 'elfriedashewry@cargocollective.com', 541540613, '38 Fremont Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (251122348, 'Josepha Vallentin', to_date('09-11-2019', 'dd-mm-yyyy'), 'josephavallentin@dropbox.com', 582496724, '672 Mayer Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (620372277, 'Kelsi Mioni', to_date('02-08-2012', 'dd-mm-yyyy'), 'kelsimioni@chron.com', 511818857, '5566 Prairie Rose Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (715505955, 'Genevieve Stormonth', to_date('09-04-2005', 'dd-mm-yyyy'), 'genevievestormonth@people.com.cn', 510158528, '79 Texas Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (327370740, 'Jenny Garrod', to_date('13-10-2013', 'dd-mm-yyyy'), 'jennygarrod@ning.com', 502242005, '26 Hudson Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (851431384, 'Ertha Burdin', to_date('02-03-2019', 'dd-mm-yyyy'), 'erthaburdin@europa.eu', 527289130, '6 Lyons Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (579785481, 'Kirby Andren', to_date('20-07-2012', 'dd-mm-yyyy'), 'kirbyandren@ameblo.jp', 588470095, '114 Anhalt Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (380007079, 'Carlynne Zorro', to_date('01-09-2002', 'dd-mm-yyyy'), 'carlynnezorro@mac.com', 552158767, '5 Monica Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (689614398, 'Rosette Sleit', to_date('26-10-2010', 'dd-mm-yyyy'), 'rosettesleit@dot.gov', 556712433, '110 Sommers Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (159480739, 'Cathryn Yurin', to_date('03-01-2019', 'dd-mm-yyyy'), 'cathrynyurin@cdbaby.com', 574258496, '9 Anhalt Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (670693235, 'Miquela Saphir', to_date('24-03-2018', 'dd-mm-yyyy'), 'miquelasaphir@google.com', 525256942, '77 Pawling Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (891087041, 'Valry Maudlen', to_date('26-01-2000', 'dd-mm-yyyy'), 'valrymaudlen@cbsnews.com', 574990036, '11926 Spohn Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (723299115, 'Virginia McCarrell', to_date('16-12-2003', 'dd-mm-yyyy'), 'virginiamccarrell@java.com', 522464610, '437 Lawn Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (560105519, 'Suki Crake', to_date('25-10-2015', 'dd-mm-yyyy'), 'sukicrake@sphinn.com', 533138180, '43 Manley Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (398746881, 'Amandi Teresi', to_date('05-06-2013', 'dd-mm-yyyy'), 'amanditeresi@storify.com', 507697454, '53 Gulseth Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (764463799, 'Aundrea Gewer', to_date('04-03-2008', 'dd-mm-yyyy'), 'aundreagewer@technorati.com', 577271045, '4 Sherman Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (131145243, 'Gladys Petriello', to_date('16-01-2005', 'dd-mm-yyyy'), 'gladyspetriello@1und1.de', 505252466, '211 Arizona Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (772584828, 'Karie Canner', to_date('08-09-2018', 'dd-mm-yyyy'), 'kariecanner@ovh.net', 531097008, '42822 Pawling Crossing');
commit;
prompt 800 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (996862753, 'Brianne Morfield', to_date('12-09-2016', 'dd-mm-yyyy'), 'briannemorfield@addtoany.com', 577738666, '786 Grover Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (885568274, 'Nonnah Birtwistle', to_date('01-02-2004', 'dd-mm-yyyy'), 'nonnahbirtwistle@themeforest.net', 569340660, '8547 Pierstorff Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (654360049, 'Sammy Burdin', to_date('11-10-2005', 'dd-mm-yyyy'), 'sammyburdin@europa.eu', 503773576, '62 Heath Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (190360834, 'Jana Belhomme', to_date('09-04-2006', 'dd-mm-yyyy'), 'janabelhomme@imdb.com', 514162576, '3711 Algoma Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (329865472, 'Talya Knotton', to_date('18-01-2008', 'dd-mm-yyyy'), 'talyaknotton@angelfire.com', 568890088, '9039 Roxbury Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (940067704, 'Kyle Seamarke', to_date('17-11-2018', 'dd-mm-yyyy'), 'kyleseamarke@cisco.com', 562962888, '24299 Chinook Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (487796197, 'Robinette Duligal', to_date('26-06-2007', 'dd-mm-yyyy'), 'robinetteduligal@so-net.ne.jp', 518206531, '425 Petterle Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (763635580, 'Renata Beet', to_date('21-01-2007', 'dd-mm-yyyy'), 'renatabeet@amazon.co.uk', 518519222, '1225 Ridge Oak Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (458408009, 'Cybil Siddall', to_date('23-07-2005', 'dd-mm-yyyy'), 'cybilsiddall@statcounter.com', 568573239, '7 Northfield Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (773893260, 'Kimmy Loyd', to_date('07-02-2015', 'dd-mm-yyyy'), 'kimmyloyd@jugem.jp', 533558965, '3789 Del Sol Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (569660568, 'Frank Olpin', to_date('08-10-2017', 'dd-mm-yyyy'), 'frankolpin@moonfruit.com', 545788840, '074 Drewry Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (785974864, 'Cosette Tinman', to_date('03-06-2016', 'dd-mm-yyyy'), 'cosettetinman@fotki.com', 531423064, '63032 Sugar Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (713320698, 'Pansie Scanes', to_date('08-10-2012', 'dd-mm-yyyy'), 'pansiescanes@vistaprint.com', 560188782, '886 Kensington Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (879622687, 'Lorinda Saggers', to_date('08-03-2009', 'dd-mm-yyyy'), 'lorindasaggers@macromedia.com', 505865945, '3450 Grover Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (403418492, 'Inger Rings', to_date('16-10-2014', 'dd-mm-yyyy'), 'ingerrings@woothemes.com', 521517684, '469 North Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (973970811, 'Kerrill Cozby', to_date('07-11-2004', 'dd-mm-yyyy'), 'kerrillcozby@house.gov', 549269912, '2744 Mandrake Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (547079702, 'Melany Greenwood', to_date('10-08-2007', 'dd-mm-yyyy'), 'melanygreenwood@bandcamp.com', 585907634, '3434 Sheridan Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (834129951, 'Karylin Narramor', to_date('06-02-2019', 'dd-mm-yyyy'), 'karylinnarramor@whitehouse.gov', 579473046, '9522 Blaine Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (153367163, 'Gertrud Treherne', to_date('12-08-2006', 'dd-mm-yyyy'), 'gertrudtreherne@jigsy.com', 504265729, '60 Rutledge Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (798624234, 'Cathi Taffe', to_date('18-04-2003', 'dd-mm-yyyy'), 'cathitaffe@youtube.com', 514063267, '667 Northridge Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (659880448, 'Lonee Stollsteiner', to_date('02-04-2004', 'dd-mm-yyyy'), 'loneestollsteiner@diigo.com', 577104767, '7976 Hazelcrest Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (910680191, 'Celina Sweedy', to_date('30-05-2006', 'dd-mm-yyyy'), 'celinasweedy@chicagotribune.com', 538094268, '81 Corry Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (946331566, 'Fernande McNaughton', to_date('20-07-2002', 'dd-mm-yyyy'), 'fernandemcnaughton@aol.com', 543645606, '947 Northfield Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (505151181, 'Iolanthe Shipp', to_date('03-05-2015', 'dd-mm-yyyy'), 'iolantheshipp@buzzfeed.com', 547400915, '886 Anthes Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (584847554, 'Patrica Fairlam', to_date('05-05-2008', 'dd-mm-yyyy'), 'patricafairlam@globo.com', 508889232, '7 Gerald Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (919043255, 'Kore Howgego', to_date('08-12-2016', 'dd-mm-yyyy'), 'korehowgego@qq.com', 524871148, '69399 Duke Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (962096973, 'Sher Datte', to_date('14-01-2013', 'dd-mm-yyyy'), 'sherdatte@engadget.com', 530661251, '4 Hanover Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (919439565, 'Devan Glyne', to_date('24-01-2005', 'dd-mm-yyyy'), 'devanglyne@flavors.me', 555356977, '20735 Longview Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (193367254, 'Josee Feare', to_date('12-01-2005', 'dd-mm-yyyy'), 'joseefeare@disqus.com', 508696686, '7 Larry Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (717581744, 'Nadeen Illingsworth', to_date('13-04-2010', 'dd-mm-yyyy'), 'nadeenillingsworth@indiatimes.com', 567450510, '2 Ruskin Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (346637647, 'Valery Leason', to_date('03-11-2000', 'dd-mm-yyyy'), 'valeryleason@friendfeed.com', 524245659, '67 Delaware Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (547461534, 'Rania Dollard', to_date('06-11-2011', 'dd-mm-yyyy'), 'raniadollard@ask.com', 521162985, '53674 Ronald Regan Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (497974425, 'Jewelle Staddart', to_date('07-08-2013', 'dd-mm-yyyy'), 'jewellestaddart@nydailynews.com', 558289551, '1137 Hagan Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (593999831, 'Mersey Durand', to_date('20-01-2016', 'dd-mm-yyyy'), 'merseydurand@histats.com', 520557653, '6441 Debs Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441696270, 'Jennifer Belham', to_date('05-09-2014', 'dd-mm-yyyy'), 'jenniferbelham@dailymail.co.uk', 528030118, '827 Birchwood Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (325043737, 'Gloriana Concklin', to_date('20-01-2002', 'dd-mm-yyyy'), 'glorianaconcklin@diigo.com', 523122514, '6 Huxley Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (566408163, 'Garnet Griss', to_date('07-07-2004', 'dd-mm-yyyy'), 'garnetgriss@reverbnation.com', 573172699, '14 Kipling Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (431546217, 'Birdie Ulster', to_date('01-08-2008', 'dd-mm-yyyy'), 'birdieulster@friendfeed.com', 504143828, '23 Meadow Ridge Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (782477403, 'Ki Ashelford', to_date('13-06-2005', 'dd-mm-yyyy'), 'kiashelford@ebay.com', 550026822, '472 Knutson Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (966881718, 'Dannye Cornely', to_date('06-08-2017', 'dd-mm-yyyy'), 'dannyecornely@is.gd', 580854071, '4 Clyde Gallagher Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (527125810, 'Karie Madders', to_date('12-09-2002', 'dd-mm-yyyy'), 'kariemadders@amazonaws.com', 514124374, '485 Marquette Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (407652575, 'Josselyn Lewer', to_date('18-01-2002', 'dd-mm-yyyy'), 'josselynlewer@mlb.com', 582574120, '123 Elka Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (866733001, 'Ardath Scattergood', to_date('18-01-2003', 'dd-mm-yyyy'), 'ardathscattergood@goodreads.com', 521399142, '29823 Johnson Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (609774041, 'Malanie Philson', to_date('20-01-2015', 'dd-mm-yyyy'), 'malaniephilson@nyu.edu', 589346212, '295 Stuart Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (362479656, 'Meggy Paolacci', to_date('11-04-2018', 'dd-mm-yyyy'), 'meggypaolacci@timesonline.co.uk', 511612818, '827 Talmadge Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (241637541, 'Gretta MacAvaddy', to_date('19-03-2007', 'dd-mm-yyyy'), 'grettamacavaddy@elpais.com', 524076290, '8170 Larry Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (418941549, 'Alie Found', to_date('23-04-2000', 'dd-mm-yyyy'), 'aliefound@yellowpages.com', 546287545, '538 Utah Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (844609510, 'Doe Klink', to_date('02-05-2017', 'dd-mm-yyyy'), 'doeklink@unc.edu', 512224013, '69 Rieder Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (643181374, 'Arlena Clemmen', to_date('14-11-2003', 'dd-mm-yyyy'), 'arlenaclemmen@privacy.gov.au', 571996735, '1 Dawn Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (745767641, 'Colette Coulthart', to_date('19-11-2016', 'dd-mm-yyyy'), 'colettecoulthart@hp.com', 580521060, '9367 Ryan Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (630664380, 'Timi Gosneye', to_date('11-08-2003', 'dd-mm-yyyy'), 'timigosneye@vkontakte.ru', 571656028, '60 Russell Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (304226614, 'Alis Tomaini', to_date('21-09-2006', 'dd-mm-yyyy'), 'alistomaini@statcounter.com', 521081796, '7 Meadow Ridge Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (497672990, 'Shandra Gostage', to_date('08-07-2008', 'dd-mm-yyyy'), 'shandragostage@chicagotribune.com', 538718305, '24 Lyons Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (742292557, 'Alexandrina Bondley', to_date('12-01-2003', 'dd-mm-yyyy'), 'alexandrinabondley@bbc.co.uk', 501725458, '4531 Melby Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (873353399, 'Linea Egell', to_date('17-01-2019', 'dd-mm-yyyy'), 'lineaegell@latimes.com', 539652034, '0 Mendota Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (209623814, 'Collete Whiterod', to_date('03-01-2016', 'dd-mm-yyyy'), 'colletewhiterod@ehow.com', 509793433, '99895 Farragut Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (611314031, 'Loralyn Nann', to_date('05-11-2004', 'dd-mm-yyyy'), 'loralynnann@angelfire.com', 578585198, '63 Derek Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (598858081, 'Tresa McKelvey', to_date('30-10-2011', 'dd-mm-yyyy'), 'tresamckelvey@aol.com', 586728756, '0914 Hagan Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (977848457, 'Roxana Slatcher', to_date('29-07-2015', 'dd-mm-yyyy'), 'roxanaslatcher@feedburner.com', 540343700, '726 Merrick Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (945019903, 'Carmel McGirl', to_date('14-10-2011', 'dd-mm-yyyy'), 'carmelmcgirl@oaic.gov.au', 516619260, '1532 Shasta Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (781922286, 'Linet Matyukon', to_date('23-12-2010', 'dd-mm-yyyy'), 'linetmatyukon@zimbio.com', 527355009, '68 Mcguire Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (331008865, 'Morissa Giorgi', to_date('23-12-2019', 'dd-mm-yyyy'), 'morissagiorgi@intel.com', 584763145, '45 Tony Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (476772296, 'Amara Budgett', to_date('13-07-2006', 'dd-mm-yyyy'), 'amarabudgett@acquirethisname.com', 552074305, '3 Becker Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (237075795, 'Delcine Clementson', to_date('31-03-2011', 'dd-mm-yyyy'), 'delcineclementson@eventbrite.com', 530436185, '00376 Banding Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (738218439, 'Nolie Sidery', to_date('23-07-2014', 'dd-mm-yyyy'), 'noliesidery@dailymotion.com', 564841726, '6 Blackbird Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (262643480, 'Jessi Riccioppo', to_date('13-02-2011', 'dd-mm-yyyy'), 'jessiriccioppo@cbsnews.com', 586521424, '030 Mendota Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (871728908, 'Maybelle Chadbourne', to_date('24-06-2005', 'dd-mm-yyyy'), 'maybellechadbourne@shutterfly.com', 582064455, '76187 Bellgrove Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (433076239, 'Molli Pluvier', to_date('29-12-2002', 'dd-mm-yyyy'), 'mollipluvier@loc.gov', 544122680, '0078 Scott Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (907674013, 'Selena Ragborne', to_date('22-11-2012', 'dd-mm-yyyy'), 'selenaragborne@ycombinator.com', 550127771, '847 Sutteridge Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (401709948, 'Olive Krollman', to_date('26-07-2000', 'dd-mm-yyyy'), 'olivekrollman@harvard.edu', 544154018, '78 Anthes Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (497880581, 'Dorelia Primak', to_date('29-10-2019', 'dd-mm-yyyy'), 'doreliaprimak@virginia.edu', 504076134, '284 Declaration Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (226986610, 'Emylee Prudham', to_date('31-10-2002', 'dd-mm-yyyy'), 'emyleeprudham@msu.edu', 586267391, '069 Northridge Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (182963438, 'Horatia Stallen', to_date('12-10-2017', 'dd-mm-yyyy'), 'horatiastallen@google.com.br', 570439926, '49233 Bellgrove Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (548330988, 'Marcelline Ludlamme', to_date('26-11-2003', 'dd-mm-yyyy'), 'marcellineludlamme@paypal.com', 585948074, '48 Continental Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (706326162, 'Lilias Strodder', to_date('20-12-2014', 'dd-mm-yyyy'), 'liliasstrodder@columbia.edu', 548015820, '8 Delaware Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (600244770, 'Nerte MacAndrew', to_date('11-02-2009', 'dd-mm-yyyy'), 'nertemacandrew@alibaba.com', 541793037, '392 Arkansas Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (921877972, 'Christi Beiderbeck', to_date('28-04-2008', 'dd-mm-yyyy'), 'christibeiderbeck@cam.ac.uk', 573625579, '17 Division Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (538534007, 'Olympia Orehead', to_date('11-05-2000', 'dd-mm-yyyy'), 'olympiaorehead@google.cn', 585147266, '38716 Schiller Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (558169743, 'Gratiana Ughini', to_date('21-09-2010', 'dd-mm-yyyy'), 'gratianaughini@elegantthemes.com', 581534843, '30921 Homewood Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (514339325, 'Othilia Farnworth', to_date('19-07-2005', 'dd-mm-yyyy'), 'othiliafarnworth@unicef.org', 584889886, '85215 Manitowish Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (672929772, 'Mariya Eschelle', to_date('14-12-2019', 'dd-mm-yyyy'), 'mariyaeschelle@instagram.com', 582923120, '00 Straubel Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (759277745, 'Penny Burrus', to_date('09-06-2010', 'dd-mm-yyyy'), 'pennyburrus@cbslocal.com', 545683148, '489 Lyons Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (410001958, 'Basia Ivel', to_date('03-11-2014', 'dd-mm-yyyy'), 'basiaivel@nydailynews.com', 545283904, '6 Dahle Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (364028941, 'Vivi Trinder', to_date('13-02-2013', 'dd-mm-yyyy'), 'vivitrinder@patch.com', 514445283, '1774 Donald Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (940887465, 'Courtenay Wornham', to_date('19-05-2003', 'dd-mm-yyyy'), 'courtenaywornham@t.co', 546535071, '6226 Glendale Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (157623754, 'Rita McMurdo', to_date('01-07-2010', 'dd-mm-yyyy'), 'ritamcmurdo@uol.com.br', 587258515, '6052 Florence Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (110437201, 'Lyndsey De Minico', to_date('28-07-2001', 'dd-mm-yyyy'), 'lyndseyde minico@google.de', 517297493, '0494 Hoard Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (527445580, 'Alexandrina Dahlborg', to_date('24-05-2018', 'dd-mm-yyyy'), 'alexandrinadahlborg@cocolog-nifty.com', 546067340, '6692 Stone Corner Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (349290214, 'Rachele Brason', to_date('03-11-2005', 'dd-mm-yyyy'), 'rachelebrason@home.pl', 566867798, '84 Pepper Wood Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (697864357, 'Cathy Allward', to_date('26-11-2012', 'dd-mm-yyyy'), 'cathyallward@1und1.de', 503415274, '01 Hudson Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (922336964, 'Hendrika Bidgood', to_date('16-08-2000', 'dd-mm-yyyy'), 'hendrikabidgood@ibm.com', 569661403, '38632 Eastwood Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (143359256, 'Vina Castledine', to_date('28-02-2002', 'dd-mm-yyyy'), 'vinacastledine@artisteer.com', 559595531, '036 Lake View Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (498521987, 'Rochette Muddimer', to_date('17-05-2015', 'dd-mm-yyyy'), 'rochettemuddimer@csmonitor.com', 542695563, '296 Golf Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (474646280, 'Clarita Pistol', to_date('24-04-2012', 'dd-mm-yyyy'), 'claritapistol@ihg.com', 590758602, '75 Fieldstone Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (621738771, 'Emili Bignell', to_date('11-11-2016', 'dd-mm-yyyy'), 'emilibignell@nydailynews.com', 518870325, '31 American Ash Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (858616442, 'Dulci Matuszinski', to_date('04-12-2003', 'dd-mm-yyyy'), 'dulcimatuszinski@jalbum.net', 590257660, '7 Warrior Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (258945756, 'Salome Allanby', to_date('07-12-2000', 'dd-mm-yyyy'), 'salomeallanby@yandex.ru', 562151814, '92 Tony Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (527280153, 'Brier Mattingley', to_date('07-06-2017', 'dd-mm-yyyy'), 'briermattingley@ted.com', 505679594, '12 Merchant Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (785952021, 'Feliza Quinevan', to_date('06-11-2012', 'dd-mm-yyyy'), 'felizaquinevan@kickstarter.com', 552302749, '177 Sunfield Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (263763052, 'Dede Gossop', to_date('12-08-2017', 'dd-mm-yyyy'), 'dedegossop@google.ru', 506593672, '5130 Mayfield Pass');
commit;
prompt 900 records committed...
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (634174678, 'Sibilla Wenman', to_date('13-01-2017', 'dd-mm-yyyy'), 'sibillawenman@redcross.org', 538245379, '874 Fairview Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (162741206, 'Pearl Benzies', to_date('09-03-2017', 'dd-mm-yyyy'), 'pearlbenzies@tmall.com', 555823059, '37391 Burning Wood Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (993619075, 'Almeta Le Estut', to_date('15-07-2011', 'dd-mm-yyyy'), 'almetale estut@merriam-webster.com', 570127556, '29032 Union Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (789430577, 'Kasey Bilborough', to_date('26-03-2015', 'dd-mm-yyyy'), 'kaseybilborough@rambler.ru', 566717423, '1 Vernon Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (519964492, 'Ingaberg Nern', to_date('28-08-2003', 'dd-mm-yyyy'), 'ingabergnern@businessweek.com', 511891766, '96171 Heffernan Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (895943487, 'Henka Landeaux', to_date('08-03-2017', 'dd-mm-yyyy'), 'henkalandeaux@irs.gov', 563561178, '87179 Boyd Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (157820082, 'Emmalynne Berndsen', to_date('10-02-2000', 'dd-mm-yyyy'), 'emmalynneberndsen@sohu.com', 518829794, '5706 Huxley Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (896975711, 'Carrissa Raithby', to_date('31-12-2002', 'dd-mm-yyyy'), 'carrissaraithby@stanford.edu', 567179777, '13874 Birchwood Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (349385964, 'Mab Patise', to_date('31-07-2008', 'dd-mm-yyyy'), 'mabpatise@mozilla.com', 581628700, '33 Paget Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (375034734, 'Magdalena Gostage', to_date('21-02-2006', 'dd-mm-yyyy'), 'magdalenagostage@yellowpages.com', 574665398, '04284 Transport Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (305478453, 'Willy Pylkynyton', to_date('21-09-2018', 'dd-mm-yyyy'), 'willypylkynyton@bbc.co.uk', 546991274, '9423 Butternut Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (601701489, 'Brandie Boyall', to_date('04-12-2001', 'dd-mm-yyyy'), 'brandieboyall@slate.com', 553844346, '0 Gulseth Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (572005342, 'Juliet Mallabar', to_date('04-03-2005', 'dd-mm-yyyy'), 'julietmallabar@newyorker.com', 578752376, '3503 Birchwood Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (482685638, 'Mariette Renac', to_date('28-07-2012', 'dd-mm-yyyy'), 'marietterenac@symantec.com', 503585800, '0 Bunting Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (366632145, 'Aubrey Jonah', to_date('28-04-2019', 'dd-mm-yyyy'), 'aubreyjonah@purevolume.com', 585053951, '72 Esch Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (770156282, 'Junette Hamelyn', to_date('05-01-2000', 'dd-mm-yyyy'), 'junettehamelyn@is.gd', 580660608, '54631 Golf Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (695972534, 'Patrica Grolmann', to_date('04-08-2002', 'dd-mm-yyyy'), 'patricagrolmann@cafepress.com', 509428916, '74274 Merchant Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (962588264, 'Carley Siggens', to_date('18-03-2008', 'dd-mm-yyyy'), 'carleysiggens@google.it', 526013796, '01936 Westport Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (733424841, 'Anitra Daniells', to_date('04-12-2007', 'dd-mm-yyyy'), 'anitradaniells@unesco.org', 561494586, '709 Butterfield Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (999257848, 'Charissa Dallan', to_date('29-01-2003', 'dd-mm-yyyy'), 'charissadallan@e-recht24.de', 560901643, '969 Hauk Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (885450349, 'Corenda Weatherall', to_date('02-08-2017', 'dd-mm-yyyy'), 'corendaweatherall@eepurl.com', 514075672, '4 Schiller Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (582020987, 'Babb Rosenhaus', to_date('06-04-2015', 'dd-mm-yyyy'), 'babbrosenhaus@marketwatch.com', 533400949, '6320 West Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (445960804, 'Jobye Alvar', to_date('28-12-2011', 'dd-mm-yyyy'), 'jobyealvar@alexa.com', 563893392, '25538 Gerald Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (998764869, 'Tiff Topping', to_date('13-04-2002', 'dd-mm-yyyy'), 'tifftopping@smh.com.au', 570848164, '28724 Orin Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (494960174, 'Beth Bazley', to_date('15-07-2010', 'dd-mm-yyyy'), 'bethbazley@domainmarket.com', 549510046, '5 Holy Cross Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (502491985, 'Alexa Housden', to_date('02-12-2016', 'dd-mm-yyyy'), 'alexahousden@yellowbook.com', 505053568, '94488 Old Gate Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (360999355, 'Doralin Harrop', to_date('10-01-2005', 'dd-mm-yyyy'), 'doralinharrop@oaic.gov.au', 518760967, '0307 Walton Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (339607802, 'Emmalynne Dyshart', to_date('08-09-2011', 'dd-mm-yyyy'), 'emmalynnedyshart@diigo.com', 526975946, '5 Barby Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (221497111, 'Andeee O''Harney', to_date('15-02-2017', 'dd-mm-yyyy'), 'andeeeo''harney@princeton.edu', 560344395, '96451 Continental Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (591082304, 'Drusy Loughrey', to_date('28-06-2004', 'dd-mm-yyyy'), 'drusyloughrey@google.cn', 504335854, '495 Judy Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (844165456, 'Denna Gratrex', to_date('10-04-2002', 'dd-mm-yyyy'), 'dennagratrex@cocolog-nifty.com', 512650412, '4566 David Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (182055053, 'Brett Keston', to_date('18-04-2017', 'dd-mm-yyyy'), 'brettkeston@unicef.org', 559623032, '40443 Stephen Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (441225071, 'Shaylynn Pizzie', to_date('18-04-2010', 'dd-mm-yyyy'), 'shaylynnpizzie@cam.ac.uk', 531176438, '72369 Arkansas Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (126517000, 'Thomasina Witchard', to_date('09-05-2013', 'dd-mm-yyyy'), 'thomasinawitchard@livejournal.com', 566105080, '390 American Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (213253770, 'Jessie Bunten', to_date('26-10-2004', 'dd-mm-yyyy'), 'jessiebunten@xrea.com', 565748073, '68570 Morningstar Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (185794095, 'Jada Farron', to_date('20-07-2003', 'dd-mm-yyyy'), 'jadafarron@bbb.org', 562691578, '10 Forster Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (980430236, 'Cassondra Dalley', to_date('16-05-2001', 'dd-mm-yyyy'), 'cassondradalley@shinystat.com', 576459852, '537 Mariners Cove Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (526438708, 'Melba Feast', to_date('29-10-2017', 'dd-mm-yyyy'), 'melbafeast@abc.net.au', 559417029, '4 Quincy Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (755209681, 'Orelee Conibear', to_date('04-10-2018', 'dd-mm-yyyy'), 'oreleeconibear@jiathis.com', 518575870, '54 Ridgeway Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (634913355, 'Dotti McAvaddy', to_date('05-01-2016', 'dd-mm-yyyy'), 'dottimcavaddy@ow.ly', 504615995, '1559 Lerdahl Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (339476205, 'Sephira Philps', to_date('04-06-2019', 'dd-mm-yyyy'), 'sephiraphilps@cdc.gov', 535061210, '1 Fairfield Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (240089876, 'Felisha Salliere', to_date('15-12-2007', 'dd-mm-yyyy'), 'felishasalliere@sciencedaily.com', 503073729, '3 Harper Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (984504236, 'Hazel Schooley', to_date('12-10-2018', 'dd-mm-yyyy'), 'hazelschooley@mtv.com', 567006032, '1 Towne Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (120024694, 'Ianthe Acreman', to_date('05-12-2017', 'dd-mm-yyyy'), 'iantheacreman@dagondesign.com', 507543431, '53 Grayhawk Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (457561642, 'Ruthanne Nurse', to_date('25-08-2017', 'dd-mm-yyyy'), 'ruthannenurse@cyberchimps.com', 509819741, '89798 Doe Crossing Lane');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (839691671, 'Brande Ollcott', to_date('01-10-2000', 'dd-mm-yyyy'), 'brandeollcott@yale.edu', 577715488, '66 Karstens Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (520342574, 'Rozele Waldock', to_date('01-08-2000', 'dd-mm-yyyy'), 'rozelewaldock@google.com', 545206254, '4629 Tennessee Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (388799844, 'Brit Burgane', to_date('12-11-2007', 'dd-mm-yyyy'), 'britburgane@hibu.com', 548467214, '9 New Castle Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (511064174, 'Rachele Toogood', to_date('27-08-2003', 'dd-mm-yyyy'), 'racheletoogood@army.mil', 539607560, '44154 Rowland Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (982854200, 'Astrid Pirrie', to_date('21-08-2012', 'dd-mm-yyyy'), 'astridpirrie@geocities.com', 520180171, '2123 Dovetail Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (187453014, 'Britta Delue', to_date('13-02-2004', 'dd-mm-yyyy'), 'brittadelue@fastcompany.com', 539856638, '816 Crest Line Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (612797289, 'Gennie Shorthill', to_date('12-02-2001', 'dd-mm-yyyy'), 'gennieshorthill@ed.gov', 513501873, '947 Steensland Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (432597233, 'Darda Daudray', to_date('13-11-2005', 'dd-mm-yyyy'), 'dardadaudray@pbs.org', 534777009, '6 Tennyson Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (861702774, 'Mufinella Guinness', to_date('26-07-2019', 'dd-mm-yyyy'), 'mufinellaguinness@hibu.com', 557187711, '1147 Crest Line Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (399077464, 'Alma Cabedo', to_date('17-10-2009', 'dd-mm-yyyy'), 'almacabedo@yelp.com', 577366968, '9270 Randy Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (823928736, 'Dana Kienl', to_date('17-03-2018', 'dd-mm-yyyy'), 'danakienl@upenn.edu', 556374232, '8 Sauthoff Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (971185840, 'Merrielle Hurn', to_date('08-11-2001', 'dd-mm-yyyy'), 'merriellehurn@omniture.com', 533143005, '657 Kingsford Crossing');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (622986567, 'Faydra Melmore', to_date('18-08-2006', 'dd-mm-yyyy'), 'faydramelmore@plala.or.jp', 571541705, '312 Kingsford Place');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (838142465, 'Lonee Nerger', to_date('08-04-2016', 'dd-mm-yyyy'), 'loneenerger@bing.com', 534664703, '94 Service Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (557790470, 'Tabbie Dowdle', to_date('29-11-2010', 'dd-mm-yyyy'), 'tabbiedowdle@harvard.edu', 535982555, '3601 Paget Avenue');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (468127207, 'Anne-corinne Sowter', to_date('11-07-2016', 'dd-mm-yyyy'), 'anne-corinnesowter@gizmodo.com', 501354951, '917 Glendale Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (177277974, 'Floria Champniss', to_date('12-03-2006', 'dd-mm-yyyy'), 'floriachampniss@google.co.uk', 507791056, '21904 Independence Point');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (598227354, 'Roda Alibone', to_date('23-01-2005', 'dd-mm-yyyy'), 'rodaalibone@nps.gov', 584439791, '78318 Forest Dale Road');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (462552035, 'Elane Delgua', to_date('05-07-2010', 'dd-mm-yyyy'), 'elanedelgua@mtv.com', 587332397, '8183 Dakota Plaza');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (854958507, 'Alisha Woodnutt', to_date('07-07-2008', 'dd-mm-yyyy'), 'alishawoodnutt@sakura.ne.jp', 520025601, '2 Troy Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (444008216, 'Chrystel Merrett', to_date('19-01-2014', 'dd-mm-yyyy'), 'chrystelmerrett@tripadvisor.com', 507517006, '98 Badeau Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (388592218, 'Loraine Shepherd', to_date('08-12-2001', 'dd-mm-yyyy'), 'loraineshepherd@utexas.edu', 524195872, '0 Pawling Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (612398190, 'Kalindi Moggan', to_date('29-11-2014', 'dd-mm-yyyy'), 'kalindimoggan@feedburner.com', 578564911, '8569 Pennsylvania Park');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (361791170, 'Angie Alleburton', to_date('28-06-2008', 'dd-mm-yyyy'), 'angiealleburton@infoseek.co.jp', 538431446, '795 Karstens Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (440671201, 'Geneva Gaish', to_date('30-07-2012', 'dd-mm-yyyy'), 'genevagaish@arizona.edu', 525271683, '72716 Bluestem Center');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (958863687, 'Hildegarde Marrett', to_date('11-03-2013', 'dd-mm-yyyy'), 'hildegardemarrett@ehow.com', 532435755, '61 Quincy Way');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (228056872, 'Annabell Labbett', to_date('07-11-2011', 'dd-mm-yyyy'), 'annabelllabbett@sohu.com', 555386989, '916 Columbus Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (594728451, 'Tammie Menear', to_date('22-10-2000', 'dd-mm-yyyy'), 'tammiemenear@163.com', 528980781, '98 Butterfield Trail');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (872708693, 'Jen Hiers', to_date('18-10-2003', 'dd-mm-yyyy'), 'jenhiers@tamu.edu', 501289522, '91 Hoffman Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (606754465, 'Gilligan Bursnell', to_date('21-08-2019', 'dd-mm-yyyy'), 'gilliganbursnell@sphinn.com', 559406388, '1726 Merrick Court');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (274715538, 'Suzy Ferrarello', to_date('07-04-2000', 'dd-mm-yyyy'), 'suzyferrarello@1688.com', 525071050, '459 Almo Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (638404454, 'Lise Adenet', to_date('23-11-2011', 'dd-mm-yyyy'), 'liseadenet@biblegateway.com', 562732825, '03214 Valley Edge Pass');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (267248998, 'Delilah Schnieder', to_date('03-06-2000', 'dd-mm-yyyy'), 'delilahschnieder@omniture.com', 552161357, '4716 Meadow Vale Hill');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (978293260, 'Issie Lichtfoth', to_date('03-09-2011', 'dd-mm-yyyy'), 'issielichtfoth@irs.gov', 531026575, '79 Caliangt Alley');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (796357825, 'Elyse Bayford', to_date('10-07-2011', 'dd-mm-yyyy'), 'elysebayford@harvard.edu', 573666501, '262 Transport Circle');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (300808131, 'Fina Ciciura', to_date('12-09-2016', 'dd-mm-yyyy'), 'finaciciura@newyorker.com', 515291963, '2 4th Street');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (549199038, 'Daphene McMylor', to_date('29-10-2003', 'dd-mm-yyyy'), 'daphenemcmylor@cmu.edu', 536883652, '55 Maple Parkway');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (105490171, 'Linnell Charville', to_date('10-08-2013', 'dd-mm-yyyy'), 'linnellcharville@barnesandnoble.com', 562962653, '5 Summerview Terrace');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (517114536, 'Astrix Eastgate', to_date('07-05-2009', 'dd-mm-yyyy'), 'astrixeastgate@is.gd', 546320433, '4 Old Gate Drive');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (437525444, 'Carolina Mew', to_date('04-10-2006', 'dd-mm-yyyy'), 'carolinamew@g.co', 584015682, '442 Goodland Junction');
insert into CMEMBER (m_id, m_name, m_dateofjoining, m_mail, m_phone, m_address)
values (987324803, 'Laurella Roscam', to_date('20-12-2005', 'dd-mm-yyyy'), 'laurellaroscam@nhs.uk', 579629799, '484 Shasta Lane');
commit;
prompt 986 records loaded
prompt Loading SERVICEGIVER...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ & Biostar M7VKQ Pro MB w/ 313M Case. W/ PS2 Mouse.', 731631935);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2100+ CPU (oem)(AXDA2100DUT3C; RevisionB).', 667916897);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.7Ghz 478 pin Box cpu + fan', 536750145);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 1;7Ghz Box CPU+fan (478 pin)', 750212736);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '14"/15" Filter Screen', 329865472);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '313K 300W P4/AMD and Free Case Fan and 2 Front USB.', 453064263);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATA 100 RAID controller card', 681850365);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'YS AMD T-Bird 1.2 Ghz Performance Series', 133984187);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU ASUS A7N8X Deluxe NVIDIA Force2', 926497407);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radion 7000 64Mb SD CRT+TV-Out', 439190057);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Antec PFII Series 1040BII 400W PSU.', 349290214);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATA 100 RAID controller card', 913264381);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Boka 406 Sub Woofer 4 Channel Speaker system', 276868998);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2500+ Barton (OEM). (with 333Mhz Front Side Bus w/ 512k Cache).', 823928736);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, '512Mb DDR 333 PC2700 (samsung)', 448882818);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX translucent blue color case with 300W P4/AMD with(front USB ready) .', 672588466);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Benwin S54 Surround Sound Speakers.', 185101463);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Dynatron CPU Cooler DF1206BH AMD Athlon\Duron Fan. (AMD Recommend)', 699214173);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 1.8 Ghz CPU BOX (533Mhz)', 887429256);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2600+ Retail box. (with 333Mhz Front Side Bus)', 343015765);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar Mini BareBone PC > iDEQ 200S.', 310735882);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb DDR 333 PC2700 (samsung)', 178737651);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD Duron 1.1/128M/30G Black Complete System.', 182055053);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Dynatron MicroFin DC1206BM-l AMD Athlon/Duron Fan w/ Copper Base up to AMD XP (AMD APPROVED!) 3000+.', 386928076);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'YS Intel P4 2.0Ghz POWER SYSTEM', 183639285);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'KIT Keyboard Mouse and Speakers to match color case', 237075795);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2400 Biostar M7VIK Skt A MotherBoard; KT400.', 462028344);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512MB DDR PC2700 Kingston(KVR333X64C25/512)', 879622687);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Benwin S54 Surround Sound Speakers.', 799597846);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'WD Caviar 20.0G 7200rpm Hard Drive', 441696270);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'LG Goldstar 16X DVD with audio cable OEM', 765327686);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2500+ Biostar M7VIK Skt A MotherBoard; KT400.', 911869430);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi DW-7801TE DVD Duplicator/Burner.', 834129951);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AOC LM520 Flat Screen (LCD) 15" Monitor', 171796939);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Biostar M7VKQ Pro MB w/ 313M case. W/ PS2 Mouse.', 468127207);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb SDRam PC133 Kingston', 583838247);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Sony 48x24x40 and 16x CD-RW/DVD OEM.', 516162245);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1900+ cpu Gigabyte GA-7ZXE Motherboard + Fan', 513603889);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 473903044);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 300Watt P4/P3/AMD Support PowerSupply.', 714440128);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Combo Intel P4 1.6Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 787229074);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'DVI to 15pin CRT adapter', 682573186);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master Ball Bearing Case Fan', 425485955);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'Combo AMD XP 2500+ Barton CPU ASUS A7N8X Deluxe NVIDIA Force2', 466988754);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo Intel Celeron 1.7ghz (box)478pin +Gigabyte GA8IRX M/b +fan', 146897612);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.0ghz Gigabyte GA-8LD533 m/b + fan.', 598858081);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, '2 Year Warranty On Combo''s.', 890819891);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Gigabyte GA 7DPXDW-c Dual AMD server board', 522099376);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7VIK SKT A AMD® DDR400 AGP 8x ;onboard Raid & Sound & 1394 .', 770156282);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'AMD XP 1800+ (oem)', 753024805);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, '312D ATX translucent blue color case with 300W P4/AMD with(front USB ready) .', 781922286);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 888269770);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'AOC 17" Monitor 7FSLK .25mm Dot Pitch TureFlat', 185794095);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2400+ Retail box.', 581307727);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1900+ Gigabyte GA-7VKML M/B + Fan', 206312322);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.4Ghz retail CPU + Gigabyte GA-8IE800 M/B + Fan.', 854958507);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Dynatron CPU Cooler DF1206BH AMD Athlon\Duron Fan. (AMD Recommend)', 209623814);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'AMD XP 2200+ & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 982854200);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.7ghz & Gigabyte GA-8LS533 MB w/ 313M Case. W/ Free PS2 Mouse.', 945019903);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ADS Technologies Firewire External Drive.', 844173763);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AOC 19" Monitor .26 9GLR', 559292166);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'BIOSTAR M6TSL skt370 m/b (30 day D.O.A Warranty)', 607902262);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'HP 1300 Laser Jet New.', 753638601);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2500+ Barton CPU ASUS A7N8X Deluxe NVIDIA Force2 w/ Antec Performance plus II 1040B Case.', 316640446);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb DDR PC2100 Kingston', 724109514);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7VKB Ver2.0 ATA100 socket A (w/30 day limit warranty)', 687464649);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.0ghz & Gigabyte GA-8LS533 MB w/ 313N Case. W/ Free PS2 Mouse.', 175441465);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 942515529);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb RDRam 800Mhz Kingston', 350723928);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2600+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 667562726);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GA-SINXP1394(GA-8SQ800 Ultra2) (SiS 655 Chipset) w/ Pentium 4 2.4 Ghz (Box CPU)', 547079702);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1900+ & Gigabyte GA-7VKMLS MB w/ 313M Color Case.', 992615606);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256MB DDR 400 (PC3200) Kingston(KVR400X64C3/256)', 153649997);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Logitech Optical Mouse', 644414827);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi 52x 40 x 48 CD-RW', 612546655);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 3.0Ghz FSB 800MHZ (478)pin(HT) 3 Year MFG Warr.', 332847604);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1900+ OEM', 241637541);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ & Biostar M7VKQ Pro MB w/ 313M Case. W/ PS2 Mouse.', 385313476);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313G-B ATX case 400W P4/AMD Free Fan and 2 Front USB.', 238002042);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Seagate 40GB 5400RPM ATA100', 840341264);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-8IE800 Intel®845E Chipset.', 529348579);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313K 300W P4/AMD and 2 Front USB.', 837052178);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '2 Year Warranty On BareBones.', 346192718);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'W.D 80.0Gb 7200rpm ATA100 (WD800BB)', 234029909);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'ADS USB 4 Port Hub', 943569264);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '14"/15" Filter Screen', 858481074);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'KIT Keyboard Mouse and Speakers to match Black cases.', 734366943);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'ADS USB2000 USB Turbo 2.0 pci Controller card', 951075931);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP2200/128M/30G Black Complete System.', 570953732);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.8Ghz 478pin(box)CPU + Gigabyte GA-8IRX (DDR up to 2GB/4 USB)M/B + Fan', 287920615);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Benwin S54 Surround Sound Speakers.', 407652575);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'LABTEC Cordless Desktop Keyboard & Mouse (Spanish Edition).', 977848457);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Fast Ethernet 10/100 8 port switching hub', 723299115);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & GigaByte GA-7VT600L MB w/ 313M case. Free PS2 Mouse.', 854805518);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Fast Ethernet 10/100 8 port switching hub', 250253966);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'USB Cable 6ft. Long.', 116462353);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M6VCG skt 370 m/b (30 day D.O.A Warranty)', 694803403);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Mitsumi 48x 12 x 40 CD-RW', 331919904);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, '14inch LCD MG-015A Xgen2 Monitor.', 572028348);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1600+ CPU (OEM)', 164659178);
commit;
prompt 100 records committed...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'hp deskjet 3820 printer - specifications and warranty.', 962096973);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 1.8ghz & Gigabyte GA-8IE800 MB w/ 313M Case. W/ Free PS2 Mouse.', 362479656);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & GigaByte 8IPE1000 Pro MB w/ Antec Performance Plus II 1040B Case.', 640098230);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP1800/128M/30G Black Complete System.', 274807987);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GigaByte G-Max AMD Flex ATX Platform .', 420154025);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312A Black ATX case 300W P4/AMD (Front USB Optional.)', 441225071);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 638404454);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2700+ FBS 333 & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 694209395);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '219L ATX color Case teal 400W ScrewLess mid tower w/case Fan', 485506309);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, '313F-B ATX case 400W P4/AMD Free LED Fan.', 310279833);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Boka 306 Sub Woofer Flat Speaker system', 660043671);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'SVA-USA VR-17S 17" TFT LCD Display.', 440671201);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D845PEBT2 P4 M/B DDR-333 & 533MHz FSB.', 506915991);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Intel Celeron 2.0Ghz 478 pin Box cpu + fan', 986676799);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Intel Pentium4 1.8ghz & Gigabyte GA-8LD533 MB w/ 313N Case. W/ Free PS2 Mouse.', 432597233);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Audio Cable.', 242113481);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '14inch LCD MG-015A Xgen2 Monitor.', 123959939);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Boka 1050 Sub Woofer and Speakers', 214271290);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Hewlett Packard Color Deskjet HP 3420 .( Comes with Sample of HP Paper. HP Bright White Paper; HP Gl', 702330680);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, '10 Pack CD-R cd''s Color pack', 762821548);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Intel Celeron 1.7Ghz/128M/30G Black Complete System.', 551526087);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312A Black ATX case 300W P4/AMD (Front USB Optional.)', 816391512);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 173927735);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '6066-C10 ATX Black Mid case 350W w/ 2 Front USB; 1 Mic; 1 Headset.', 232516560);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & Intel D845PESV MB w/ 313M Case. W/ Free PS2 Mouse.', 995273588);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi 52x 40 x 48 CD-RW', 343057735);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '6072-1 case with side window 400W Powersupply.', 918190109);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Cable/DSL Broadband Router (w/ 4-port Switch) (EE400-R).', 687537052);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '6072-1 case with side window 400W Powersupply.', 871846808);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & Gigabyte 8IRXP MB w/ 313N Case. W/ Free PS2 Mouse.', 697015085);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2600+ & Biostar M7VIK KT400 MB w/ 313M case. Free PS2 Mouse.', 380288743);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'C Rimm', 594728451);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.8Ghz (Box CPU)+ Biostar U8668D m/b (478pin)CPU & Fan Support .', 672929772);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 400Watt P4/P3/AMD Support PS.', 478765875);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP1800/128M/30G Black Complete System.', 509387616);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 1.7Ghz & Biostar M7TDB MB w/ 313M Case.', 126762133);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313M ATX color Case blue 300W P4 w/ front USB & case fan', 763635580);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATX 300W High Quality Switching Power Supply', 768584445);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 2.0Ghz 478 pin Box cpu + fan', 615586328);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Creative Inspire 2.1 2500 surround sound', 970123677);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 277855177);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD XP 2600+ & Biostar M7VIK KT400 MB w/ 313M case. Free PS2 Mouse.', 402986300);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master Ball Bearing Case Fan', 257691173);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Sound Blaster Audigy with 1394 firewire (oem)', 595247363);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD Duron 1.3MHz & Biostar M7VIG-Pro MB w/ 312D case. Free PS2 Mouse.', 164877394);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.8Ghz (Box CPU)+ Biostar U8668D m/b (478pin)CPU & Fan Support SD.', 360000709);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 496859662);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Black LG Electronics CD-RW 48x12x48x / DVD 16x Combo Drive.', 189535699);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1700+ & Gigabyte GA-7ZXE MB w/ 313N Case. W/ Free PS2 Mouse.', 895629963);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar Mini BareBone PC > iDEQ 200N.', 553517298);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 400Watt P4/P3/AMD Support PS.', 105836606);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel Celeron 1.8ghz & Biostar U8668D. W/ Free CNR 56k & PS2 Mouse.', 972229832);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP1800 Biostar M7VKQ Pro', 579785481);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Intel P4 3.06 HT CPU & Intel D845PEBT2 M/B onboard Raid and S-ATA', 115967722);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Surge protector', 364362923);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Mitsumi DW-7801TE DVD Duplicator/Burner.', 318609792);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ Biostar M7VIG Pro m/b + Cooler Master fan', 801616613);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb SDRam PC133 Kingston', 874216918);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Serial ATA IDE Connector.', 595271596);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'Biostar M6VCF MICRO ATX M/B(w/30 day D.O.A. warranty)', 135014039);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.0ghz & Gigabyte 8IE533 MB w/ 313N Case. W/ Free PS2 Mouse.', 285418152);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'ADS External USB 2.0 Drive Kit', 377585071);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, '500W P4 Dual Fan Codegen Power supply.', 579018697);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '10/100 REALTEK NETWORK CARD 8139 chipset RETAIL BOX', 370249439);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2400+ CPU; Gigabyte GA-7VR M/B(W/DDR333 up to 3GB/ATA133) .', 200188458);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Surge protector', 815054512);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.6Ghz (512k cache) 845WN M/B & Fan (478pin)', 708612515);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.0 Ghz skt 370 PPGA (BOX)', 821874383);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313M ATX color Case blue 300W P4 w/ front USB & case fan', 399077464);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Intel Pentium4 1.6ghz & Gigabyte 8ID533 MB w/ 313N Case. W/ Free PS2 Mouse.', 468477800);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 2.2Ghz 478 pin Box cpu + fan', 273451063);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 2.2Ghz 478 pin Box cpu + fan', 936769324);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312A Black ATX case 300W P4/AMD (Front USB Optional.)', 607668294);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312B ATX Case with 250W P4/P3/AMD PS.', 149248623);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'USB Cable 6ft. Long.', 921877972);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '10ft Cat 5 network cable w/RJ45 connectors', 267080645);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 1800+ & Gigabyte GA-7VR MB w/ 313N Case. W/ Free PS2 Mouse.', 527445580);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD Duron 1.3Ghz Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 997569877);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Gigabyte GA-7VAXP AMD Motherboard. VIA KT400 RAID ATA133 with DDR support', 915559018);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.0ghz Gigabyte GA-8LD533 m/b + fan.', 265633696);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.8ghz & Gigabyte GA-8LD533 MB w/ 313N Case. W/ Free PS2 Mouse.', 387092329);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CyberPower Surge Protector 850 with 8 Outlet.', 170305645);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2200+ & Gigabyte 7DXE w/ 313M case . W/ Free PS2 Mouse.', 163103742);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Linksys Wireless PCI card (WMP11)', 524148126);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb SDRam PC133 Kingston', 169659515);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.8Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 254647820);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.0ghz Gigabyte GA-8LD533 m/b + fan.', 858616442);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 2200+ & Gigabyte 7DXE w/ 313M case . W/ Free PS2 Mouse.', 936169503);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel D845PEBT2 M/B onboard Raid and S-ATA .', 100148653);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Gigabyte GA-8ID533 Socket 478 Intel®', 363820511);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1700+ & Gigabyte GA-7VKML MB w/313N case. W/ Free PS2 Mouse.', 471686465);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'LG 48x24x40 and 16x CD-RW/DVD OEM.', 667176850);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Surge protector', 547111578);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'W.D 120G 7200RPM (1200JB) 8MB Cache and 3 year MDW', 871728908);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Seagate 20GB ATA100 5400RPM.', 982076921);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP2200/128M/30G Black Complete System.', 498521987);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2400+ cpu Gigabyte GA-7DXE Motherboard + Fan.', 291379350);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Seagate 40GB 5400RPM ATA100', 849923350);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Seagate 40GB 5400RPM ATA100', 233791357);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 250Watt P4/P3/AMD Ready PS.', 107286193);
commit;
prompt 200 records committed...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'MicroSoft Windows Server 2003 W/ 10 Licenses.', 557714154);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Biostar M7VKQ Pro MB w/ 313M case. W/ PS2 Mouse.', 391598548);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Gigabyte GA-7VKMLE', 759277745);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Keyboard Converter from (old) standard form to (new) PS/2.', 301145806);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-7NNXP MotherBoard w/ Nforce2 400 chipset.', 672677177);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel Celeron 1.2Ghz & Gigabyte GA6VEML MB w/ 312J Color Case. W/ Free PS2 Mouse.', 562560915);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2500+ Barton (OEM). (with 333Mhz Front Side Bus w/ 512k Cache).', 784915922);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Intel Pentium4 2.4ghz & Intel D845PESV MB w/ 313M Case. W/ Free PS2 Mouse.', 337376936);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 1.9ghz & Biostar U8668 MB w/ 313N Case. W/ Free CNR 56k & PS2 Mouse.', 488493128);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Pentiume 4 1.8Ghz/128M/30G Black Complete System.', 233045254);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Biostar Mini BareBone PC > iDEQ 200N.', 572005342);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2100+ w/ Cpu Fan & Biostar M7VKQ +', 297102804);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel Celeron 2.2Ghz 478 pin Box cpu + fan', 478438487);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 3000+ Barton CPU ASUS A7N8X Deluxe NVIDIA Force2 w/ Antec Performance plus II 1040B Case.', 578729163);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'ATI Radion 7000; 64Mb DDR AGP +CRT+DVI+TV', 753413531);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Combo AMD XP 2500+ CPU; Gigabyte GA-7VT600L M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 817026839);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Fast Ethernet 10/100 8 port switching hub', 994000381);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, '313M ATX color Case blue 300W P4 w/ front USB & case fan', 474353737);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD Duron 1.1Ghz (1100 Mhz) OEM', 663196582);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.0ghz & Gigabyte 8IRX MB w/ 313N Case.', 181676281);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo Intel Celeron 1.7Ghz (Box CPU)+ Biostar U8668D m/b (478pin)CPU & Fan Support .', 479537259);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 699262710);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-8IE800 Intel®845E Chipset.', 729277013);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel D845PEBT2 P4 M/B DDR-333 & 533MHz FSB.', 300117638);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD Duron 1.2Ghz Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 995849472);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ASUS P4SDX SiS655 Chipset Dual Channel DDR333.', 185360775);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'LG Goldstar 16X DVD with audio cable OEM', 877677760);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.3GHz 256k S370 FCPGA2 (Retail Box)', 795466385);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-8IRXP ATA133 + onboard Raid + USB2.0 + Lan', 549920959);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'ATI Radeon 7000 32MB DDR PCI CRT+DVI+TV.', 847523648);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi 48x 12 x 40 CD-RW', 891087041);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-7VKMLE', 527686504);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.7ghz & Biostar U8668D. W/ Free CNR 56k & PS2 Mouse.', 931697691);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.7Ghz 478 pin Box cpu + fan', 458125190);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312J ATX Case with 400W P4/P3/AMD PS', 981543943);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Combo Intel P4 2.4Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 263763052);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.7ghz (box)478pin +Gigabyte GA8IRX M/b +fan', 737512334);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Combo Intel Celeron 1.8ghz Gigabyte GA-8LD533 m/b + fan.', 497672990);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 878995495);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CyberPower Surge Protector 850 with 8 Outlet.', 745767641);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Combo AMD XP 1900+ cpu Gigabyte GA-7ZXE Motherboard + Fan', 971185840);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Logitech Cordless Elite Duo Optical Kit(KB/MS)', 677269787);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.8ghz Gigabyte GA-8LS533 m/b + fan.', 240921696);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '3Com 905cx-txm NIC (Network Interface Card)', 428745222);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '1.7Ghz Intel Celeron(box)478pin+ Biostar M7SXF M/b +fan', 693685227);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '319A ATX case 400W P4/AMD Free Fan and 2 Front USB.', 901502896);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CP-691 Stereo Speakers', 523949424);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AOC LM520 Flat Screen (LCD) 15" Monitor', 438150346);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '2 Year Warranty On Combo''s.', 720258585);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.1Ghz & Gigabyte GA6VEML MB w/ 312D Color Case. W/ Free PS2 Mouse.', 162741206);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 2.4ghz', 208673611);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Windows XP Pro Registered OEM', 670693235);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'KIT with Mistumi Internet Keyboard & Optical Mouse & 54X CDrom to match Black case .', 433173537);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Creative Inspire 5200 5.1 surround sound.', 389621535);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '6066-C10 Black Computer case w/Window panel', 861070252);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ASUS A7N8X Deluxe NVIDIA Force2 .', 120818128);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 300Watt P4/P3/AMD Support PowerSupply.', 725424742);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.1Ghz CPU Box (256K cache)PPGA2', 619767996);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256MB DDR 400 (PC3200) Kingston(KVR400X64C3/256)', 506163412);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 1800+ & Gigabyte GA-7VR MB w/ 313N Case. W/ Free PS2 Mouse.', 588368340);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Biostar U8668D P4 uATX M/B (VIA P4M266 478pin) with AMR ;Support DDR and 533MhZ FSB; onboard Sound &', 620372277);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Biostar M7VIG-Pro MB w/ 313M case. Free PS2 Mouse.', 444894245);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.4ghz CPU + Fan(BOx) w/ Gigabyte GA-8IE800 Intel®845E Chipset.', 952669174);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'KIT with Mistumi Internet Keyboard & Optical Mouse & 54X CDrom to match Black case .', 284087405);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radeon 7000 32MB DDR PCI CRT+DVI+TV.', 897443171);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Benwin S54 Surround Sound Speakers.', 496967655);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Gigabyte GA-7DXE MB w/ 313M Case W/ Free PS2 Mouse.', 885568274);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb DDRam PC2100 Kingston', 165069233);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ & Biostar M7VKQ Pro MB w/ 313M Case. W/ PS2 Mouse.', 518817006);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.7Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 438885298);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb SDRam PC133 Kingston', 226986610);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 505151181);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi Win 2000 Internet Keyboard', 856694332);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1900+ cpu Gigabyte GA-7VKMLS m/b fan.', 441752575);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 1900+ & Gigabyte GA-7ZXE MB w/ 313M Case', 839691671);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'xAMD XP 1600+ Biostar M7VIB M/B + Cooler master fan', 654360049);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Mitsumi optical mouse.', 440396543);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master DP5-6J31C AMD Approved HeatSync.', 227135671);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256Mb DDRam PC2100 Kingston', 240089876);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '313M ATX color Case blue 300W P4 w/ front USB & case fan', 565182304);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P3 1.13 GMhz FC-PGA 256KB PC133 OEM', 166897367);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '1.7Ghz Intel Celeron(box)478pin+ Biostar M7SXF M/b +fan', 171853644);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D845PEBT2 M/B onboard Raid and S-ATA .', 299747885);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7VIK SKT A AMD® DDR400 AGP 8x ;onboard Raid & Sound & 1394 .', 889445318);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2100+ CPU ASUS A7N8X Deluxe NVIDIA Force2', 498768696);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Microsoft Windows XP Home Full Registered.', 197218839);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi DW-7801TE DVD Duplicator/Burner.', 841499510);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ANTEC Performance PLUS Model PLUS1080 w/ Antec Original TRUE 430W P4 Power Supply.', 871722354);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 3.0ghz CPU + Fan(BOx) FSB800 with Hyper Threading w/ Gigabyte 8IPE1000 Pro MotherBoar', 958863687);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GA-7N400L nForce 2 Ultra400 chipset.', 396469378);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AOC 15" Monitor .27mm Pitch', 938406845);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 401709948);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '6066-C10 Black Computer case w/Window panel', 996862753);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Promise Fast Track ATA 100 RAID Controller Kit.', 514339325);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1700+ & Gigabyte GA-7ZXE MB w/ 313N Case. W/ Free PS2 Mouse.', 683617507);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CNet External 56k V.92 Fax modem (Serial).', 952352618);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Cooler Master ATA133 Rounded IDE Cable . PTC-A18', 258945756);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Microsoft Office 2000 Small Biz edition', 463520539);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Dynatron CPU Cooler DF1206BH AMD Athlon\Duron Fan. (AMD Recommend)', 170846994);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7SXF P4 478pin M/B Intel P4 1;8ghz CPU + Fan(BOx)Support DDR DIMM', 124420100);
commit;
prompt 300 records committed...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radion 7000; 64Mb DDR AGP +CRT+DVI+TV', 922336964);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Intel P4 2.4 Ghz CPU BOX (800Mhz)', 513923427);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 708135979);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Combo AMD XP 2100+ (Box CPU); Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 410929065);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.1Ghz (Box)Tulatin core Biostar M6VLR m/b (Free AMR Modem.)', 774685658);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'CyberPower 525VA(525SL)', 377729240);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master Copper HEAT PIPE Cooler. HHC-001', 487861711);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M6VCG skt 370 m/b (30 day D.O.A Warranty)', 713320698);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Combo AMD XP 2100+ (Box CPU)Gigabyte GA-7VKML M/B + Fan', 538534007);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Audio Cable.', 407933782);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Logitech Quick Cam W/Free Headset', 494960174);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2600+ Retail box. (with 333Mhz Front Side Bus)', 696812757);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Combo Intel P4 1.8Ghz (Box CPU)+ Biostar U8668D m/b (478pin)CPU & Fan Support SD.', 723305141);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Biostar M7VKQ Pro MB w/ 313M case. W/ PS2 Mouse.', 593999831);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb RDRam 800Mhz Kingston', 156162327);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 400Watt P4/P3/AMD Support PS.', 266606670);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 1;8Ghz (478)pin 512K 3 Year MFG warr.', 565469376);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2600+ CPU; Gigabyte GA-7VR M/B(W/DDR333 up to 3GB/ATA133) .', 602119198);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CyberPower 1500VA UPS Upto 135 minutes', 682245522);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'AMD Server Solution YS XP2000+ 266 FSB Raid Server', 483122626);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Intel Pentium4 2.0ghz & Gigabyte 8ID533 MB w/ 313N Case. W/ Free PS2 Mouse.', 926537995);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Flat Panel Speakers Boka-206', 245705265);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD MP 1500+ Gigabyte GA-7DPXDW Dual CPU M/B +Fan (one cpu only)', 873353399);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Boka 1050 Sub Woofer and Speakers', 838763998);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1700+ & Biostar M7VKQ w/ 313N case . W/ Free AMR 56k & PS2 Mouse.', 183828210);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Mircosoft Ergonomic Keyboard and Mouse Set.', 689614398);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Surge protector', 359211432);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2200+ & Biostar M7VIK KT400 MB w/ 313M case. Free PS2 Mouse.', 872402104);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Mitsumi 52x 40 x 48 CD-RW', 742292557);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.8ghz CPU + Fan(BOx) w/ Intel D845PESV P4 M/B Socket 478.', 386637107);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D 850MV P4 M/B RDRam support', 240771738);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512MB DDR PC3200 Kingston Hyper X (KHX3200/512 )', 388509855);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'ATX 300W High Quality Switching Power Supply', 339607802);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ADS External USB 2.0 Drive Kit', 216264525);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '14"/15" Filter Screen', 880283169);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Flat Panel Speakers Boka-206', 953132895);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD Duron 1.3MHz & Biostar M7VIG-Pro MB w/ 312D case. Free PS2 Mouse.', 940067704);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'KDS 15" Flat Screen LCD monitor (black).', 732364554);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '17" Filter Screen', 108400326);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master Copper HEAT PIPE Cooler. HHC-001', 216090090);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'BIOSTAR M6TSL skt370 m/b (30 day D.O.A Warranty)', 282560191);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2000+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 396481548);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Epson Stylus C42UX - C11C482001.', 474646280);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ Biostar M7VIG Pro m/b + Cooler Master fan', 680526159);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, '512Mb DDRam PC2100 (one piece) Micron', 734673425);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Seagate 40GB 5400RPM ATA100', 517114536);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'LG 48x24x40 and 16x CD-RW/DVD OEM.', 360999355);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-8IRXP ATA133 + onboard Raid + USB2.0 + Lan', 399864090);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Gigabyte GA-8IRXP ATA133 + onboard Raid + USB2.0 + Lan', 525588342);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '3Com 905cx-txm NIC (Network Interface Card)', 399360066);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 3000+ Barton Box. (with 333Mhz Front Side Bus w/ 512k Cache).', 118236069);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb SDRam PC133', 901702266);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Serial ATA Power Connector for the Hard Drive.', 492052662);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'AMD XP 1700+ & Gigabyte GA-7VKMLS MB w/ 313N Color Case. W/ Free PS2 Mouse.', 326694357);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512MB DDR PC2700 Kingston(KVR333X64C25/512)', 551407504);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, '312D ATX color case(translucent blue) with 400Watt P4/P3/AMD Support PS.', 226292015);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.7Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 215499619);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2400+ CPU; Gigabyte GA-7VR M/B(W/DDR333 up to 3GB/ATA133) .', 191356229);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Intel Celeron 1.2Ghz & Biostar M6VLR MB w/ 312J Color Case. W/ Free AMR 56k & PS2 Mouse.', 511064174);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel D 850MV P4 M/B RDRam support', 866234023);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel D845PESV P4 M/B DDR-333 support.', 878361050);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Sony 16X DVD-CDRom (OEM)', 238831365);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.0ghz Gigabyte GA-8LD533 m/b + fan.', 107444785);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 2000+ Box/with AMD Fan', 973970811);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ Gigabyte GA-7VKML M/B + Fan', 157482297);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'YS Intel P4 2.0Ghz Server Solution', 167172437);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312B ATX Case with 300W P4/P3/AMD PS. USB Ready.', 792482323);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'PowerColor 128MB USB Portable MP3 Player.', 906671114);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-8SG800 Mother Board W/ SiS 648 chipset.', 194549335);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Black Sony CD-RW 52x24x52x .', 925270311);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312D ATX color case(translucent blue) with 300Watt P4/P3/AMD Support PowerSupply.', 879861476);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 3.0ghz & Asus P4C800 MB w/ Antec Performance Plus II 1040B Case.', 968243817);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'AMD XP 2100+ Box w/Fan', 355146666);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD Duron 1.2Ghz cpu Gigabyte GA-7VKMLS m/b fan.', 848489360);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.4Ghz retail CPU + Gigabyte GA-8ID533 M/B + Fan.', 907424842);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radion 7000 64Mb SD CRT+TV-Out', 661216534);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'SIS Xabre200 64MB DDR AGP 8X DVI+TV+CRT by Power Color', 120974857);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 386354445);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 1800+ (oem)', 638472575);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Biostar Mini BareBone PC > iDEQ 200N.', 725612282);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA 7DPXDW-c Dual AMD server board', 108592361);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Intel P4 1;6Ghz Bare Bone CPU & Fan;', 642289450);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Linksys USB Wireless (WUSB11)', 445960804);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Black RF Wireless Keyboard Track Ball .', 721527128);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.8ghz & Biostar U8668D. W/ Free CNR 56k & PS2 Mouse.', 874834733);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb DDR 333 PC2700 (samsung)', 103639039);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, '312B ATX Case (No Power Supply)', 251122348);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ASUS A7N8X Deluxe NVIDIA Force2 .', 967138840);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AOC 17" Monitor 7FSLK .25mm Dot Pitch TureFlat', 485862308);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Wireless Access Point Router with 4-Port Switch - Version 3.2 (BEFW11S4)', 796357825);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2700+ Retail box. (with 333Mhz Front Side Bus)', 480996732);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1700+ Gigabyte GA-7VKML M/B + Fan', 976175712);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Fast Ethernet 10/100 8 port switching hub', 418941549);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2000+ Gigabyte GA-7VKML MB', 244957874);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512Mb SDRam PC133 Kingston', 154242474);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Antec Plus 660 ATX Mid tower 330w Power Supply', 487796197);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & Gigabyte GA-8IE800 MB w/ 313N Case. W/ Free PS2 Mouse.', 826802360);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'MITSUMI 54X CD-Rom Black.', 543857648);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo Intel Celeron 1.8ghz Gigabyte GA-8LD533 m/b + fan.', 428983287);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP2400/128M/30G Black Complete System.', 449337529);
commit;
prompt 400 records committed...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 2000+ & Gigabyte GA-7VKMLE MB w/ 313M Color Case. W/ Free PS2 Mouse.', 357643935);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 698624693);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1900+ & Gigabyte GA-7VKMLS MB w/ 313M Color Case.', 366632145);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Gigabyte GA-7DXE MB w/ 313M Case W/ Free PS2 Mouse.', 411001240);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Sony 48x24x40 and 16x CD-RW/DVD OEM.', 446811236);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar Mini BareBone PC > iDEQ 200S.', 805558047);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 487397320);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '17" Filter Screen', 462552035);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Biostar M7VKD AMD 1Ghz Duron + Cooler Master Fan', 387289289);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Gigabyte GA-7VKMLE MB w/ 313M Color Case. W/ Free PS2 Mouse.', 945448417);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Intel Pentium4 2.0ghz & Gigabyte 8IRXP MB w/ 313N Case. W/ Free PS2 Mouse.', 481552416);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312J ATX Case with 400W P4/P3/AMD PS', 527280153);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512MB DDR400 PC3200 Kingston(KVR400X64C25/512 )', 506994358);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GA-8LD533 Intel®845GL Chipset VC/SC/Lan.', 873783034);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 2.4 Ghz CPU BOX (533Mhz)', 129195321);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Boka 1050 Sub Woofer and Speakers', 602026165);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313M ATX color Case blue 300W P4 w/ front USB & case fan', 601701489);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256Mb DDRam PC2100 Kingston', 706326162);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMDXP1800/128M/30G Black Complete System.', 437929378);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'ATI Radeon 7000 VIVO 64mb DDR AGP .', 418481619);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 628747616);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M7VKQ Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 262643480);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '14inch LCD MG-015A Xgen2 Monitor.', 860551807);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'KIT Keyboard Mouse and Speakers to match color case', 639121639);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 1.8 Ghz CPU BOX (533Mhz)', 547461534);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '8 inch Neon blue lamp', 315456383);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD Duron 1.2MHz & Biostar M7VIG-Pro MB w/ 312J case. Free PS2 Mouse.', 957537094);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Sony 16X DVD-CDRom (OEM)', 776623460);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 1.6ghz & Gigabyte 8ID533 MB w/ 313N Case. W/ Free PS2 Mouse.', 305478453);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ & Gigabyte GA-7VKMLE MB w/ 313M Color Case. W/ Free PS2 Mouse.', 443991351);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'HP 1300 Laser Jet New.', 205397955);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '1.7Ghz Intel Celeron(box)478pin+ Biostar M7SXF M/b +fan', 558169743);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & Gigabyte GA-8IE800 MB w/ 313N Case. W/ Free PS2 Mouse.', 215074393);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Black Mitsumi CD-RW 52x24x52x.', 380007079);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'GA-8LD533 Intel®845GL Chipset VC/SC/Lan.', 777063364);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'AMD XP 2600+ FBS 333 & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 382678745);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1900+ & Gigabyte GA-7ZXE MB w/ 313M Case', 249640786);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CyberPower 1500VA UPS Upto 135 minutes', 894501335);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Assembly & Testing of the CPU/Fan; Motherboard; Case; and Other Products.', 912774864);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Intel Pentium4 3.0ghz & Asus P4C800 MB w/ Antec Performance Plus II 1040B Case.', 488283015);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2000+ Box/with AMD Fan', 779283595);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D875PBZ M/B onboard S-ATA 150 + Intel Pentium 4 2.4Ghz; 800MHz FSB; Fan; Retail Box CPU/MB.', 816505821);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Fast Ethernet 10/100 8 port switching hub', 351074926);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2700+ CPU ASUS A7N8X Deluxe NVIDIA Force2', 190360834);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 143766014);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Antec PlusView1000AMG Metallic Gray SOHO File Server without PowerSupply.', 490041641);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 1900+ & Gigabyte GA-7VKML MB w/ 313M case', 816505320);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cyber Power 325SL Battery Back Up', 584847554);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI RADEON 9200™ SE 128M DDR DVI+TV-Out 8X AGP (R92LE-C3S).', 779757808);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ADS Firewire Web Cam (20X faster than USB)', 306244196);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2000+ Gigabyte GA-7VKML MB', 895943487);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512MB DDR400 PC3200 Kingston(KVR400X64C25/512 )', 919043255);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M6TWL skt 370 Motherboard. (D.O.A 30 days)', 110437201);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2500+ Barton (OEM). (with 333Mhz Front Side Bus w/ 512k Cache).', 885809424);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2100+ w/ Cpu Fan & Biostar M7VKQ +', 105490171);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2100+ (Box) & Gigabyte GA-7VKML MB w/ 313M Case. W/ Free PS2 Mouse.', 747163297);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, '512MB DDR400 PC3200 Kingston(KVR400X64C25/512 )', 567016150);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2000+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 851431384);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Combo AMD XP 1800+ Gigabyte GA-7VKML M/B + Fan', 259281637);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'ATI Radeon 9600 256MB DVI+CRT+TV 8X .', 274715538);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 329158441);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2200+ & Gigabyte GA-7VKMLE MB w/ 313M Color Case. W/ Free PS2 Mouse.', 560105519);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Combo AMD XP 2000+ CPU; Gigabyte GA-7VT600L M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 789087097);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2700+ & Gigabyte 7N400Pro w/ 313M case . W/ Free PS2 Mouse.', 512652034);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 402230125);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD XP 2400+ FBS 333 & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 634913355);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '128Mb RDRam 800Mhz Kingston', 433116488);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GA-7N400L nForce 2 Ultra400 chipset.', 644116143);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mitsumi PS/2 Net scroll 5 button mouse', 878452649);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD XP 2000+ Box/with AMD Fan', 616311456);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & GigaByte 8IPE1000 Pro MB w/ Antec Performance Plus II 1040B Case.', 925234625);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cyber Power 1000VA Back Up W/Automatic Voltage Regulator', 785202161);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'Maxtor 40Gb ATA100 5400rpm H/D', 140359430);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD Duron 1.3 Ghz (Oem)', 271296079);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256MB DDR 400 (PC3200) Kingston(KVR400X64C3/256)', 557466349);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2400+ Retail box.', 917191761);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313K 300W P4/AMD and 2 Front USB.', 326809666);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD Duron 1.2Ghz Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 283264539);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256Mb PC133 SDRam Micron 168 PIN SDRAM - Lifetime Warranty! We offer a 100% Compatibility Guarantee.', 879054575);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.6Ghz (512k cache) 845WN M/B & Fan (478pin)', 739747358);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Case Fan 3 1/2"(80mm) 12V', 746398682);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.2Ghz Biostar M6VLR m/b fan (Free AMR Modem.)', 962501060);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ CPU; Gigabyte GA-7VA M/B.', 635968955);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.6Ghz (512k cache) 845WN M/B & Fan (478pin)', 177060427);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Logitech Cordless Optical Mouse.', 408789796);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'CyberDrive 40X16X48X CD-R/RW Drive.', 816251377);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD Duron 1.2Ghz OEM', 346637647);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.8ghz Gigabyte GA-8LD533 m/b + fan.', 176236963);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2200+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 204794274);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2100+ CPU; Gigabyte GA-7VA M/B.', 685512872);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Boka 1050 Sub Woofer and Speakers', 533177138);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '313D Black 400W P4/AMD 2xUSB', 566408163);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Intel Celeron 1.7Ghz 478 pin Box cpu + fan', 730570311);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Testing of CPU/Fan and Motherboard.', 951821196);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD XP 1800+ & Gigabyte GA-7VKML MB w/ 313M case W/ Free PS2 Mouse.', 226019979);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'AMD XP 2100+ CPU (oem)(AXDA2100DUT3C; RevisionB).', 617533806);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Combo Intel P4 1.8ghz CPU + Fan(BOx) w/ Gigabyte GA-8IE800 Intel®845E Chipset.', 221497111);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.7ghz Gigabyte GA-8LD533 m/b onboard sound;video ;10/100 Lan USB2.0 + fan.', 737627430);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 2.4 Ghz CPU BOX (533Mhz)', 357723571);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2000+ cpu Gigabyte GA-7VKMLS m/b fan.', 829260788);
commit;
prompt 500 records committed...
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'Biostar M7VIK SKT A AMD® DDR400 AGP 8x ;onboard Raid & Sound & 1394 .', 738309645);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'AMD XP 2000+ & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 731977144);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GigaByte G-Max Intel P4 Flex ATX Platform .', 490850485);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Microsoft Windows XP Home Full Registered.', 487955324);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ASUS P4C800 Deluxe Skt 478 Intel 875P (800MHZ FSB).', 148198111);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Windows 2000 w/Service Pack 3(NEW) OEM Full Version LICENCED', 482685638);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Combo Intel Celeron 1.7ghz Gigabyte GA-8LD533 m/b onboard sound;video ;10/100 Lan USB2.0 + fan.', 482986698);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Pentium4 2.4ghz & Intel D845PESV MB w/ 313M Case. W/ Free PS2 Mouse.', 339493176);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1700+ Gigabyte GA-7VKML M/B + Fan', 966881718);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar M6VLR skt 370 Motherboard', 541784559);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'LG 48x24x40 and 16x CD-RW/DVD OEM.', 609774041);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD Duron 1.3MHz & Biostar M7VIG-Pro MB w/ 312D case. Free PS2 Mouse.', 451356256);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 2100+ Box w/Fan', 995631486);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'LABTEC Internet Keyboard (Spanish Edition).', 876541800);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 2.4 Ghz CPU BOX (800Mhz)', 614694861);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'xAMD XP 1600+ Biostar M7VIB M/B + Cooler master fan', 369293915);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Biostar U8668D P4 uATX M/B (VIA P4M266 478pin) with AMR ;Support DDR and 533MhZ FSB; onboard Sound &', 467965675);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Seagate 40GB 5400RPM ATA100', 570993504);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '10ft Cat 5 network cable w/RJ45 connectors', 832343421);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel Celeron 1.8ghz Gigabyte GA-8LD533 m/b + fan.', 764463799);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'USB to Parallel Printer Cable.', 542084528);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '313K 300W P4/AMD and Free Case Fan and 2 Front USB.', 744764697);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Seagate 40GB 5400RPM ATA100', 317144977);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Combo Intel P4 1.8Ghz retail CPU + Gigabyte GA-8IE533 M/B + Fan.', 157540214);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'GA-SINXP1394(GA-8SQ800 Ultra2) (SiS 655 Chipset) w/ Pentium 4 2.4 Ghz (Box CPU)', 286942816);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Mircosoft Ergonomic Keyboard and Mouse Set.', 749018448);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256Mb PC133 SDRam Micron 168 PIN SDRAM - Lifetime Warranty! We offer a 100% Compatibility Guarantee.', 173398008);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel P4 1;6Ghz Bare Bone', 131145243);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.1Ghz CPU Box (256K cache)PPGA2', 874114945);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD 1.1Ghz Starter Series / Work Station.', 974400788);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 169524150);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, '313D Black Case 300W P4/AMD', 785952021);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cyber Power 325SL Battery Back Up', 297288231);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Antec PFII Series 1040BII 400W PSU.', 157623754);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Intel Pentium4 1.8ghz & Biostar U8668 MB w/ 313N Case. W/ Free CNR 56k & PS2 Mouse.', 492827855);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (35, 'KIT Keyboard Mouse and Speakers to match color case', 576647580);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD XP 1900+ & Gigabyte GA-7VKMLS MB w/ 313M Color Case.', 139741096);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Cable/DSL Broadband Router (w/ 4-port Switch) (EE400-R).', 370571857);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'xAMD XP 1600+ Biostar M7VIB M/B + Cooler master fan', 458408009);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Windows 2000 w/Service Pack 3(NEW) OEM Full Version LICENCED', 410848744);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.1Ghz CPU Box (256K cache)PPGA2', 937043198);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Seagate Baraccuda 40Gb 7200rpm', 251279284);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '512mb DDR ECC Registerd. For Dual Processor Server MotherBoards.', 902058409);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Promise Fast Track ATA 100 RAID Controller Kit.', 720417144);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Biostar M7VKD AMD 1Ghz Duron + Cooler Master Fan', 846842975);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Keyboard Converter from (old) standard form to (new) PS/2.', 876495432);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Audio Cable.', 374356341);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 294004123);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Cooler Master Round Floppy Cable. PTC-F18', 712214343);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radeon 9600 256MB DVI+CRT+TV 8X .', 492313313);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.7Ghz/128M/30G Black Complete System.', 388799844);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '312J ATX Case with 400W P4/P3/AMD PS', 742378510);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (15, 'USB to Parallel Printer Cable.', 529485293);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.8ghz & Gigabyte GA-8LD533 MB w/ 313N Case. W/ Free PS2 Mouse.', 751450151);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'AMD Duron 1.3Ghz & Gigabyte GA-7VKMLE MB w/ 312D Color Case. W/ Free PS2 Mouse.', 717787972);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ADS Firewire Web Cam (20X faster than USB)', 234814837);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Intel P4 2.4 Ghz CPU BOX (533Mhz)', 496971214);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'Creative Inspire 5200 5.1 surround sound.', 279868753);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '5ft Cat5 network cable w/RJ45 connectors', 454248607);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1700+ & Gigabyte GA-7VKMLS MB w/ 313N Color Case. W/ Free PS2 Mouse.', 615422014);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '219L ATX color Case teal 400W ScrewLess mid tower w/case Fan', 471939757);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ & Biostar M7VIG-Pro MB w/ 313M case. Free PS2 Mouse.', 213253770);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'Creative Inspire 2.1 2500 surround sound', 696579829);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMDXP2200/128M/30G Black Complete System.', 844165456);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 1.8ghz & Biostar U8668D. W/ Free CNR 56k & PS2 Mouse.', 914847250);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Logitech Optical Mouse', 598623933);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '256MB DDR PC2700 Kingston', 372489438);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'YS Intel Celeron 1.1GHz Work Station Series', 850393521);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '128Mb RDRam 800Mhz Kingston', 182765780);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GigaByte G-Max AMD Flex ATX Platform .', 444008216);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'CoolerMaster Thermal Compound High Performance. HTK-001', 526438708);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Dynatron MicroFin DC1206BM-l AMD Athlon/Duron Fan w/ Copper Base up to AMD XP (AMD APPROVED!) 3000+.', 324906557);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (25, 'KIT with Mistumi Internet Keyboard & Optical Mouse & 54X CDrom to match Black case .', 742612917);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.6Ghz (512k cache) 845WN M/B & Fan (478pin)', 222417749);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel Celeron 2.0Ghz 478 pin Box cpu + fan', 901120266);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 2100+ (Box CPU)Gigabyte GA-7VKML M/B + Fan', 193082739);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'GA-7VT600-L VIA KT600 chipset.', 466010638);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D875PBZ M/B onboard S-ATA 150 + Intel Pentium 4 2.4Ghz; 800MHz FSB; Fan; Retail Box CPU/MB.', 826640267);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radeon 7000 32MB DDR PCI CRT+DVI+TV.', 648581103);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Windows XP Pro Registered OEM', 682304864);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Fast Ethernet 10/100 8 port switching hub', 685494264);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo AMD XP 1800+ Biostar M7VIG-Pro Skt A MotherBoard w/ OnBoard Video/sound/Lan.', 126517000);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ATI Radeon 9800 Pro 128MB Gold Edition.', 962866648);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '2 Year Warranty On BareBones.', 998764869);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, '313K 300W P4/AMD and Free Case Fan and 2 Front USB.', 815488313);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'ADS Technologies Firewire External Drive.', 388592218);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 1.9Ghz (Box CPU)+ Biostar U8668 m/b (478pin)CPU & Fan Support SD.', 204329406);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.4ghz CPU + Fan(BOx) w/ Intel D845PESV P4 M/B Socket 478.', 860545515);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.0Ghz retail CPU + Gigabyte GA-8IE533 M/B + Fan.', 158783600);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Maxtor 40Gb ATA100 5400rpm H/D', 140417983);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AMD XP 1800+ & Biostar M7VIG-Pro MB w/ 313M case. Free PS2 Mouse.', 738218439);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (10, 'AMD XP 1800+ Box CPU and Fan', 466239135);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (20, 'Black Complete Computer System w/ Mouse KeyBoard and Speakers(Free AMR Moden). (Duron 1.3)', 282259005);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Intel D845WN 478Pin SDRAM retail Box', 267248998);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, '8 inch Neon blue lamp', 960965084);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (30, 'AMD XP 1700+ & Gigabyte GA-7DXE MB w/ 313N Case. W/ Free PS2 Mouse.', 619980182);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA 7DPXDW-c Dual AMD server board', 276224889);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Combo Intel P4 2.4ghz CPU + Fan(BOx) w/ Intel D845PESV P4 M/B Socket 478.', 598227354);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'Gigabyte GA-7NNXP MotherBoard w/ Nforce2 400 chipset.', 349109407);
insert into SERVICEGIVER (sg_price, sg_details, sgm_id)
values (null, 'AOC 15" Monitor .27mm Pitch', 358460781);
commit;
prompt 600 records loaded
prompt Loading BABYSITTING...
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 2, 8, 856694332);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 3, 2, 917191761);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 8, 1, 849923350);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 3, 4, 190360834);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 4, 9, 776623460);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 5, 6, 438885298);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 2, 10, 566408163);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 9, 5, 551526087);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 9, 6, 595247363);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 2, 6, 250253966);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 3, 5, 506994358);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 9, 2, 762821548);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 8, 9, 672677177);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 9, 5, 433116488);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 3, 7, 721527128);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 3, 5, 425485955);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 10, 9, 315456383);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 0, 2, 467965675);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 4, 7, 940067704);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 9, 4, 936169503);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 2, 7, 913264381);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 1, 1, 547461534);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 2, 2, 994000381);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 7, 8, 873783034);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 5, 3, 233045254);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 0, 10, 738309645);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 10, 6, 388592218);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 1, 4, 466988754);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 3, 1, 259281637);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 4, 7, 445960804);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 0, 6, 699262710);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 1, 5, 996862753);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 7, 2, 498768696);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 4, 6, 768584445);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 2, 10, 343057735);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 3, 5, 602026165);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 9, 4, 731977144);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 10, 8, 471939757);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 6, 6, 355146666);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 1, 7, 742612917);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 9, 5, 816391512);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 5, 7, 694803403);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 10, 5, 276868998);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 4, 6, 960965084);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 1, 8, 901502896);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 3, 5, 165069233);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 7, 5, 878995495);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 2, 9, 388509855);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 10, 5, 880283169);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 6, 6, 100148653);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 2, 10, 238002042);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 2, 5, 513923427);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 6, 10, 349109407);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 2, 9, 995849472);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 9, 3, 926537995);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 7, 2, 785202161);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 10, 6, 163103742);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 6, 2, 448882818);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 5, 5, 706326162);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 6, 8, 468127207);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 0, 5, 164877394);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 3, 3, 301145806);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 9, 7, 878452649);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 5, 7, 953132895);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 0, 4, 251279284);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 1, 4, 576647580);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 9, 5, 462028344);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 9, 6, 266606670);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 6, 10, 509387616);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 3, 10, 854805518);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 1, 9, 638472575);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 4, 9, 687464649);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 4, 8, 170305645);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 0, 9, 466010638);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 3, 1, 343015765);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 5, 5, 511064174);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 3, 7, 506915991);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 7, 7, 729277013);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 4, 10, 846842975);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 1, 8, 683617507);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 0, 3, 162741206);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 1, 10, 439190057);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 8, 3, 541784559);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 5, 6, 2, 732364554);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 6, 2, 877677760);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 4, 1, 619767996);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 5, 9, 454248607);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 3, 4, 129195321);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 10, 7, 792482323);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 7, 7, 189535699);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 9, 1, 480996732);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 8, 6, 753413531);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 9, 2, 595271596);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 9, 2, 634913355);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 2, 3, 617533806);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 8, 9, 478765875);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 10, 3, 971185840);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 7, 5, 391598548);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 8, 9, 487955324);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 0, 1, 297102804);
commit;
prompt 100 records committed...
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 3, 10, 628747616);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 4, 1, 951821196);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 9, 2, 357723571);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 4, 2, 441696270);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 4, 2, 738218439);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 2, 1, 262643480);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 8, 4, 851431384);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 2, 9, 473903044);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 0, 10, 517114536);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 1, 1, 399360066);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 9, 6, 350723928);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 8, 2, 154242474);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 3, 10, 638404454);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 2, 9, 514339325);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 9, 5, 358460781);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 2, 1, 380007079);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 8, 6, 490041641);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 4, 3, 216090090);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 9, 3, 418481619);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 5, 2, 131145243);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 10, 9, 977848457);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 3, 4, 918190109);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 5, 10, 7, 837052178);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 1, 7, 945019903);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 3, 4, 614694861);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 0, 1, 157540214);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 8, 3, 466239135);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 6, 1, 914847250);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 9, 8, 226019979);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 4, 5, 731631935);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 7, 6, 992615606);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 0, 7, 240089876);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 5, 3, 840341264);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 6, 9, 841499510);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 4, 4, 518817006);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 0, 1, 463520539);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 2, 9, 185101463);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 2, 6, 860545515);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 0, 5, 474353737);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 10, 5, 169524150);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 10, 5, 696579829);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 5, 8, 901702266);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 9, 5, 506163412);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 6, 6, 386637107);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 10, 8, 324906557);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 3, 4, 889445318);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 6, 10, 488493128);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 8, 6, 725424742);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 5, 1, 998764869);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 6, 4, 208673611);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 8, 10, 547111578);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 0, 6, 124420100);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 0, 2, 713320698);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 0, 2, 158783600);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 9, 2, 527445580);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 0, 2, 496971214);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 2, 1, 897443171);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 7, 2, 148198111);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 1, 5, 226292015);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 9, 5, 952352618);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 7, 1, 317144977);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 10, 4, 441225071);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 3, 5, 523949424);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 9, 2, 667916897);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 2, 10, 784915922);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 2, 1, 411001240);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 8, 6, 496859662);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 7, 9, 166897367);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 6, 4, 750212736);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 2, 7, 274715538);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 9, 7, 937043198);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 5, 7, 854958507);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 9, 2, 204329406);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 1, 2, 816505821);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 8, 5, 505151181);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 9, 1, 274807987);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 3, 2, 876495432);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 8, 6, 601701489);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 7, 3, 107286193);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 5, 9, 911869430);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 7, 3, 997569877);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 1, 9, 957537094);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 10, 1, 888269770);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 3, 8, 817026839);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 2, 6, 369293915);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 3, 2, 282560191);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 9, 4, 222417749);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 3, 5, 257691173);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 8, 3, 874216918);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 0, 3, 723305141);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 6, 1, 687537052);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 10, 1, 135014039);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 7, 9, 213253770);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 9, 2, 753024805);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 1, 10, 326694357);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 1, 10, 931697691);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 6, 9, 777063364);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 5, 2, 958863687);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 8, 5, 670693235);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 10, 7, 245705265);
commit;
prompt 200 records committed...
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 1, 1, 478438487);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 1, 2, 753638601);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 2, 6, 346637647);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 9, 4, 240771738);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 5, 5, 861070252);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 8, 4, 372489438);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 5, 3, 816505320);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 8, 3, 962096973);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 4, 7, 708612515);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 7, 1, 3, 175441465);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 4, 1, 428745222);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 10, 2, 635968955);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 5, 9, 171853644);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 0, 9, 232516560);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 6, 3, 513603889);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 1, 8, 107444785);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 10, 9, 214271290);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 5, 6, 8, 108400326);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 8, 3, 567016150);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 5, 5, 428983287);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 5, 10, 616311456);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 9, 2, 821874383);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 7, 5, 241637541);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 4, 5, 209623814);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 9, 1, 276224889);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 4, 5, 287920615);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 2, 2, 942515529);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 3, 6, 847523648);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 0, 7, 742378510);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 7, 5, 410929065);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 0, 3, 363820511);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 0, 2, 297288231);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 8, 1, 204794274);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 9, 8, 759277745);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 1, 7, 389621535);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 0, 1, 816251377);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 7, 6, 258945756);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 1, 3, 267248998);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 1, 2, 349290214);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 1, 6, 462552035);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 5, 7, 781922286);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 9, 8, 386928076);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 9, 6, 205397955);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 0, 2, 474646280);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 6, 1, 785952021);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 6, 8, 444008216);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 0, 2, 951075931);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 9, 2, 339493176);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 6, 6, 123959939);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 4, 4, 663196582);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 7, 10, 871722354);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 8, 2, 981543943);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 0, 5, 640098230);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 7, 7, 615586328);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 2, 7, 565469376);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 0, 9, 565182304);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 0, 1, 547079702);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 8, 7, 286942816);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 7, 3, 739747358);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 6, 4, 3, 682304864);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 0, 10, 906671114);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 9, 10, 181676281);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 4, 2, 858481074);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 7, 2, 765327686);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 3, 2, 494960174);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 8, 10, 667562726);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 8, 2, 912774864);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 6, 7, 401709948);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 4, 2, 492827855);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 10, 2, 8, 801616613);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 6, 7, 215499619);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 9, 8, 3, 529348579);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 5, 3, 974400788);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 3, 9, 527686504);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 9, 4, 543857648);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 7, 4, 410848744);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 0, 2, 157623754);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 9, 10, 685512872);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 5, 6, 329158441);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 2, 7, 876541800);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 0, 9, 838763998);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 0, 8, 962501060);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 10, 8, 346192718);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 4, 3, 115967722);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 0, 3, 602119198);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 1, 2, 787229074);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 1, 6, 895943487);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 6, 6, 562560915);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 3, 9, 420154025);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 7, 1, 588368340);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 3, 3, 805558047);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 0, 1, 872402104);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 2, 8, 351074926);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 9, 10, 607902262);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 1, 6, 982854200);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 5, 5, 527280153);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 4, 10, 667176850);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 9, 1, 677269787);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 2, 4, 167172437);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 0, 4, 720258585);
commit;
prompt 300 records committed...
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 0, 4, 724109514);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 7, 9, 823928736);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 5, 10, 7, 879861476);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 7, 7, 487861711);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 10, 8, 584847554);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 2, 6, 438150346);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 1, 3, 294004123);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 5, 6, 164659178);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 9, 9, 682573186);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 8, 0, 3, 329865472);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 10, 8, 310735882);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 9, 3, 402230125);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 0, 7, 995631486);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 9, 10, 380288743);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 7, 7, 737627430);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 3, 5, 226986610);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 4, 6, 815054512);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 4, 4, 685494264);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 7, 9, 717787972);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 5, 4, 331919904);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 7, 4, 708135979);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 1, 7, 206312322);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 7, 3, 967138840);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 7, 3, 277855177);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 2, 6, 173927735);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 9, 10, 364362923);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 5, 1, 249640786);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 5, 3, 714440128);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 10, 9, 140417983);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 8, 9, 9, 879622687);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 10, 9, 2, 583838247);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 3, 7, 747163297);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 5, 2, 970123677);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 4, 2, 339607802);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 5, 9, 396469378);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 0, 3, 890819891);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 2, 5, 299747885);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 4, 7, 193082739);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 5, 2, 300117638);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 4, 8, 696812757);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 7, 8, 578729163);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 7, 3, 271296079);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 2, 8, 305478453);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 2, 9, 4, 834129951);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 7, 7, 972229832);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 5, 1, 936769324);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 6, 5, 848489360);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 9, 5, 839691671);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 2, 8, 1, 620372277);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 12, 1, 5, 926497407);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 1, 10, 263763052);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 7, 1, 10, 874114945);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 3, 3, 3, 871846808);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 6, 3, 907424842);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 7, 10, 133984187);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 2, 3, 360000709);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 10, 1, 1, 522099376);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 11, 1, 5, 542084528);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 12, 6, 3, 227135671);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 9, 6, 553517298);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 9, 10, 471686465);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 8, 7, 2, 654360049);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 2, 3, 885568274);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 1, 2, 524148126);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 10, 2, 433173537);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 2, 7, 479537259);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 8, 10, 826802360);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 8, 4, 483122626);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 1, 3, 6, 751450151);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 1, 6, 8, 441752575);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 4, 10, 901120266);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 2, 4, 7, 237075795);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 6, 9, 5, 723299115);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 7, 5, 6, 976175712);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 8, 2, 377585071);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 5, 4, 326809666);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 9, 7, 938406845);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 11, 3, 4, 986676799);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 4, 2, 9, 763635580);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 1, 2, 1, 267080645);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 8, 7, 105836606);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 2, 5, 829260788);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 0, 7, 746398682);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 12, 9, 6, 238831365);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 7, 4, 440671201);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 6, 2, 6, 244957874);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 3, 2, 1, 560105519);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 11, 6, 10, 557714154);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 9, 4, 6, 183639285);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 4, 2, 3, 796357825);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('F', 5, 3, 4, 579785481);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 4, 4, 7, 482986698);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('B', 3, 9, 9, 844165456);
insert into BABYSITTING (b_gender, b_age, b_yearsofexperience, b_maxnumofchildren, sgm_id)
values ('M', 9, 8, 4, 925234625);
commit;
prompt 394 records loaded
prompt Loading CLEANING...
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 369293915);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 514339325);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 291379350);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 746398682);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 478765875);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 238831365);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 420154025);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 620372277);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 237075795);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 277855177);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 742612917);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 245705265);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 583838247);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 699214173);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 615422014);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 249640786);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 998764869);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 377585071);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 553517298);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 951075931);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 672677177);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 926497407);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 849923350);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 667916897);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 388592218);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 826640267);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 108592361);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 471939757);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 784915922);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 251122348);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 670693235);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 878995495);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 558169743);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 694209395);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 443991351);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 283264539);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 851431384);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 918190109);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 124420100);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 925270311);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 175441465);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 635968955);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 642289450);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 448882818);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 765327686);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 874114945);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 339493176);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 725612282);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 879861476);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 712214343);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 895629963);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 178737651);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 126762133);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 482685638);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 601701489);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 163103742);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 185101463);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 907424842);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 848489360);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 708135979);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 817026839);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 584847554);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 559292166);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 823928736);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 901120266);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 938406845);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 140417983);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 433116488);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 408789796);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 454248607);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 463520539);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 693685227);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 317144977);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 529348579);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 116462353);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 233045254);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 494960174);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 131145243);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 262643480);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 346637647);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 696579829);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 440671201);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 105836606);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 193082739);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 479537259);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 399864090);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 895943487);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 742292557);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 206312322);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 166897367);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 274807987);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 787229074);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 698624693);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 190360834);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 200188458);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 363820511);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 889445318);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 917191761);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 226019979);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 777063364);
commit;
prompt 100 records committed...
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 644116143);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 506915991);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 763635580);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 962096973);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 516162245);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 468127207);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 880283169);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 287920615);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 496967655);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 962501060);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 386354445);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 593999831);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 753413531);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 699262710);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 282560191);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 708612515);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 173398008);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 428745222);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 764463799);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 588368340);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 616311456);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 458408009);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 326809666);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 343057735);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 749018448);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 762821548);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 444008216);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 682304864);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 182765780);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 970123677);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 297102804);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 890819891);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 840341264);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 305478453);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 667176850);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 170846994);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 832343421);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 241637541);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 871722354);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 518817006);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 871846808);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 157482297);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 922336964);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 337376936);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 952669174);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 388799844);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 513603889);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 498521987);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 677269787);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 439190057);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 945019903);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 506994358);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 449337529);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 242113481);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 259281637);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 133984187);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 149248623);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 527280153);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 837052178);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 522099376);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 551526087);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 792482323);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 182055053);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 723305141);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 441696270);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 120818128);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 468477800);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 581307727);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 785952021);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 751450151);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 919043255);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 785202161);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 683617507);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 399077464);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 795466385);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 154242474);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 118236069);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 355146666);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 994000381);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 706326162);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 972229832);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 942515529);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 860551807);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 770156282);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 402230125);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 265633696);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 496859662);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 350723928);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 310279833);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 177060427);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 306244196);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 165069233);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 216264525);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 135014039);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 407652575);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 396481548);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 612546655);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 663196582);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 628747616);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 339607802);
commit;
prompt 200 records committed...
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 874834733);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 103639039);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 485506309);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 940067704);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 221497111);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 227135671);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 107286193);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 445960804);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 565469376);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 560105519);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 153649997);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 107444785);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 725424742);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 478438487);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 492827855);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 874216918);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 914847250);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 438150346);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 697015085);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 512652034);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 976175712);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 595271596);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 100148653);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 872402104);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 960965084);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 204329406);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 387289289);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 891087041);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 185794095);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 462028344);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 213253770);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 374356341);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 565182304);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 682245522);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 549920959);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 730570311);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 860545515);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 148198111);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 745767641);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 992615606);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 744764697);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 222417749);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 473903044);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 191356229);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 481552416);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 654360049);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 240921696);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 467965675);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 602026165);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 578729163);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 572005342);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 913264381);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 349290214);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 527445580);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 731631935);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 921877972);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 885809424);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 815488313);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 997569877);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 183828210);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 952352618);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 876495432);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 329158441);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 614694861);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 274715538);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 441752575);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 995631486);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 164659178);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 958863687);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 425485955);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 391598548);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 257691173);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 232516560);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 496971214);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 487397320);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 538534007);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 158783600);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 108400326);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 263763052);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 543857648);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 854958507);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 233791357);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 441225071);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 936169503);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 536750145);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 466239135);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 462552035);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 458125190);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 542084528);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 366632145);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 977848457);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 906671114);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 639121639);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 234814837);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 359211432);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 598858081);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 720417144);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 702330680);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 483122626);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 594728451);
commit;
prompt 300 records committed...
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 687464649);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 687537052);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 732364554);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 962866648);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 492313313);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 721527128);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 387092329);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 759277745);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 214271290);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 876541800);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 123959939);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 602119198);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 204794274);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 146897612);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 598227354);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 490041641);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 925234625);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 105490171);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 779757808);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 931697691);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 816505821);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 385313476);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 170305645);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 850393521);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 912774864);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 466010638);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 169524150);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 487861711);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 343015765);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 801616613);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 451356256);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 682573186);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 389621535);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 672929772);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 738218439);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 714440128);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 509387616);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 834129951);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 511064174);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 386928076);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 829260788);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 887429256);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 164877394);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 167172437);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 839691671);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 738309645);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 847523648);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 437929378);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 143766014);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 346192718);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 877677760);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 861070252);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 471686465);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 579018697);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 815054512);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 648581103);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 171796939);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 937043198);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 244957874);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 157540214);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 380007079);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 966881718);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 731977144);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 996862753);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 737627430);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 209623814);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 176236963);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 315456383);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 747163297);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 567016150);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 523949424);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 789087097);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 844165456);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 171853644);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 871728908);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 634913355);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 488283015);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 572028348);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 742378510);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 254647820);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 816251377);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('ironing', 380288743);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 595247363);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 888269770);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 329865472);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 768584445);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 326694357);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 894501335);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 388509855);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values (null, 936769324);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 838763998);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 576647580);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('laundry', 351074926);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 506163412);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 513923427);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dusting', 480996732);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('windows', 156162327);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('everything', 251279284);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('floors', 854805518);
insert into CLEANING (cl_typeofcleaning, sgm_id)
values ('dishes', 729277013);
commit;
prompt 400 records loaded
prompt Loading COMMUNITY...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (213, 'Neve Dan', 'The Neve Dan community is located in Haifa and has 470 members.', 'Haifa', 470);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (214, 'Orot Naftali', 'The Orot Naftali community is located in Beer Sheva and has 59 members.', 'Beer Sheva', 59);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (215, 'Bnei Gad', 'The Bnei Gad community is located in Eilat and has 414 members.', 'Eilat', 414);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (216, 'Har Asher', 'The Har Asher community is located in Netanya and has 236 members.', 'Netanya', 236);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (217, 'Gan Yosef', 'The Gan Yosef community is located in Ashdod and has 405 members.', 'Ashdod', 405);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (218, 'Beit Binyamin', 'The Beit Binyamin community is located in Rishon LeZion and has 382 members.', 'Rishon LeZion', 382);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (219, 'Ohel Menashe', 'The Ohel Menashe community is located in Petah Tikva and has 136 members.', 'Petah Tikva', 136);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (220, 'Neve Ephraim', 'The Neve Ephraim community is located in Holon and has 349 members.', 'Holon', 349);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (221, 'Orot Sarah', 'The Orot Sarah community is located in Bnei Brak and has 148 members.', 'Bnei Brak', 148);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (222, 'Bnei Rivka', 'The Bnei Rivka community is located in Bat Yam and has 489 members.', 'Bat Yam', 489);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (223, 'Har Rachel', 'The Har Rachel community is located in Ashkelon and has 372 members.', 'Ashkelon', 372);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (224, 'Gan  Lea', 'The Gan  Lea community is located in Rehovot and has 491 members.', 'Rehovot', 491);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (225, 'Beit Dvora', 'The Beit Dvora community is located in Herzliya and has 468 members.', 'Herzliya', 468);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (226, 'Ohel Michal', 'The Ohel Michal community is located in Ramat Gan and has 137 members.', 'Ramat Gan', 137);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (227, 'Neve Tamar', 'The Neve Tamar community is located in Kfar Saba and has 253 members.', 'Kfar Saba', 253);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (228, 'Orot Ester', 'The Orot Ester community is located in Hadera and has 159 members.', 'Hadera', 159);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (229, 'Bnei Rina', 'The Bnei Rina community is located in Raanana and has 467 members.', 'Raanana', 467);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (230, 'Har Tehila ', 'The Har Tehila  community is located in Modiin and has 189 members.', 'Modiin', 189);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (231, 'Gan Shalom', 'The Gan Shalom community is located in Nahariya and has 272 members.', 'Nahariya', 272);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (232, 'Beit Avraham', 'The Beit Avraham community is located in Beit Shemesh and has 154 members.', 'Beit Shemesh', 154);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (233, 'Ohel Yitzhak', 'The Ohel Yitzhak community is located in Tiberias and has 453 members.', 'Tiberias', 453);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (234, 'Neve Yaakov', 'The Neve Yaakov community is located in Kiryat Gat and has 286 members.', 'Kiryat Gat', 286);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (235, 'Orot Moshe', 'The Orot Moshe community is located in Lod and has 40 members.', 'Lod', 40);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (236, 'Bnei Aharon', 'The Bnei Aharon community is located in Maale Adumim and has 45 members.', 'Maale Adumim', 45);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (237, 'Har David', 'The Har David community is located in Afula and has 342 members.', 'Afula', 342);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (238, 'Gan Shlomo', 'The Gan Shlomo community is located in Dimona and has 431 members.', 'Dimona', 431);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (239, 'Beit Eliezer', 'The Beit Eliezer community is located in Kfar Saba and has 19 members.', 'Kfar Saba', 19);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (240, 'Ohel Eliyaho', 'The Ohel Eliyaho community is located in Zichron Yaakov and has 252 members.', 'Zichron Yaakov', 252);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (241, 'Neve Yisrael', 'The Neve Yisrael community is located in Tel Aviv and has 365 members.', 'Tel Aviv', 365);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (242, 'Orot Reuven', 'The Orot Reuven community is located in Jerusalem and has 463 members.', 'Jerusalem', 463);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (243, 'Bnei Shimon', 'The Bnei Shimon community is located in Haifa and has 265 members.', 'Haifa', 265);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (244, 'Har Levi', 'The Har Levi community is located in Beer Sheva and has 373 members.', 'Beer Sheva', 373);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (245, 'Gan Yehoda', 'The Gan Yehoda community is located in Eilat and has 405 members.', 'Eilat', 405);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (246, 'Beit Dan', 'The Beit Dan community is located in Netanya and has 425 members.', 'Netanya', 425);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (247, 'Ohel Naftali', 'The Ohel Naftali community is located in Ashdod and has 36 members.', 'Ashdod', 36);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (248, 'Neve Gad', 'The Neve Gad community is located in Rishon LeZion and has 35 members.', 'Rishon LeZion', 35);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (249, 'Orot Asher', 'The Orot Asher community is located in Petah Tikva and has 393 members.', 'Petah Tikva', 393);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (250, 'Bnei Yosef', 'The Bnei Yosef community is located in Holon and has 354 members.', 'Holon', 354);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (251, 'Har Binyamin', 'The Har Binyamin community is located in Bnei Brak and has 110 members.', 'Bnei Brak', 110);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (252, 'Gan Menashe', 'The Gan Menashe community is located in Bat Yam and has 289 members.', 'Bat Yam', 289);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (253, 'Beit Ephraim', 'The Beit Ephraim community is located in Ashkelon and has 459 members.', 'Ashkelon', 459);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (254, 'Ohel Sarah', 'The Ohel Sarah community is located in Rehovot and has 87 members.', 'Rehovot', 87);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (255, 'Neve Rivka', 'The Neve Rivka community is located in Herzliya and has 44 members.', 'Herzliya', 44);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (256, 'Orot Rachel', 'The Orot Rachel community is located in Ramat Gan and has 438 members.', 'Ramat Gan', 438);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (257, 'Bnei  Lea', 'The Bnei  Lea community is located in Kfar Saba and has 186 members.', 'Kfar Saba', 186);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (258, 'Har Dvora', 'The Har Dvora community is located in Hadera and has 143 members.', 'Hadera', 143);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (259, 'Gan Michal', 'The Gan Michal community is located in Raanana and has 343 members.', 'Raanana', 343);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (260, 'Beit Tamar', 'The Beit Tamar community is located in Modiin and has 280 members.', 'Modiin', 280);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (261, 'Ohel Ester', 'The Ohel Ester community is located in Nahariya and has 395 members.', 'Nahariya', 395);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (262, 'Neve Rina', 'The Neve Rina community is located in Beit Shemesh and has 111 members.', 'Beit Shemesh', 111);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (263, 'Orot Tehila ', 'The Orot Tehila  community is located in Tiberias and has 488 members.', 'Tiberias', 488);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (264, 'Bnei Shalom', 'The Bnei Shalom community is located in Kiryat Gat and has 249 members.', 'Kiryat Gat', 249);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (265, 'Har Avraham', 'The Har Avraham community is located in Lod and has 93 members.', 'Lod', 93);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (266, 'Gan Yitzhak', 'The Gan Yitzhak community is located in Maale Adumim and has 166 members.', 'Maale Adumim', 166);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (267, 'Beit Yaakov', 'The Beit Yaakov community is located in Afula and has 293 members.', 'Afula', 293);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (268, 'Ohel Moshe', 'The Ohel Moshe community is located in Dimona and has 458 members.', 'Dimona', 458);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (269, 'Neve Aharon', 'The Neve Aharon community is located in Kfar Saba and has 404 members.', 'Kfar Saba', 404);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (270, 'Orot David', 'The Orot David community is located in Zichron Yaakov and has 85 members.', 'Zichron Yaakov', 85);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (271, 'Bnei Shlomo', 'The Bnei Shlomo community is located in Tel Aviv and has 290 members.', 'Tel Aviv', 290);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (272, 'Har Eliezer', 'The Har Eliezer community is located in Jerusalem and has 270 members.', 'Jerusalem', 270);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (273, 'Gan Eliyaho', 'The Gan Eliyaho community is located in Haifa and has 397 members.', 'Haifa', 397);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (274, 'Beit Yisrael', 'The Beit Yisrael community is located in Beer Sheva and has 138 members.', 'Beer Sheva', 138);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (275, 'Ohel Reuven', 'The Ohel Reuven community is located in Eilat and has 231 members.', 'Eilat', 231);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (276, 'Neve Shimon', 'The Neve Shimon community is located in Netanya and has 114 members.', 'Netanya', 114);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (277, 'Orot Levi', 'The Orot Levi community is located in Ashdod and has 253 members.', 'Ashdod', 253);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (278, 'Bnei Yehoda', 'The Bnei Yehoda community is located in Rishon LeZion and has 419 members.', 'Rishon LeZion', 419);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (279, 'Har Dan', 'The Har Dan community is located in Petah Tikva and has 66 members.', 'Petah Tikva', 66);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (280, 'Gan Naftali', 'The Gan Naftali community is located in Holon and has 172 members.', 'Holon', 172);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (281, 'Beit Gad', 'The Beit Gad community is located in Bnei Brak and has 384 members.', 'Bnei Brak', 384);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (282, 'Ohel Asher', 'The Ohel Asher community is located in Bat Yam and has 460 members.', 'Bat Yam', 460);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (283, 'Neve Yosef', 'The Neve Yosef community is located in Ashkelon and has 325 members.', 'Ashkelon', 325);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (284, 'Orot Binyamin', 'The Orot Binyamin community is located in Rehovot and has 390 members.', 'Rehovot', 390);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (285, 'Bnei Menashe', 'The Bnei Menashe community is located in Herzliya and has 438 members.', 'Herzliya', 438);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (286, 'Har Ephraim', 'The Har Ephraim community is located in Ramat Gan and has 58 members.', 'Ramat Gan', 58);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (287, 'Gan Sarah', 'The Gan Sarah community is located in Kfar Saba and has 221 members.', 'Kfar Saba', 221);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (288, 'Beit Rivka', 'The Beit Rivka community is located in Hadera and has 354 members.', 'Hadera', 354);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (289, 'Ohel Rachel', 'The Ohel Rachel community is located in Raanana and has 307 members.', 'Raanana', 307);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (290, 'Neve  Lea', 'The Neve  Lea community is located in Modiin and has 39 members.', 'Modiin', 39);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (291, 'Orot Dvora', 'The Orot Dvora community is located in Nahariya and has 436 members.', 'Nahariya', 436);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (292, 'Bnei Michal', 'The Bnei Michal community is located in Beit Shemesh and has 487 members.', 'Beit Shemesh', 487);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (293, 'Har Tamar', 'The Har Tamar community is located in Tiberias and has 252 members.', 'Tiberias', 252);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (294, 'Gan Ester', 'The Gan Ester community is located in Kiryat Gat and has 461 members.', 'Kiryat Gat', 461);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (295, 'Beit Rina', 'The Beit Rina community is located in Lod and has 481 members.', 'Lod', 481);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (296, 'Ohel Tehila ', 'The Ohel Tehila  community is located in Maale Adumim and has 470 members.', 'Maale Adumim', 470);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (297, 'Neve Shalom', 'The Neve Shalom community is located in Afula and has 464 members.', 'Afula', 464);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (298, 'Orot Avraham', 'The Orot Avraham community is located in Dimona and has 119 members.', 'Dimona', 119);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (299, 'Bnei Yitzhak', 'The Bnei Yitzhak community is located in Kfar Saba and has 428 members.', 'Kfar Saba', 428);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (300, 'Har Yaakov', 'The Har Yaakov community is located in Zichron Yaakov and has 163 members.', 'Zichron Yaakov', 163);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (301, 'Gan Moshe', 'The Gan Moshe community is located in Tel Aviv and has 62 members.', 'Tel Aviv', 62);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (302, 'Beit Aharon', 'The Beit Aharon community is located in Jerusalem and has 184 members.', 'Jerusalem', 184);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (303, 'Ohel David', 'The Ohel David community is located in Haifa and has 412 members.', 'Haifa', 412);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (304, 'Neve Shlomo', 'The Neve Shlomo community is located in Beer Sheva and has 221 members.', 'Beer Sheva', 221);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (305, 'Orot Eliezer', 'The Orot Eliezer community is located in Eilat and has 392 members.', 'Eilat', 392);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (306, 'Bnei Eliyaho', 'The Bnei Eliyaho community is located in Netanya and has 191 members.', 'Netanya', 191);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (307, 'Har Yisrael', 'The Har Yisrael community is located in Ashdod and has 370 members.', 'Ashdod', 370);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (308, 'Gan Reuven', 'The Gan Reuven community is located in Rishon LeZion and has 441 members.', 'Rishon LeZion', 441);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (309, 'Beit Shimon', 'The Beit Shimon community is located in Petah Tikva and has 184 members.', 'Petah Tikva', 184);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (310, 'Ohel Levi', 'The Ohel Levi community is located in Holon and has 241 members.', 'Holon', 241);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (311, 'Neve Yehoda', 'The Neve Yehoda community is located in Bnei Brak and has 227 members.', 'Bnei Brak', 227);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (312, 'Orot Dan', 'The Orot Dan community is located in Bat Yam and has 90 members.', 'Bat Yam', 90);
commit;
prompt 100 records committed...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (313, 'Bnei Naftali', 'The Bnei Naftali community is located in Ashkelon and has 470 members.', 'Ashkelon', 470);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (314, 'Har Gad', 'The Har Gad community is located in Rehovot and has 324 members.', 'Rehovot', 324);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (315, 'Gan Asher', 'The Gan Asher community is located in Herzliya and has 411 members.', 'Herzliya', 411);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (316, 'Beit Yosef', 'The Beit Yosef community is located in Ramat Gan and has 62 members.', 'Ramat Gan', 62);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (317, 'Ohel Binyamin', 'The Ohel Binyamin community is located in Kfar Saba and has 399 members.', 'Kfar Saba', 399);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (318, 'Neve Menashe', 'The Neve Menashe community is located in Hadera and has 76 members.', 'Hadera', 76);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (319, 'Orot Ephraim', 'The Orot Ephraim community is located in Raanana and has 96 members.', 'Raanana', 96);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (320, 'Bnei Sarah', 'The Bnei Sarah community is located in Modiin and has 125 members.', 'Modiin', 125);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (321, 'Har Rivka', 'The Har Rivka community is located in Nahariya and has 207 members.', 'Nahariya', 207);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (322, 'Gan Rachel', 'The Gan Rachel community is located in Beit Shemesh and has 52 members.', 'Beit Shemesh', 52);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (323, 'Beit  Lea', 'The Beit  Lea community is located in Tiberias and has 51 members.', 'Tiberias', 51);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (324, 'Ohel Dvora', 'The Ohel Dvora community is located in Kiryat Gat and has 152 members.', 'Kiryat Gat', 152);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (325, 'Neve Michal', 'The Neve Michal community is located in Lod and has 85 members.', 'Lod', 85);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (326, 'Orot Tamar', 'The Orot Tamar community is located in Maale Adumim and has 321 members.', 'Maale Adumim', 321);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (327, 'Bnei Ester', 'The Bnei Ester community is located in Afula and has 114 members.', 'Afula', 114);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (328, 'Har Rina', 'The Har Rina community is located in Dimona and has 159 members.', 'Dimona', 159);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (329, 'Gan Tehila ', 'The Gan Tehila  community is located in Kfar Saba and has 164 members.', 'Kfar Saba', 164);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (330, 'Beit Shalom', 'The Beit Shalom community is located in Zichron Yaakov and has 61 members.', 'Zichron Yaakov', 61);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (331, 'Ohel Avraham', 'The Ohel Avraham community is located in Tel Aviv and has 38 members.', 'Tel Aviv', 38);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (332, 'Neve Yitzhak', 'The Neve Yitzhak community is located in Jerusalem and has 210 members.', 'Jerusalem', 210);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (333, 'Orot Yaakov', 'The Orot Yaakov community is located in Haifa and has 242 members.', 'Haifa', 242);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (334, 'Bnei Moshe', 'The Bnei Moshe community is located in Beer Sheva and has 463 members.', 'Beer Sheva', 463);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (335, 'Har Aharon', 'The Har Aharon community is located in Eilat and has 496 members.', 'Eilat', 496);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (336, 'Gan David', 'The Gan David community is located in Netanya and has 405 members.', 'Netanya', 405);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (337, 'Beit Shlomo', 'The Beit Shlomo community is located in Ashdod and has 354 members.', 'Ashdod', 354);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (338, 'Ohel Eliezer', 'The Ohel Eliezer community is located in Rishon LeZion and has 269 members.', 'Rishon LeZion', 269);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (339, 'Neve Eliyaho', 'The Neve Eliyaho community is located in Petah Tikva and has 321 members.', 'Petah Tikva', 321);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (340, 'Orot Yisrael', 'The Orot Yisrael community is located in Holon and has 255 members.', 'Holon', 255);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (341, 'Bnei Reuven', 'The Bnei Reuven community is located in Bnei Brak and has 409 members.', 'Bnei Brak', 409);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (342, 'Har Shimon', 'The Har Shimon community is located in Bat Yam and has 74 members.', 'Bat Yam', 74);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (343, 'Gan Levi', 'The Gan Levi community is located in Ashkelon and has 102 members.', 'Ashkelon', 102);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (344, 'Beit Yehoda', 'The Beit Yehoda community is located in Rehovot and has 227 members.', 'Rehovot', 227);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (345, 'Ohel Dan', 'The Ohel Dan community is located in Herzliya and has 105 members.', 'Herzliya', 105);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (346, 'Neve Naftali', 'The Neve Naftali community is located in Ramat Gan and has 74 members.', 'Ramat Gan', 74);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (347, 'Orot Gad', 'The Orot Gad community is located in Kfar Saba and has 248 members.', 'Kfar Saba', 248);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (348, 'Bnei Asher', 'The Bnei Asher community is located in Hadera and has 208 members.', 'Hadera', 208);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (349, 'Har Yosef', 'The Har Yosef community is located in Raanana and has 354 members.', 'Raanana', 354);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (350, 'Gan Binyamin', 'The Gan Binyamin community is located in Modiin and has 499 members.', 'Modiin', 499);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (351, 'Beit Menashe', 'The Beit Menashe community is located in Nahariya and has 223 members.', 'Nahariya', 223);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (352, 'Ohel Ephraim', 'The Ohel Ephraim community is located in Beit Shemesh and has 399 members.', 'Beit Shemesh', 399);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (1, 'Beit Avraham', 'The Beit Avraham community is located in Tel Aviv and has 164 members.', 'Tel Aviv', 164);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (2, 'Ohel Yitzhak', 'The Ohel Yitzhak community is located in Jerusalem and has 142 members.', 'Jerusalem', 142);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (3, 'Neve Yaakov', 'The Neve Yaakov community is located in Haifa and has 53 members.', 'Haifa', 53);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (4, 'Orot Moshe', 'The Orot Moshe community is located in Beer Sheva and has 415 members.', 'Beer Sheva', 415);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (5, 'Bnei Aharon', 'The Bnei Aharon community is located in Eilat and has 229 members.', 'Eilat', 229);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (6, 'Har David', 'The Har David community is located in Netanya and has 42 members.', 'Netanya', 42);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (7, 'Gan Shlomo', 'The Gan Shlomo community is located in Ashdod and has 435 members.', 'Ashdod', 435);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (8, 'Beit Eliezer', 'The Beit Eliezer community is located in Rishon LeZion and has 466 members.', 'Rishon LeZion', 466);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (9, 'Ohel Eliyaho', 'The Ohel Eliyaho community is located in Petah Tikva and has 325 members.', 'Petah Tikva', 325);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (10, 'Neve Yisrael', 'The Neve Yisrael community is located in Holon and has 47 members.', 'Holon', 47);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (11, 'Orot Reuven', 'The Orot Reuven community is located in Bnei Brak and has 430 members.', 'Bnei Brak', 430);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (12, 'Bnei Shimon', 'The Bnei Shimon community is located in Bat Yam and has 344 members.', 'Bat Yam', 344);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (13, 'Har Levi', 'The Har Levi community is located in Ashkelon and has 71 members.', 'Ashkelon', 71);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (14, 'Gan Yehoda', 'The Gan Yehoda community is located in Rehovot and has 136 members.', 'Rehovot', 136);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (15, 'Beit Dan', 'The Beit Dan community is located in Herzliya and has 103 members.', 'Herzliya', 103);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (16, 'Ohel Naftali', 'The Ohel Naftali community is located in Ramat Gan and has 21 members.', 'Ramat Gan', 21);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (17, 'Neve Gad', 'The Neve Gad community is located in Kfar Saba and has 293 members.', 'Kfar Saba', 293);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (18, 'Orot Asher', 'The Orot Asher community is located in Hadera and has 350 members.', 'Hadera', 350);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (19, 'Bnei Yosef', 'The Bnei Yosef community is located in Raanana and has 411 members.', 'Raanana', 411);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (20, 'Har Binyamin', 'The Har Binyamin community is located in Modiin and has 185 members.', 'Modiin', 185);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (21, 'Gan Menashe', 'The Gan Menashe community is located in Nahariya and has 199 members.', 'Nahariya', 199);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (22, 'Beit Ephraim', 'The Beit Ephraim community is located in Beit Shemesh and has 235 members.', 'Beit Shemesh', 235);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (23, 'Ohel Sarah', 'The Ohel Sarah community is located in Tiberias and has 460 members.', 'Tiberias', 460);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (24, 'Neve Rivka', 'The Neve Rivka community is located in Kiryat Gat and has 92 members.', 'Kiryat Gat', 92);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (25, 'Orot Rachel', 'The Orot Rachel community is located in Lod and has 145 members.', 'Lod', 145);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (26, 'Bnei  Lea', 'The Bnei  Lea community is located in Maale Adumim and has 366 members.', 'Maale Adumim', 366);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (27, 'Har Dvora', 'The Har Dvora community is located in Afula and has 311 members.', 'Afula', 311);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (28, 'Gan Michal', 'The Gan Michal community is located in Dimona and has 160 members.', 'Dimona', 160);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (29, 'Beit Tamar', 'The Beit Tamar community is located in Kfar Saba and has 265 members.', 'Kfar Saba', 265);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (30, 'Ohel Ester', 'The Ohel Ester community is located in Zichron Yaakov and has 404 members.', 'Zichron Yaakov', 404);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (31, 'Neve Rina', 'The Neve Rina community is located in Tel Aviv and has 428 members.', 'Tel Aviv', 428);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (32, 'Orot Tehila ', 'The Orot Tehila  community is located in Jerusalem and has 74 members.', 'Jerusalem', 74);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (33, 'Bnei Shalom', 'The Bnei Shalom community is located in Haifa and has 292 members.', 'Haifa', 292);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (34, 'Har Avraham', 'The Har Avraham community is located in Beer Sheva and has 414 members.', 'Beer Sheva', 414);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (35, 'Gan Yitzhak', 'The Gan Yitzhak community is located in Eilat and has 228 members.', 'Eilat', 228);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (36, 'Beit Yaakov', 'The Beit Yaakov community is located in Netanya and has 333 members.', 'Netanya', 333);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (37, 'Ohel Moshe', 'The Ohel Moshe community is located in Ashdod and has 244 members.', 'Ashdod', 244);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (38, 'Neve Aharon', 'The Neve Aharon community is located in Rishon LeZion and has 362 members.', 'Rishon LeZion', 362);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (39, 'Orot David', 'The Orot David community is located in Petah Tikva and has 307 members.', 'Petah Tikva', 307);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (40, 'Bnei Shlomo', 'The Bnei Shlomo community is located in Holon and has 160 members.', 'Holon', 160);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (41, 'Har Eliezer', 'The Har Eliezer community is located in Bnei Brak and has 142 members.', 'Bnei Brak', 142);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (42, 'Gan Eliyaho', 'The Gan Eliyaho community is located in Bat Yam and has 78 members.', 'Bat Yam', 78);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (43, 'Beit Yisrael', 'The Beit Yisrael community is located in Ashkelon and has 196 members.', 'Ashkelon', 196);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (44, 'Ohel Reuven', 'The Ohel Reuven community is located in Rehovot and has 49 members.', 'Rehovot', 49);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (45, 'Neve Shimon', 'The Neve Shimon community is located in Herzliya and has 253 members.', 'Herzliya', 253);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (46, 'Orot Levi', 'The Orot Levi community is located in Ramat Gan and has 142 members.', 'Ramat Gan', 142);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (47, 'Bnei Yehoda', 'The Bnei Yehoda community is located in Kfar Saba and has 138 members.', 'Kfar Saba', 138);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (48, 'Har Dan', 'The Har Dan community is located in Hadera and has 182 members.', 'Hadera', 182);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (49, 'Gan Naftali', 'The Gan Naftali community is located in Raanana and has 252 members.', 'Raanana', 252);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (50, 'Beit Gad', 'The Beit Gad community is located in Modiin and has 324 members.', 'Modiin', 324);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (51, 'Ohel Asher', 'The Ohel Asher community is located in Nahariya and has 361 members.', 'Nahariya', 361);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (52, 'Neve Yosef', 'The Neve Yosef community is located in Beit Shemesh and has 246 members.', 'Beit Shemesh', 246);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (53, 'Orot Binyamin', 'The Orot Binyamin community is located in Tiberias and has 330 members.', 'Tiberias', 330);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (54, 'Bnei Menashe', 'The Bnei Menashe community is located in Kiryat Gat and has 473 members.', 'Kiryat Gat', 473);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (55, 'Har Ephraim', 'The Har Ephraim community is located in Lod and has 44 members.', 'Lod', 44);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (56, 'Gan Sarah', 'The Gan Sarah community is located in Maale Adumim and has 377 members.', 'Maale Adumim', 377);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (57, 'Beit Rivka', 'The Beit Rivka community is located in Afula and has 387 members.', 'Afula', 387);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (58, 'Ohel Rachel', 'The Ohel Rachel community is located in Dimona and has 390 members.', 'Dimona', 390);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (59, 'Neve  Lea', 'The Neve  Lea community is located in Kfar Saba and has 308 members.', 'Kfar Saba', 308);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (60, 'Orot Dvora', 'The Orot Dvora community is located in Zichron Yaakov and has 59 members.', 'Zichron Yaakov', 59);
commit;
prompt 200 records committed...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (61, 'Bnei Michal', 'The Bnei Michal community is located in Tel Aviv and has 45 members.', 'Tel Aviv', 45);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (62, 'Har Tamar', 'The Har Tamar community is located in Jerusalem and has 112 members.', 'Jerusalem', 112);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (63, 'Gan Ester', 'The Gan Ester community is located in Haifa and has 219 members.', 'Haifa', 219);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (64, 'Beit Rina', 'The Beit Rina community is located in Beer Sheva and has 369 members.', 'Beer Sheva', 369);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (65, 'Ohel Tehila ', 'The Ohel Tehila  community is located in Eilat and has 58 members.', 'Eilat', 58);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (66, 'Neve Shalom', 'The Neve Shalom community is located in Netanya and has 147 members.', 'Netanya', 147);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (67, 'Orot Avraham', 'The Orot Avraham community is located in Ashdod and has 482 members.', 'Ashdod', 482);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (68, 'Bnei Yitzhak', 'The Bnei Yitzhak community is located in Rishon LeZion and has 84 members.', 'Rishon LeZion', 84);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (69, 'Har Yaakov', 'The Har Yaakov community is located in Petah Tikva and has 326 members.', 'Petah Tikva', 326);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (70, 'Gan Moshe', 'The Gan Moshe community is located in Holon and has 228 members.', 'Holon', 228);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (71, 'Beit Aharon', 'The Beit Aharon community is located in Bnei Brak and has 202 members.', 'Bnei Brak', 202);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (72, 'Ohel David', 'The Ohel David community is located in Bat Yam and has 225 members.', 'Bat Yam', 225);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (73, 'Neve Shlomo', 'The Neve Shlomo community is located in Ashkelon and has 380 members.', 'Ashkelon', 380);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (74, 'Orot Eliezer', 'The Orot Eliezer community is located in Rehovot and has 448 members.', 'Rehovot', 448);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (75, 'Bnei Eliyaho', 'The Bnei Eliyaho community is located in Herzliya and has 396 members.', 'Herzliya', 396);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (76, 'Har Yisrael', 'The Har Yisrael community is located in Ramat Gan and has 466 members.', 'Ramat Gan', 466);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (77, 'Gan Reuven', 'The Gan Reuven community is located in Kfar Saba and has 478 members.', 'Kfar Saba', 478);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (78, 'Beit Shimon', 'The Beit Shimon community is located in Hadera and has 310 members.', 'Hadera', 310);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (79, 'Ohel Levi', 'The Ohel Levi community is located in Raanana and has 343 members.', 'Raanana', 343);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (80, 'Neve Yehoda', 'The Neve Yehoda community is located in Modiin and has 25 members.', 'Modiin', 25);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (81, 'Orot Dan', 'The Orot Dan community is located in Nahariya and has 391 members.', 'Nahariya', 391);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (82, 'Bnei Naftali', 'The Bnei Naftali community is located in Beit Shemesh and has 179 members.', 'Beit Shemesh', 179);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (83, 'Har Gad', 'The Har Gad community is located in Tiberias and has 335 members.', 'Tiberias', 335);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (84, 'Gan Asher', 'The Gan Asher community is located in Kiryat Gat and has 343 members.', 'Kiryat Gat', 343);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (85, 'Beit Yosef', 'The Beit Yosef community is located in Lod and has 178 members.', 'Lod', 178);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (86, 'Ohel Binyamin', 'The Ohel Binyamin community is located in Maale Adumim and has 412 members.', 'Maale Adumim', 412);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (87, 'Neve Menashe', 'The Neve Menashe community is located in Afula and has 194 members.', 'Afula', 194);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (88, 'Orot Ephraim', 'The Orot Ephraim community is located in Dimona and has 217 members.', 'Dimona', 217);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (89, 'Bnei Sarah', 'The Bnei Sarah community is located in Kfar Saba and has 372 members.', 'Kfar Saba', 372);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (90, 'Har Rivka', 'The Har Rivka community is located in Zichron Yaakov and has 292 members.', 'Zichron Yaakov', 292);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (91, 'Gan Rachel', 'The Gan Rachel community is located in Tel Aviv and has 94 members.', 'Tel Aviv', 94);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (92, 'Beit  Lea', 'The Beit  Lea community is located in Jerusalem and has 493 members.', 'Jerusalem', 493);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (93, 'Ohel Dvora', 'The Ohel Dvora community is located in Haifa and has 151 members.', 'Haifa', 151);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (94, 'Neve Michal', 'The Neve Michal community is located in Beer Sheva and has 169 members.', 'Beer Sheva', 169);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (95, 'Orot Tamar', 'The Orot Tamar community is located in Eilat and has 60 members.', 'Eilat', 60);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (96, 'Bnei Ester', 'The Bnei Ester community is located in Netanya and has 143 members.', 'Netanya', 143);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (97, 'Har Rina', 'The Har Rina community is located in Ashdod and has 272 members.', 'Ashdod', 272);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (98, 'Gan Tehila ', 'The Gan Tehila  community is located in Rishon LeZion and has 329 members.', 'Rishon LeZion', 329);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (99, 'Beit Shalom', 'The Beit Shalom community is located in Petah Tikva and has 468 members.', 'Petah Tikva', 468);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (100, 'Ohel Avraham', 'The Ohel Avraham community is located in Holon and has 345 members.', 'Holon', 345);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (101, 'Neve Yitzhak', 'The Neve Yitzhak community is located in Bnei Brak and has 11 members.', 'Bnei Brak', 11);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (102, 'Orot Yaakov', 'The Orot Yaakov community is located in Bat Yam and has 222 members.', 'Bat Yam', 222);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (103, 'Bnei Moshe', 'The Bnei Moshe community is located in Ashkelon and has 368 members.', 'Ashkelon', 368);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (104, 'Har Aharon', 'The Har Aharon community is located in Rehovot and has 98 members.', 'Rehovot', 98);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (105, 'Gan David', 'The Gan David community is located in Herzliya and has 113 members.', 'Herzliya', 113);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (106, 'Beit Shlomo', 'The Beit Shlomo community is located in Ramat Gan and has 287 members.', 'Ramat Gan', 287);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (107, 'Ohel Eliezer', 'The Ohel Eliezer community is located in Kfar Saba and has 289 members.', 'Kfar Saba', 289);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (108, 'Neve Eliyaho', 'The Neve Eliyaho community is located in Hadera and has 353 members.', 'Hadera', 353);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (109, 'Orot Yisrael', 'The Orot Yisrael community is located in Raanana and has 354 members.', 'Raanana', 354);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (110, 'Bnei Reuven', 'The Bnei Reuven community is located in Modiin and has 472 members.', 'Modiin', 472);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (111, 'Har Shimon', 'The Har Shimon community is located in Nahariya and has 83 members.', 'Nahariya', 83);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (112, 'Gan Levi', 'The Gan Levi community is located in Beit Shemesh and has 182 members.', 'Beit Shemesh', 182);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (113, 'Beit Yehoda', 'The Beit Yehoda community is located in Tiberias and has 221 members.', 'Tiberias', 221);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (114, 'Ohel Dan', 'The Ohel Dan community is located in Kiryat Gat and has 467 members.', 'Kiryat Gat', 467);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (115, 'Neve Naftali', 'The Neve Naftali community is located in Lod and has 32 members.', 'Lod', 32);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (116, 'Orot Gad', 'The Orot Gad community is located in Maale Adumim and has 277 members.', 'Maale Adumim', 277);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (117, 'Bnei Asher', 'The Bnei Asher community is located in Afula and has 66 members.', 'Afula', 66);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (118, 'Har Yosef', 'The Har Yosef community is located in Dimona and has 235 members.', 'Dimona', 235);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (119, 'Gan Binyamin', 'The Gan Binyamin community is located in Kfar Saba and has 98 members.', 'Kfar Saba', 98);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (120, 'Beit Menashe', 'The Beit Menashe community is located in Zichron Yaakov and has 220 members.', 'Zichron Yaakov', 220);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (121, 'Ohel Ephraim', 'The Ohel Ephraim community is located in Tel Aviv and has 195 members.', 'Tel Aviv', 195);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (122, 'Neve Sarah', 'The Neve Sarah community is located in Jerusalem and has 411 members.', 'Jerusalem', 411);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (123, 'Orot Rivka', 'The Orot Rivka community is located in Haifa and has 343 members.', 'Haifa', 343);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (124, 'Bnei Rachel', 'The Bnei Rachel community is located in Beer Sheva and has 455 members.', 'Beer Sheva', 455);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (125, 'Har  Lea', 'The Har  Lea community is located in Eilat and has 12 members.', 'Eilat', 12);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (126, 'Gan Dvora', 'The Gan Dvora community is located in Netanya and has 79 members.', 'Netanya', 79);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (127, 'Beit Michal', 'The Beit Michal community is located in Ashdod and has 496 members.', 'Ashdod', 496);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (128, 'Ohel Tamar', 'The Ohel Tamar community is located in Rishon LeZion and has 381 members.', 'Rishon LeZion', 381);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (129, 'Neve Ester', 'The Neve Ester community is located in Petah Tikva and has 463 members.', 'Petah Tikva', 463);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (130, 'Orot Rina', 'The Orot Rina community is located in Holon and has 265 members.', 'Holon', 265);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (131, 'Bnei Tehila ', 'The Bnei Tehila  community is located in Bnei Brak and has 388 members.', 'Bnei Brak', 388);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (132, 'Har Shalom', 'The Har Shalom community is located in Bat Yam and has 32 members.', 'Bat Yam', 32);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (133, 'Gan Avraham', 'The Gan Avraham community is located in Ashkelon and has 220 members.', 'Ashkelon', 220);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (134, 'Beit Yitzhak', 'The Beit Yitzhak community is located in Rehovot and has 424 members.', 'Rehovot', 424);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (135, 'Ohel Yaakov', 'The Ohel Yaakov community is located in Herzliya and has 365 members.', 'Herzliya', 365);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (136, 'Neve Moshe', 'The Neve Moshe community is located in Ramat Gan and has 330 members.', 'Ramat Gan', 330);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (137, 'Orot Aharon', 'The Orot Aharon community is located in Kfar Saba and has 254 members.', 'Kfar Saba', 254);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (138, 'Bnei David', 'The Bnei David community is located in Hadera and has 451 members.', 'Hadera', 451);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (139, 'Har Shlomo', 'The Har Shlomo community is located in Raanana and has 144 members.', 'Raanana', 144);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (140, 'Gan Eliezer', 'The Gan Eliezer community is located in Modiin and has 322 members.', 'Modiin', 322);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (141, 'Beit Eliyaho', 'The Beit Eliyaho community is located in Nahariya and has 281 members.', 'Nahariya', 281);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (142, 'Ohel Yisrael', 'The Ohel Yisrael community is located in Beit Shemesh and has 53 members.', 'Beit Shemesh', 53);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (143, 'Neve Reuven', 'The Neve Reuven community is located in Tiberias and has 452 members.', 'Tiberias', 452);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (144, 'Orot Shimon', 'The Orot Shimon community is located in Kiryat Gat and has 87 members.', 'Kiryat Gat', 87);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (145, 'Bnei Levi', 'The Bnei Levi community is located in Lod and has 32 members.', 'Lod', 32);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (146, 'Har Yehoda', 'The Har Yehoda community is located in Maale Adumim and has 371 members.', 'Maale Adumim', 371);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (147, 'Gan Dan', 'The Gan Dan community is located in Afula and has 160 members.', 'Afula', 160);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (148, 'Beit Naftali', 'The Beit Naftali community is located in Dimona and has 470 members.', 'Dimona', 470);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (149, 'Ohel Gad', 'The Ohel Gad community is located in Kfar Saba and has 460 members.', 'Kfar Saba', 460);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (150, 'Neve Asher', 'The Neve Asher community is located in Zichron Yaakov and has 350 members.', 'Zichron Yaakov', 350);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (151, 'Orot Yosef', 'The Orot Yosef community is located in Tel Aviv and has 486 members.', 'Tel Aviv', 486);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (152, 'Bnei Binyamin', 'The Bnei Binyamin community is located in Jerusalem and has 375 members.', 'Jerusalem', 375);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (153, 'Har Menashe', 'The Har Menashe community is located in Haifa and has 75 members.', 'Haifa', 75);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (154, 'Gan Ephraim', 'The Gan Ephraim community is located in Beer Sheva and has 446 members.', 'Beer Sheva', 446);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (155, 'Beit Sarah', 'The Beit Sarah community is located in Eilat and has 321 members.', 'Eilat', 321);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (156, 'Ohel Rivka', 'The Ohel Rivka community is located in Netanya and has 449 members.', 'Netanya', 449);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (157, 'Neve Rachel', 'The Neve Rachel community is located in Ashdod and has 479 members.', 'Ashdod', 479);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (158, 'Orot  Lea', 'The Orot  Lea community is located in Rishon LeZion and has 140 members.', 'Rishon LeZion', 140);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (159, 'Bnei Dvora', 'The Bnei Dvora community is located in Petah Tikva and has 252 members.', 'Petah Tikva', 252);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (160, 'Har Michal', 'The Har Michal community is located in Holon and has 387 members.', 'Holon', 387);
commit;
prompt 300 records committed...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (161, 'Gan Tamar', 'The Gan Tamar community is located in Bnei Brak and has 200 members.', 'Bnei Brak', 200);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (162, 'Beit Ester', 'The Beit Ester community is located in Bat Yam and has 108 members.', 'Bat Yam', 108);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (163, 'Ohel Rina', 'The Ohel Rina community is located in Ashkelon and has 223 members.', 'Ashkelon', 223);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (164, 'Neve Tehila ', 'The Neve Tehila  community is located in Rehovot and has 20 members.', 'Rehovot', 20);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (165, 'Orot Shalom', 'The Orot Shalom community is located in Herzliya and has 284 members.', 'Herzliya', 284);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (166, 'Bnei Avraham', 'The Bnei Avraham community is located in Ramat Gan and has 297 members.', 'Ramat Gan', 297);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (167, 'Har Yitzhak', 'The Har Yitzhak community is located in Kfar Saba and has 482 members.', 'Kfar Saba', 482);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (168, 'Gan Yaakov', 'The Gan Yaakov community is located in Hadera and has 275 members.', 'Hadera', 275);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (169, 'Beit Moshe', 'The Beit Moshe community is located in Raanana and has 289 members.', 'Raanana', 289);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (170, 'Ohel Aharon', 'The Ohel Aharon community is located in Modiin and has 384 members.', 'Modiin', 384);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (171, 'Neve David', 'The Neve David community is located in Nahariya and has 152 members.', 'Nahariya', 152);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (172, 'Orot Shlomo', 'The Orot Shlomo community is located in Beit Shemesh and has 309 members.', 'Beit Shemesh', 309);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (173, 'Bnei Eliezer', 'The Bnei Eliezer community is located in Tiberias and has 352 members.', 'Tiberias', 352);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (174, 'Har Eliyaho', 'The Har Eliyaho community is located in Kiryat Gat and has 431 members.', 'Kiryat Gat', 431);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (175, 'Gan Yisrael', 'The Gan Yisrael community is located in Lod and has 476 members.', 'Lod', 476);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (176, 'Beit Reuven', 'The Beit Reuven community is located in Maale Adumim and has 114 members.', 'Maale Adumim', 114);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (177, 'Ohel Shimon', 'The Ohel Shimon community is located in Afula and has 482 members.', 'Afula', 482);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (178, 'Neve Levi', 'The Neve Levi community is located in Dimona and has 304 members.', 'Dimona', 304);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (179, 'Orot Yehoda', 'The Orot Yehoda community is located in Kfar Saba and has 390 members.', 'Kfar Saba', 390);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (180, 'Bnei Dan', 'The Bnei Dan community is located in Zichron Yaakov and has 371 members.', 'Zichron Yaakov', 371);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (181, 'Har Naftali', 'The Har Naftali community is located in Tel Aviv and has 332 members.', 'Tel Aviv', 332);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (182, 'Gan Gad', 'The Gan Gad community is located in Jerusalem and has 373 members.', 'Jerusalem', 373);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (183, 'Beit Asher', 'The Beit Asher community is located in Haifa and has 141 members.', 'Haifa', 141);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (184, 'Ohel Yosef', 'The Ohel Yosef community is located in Beer Sheva and has 205 members.', 'Beer Sheva', 205);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (185, 'Neve Binyamin', 'The Neve Binyamin community is located in Eilat and has 312 members.', 'Eilat', 312);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (186, 'Orot Menashe', 'The Orot Menashe community is located in Netanya and has 255 members.', 'Netanya', 255);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (187, 'Bnei Ephraim', 'The Bnei Ephraim community is located in Ashdod and has 102 members.', 'Ashdod', 102);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (188, 'Har Sarah', 'The Har Sarah community is located in Rishon LeZion and has 271 members.', 'Rishon LeZion', 271);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (189, 'Gan Rivka', 'The Gan Rivka community is located in Petah Tikva and has 195 members.', 'Petah Tikva', 195);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (190, 'Beit Rachel', 'The Beit Rachel community is located in Holon and has 363 members.', 'Holon', 363);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (191, 'Ohel  Lea', 'The Ohel  Lea community is located in Bnei Brak and has 440 members.', 'Bnei Brak', 440);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (192, 'Neve Dvora', 'The Neve Dvora community is located in Bat Yam and has 160 members.', 'Bat Yam', 160);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (193, 'Orot Michal', 'The Orot Michal community is located in Ashkelon and has 425 members.', 'Ashkelon', 425);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (194, 'Bnei Tamar', 'The Bnei Tamar community is located in Rehovot and has 277 members.', 'Rehovot', 277);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (195, 'Har Ester', 'The Har Ester community is located in Herzliya and has 478 members.', 'Herzliya', 478);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (196, 'Gan Rina', 'The Gan Rina community is located in Ramat Gan and has 339 members.', 'Ramat Gan', 339);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (197, 'Beit Tehila ', 'The Beit Tehila  community is located in Kfar Saba and has 492 members.', 'Kfar Saba', 492);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (198, 'Ohel Shalom', 'The Ohel Shalom community is located in Hadera and has 190 members.', 'Hadera', 190);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (199, 'Neve Avraham', 'The Neve Avraham community is located in Raanana and has 432 members.', 'Raanana', 432);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (200, 'Orot Yitzhak', 'The Orot Yitzhak community is located in Modiin and has 57 members.', 'Modiin', 57);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (201, 'Bnei Yaakov', 'The Bnei Yaakov community is located in Nahariya and has 367 members.', 'Nahariya', 367);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (202, 'Har Moshe', 'The Har Moshe community is located in Beit Shemesh and has 415 members.', 'Beit Shemesh', 415);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (203, 'Gan Aharon', 'The Gan Aharon community is located in Tiberias and has 492 members.', 'Tiberias', 492);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (204, 'Beit David', 'The Beit David community is located in Kiryat Gat and has 293 members.', 'Kiryat Gat', 293);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (205, 'Ohel Shlomo', 'The Ohel Shlomo community is located in Lod and has 412 members.', 'Lod', 412);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (206, 'Neve Eliezer', 'The Neve Eliezer community is located in Maale Adumim and has 193 members.', 'Maale Adumim', 193);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (207, 'Orot Eliyaho', 'The Orot Eliyaho community is located in Afula and has 82 members.', 'Afula', 82);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (208, 'Bnei Yisrael', 'The Bnei Yisrael community is located in Dimona and has 168 members.', 'Dimona', 168);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (209, 'Har Reuven', 'The Har Reuven community is located in Kfar Saba and has 394 members.', 'Kfar Saba', 394);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (210, 'Gan Shimon', 'The Gan Shimon community is located in Zichron Yaakov and has 253 members.', 'Zichron Yaakov', 253);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (211, 'Beit Levi', 'The Beit Levi community is located in Tel Aviv and has 117 members.', 'Tel Aviv', 117);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (212, 'Ohel Yehoda', 'The Ohel Yehoda community is located in Jerusalem and has 444 members.', 'Jerusalem', 444);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (401, 'AAA', 'aaa', null, 100);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (402, 'Gavin', 'Biostar M7SXF P4 478pin M/B Intel P4 1;8ghz CPU + Fan(BOx)Support DDR DIMM', 'Breda', 55);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (904, 'Taye', 'AMD XP 2600+ Retail box. (with 333Mhz Front Side Bus)', 'Koeln', 50);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (1406, 'Jose', 'Intel D 850MV P4 M/B RDRam support', 'Antwerpen', 32);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (1908, 'Cheryl', 'Biostar M7VKB Ver2.0 ATA100 socket A (w/30 day limit warranty)', 'Wörth', 79);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (2410, 'Wallace', 'Intel Pentium4 2.0ghz & Gigabyte 8IRXP MB w/ 313N Case. W/ Free PS2 Mouse.', 'Stony Point', 99);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (2912, 'Swoosie', '128Mb SDRAM PC133 Micron;Lifetime Warranty! We offer a 100% Compatibility Guarantee. 7.5ns PC133', 'Heubach', 26);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (3414, 'Jim', 'Linksys Instant Wireless Network Adapter - Version 3.0 for Notbooks. (Model No. WPC11 ver.3)', 'Luzern', 25);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (3916, 'Jackie', 'Cyber Power 725VA Battery Back Up', 'Hohenfels', 8);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (4418, 'Mika', 'Intel Pentium4 2.4ghz & Gigabyte 8IRX MB w/ 313M Case.', 'Dreieich', 32);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (4920, 'Lisa', 'Dynatron CPU Cooler DF1206BH AMD Athlon\Duron Fan. (AMD Recommend)', 'Maebashi', 15);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (5422, 'Johnette', 'Combo Intel P4 1.8ghz CPU + Fan(BOx) w/ Gigabyte GA-8IE800 Intel®845E Chipset.', 'Pomona', 30);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (5924, 'Udo', '313D Black 400W P4/AMD 2xUSB', 'Carlingford', 8);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (6426, 'Mary', 'AMD XP 1800+ Box CPU and Fan', 'Nagano', 39);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (6928, 'Halle', 'Asus P4C800 Deluxe intel 875 Chip 800FSB DDR SATA ATA133 RAID GIGABIT LAN USB2.0 ATX Retail Box + In', 'Palo Alto', 33);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (7430, 'Uma', 'SVA-USA VR-15A 15" TFT LCD Display.', 'Milwaukee', 90);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (7932, 'Hank', 'Mitsumi PS2 Keyboard', 'Parsippany', 46);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (8434, 'Adam', '6066-C10 Black Computer case w/Window panel', 'Santa Clarita', 100);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (8936, 'Mickey', 'Assembly & Testing of the CPU/Fan; Motherboard; Case; and Other Products.', 'Bracknell', 53);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (9438, 'Russell', '128Mb PC2100 266Mhz DDR Ram ( Micron )', 'Lahr', 36);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (9940, 'Jonny', '128Mb DDRam PC2100 Kingston', 'Kungens kurva', 81);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (10442, 'Dom', 'SVA-USA VR-17S 17" TFT LCD Display.', 'Essen', 27);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (10944, 'Albertina', 'Intel D845WN 478Pin SDRAM retail Box', 'Hochwald', 52);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (11446, 'Albertina', 'Combo AMD XP 2700+ CPU; Gigabyte GA-7VA M/B(W/8X AGP;DDR333 up to 3GB/ATA133 ) +Fan.', 'Silverdale', 63);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (11948, 'Larnelle', '6066-C10 Black Computer case w/Window panel', 'Baltimore', 84);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (12450, 'Kimberly', 'Intel D 850MV P4 M/B RDRam support', 'Edmonton', 20);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (12952, 'Carl', 'AMD Duron 1.3Ghz & Gigabyte GA-7VKMLE MB w/ 312D Color Case. W/ Free PS2 Mouse.', 'L''union', 81);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (13454, 'Timothy', 'Microsoft Wireless Optical Desktop .', 'Anyang-si', 16);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (13956, 'Neneh', 'AMD XP 1800+ & Gigabyte GA-7VKMLE MB w/ 313M Color Case. W/ Free PS2 Mouse.', 'Royersford', 63);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (14458, 'Melanie', 'Intel Celeron 1.8ghz & Gigabyte GA-8LD533 MB w/ 313N Case. W/ Free PS2 Mouse.', 'University', 92);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (14960, 'Beverley', 'AMD XP 2200+ & Gigabyte 7DXE w/ 313M case . W/ Free PS2 Mouse.', 'Warley', 89);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (15462, 'Miles', '312D ATX translucent blue color case with 300W P4/AMD with(front USB ready) .', 'Eschen', 14);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (15964, 'James', 'KDS 15" Flat Screen LCD monitor (black).', 'Fukushima', 29);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (16466, 'Goran', 'Intel P4 1;6Ghz Bare Bone CPU & Fan;', 'Park Ridge', 78);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (16968, 'Vincent', 'Combo AMD XP 2000+ cpu Gigabyte GA-7VKMLS m/b fan.', 'Libertyville', 96);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (17470, 'Katie', 'Combo AMD XP 1700+ Gigabyte GA-7VKML M/B + Fan', 'Oxford', 14);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (17972, 'Adrien', '64Mb RDRam SAMSUNG Must be used in pairs', 'Kongserbg', 8);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (18474, 'Russell', '512Mb SDRam PC133', 'Solikamsk', 100);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (18976, 'Hank', 'AMD XP 1700+ & Gigabyte GA-7VKML MB w/313N case. W/ Free PS2 Mouse.', 'Bratislava', 46);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (19478, 'Charlie', 'ANTEC Performance PLUS Model PLUS1080 w/ Antec Original TRUE 430W P4 Power Supply.', 'Zurich', 56);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (19980, 'Larnelle', 'Intel Celeron 1.1Ghz & Gigabyte GA6VEML MB w/ 312D Color Case. W/ Free PS2 Mouse.', 'Alessandria', 54);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (20482, 'Lee', 'AMD XP 2700+ & Gigabyte 7N400Pro w/ 313M case . W/ Free PS2 Mouse.', 'Vejle', 26);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (20984, 'Dick', 'Biostar M7SXF P4 478pin M/B Intel P4 1;8ghz CPU + Fan(BOx)Support DDR DIMM', 'Friedrichshafe', 14);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (21486, 'Joaquim', 'Intel P4 3.06 HT CPU & Intel D845PEBT2 M/B onboard Raid and S-ATA', 'Oldham', 72);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (21988, 'Lucinda', 'Assembly & Testing of the CPU/Fan; Motherboard; Case; and Other Products.', 'Alessandria', 42);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (22490, 'Julie', 'Wireless Access Point Router with 4-Port Switch - Version 3.2 (BEFW11S4)', 'Belmont', 59);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (22992, 'Lois', 'CoolerMaster Thermal Compound High Performance. HTK-001', 'Lefkosa', 86);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (23494, 'Merrilee', 'Mitsumi 48x 12 x 40 CD-RW', 'Carlingford', 100);
commit;
prompt 400 records committed...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (23996, 'Ving', 'Linksys USB Wireless (WUSB11)', 'Los Angeles', 48);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (24498, 'Lionel', 'Cyber Power 325SL Battery Back Up', 'Tustin', 19);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (25000, 'Brendan', 'Front panel USB kit (for 312J and 312D Case)', 'Thame', 41);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (25502, 'Rawlins', 'Combo AMD XP 2700+ CPU; Gigabyte GA-7N400Pro M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 'Raleigh', 13);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (26004, 'Tanya', 'SVA-USA VR-15A 15" TFT LCD Display.', 'Indianapolis', 19);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (26506, 'Victor', 'Combo Intel P4 2.4ghz CPU + Fan(BOx) w/ Gigabyte GA-8IE800 Intel®845E Chipset.', 'Pompeia', 81);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (27008, 'Kim', 'Maxtor 40G 7200RPM ATA133', 'Salt Lake City', 89);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (27510, 'Loreena', 'AMD XP 2100+ CPU (oem)(AXDA2100DUT3C; RevisionB).', 'Darmstadt', 8);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (28012, 'Hector', 'Black Complete Computer System w/ Mouse KeyBoard and Speakers(Free AMR Moden). (Duron 1.3)', 'Drogenbos', 22);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (28514, 'Tal', 'AMD 1.1Ghz BareBone System W/Free M&M', 'Waldbronn', 95);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (29016, 'Lance', 'Combo AMD XP 2000+ CPU; Gigabyte GA-7VA M/B.', 'Colombo', 36);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (29518, 'Marc', '319A ATX case 400W P4/AMD Free Fan and 2 Front USB.', 'Riverdale', 98);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (30020, 'Lindsey', 'Matrox Dual Head G550 With 32 MB of Double Data Rate (DDR) memory; a 360. MHz primary RAMDAC.OEM pac', 'Bartlesville', 6);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (30522, 'Hex', 'Combo AMD XP 1700+ cpu Gigabyte GA-7DXE Motherboard + Fan', 'East sussex', 35);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (31024, 'Pablo', 'Microsoft Windows XP Home Full Registered.', 'Saga', 91);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (31526, 'Susan', 'Combo AMD XP 2500+ CPU; Gigabyte GA-7VT600L M/B(W/DDR400 up to 3GB/ATA133 Raid/USB2.0) +Fan.', 'Macau', 43);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (32028, 'Rickie', 'Combo AMD XP 1900+ cpu Gigabyte GA-7ZXE Motherboard + Fan', 'Duisburg', 59);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (32530, 'Noah', 'Mitsumi Win 2000 Internet Keyboard', 'Magstadt', 19);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (33032, 'Garland', 'Combo Intel P4 1.8Ghz (Box CPU)+ Biostar U8668D m/b (478pin)CPU & Fan Support SD.', 'Swarthmore', 34);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (33534, 'Eliza', 'Achieve Gold Dual Fan 550Watt PowerSupply.', 'Tours', 63);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (34036, 'Brothers', 'GA-7VT600-L VIA KT600 chipset.', 'Neuchâtel', 71);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (34538, 'Neneh', 'Combo Intel Celeron 1.7ghz Gigabyte GA-8LD533 m/b onboard sound;video ;10/100 Lan USB2.0 + fan.', 'Mississauga', 65);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (35040, 'Suzy', '312B ATX Case with 400Watt P4/P3/AMD Ready PS.', 'Prague', 12);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (35542, 'Darius', 'Mitsumi 1.44 Floppy Drive', 'Olympia', 92);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (36044, 'Pat', '14"/15" Filter Screen', 'Daejeon', 40);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (36546, 'Jason', 'Combo AMD XP 1700+ Gigabyte GA-7VKML M/B + Fan', 'Avon', 39);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (37048, 'Clay', 'AOC 17" Monitor 7FSLK .25mm Dot Pitch TureFlat', 'Banbury', 16);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (37550, 'Arnold', 'AMD XP1800 Biostar M7VKQ Pro', 'Hunt Valley', 55);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (38052, 'Julio', 'Black Sony CD-RW 52x24x52x .', 'Berkshire', 77);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (38554, 'Vickie', 'Achieve Gold Dual Fan 550Watt PowerSupply.', 'Paal Beringen', 59);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (39056, 'Timothy', 'CyberPower Surge Protector 850 with 8 Outlet.', 'Auckland', 95);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (39558, 'Wayne', 'Cable/DSL Broadband Router (w/ 4-port Switch) (EE400-R).', 'Hartford', 97);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (40060, 'Rene', 'Combo AMD XP 1800+ cpu Gigabyte GA-7VKMLE m/b fan.', 'Anyang-si', 52);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (40562, 'Cathy', 'Intel D845PEBT2 M/B onboard Raid and S-ATA .', 'Bethesda', 58);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (41064, 'Miranda', 'ADS External USB 2.0 Drive Kit', 'Kozani', 98);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (41566, 'Fats', 'ATI Radeon 7000 32MB DDR TV-Out&DVI', 'Hilversum', 39);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (42068, 'Jeanne', 'AMD XP 2600+ FBS 333 & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 'Duisburg', 74);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (42570, 'Jena', 'AMD XP 2600+ & Biostar M7VIK KT400 MB w/ 313M case. Free PS2 Mouse.', 'Toronto', 96);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (43072, 'Willie', 'Combo Intel P4 1.6Ghz (Box CPU)+ Biostar U8668 m/b (478pin)CPU & Fan Support SD.', 'Kloten', 39);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (43574, 'Praga', 'CNet External 56k V.92 Fax modem (Serial).', 'Buffalo', 5);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (44076, 'Tim', 'ASUS P4SDX SiS655 Chipset Dual Channel DDR333.', 'Boulder', 14);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (44578, 'Willem', 'GigaByte 7N400Pro AntecCase+AMDXP2700', 'Ponta grossa', 75);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (45080, 'First', '313D Black Case 300W P4/AMD', 'East Peoria', 91);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (45582, 'Johnette', 'Mircosoft Ergonomic Keyboard and Mouse Set.', 'Solon', 19);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (46084, 'Toni', '256MB DDR PC2700 Kingston', 'Porto alegre', 7);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (46586, 'Roscoe', 'AMD XP 2500+ FBS 333 & GigaByte GA-7VA MB w/ 313M case. Free PS2 Mouse.', 'Lecanto', 20);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (47088, 'Angelina', 'Combo AMD XP 2000+ CPU; Gigabyte GA-7VA M/B.', 'Palo Alto', 75);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (47590, 'Christine', 'Intel Celeron 1.8ghz & Biostar U8668D. W/ Free CNR 56k & PS2 Mouse.', 'Peterborough', 17);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (48092, 'Buddy', 'ASUS A7N8X Deluxe NVIDIA Force2 .', 'Warrington', 33);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (48594, 'Warren', '14inch LCD MG-015A Xgen2 Monitor.', 'Stocksbridge', 9);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (49096, 'Jeanne', 'Boka 2000 Sub Woofer Speaker System', 'Frederiksberg', 79);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (49598, 'Warren', '313N-B ATX case 300W P4/AMD Free Fan and 2 Front USB.', 'Toronto', 76);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (50100, 'Harry', '313D Black 400W P4/AMD 2xUSB', 'Longueuil', 92);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (353, 'Neve Sarah', 'The Neve Sarah community is located in Tiberias and has 76 members.', 'Tiberias', 76);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (354, 'Orot Rivka', 'The Orot Rivka community is located in Kiryat Gat and has 242 members.', 'Kiryat Gat', 242);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (355, 'Bnei Rachel', 'The Bnei Rachel community is located in Lod and has 68 members.', 'Lod', 68);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (356, 'Har  Lea', 'The Har  Lea community is located in Maale Adumim and has 451 members.', 'Maale Adumim', 451);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (357, 'Gan Dvora', 'The Gan Dvora community is located in Afula and has 472 members.', 'Afula', 472);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (358, 'Beit Michal', 'The Beit Michal community is located in Dimona and has 171 members.', 'Dimona', 171);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (359, 'Ohel Tamar', 'The Ohel Tamar community is located in Kfar Saba and has 247 members.', 'Kfar Saba', 247);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (360, 'Neve Ester', 'The Neve Ester community is located in Zichron Yaakov and has 405 members.', 'Zichron Yaakov', 405);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (361, 'Orot Rina', 'The Orot Rina community is located in Tel Aviv and has 124 members.', 'Tel Aviv', 124);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (362, 'Bnei Tehila ', 'The Bnei Tehila  community is located in Jerusalem and has 78 members.', 'Jerusalem', 78);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (363, 'Har Shalom', 'The Har Shalom community is located in Haifa and has 97 members.', 'Haifa', 97);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (364, 'Gan Avraham', 'The Gan Avraham community is located in Beer Sheva and has 303 members.', 'Beer Sheva', 303);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (365, 'Beit Yitzhak', 'The Beit Yitzhak community is located in Eilat and has 320 members.', 'Eilat', 320);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (366, 'Ohel Yaakov', 'The Ohel Yaakov community is located in Netanya and has 352 members.', 'Netanya', 352);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (367, 'Neve Moshe', 'The Neve Moshe community is located in Ashdod and has 427 members.', 'Ashdod', 427);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (368, 'Orot Aharon', 'The Orot Aharon community is located in Rishon LeZion and has 231 members.', 'Rishon LeZion', 231);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (369, 'Bnei David', 'The Bnei David community is located in Petah Tikva and has 171 members.', 'Petah Tikva', 171);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (370, 'Har Shlomo', 'The Har Shlomo community is located in Holon and has 217 members.', 'Holon', 217);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (371, 'Gan Eliezer', 'The Gan Eliezer community is located in Bnei Brak and has 159 members.', 'Bnei Brak', 159);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (372, 'Beit Eliyaho', 'The Beit Eliyaho community is located in Bat Yam and has 174 members.', 'Bat Yam', 174);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (373, 'Ohel Yisrael', 'The Ohel Yisrael community is located in Ashkelon and has 403 members.', 'Ashkelon', 403);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (374, 'Neve Reuven', 'The Neve Reuven community is located in Rehovot and has 440 members.', 'Rehovot', 440);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (375, 'Orot Shimon', 'The Orot Shimon community is located in Herzliya and has 464 members.', 'Herzliya', 464);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (376, 'Bnei Levi', 'The Bnei Levi community is located in Ramat Gan and has 320 members.', 'Ramat Gan', 320);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (377, 'Har Yehoda', 'The Har Yehoda community is located in Kfar Saba and has 426 members.', 'Kfar Saba', 426);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (378, 'Gan Dan', 'The Gan Dan community is located in Hadera and has 40 members.', 'Hadera', 40);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (379, 'Beit Naftali', 'The Beit Naftali community is located in Raanana and has 460 members.', 'Raanana', 460);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (380, 'Ohel Gad', 'The Ohel Gad community is located in Modiin and has 10 members.', 'Modiin', 10);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (381, 'Neve Asher', 'The Neve Asher community is located in Nahariya and has 89 members.', 'Nahariya', 89);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (382, 'Orot Yosef', 'The Orot Yosef community is located in Beit Shemesh and has 115 members.', 'Beit Shemesh', 115);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (383, 'Bnei Binyamin', 'The Bnei Binyamin community is located in Tiberias and has 115 members.', 'Tiberias', 115);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (384, 'Har Menashe', 'The Har Menashe community is located in Kiryat Gat and has 270 members.', 'Kiryat Gat', 270);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (385, 'Gan Ephraim', 'The Gan Ephraim community is located in Lod and has 251 members.', 'Lod', 251);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (386, 'Beit Sarah', 'The Beit Sarah community is located in Maale Adumim and has 308 members.', 'Maale Adumim', 308);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (387, 'Ohel Rivka', 'The Ohel Rivka community is located in Afula and has 119 members.', 'Afula', 119);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (388, 'Neve Rachel', 'The Neve Rachel community is located in Dimona and has 213 members.', 'Dimona', 213);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (389, 'Orot  Lea', 'The Orot  Lea community is located in Kfar Saba and has 171 members.', 'Kfar Saba', 171);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (390, 'Bnei Dvora', 'The Bnei Dvora community is located in Zichron Yaakov and has 338 members.', 'Zichron Yaakov', 338);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (391, 'Har Michal', 'The Har Michal community is located in Tel Aviv and has 345 members.', 'Tel Aviv', 345);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (392, 'Gan Tamar', 'The Gan Tamar community is located in Jerusalem and has 405 members.', 'Jerusalem', 405);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (393, 'Beit Ester', 'The Beit Ester community is located in Haifa and has 500 members.', 'Haifa', 500);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (394, 'Ohel Rina', 'The Ohel Rina community is located in Beer Sheva and has 281 members.', 'Beer Sheva', 281);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (395, 'Neve Tehila ', 'The Neve Tehila  community is located in Eilat and has 311 members.', 'Eilat', 311);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (396, 'Orot Shalom', 'The Orot Shalom community is located in Netanya and has 169 members.', 'Netanya', 169);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (397, 'Bnei Avraham', 'The Bnei Avraham community is located in Ashdod and has 34 members.', 'Ashdod', 34);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (398, 'Har Yitzhak', 'The Har Yitzhak community is located in Rishon LeZion and has 12 members.', 'Rishon LeZion', 12);
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (399, 'Gan Yaakov', 'The Gan Yaakov community is located in Petah Tikva and has 252 members.', 'Petah Tikva', 252);
commit;
prompt 500 records committed...
insert into COMMUNITY (c_id, c_name, c_description, c_location, c_numofmembers)
values (400, 'Beit Moshe', 'The Beit Moshe community is located in Holon and has 359 members.', 'Holon', 359);
commit;
prompt 501 records loaded
prompt Loading COMMUNITYMEMBER...
insert into COMMUNITYMEMBER (c_id, m_id)
values (1, 702330680);
insert into COMMUNITYMEMBER (c_id, m_id)
values (2, 611218507);
insert into COMMUNITYMEMBER (c_id, m_id)
values (2, 712214343);
insert into COMMUNITYMEMBER (c_id, m_id)
values (3, 634913355);
insert into COMMUNITYMEMBER (c_id, m_id)
values (4, 221497111);
insert into COMMUNITYMEMBER (c_id, m_id)
values (4, 811595988);
insert into COMMUNITYMEMBER (c_id, m_id)
values (5, 300808131);
insert into COMMUNITYMEMBER (c_id, m_id)
values (5, 816505320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (5, 837052178);
insert into COMMUNITYMEMBER (c_id, m_id)
values (6, 485862308);
insert into COMMUNITYMEMBER (c_id, m_id)
values (6, 588368340);
insert into COMMUNITYMEMBER (c_id, m_id)
values (6, 715916459);
insert into COMMUNITYMEMBER (c_id, m_id)
values (7, 176236963);
insert into COMMUNITYMEMBER (c_id, m_id)
values (7, 728382339);
insert into COMMUNITYMEMBER (c_id, m_id)
values (7, 732364554);
insert into COMMUNITYMEMBER (c_id, m_id)
values (7, 894501335);
insert into COMMUNITYMEMBER (c_id, m_id)
values (8, 113103849);
insert into COMMUNITYMEMBER (c_id, m_id)
values (10, 360999355);
insert into COMMUNITYMEMBER (c_id, m_id)
values (10, 850393521);
insert into COMMUNITYMEMBER (c_id, m_id)
values (10, 876495432);
insert into COMMUNITYMEMBER (c_id, m_id)
values (11, 693685227);
insert into COMMUNITYMEMBER (c_id, m_id)
values (11, 770754632);
insert into COMMUNITYMEMBER (c_id, m_id)
values (12, 557714154);
insert into COMMUNITYMEMBER (c_id, m_id)
values (12, 612699405);
insert into COMMUNITYMEMBER (c_id, m_id)
values (13, 105836606);
insert into COMMUNITYMEMBER (c_id, m_id)
values (13, 448882818);
insert into COMMUNITYMEMBER (c_id, m_id)
values (13, 462236022);
insert into COMMUNITYMEMBER (c_id, m_id)
values (13, 733840300);
insert into COMMUNITYMEMBER (c_id, m_id)
values (13, 856694332);
insert into COMMUNITYMEMBER (c_id, m_id)
values (14, 782477403);
insert into COMMUNITYMEMBER (c_id, m_id)
values (14, 841688466);
insert into COMMUNITYMEMBER (c_id, m_id)
values (15, 254392497);
insert into COMMUNITYMEMBER (c_id, m_id)
values (15, 553025263);
insert into COMMUNITYMEMBER (c_id, m_id)
values (15, 689614398);
insert into COMMUNITYMEMBER (c_id, m_id)
values (15, 807314354);
insert into COMMUNITYMEMBER (c_id, m_id)
values (17, 169524150);
insert into COMMUNITYMEMBER (c_id, m_id)
values (17, 980430236);
insert into COMMUNITYMEMBER (c_id, m_id)
values (19, 661315918);
insert into COMMUNITYMEMBER (c_id, m_id)
values (19, 826062368);
insert into COMMUNITYMEMBER (c_id, m_id)
values (20, 325043737);
insert into COMMUNITYMEMBER (c_id, m_id)
values (20, 552297292);
insert into COMMUNITYMEMBER (c_id, m_id)
values (20, 661216534);
insert into COMMUNITYMEMBER (c_id, m_id)
values (20, 734673425);
insert into COMMUNITYMEMBER (c_id, m_id)
values (20, 775266141);
insert into COMMUNITYMEMBER (c_id, m_id)
values (21, 356625533);
insert into COMMUNITYMEMBER (c_id, m_id)
values (21, 524148126);
insert into COMMUNITYMEMBER (c_id, m_id)
values (21, 619987847);
insert into COMMUNITYMEMBER (c_id, m_id)
values (21, 832343421);
insert into COMMUNITYMEMBER (c_id, m_id)
values (22, 262643480);
insert into COMMUNITYMEMBER (c_id, m_id)
values (22, 485506309);
insert into COMMUNITYMEMBER (c_id, m_id)
values (22, 796357825);
insert into COMMUNITYMEMBER (c_id, m_id)
values (22, 952669174);
insert into COMMUNITYMEMBER (c_id, m_id)
values (23, 889678021);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 123959939);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 653939281);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 667176850);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 686236374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 714440128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (24, 823717446);
insert into COMMUNITYMEMBER (c_id, m_id)
values (25, 942044626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (26, 558169743);
insert into COMMUNITYMEMBER (c_id, m_id)
values (26, 848489360);
insert into COMMUNITYMEMBER (c_id, m_id)
values (27, 553517298);
insert into COMMUNITYMEMBER (c_id, m_id)
values (28, 299747885);
insert into COMMUNITYMEMBER (c_id, m_id)
values (28, 339476205);
insert into COMMUNITYMEMBER (c_id, m_id)
values (28, 467965675);
insert into COMMUNITYMEMBER (c_id, m_id)
values (28, 667562726);
insert into COMMUNITYMEMBER (c_id, m_id)
values (29, 353145125);
insert into COMMUNITYMEMBER (c_id, m_id)
values (29, 526438708);
insert into COMMUNITYMEMBER (c_id, m_id)
values (29, 630664380);
insert into COMMUNITYMEMBER (c_id, m_id)
values (30, 421119444);
insert into COMMUNITYMEMBER (c_id, m_id)
values (30, 682304864);
insert into COMMUNITYMEMBER (c_id, m_id)
values (30, 755209681);
insert into COMMUNITYMEMBER (c_id, m_id)
values (31, 656802060);
insert into COMMUNITYMEMBER (c_id, m_id)
values (32, 403567464);
insert into COMMUNITYMEMBER (c_id, m_id)
values (33, 108592361);
insert into COMMUNITYMEMBER (c_id, m_id)
values (33, 120024694);
insert into COMMUNITYMEMBER (c_id, m_id)
values (33, 937043198);
insert into COMMUNITYMEMBER (c_id, m_id)
values (34, 317144977);
insert into COMMUNITYMEMBER (c_id, m_id)
values (35, 139741096);
insert into COMMUNITYMEMBER (c_id, m_id)
values (35, 722932897);
insert into COMMUNITYMEMBER (c_id, m_id)
values (36, 451171514);
insert into COMMUNITYMEMBER (c_id, m_id)
values (36, 654126598);
insert into COMMUNITYMEMBER (c_id, m_id)
values (36, 725424742);
insert into COMMUNITYMEMBER (c_id, m_id)
values (36, 795466385);
insert into COMMUNITYMEMBER (c_id, m_id)
values (36, 926537995);
insert into COMMUNITYMEMBER (c_id, m_id)
values (38, 991789435);
insert into COMMUNITYMEMBER (c_id, m_id)
values (39, 667916897);
insert into COMMUNITYMEMBER (c_id, m_id)
values (39, 873353399);
insert into COMMUNITYMEMBER (c_id, m_id)
values (41, 639036860);
insert into COMMUNITYMEMBER (c_id, m_id)
values (42, 615422014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (42, 776623460);
insert into COMMUNITYMEMBER (c_id, m_id)
values (44, 518817006);
insert into COMMUNITYMEMBER (c_id, m_id)
values (45, 576647580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (45, 738218439);
insert into COMMUNITYMEMBER (c_id, m_id)
values (46, 116462353);
insert into COMMUNITYMEMBER (c_id, m_id)
values (46, 951075931);
insert into COMMUNITYMEMBER (c_id, m_id)
values (47, 170846994);
insert into COMMUNITYMEMBER (c_id, m_id)
values (48, 228322646);
insert into COMMUNITYMEMBER (c_id, m_id)
values (48, 374356341);
commit;
prompt 100 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (48, 466239135);
insert into COMMUNITYMEMBER (c_id, m_id)
values (48, 557616226);
insert into COMMUNITYMEMBER (c_id, m_id)
values (48, 699214173);
insert into COMMUNITYMEMBER (c_id, m_id)
values (49, 492827855);
insert into COMMUNITYMEMBER (c_id, m_id)
values (49, 557466349);
insert into COMMUNITYMEMBER (c_id, m_id)
values (49, 885568274);
insert into COMMUNITYMEMBER (c_id, m_id)
values (50, 488864046);
insert into COMMUNITYMEMBER (c_id, m_id)
values (50, 759277745);
insert into COMMUNITYMEMBER (c_id, m_id)
values (50, 811608430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (51, 667562726);
insert into COMMUNITYMEMBER (c_id, m_id)
values (52, 129195321);
insert into COMMUNITYMEMBER (c_id, m_id)
values (52, 438150346);
insert into COMMUNITYMEMBER (c_id, m_id)
values (53, 166217087);
insert into COMMUNITYMEMBER (c_id, m_id)
values (53, 708135979);
insert into COMMUNITYMEMBER (c_id, m_id)
values (53, 787229074);
insert into COMMUNITYMEMBER (c_id, m_id)
values (55, 120974857);
insert into COMMUNITYMEMBER (c_id, m_id)
values (55, 254647820);
insert into COMMUNITYMEMBER (c_id, m_id)
values (56, 714440128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (57, 116462353);
insert into COMMUNITYMEMBER (c_id, m_id)
values (57, 896975711);
insert into COMMUNITYMEMBER (c_id, m_id)
values (57, 974400788);
insert into COMMUNITYMEMBER (c_id, m_id)
values (58, 208196098);
insert into COMMUNITYMEMBER (c_id, m_id)
values (58, 399360066);
insert into COMMUNITYMEMBER (c_id, m_id)
values (59, 267080645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (60, 237075795);
insert into COMMUNITYMEMBER (c_id, m_id)
values (60, 258945756);
insert into COMMUNITYMEMBER (c_id, m_id)
values (60, 444894245);
insert into COMMUNITYMEMBER (c_id, m_id)
values (60, 960965084);
insert into COMMUNITYMEMBER (c_id, m_id)
values (61, 492827855);
insert into COMMUNITYMEMBER (c_id, m_id)
values (63, 699262710);
insert into COMMUNITYMEMBER (c_id, m_id)
values (63, 712214343);
insert into COMMUNITYMEMBER (c_id, m_id)
values (63, 938406845);
insert into COMMUNITYMEMBER (c_id, m_id)
values (64, 310735882);
insert into COMMUNITYMEMBER (c_id, m_id)
values (64, 557616226);
insert into COMMUNITYMEMBER (c_id, m_id)
values (65, 463520539);
insert into COMMUNITYMEMBER (c_id, m_id)
values (65, 838232400);
insert into COMMUNITYMEMBER (c_id, m_id)
values (66, 555936029);
insert into COMMUNITYMEMBER (c_id, m_id)
values (66, 773608536);
insert into COMMUNITYMEMBER (c_id, m_id)
values (66, 946331566);
insert into COMMUNITYMEMBER (c_id, m_id)
values (67, 116069857);
insert into COMMUNITYMEMBER (c_id, m_id)
values (67, 567016150);
insert into COMMUNITYMEMBER (c_id, m_id)
values (68, 159480739);
insert into COMMUNITYMEMBER (c_id, m_id)
values (69, 481788951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (69, 615928170);
insert into COMMUNITYMEMBER (c_id, m_id)
values (69, 952750374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (70, 508814603);
insert into COMMUNITYMEMBER (c_id, m_id)
values (72, 407652575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (72, 481788951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (72, 666288551);
insert into COMMUNITYMEMBER (c_id, m_id)
values (72, 942044626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (72, 972229832);
insert into COMMUNITYMEMBER (c_id, m_id)
values (73, 131889804);
insert into COMMUNITYMEMBER (c_id, m_id)
values (73, 271482442);
insert into COMMUNITYMEMBER (c_id, m_id)
values (74, 167172437);
insert into COMMUNITYMEMBER (c_id, m_id)
values (74, 171853644);
insert into COMMUNITYMEMBER (c_id, m_id)
values (74, 630664380);
insert into COMMUNITYMEMBER (c_id, m_id)
values (74, 945448417);
insert into COMMUNITYMEMBER (c_id, m_id)
values (75, 458408009);
insert into COMMUNITYMEMBER (c_id, m_id)
values (75, 607668294);
insert into COMMUNITYMEMBER (c_id, m_id)
values (76, 105762273);
insert into COMMUNITYMEMBER (c_id, m_id)
values (76, 785974864);
insert into COMMUNITYMEMBER (c_id, m_id)
values (77, 380288743);
insert into COMMUNITYMEMBER (c_id, m_id)
values (77, 763909026);
insert into COMMUNITYMEMBER (c_id, m_id)
values (78, 267248998);
insert into COMMUNITYMEMBER (c_id, m_id)
values (78, 359642256);
insert into COMMUNITYMEMBER (c_id, m_id)
values (78, 677269787);
insert into COMMUNITYMEMBER (c_id, m_id)
values (79, 373140049);
insert into COMMUNITYMEMBER (c_id, m_id)
values (79, 527280153);
insert into COMMUNITYMEMBER (c_id, m_id)
values (80, 185360775);
insert into COMMUNITYMEMBER (c_id, m_id)
values (80, 731977144);
insert into COMMUNITYMEMBER (c_id, m_id)
values (81, 607902262);
insert into COMMUNITYMEMBER (c_id, m_id)
values (81, 687579680);
insert into COMMUNITYMEMBER (c_id, m_id)
values (81, 849923350);
insert into COMMUNITYMEMBER (c_id, m_id)
values (82, 396481548);
insert into COMMUNITYMEMBER (c_id, m_id)
values (82, 907674013);
insert into COMMUNITYMEMBER (c_id, m_id)
values (83, 999065018);
insert into COMMUNITYMEMBER (c_id, m_id)
values (84, 131145243);
insert into COMMUNITYMEMBER (c_id, m_id)
values (84, 638404454);
insert into COMMUNITYMEMBER (c_id, m_id)
values (85, 191356229);
insert into COMMUNITYMEMBER (c_id, m_id)
values (85, 193082739);
insert into COMMUNITYMEMBER (c_id, m_id)
values (85, 737627430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (85, 753024805);
insert into COMMUNITYMEMBER (c_id, m_id)
values (85, 838232400);
insert into COMMUNITYMEMBER (c_id, m_id)
values (86, 157540214);
insert into COMMUNITYMEMBER (c_id, m_id)
values (86, 187453014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (86, 232516560);
insert into COMMUNITYMEMBER (c_id, m_id)
values (87, 816505320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (89, 261226610);
insert into COMMUNITYMEMBER (c_id, m_id)
values (89, 885521932);
insert into COMMUNITYMEMBER (c_id, m_id)
values (90, 547106878);
insert into COMMUNITYMEMBER (c_id, m_id)
values (90, 776623460);
insert into COMMUNITYMEMBER (c_id, m_id)
values (90, 885809424);
insert into COMMUNITYMEMBER (c_id, m_id)
values (91, 420154025);
insert into COMMUNITYMEMBER (c_id, m_id)
values (91, 487955324);
insert into COMMUNITYMEMBER (c_id, m_id)
values (91, 612546655);
insert into COMMUNITYMEMBER (c_id, m_id)
values (92, 135014039);
insert into COMMUNITYMEMBER (c_id, m_id)
values (93, 396469378);
insert into COMMUNITYMEMBER (c_id, m_id)
values (94, 153367163);
insert into COMMUNITYMEMBER (c_id, m_id)
values (94, 215499619);
insert into COMMUNITYMEMBER (c_id, m_id)
values (94, 663196582);
commit;
prompt 200 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (94, 815540940);
insert into COMMUNITYMEMBER (c_id, m_id)
values (95, 216359243);
insert into COMMUNITYMEMBER (c_id, m_id)
values (96, 938406845);
insert into COMMUNITYMEMBER (c_id, m_id)
values (97, 386928076);
insert into COMMUNITYMEMBER (c_id, m_id)
values (98, 488864046);
insert into COMMUNITYMEMBER (c_id, m_id)
values (98, 772584828);
insert into COMMUNITYMEMBER (c_id, m_id)
values (98, 804309217);
insert into COMMUNITYMEMBER (c_id, m_id)
values (98, 844165456);
insert into COMMUNITYMEMBER (c_id, m_id)
values (99, 218193438);
insert into COMMUNITYMEMBER (c_id, m_id)
values (99, 455135434);
insert into COMMUNITYMEMBER (c_id, m_id)
values (99, 798624234);
insert into COMMUNITYMEMBER (c_id, m_id)
values (99, 802904951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (100, 970123677);
insert into COMMUNITYMEMBER (c_id, m_id)
values (101, 157623754);
insert into COMMUNITYMEMBER (c_id, m_id)
values (101, 291379350);
insert into COMMUNITYMEMBER (c_id, m_id)
values (101, 386354445);
insert into COMMUNITYMEMBER (c_id, m_id)
values (103, 274807987);
insert into COMMUNITYMEMBER (c_id, m_id)
values (103, 349109407);
insert into COMMUNITYMEMBER (c_id, m_id)
values (103, 451171514);
insert into COMMUNITYMEMBER (c_id, m_id)
values (103, 640098230);
insert into COMMUNITYMEMBER (c_id, m_id)
values (104, 267556727);
insert into COMMUNITYMEMBER (c_id, m_id)
values (104, 296735164);
insert into COMMUNITYMEMBER (c_id, m_id)
values (104, 980430236);
insert into COMMUNITYMEMBER (c_id, m_id)
values (105, 615422014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (105, 731631935);
insert into COMMUNITYMEMBER (c_id, m_id)
values (105, 847523648);
insert into COMMUNITYMEMBER (c_id, m_id)
values (105, 940067704);
insert into COMMUNITYMEMBER (c_id, m_id)
values (106, 349290214);
insert into COMMUNITYMEMBER (c_id, m_id)
values (106, 615928170);
insert into COMMUNITYMEMBER (c_id, m_id)
values (106, 686236374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (106, 841688466);
insert into COMMUNITYMEMBER (c_id, m_id)
values (108, 821749542);
insert into COMMUNITYMEMBER (c_id, m_id)
values (109, 301184346);
insert into COMMUNITYMEMBER (c_id, m_id)
values (109, 921877972);
insert into COMMUNITYMEMBER (c_id, m_id)
values (110, 547111578);
insert into COMMUNITYMEMBER (c_id, m_id)
values (112, 267248998);
insert into COMMUNITYMEMBER (c_id, m_id)
values (112, 841688466);
insert into COMMUNITYMEMBER (c_id, m_id)
values (113, 467965675);
insert into COMMUNITYMEMBER (c_id, m_id)
values (113, 529348579);
insert into COMMUNITYMEMBER (c_id, m_id)
values (113, 651855962);
insert into COMMUNITYMEMBER (c_id, m_id)
values (114, 182055053);
insert into COMMUNITYMEMBER (c_id, m_id)
values (114, 399077464);
insert into COMMUNITYMEMBER (c_id, m_id)
values (115, 718189291);
insert into COMMUNITYMEMBER (c_id, m_id)
values (115, 926537995);
insert into COMMUNITYMEMBER (c_id, m_id)
values (116, 357723571);
insert into COMMUNITYMEMBER (c_id, m_id)
values (116, 557616226);
insert into COMMUNITYMEMBER (c_id, m_id)
values (116, 804309217);
insert into COMMUNITYMEMBER (c_id, m_id)
values (116, 989941934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (117, 396481548);
insert into COMMUNITYMEMBER (c_id, m_id)
values (117, 527445580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (118, 482685638);
insert into COMMUNITYMEMBER (c_id, m_id)
values (118, 699214173);
insert into COMMUNITYMEMBER (c_id, m_id)
values (118, 995273588);
insert into COMMUNITYMEMBER (c_id, m_id)
values (119, 100148653);
insert into COMMUNITYMEMBER (c_id, m_id)
values (119, 839691671);
insert into COMMUNITYMEMBER (c_id, m_id)
values (120, 305926726);
insert into COMMUNITYMEMBER (c_id, m_id)
values (120, 476308716);
insert into COMMUNITYMEMBER (c_id, m_id)
values (120, 682304864);
insert into COMMUNITYMEMBER (c_id, m_id)
values (120, 815054512);
insert into COMMUNITYMEMBER (c_id, m_id)
values (121, 343057735);
insert into COMMUNITYMEMBER (c_id, m_id)
values (121, 370571857);
insert into COMMUNITYMEMBER (c_id, m_id)
values (123, 490172289);
insert into COMMUNITYMEMBER (c_id, m_id)
values (123, 816505821);
insert into COMMUNITYMEMBER (c_id, m_id)
values (123, 840341264);
insert into COMMUNITYMEMBER (c_id, m_id)
values (124, 197218839);
insert into COMMUNITYMEMBER (c_id, m_id)
values (124, 437929378);
insert into COMMUNITYMEMBER (c_id, m_id)
values (124, 570993504);
insert into COMMUNITYMEMBER (c_id, m_id)
values (124, 666288551);
insert into COMMUNITYMEMBER (c_id, m_id)
values (124, 756476008);
insert into COMMUNITYMEMBER (c_id, m_id)
values (125, 669449784);
insert into COMMUNITYMEMBER (c_id, m_id)
values (126, 164877394);
insert into COMMUNITYMEMBER (c_id, m_id)
values (127, 205397955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (127, 357643935);
insert into COMMUNITYMEMBER (c_id, m_id)
values (127, 425485955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (128, 468477800);
insert into COMMUNITYMEMBER (c_id, m_id)
values (128, 738309645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (130, 166897367);
insert into COMMUNITYMEMBER (c_id, m_id)
values (130, 566318538);
insert into COMMUNITYMEMBER (c_id, m_id)
values (130, 931619511);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 174600853);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 513603889);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 683067812);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 858616442);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 901120266);
insert into COMMUNITYMEMBER (c_id, m_id)
values (131, 948875262);
insert into COMMUNITYMEMBER (c_id, m_id)
values (234, 140359430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (234, 612797289);
insert into COMMUNITYMEMBER (c_id, m_id)
values (234, 732364554);
insert into COMMUNITYMEMBER (c_id, m_id)
values (235, 721527128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (235, 942515529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (236, 476772296);
insert into COMMUNITYMEMBER (c_id, m_id)
values (236, 976175712);
insert into COMMUNITYMEMBER (c_id, m_id)
values (236, 980430236);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 157623754);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 199668456);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 274715538);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 488493128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 615586328);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 738218439);
insert into COMMUNITYMEMBER (c_id, m_id)
values (238, 823928736);
commit;
prompt 300 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (240, 598227354);
insert into COMMUNITYMEMBER (c_id, m_id)
values (240, 844165456);
insert into COMMUNITYMEMBER (c_id, m_id)
values (241, 386354445);
insert into COMMUNITYMEMBER (c_id, m_id)
values (241, 744764697);
insert into COMMUNITYMEMBER (c_id, m_id)
values (241, 982854200);
insert into COMMUNITYMEMBER (c_id, m_id)
values (242, 185794095);
insert into COMMUNITYMEMBER (c_id, m_id)
values (242, 226019979);
insert into COMMUNITYMEMBER (c_id, m_id)
values (242, 545493618);
insert into COMMUNITYMEMBER (c_id, m_id)
values (242, 816505320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (243, 129195321);
insert into COMMUNITYMEMBER (c_id, m_id)
values (243, 523949424);
insert into COMMUNITYMEMBER (c_id, m_id)
values (243, 648872364);
insert into COMMUNITYMEMBER (c_id, m_id)
values (243, 918190109);
insert into COMMUNITYMEMBER (c_id, m_id)
values (244, 355146666);
insert into COMMUNITYMEMBER (c_id, m_id)
values (244, 467965675);
insert into COMMUNITYMEMBER (c_id, m_id)
values (245, 226292015);
insert into COMMUNITYMEMBER (c_id, m_id)
values (245, 485506309);
insert into COMMUNITYMEMBER (c_id, m_id)
values (246, 175518300);
insert into COMMUNITYMEMBER (c_id, m_id)
values (246, 427746575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (246, 654360049);
insert into COMMUNITYMEMBER (c_id, m_id)
values (246, 753638601);
insert into COMMUNITYMEMBER (c_id, m_id)
values (246, 889678021);
insert into COMMUNITYMEMBER (c_id, m_id)
values (247, 254571947);
insert into COMMUNITYMEMBER (c_id, m_id)
values (247, 621738771);
insert into COMMUNITYMEMBER (c_id, m_id)
values (247, 873783034);
insert into COMMUNITYMEMBER (c_id, m_id)
values (247, 974400788);
insert into COMMUNITYMEMBER (c_id, m_id)
values (248, 169659515);
insert into COMMUNITYMEMBER (c_id, m_id)
values (248, 259933017);
insert into COMMUNITYMEMBER (c_id, m_id)
values (248, 620372277);
insert into COMMUNITYMEMBER (c_id, m_id)
values (250, 204794274);
insert into COMMUNITYMEMBER (c_id, m_id)
values (250, 667176850);
insert into COMMUNITYMEMBER (c_id, m_id)
values (250, 725612282);
insert into COMMUNITYMEMBER (c_id, m_id)
values (250, 847523648);
insert into COMMUNITYMEMBER (c_id, m_id)
values (251, 120974857);
insert into COMMUNITYMEMBER (c_id, m_id)
values (251, 382678745);
insert into COMMUNITYMEMBER (c_id, m_id)
values (251, 388509855);
insert into COMMUNITYMEMBER (c_id, m_id)
values (251, 440396543);
insert into COMMUNITYMEMBER (c_id, m_id)
values (251, 504390279);
insert into COMMUNITYMEMBER (c_id, m_id)
values (252, 838232400);
insert into COMMUNITYMEMBER (c_id, m_id)
values (253, 557605097);
insert into COMMUNITYMEMBER (c_id, m_id)
values (253, 666288551);
insert into COMMUNITYMEMBER (c_id, m_id)
values (253, 666662014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (253, 901502896);
insert into COMMUNITYMEMBER (c_id, m_id)
values (254, 554661104);
insert into COMMUNITYMEMBER (c_id, m_id)
values (254, 590478640);
insert into COMMUNITYMEMBER (c_id, m_id)
values (254, 638472575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (254, 844173763);
insert into COMMUNITYMEMBER (c_id, m_id)
values (255, 120818128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (255, 600244770);
insert into COMMUNITYMEMBER (c_id, m_id)
values (255, 901120266);
insert into COMMUNITYMEMBER (c_id, m_id)
values (256, 120818128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (256, 759277745);
insert into COMMUNITYMEMBER (c_id, m_id)
values (257, 190360834);
insert into COMMUNITYMEMBER (c_id, m_id)
values (257, 240921696);
insert into COMMUNITYMEMBER (c_id, m_id)
values (257, 638472575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (258, 899139967);
insert into COMMUNITYMEMBER (c_id, m_id)
values (259, 314544963);
insert into COMMUNITYMEMBER (c_id, m_id)
values (259, 332847604);
insert into COMMUNITYMEMBER (c_id, m_id)
values (259, 449337529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (259, 753024805);
insert into COMMUNITYMEMBER (c_id, m_id)
values (259, 998764869);
insert into COMMUNITYMEMBER (c_id, m_id)
values (260, 513923427);
insert into COMMUNITYMEMBER (c_id, m_id)
values (260, 615892339);
insert into COMMUNITYMEMBER (c_id, m_id)
values (260, 638472575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (261, 418941549);
insert into COMMUNITYMEMBER (c_id, m_id)
values (261, 478438487);
insert into COMMUNITYMEMBER (c_id, m_id)
values (261, 488864046);
insert into COMMUNITYMEMBER (c_id, m_id)
values (261, 606754465);
insert into COMMUNITYMEMBER (c_id, m_id)
values (262, 778935652);
insert into COMMUNITYMEMBER (c_id, m_id)
values (262, 966881718);
insert into COMMUNITYMEMBER (c_id, m_id)
values (263, 325043737);
insert into COMMUNITYMEMBER (c_id, m_id)
values (263, 787229074);
insert into COMMUNITYMEMBER (c_id, m_id)
values (264, 301254976);
insert into COMMUNITYMEMBER (c_id, m_id)
values (264, 837052178);
insert into COMMUNITYMEMBER (c_id, m_id)
values (265, 276224889);
insert into COMMUNITYMEMBER (c_id, m_id)
values (265, 286942816);
insert into COMMUNITYMEMBER (c_id, m_id)
values (266, 418481619);
insert into COMMUNITYMEMBER (c_id, m_id)
values (267, 104602934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (267, 338247817);
insert into COMMUNITYMEMBER (c_id, m_id)
values (267, 642289450);
insert into COMMUNITYMEMBER (c_id, m_id)
values (268, 380288743);
insert into COMMUNITYMEMBER (c_id, m_id)
values (268, 849633047);
insert into COMMUNITYMEMBER (c_id, m_id)
values (269, 157820082);
insert into COMMUNITYMEMBER (c_id, m_id)
values (270, 428745222);
insert into COMMUNITYMEMBER (c_id, m_id)
values (270, 844609510);
insert into COMMUNITYMEMBER (c_id, m_id)
values (272, 677269787);
insert into COMMUNITYMEMBER (c_id, m_id)
values (272, 826802360);
insert into COMMUNITYMEMBER (c_id, m_id)
values (274, 323888942);
insert into COMMUNITYMEMBER (c_id, m_id)
values (274, 413834362);
insert into COMMUNITYMEMBER (c_id, m_id)
values (274, 801616613);
insert into COMMUNITYMEMBER (c_id, m_id)
values (275, 619987847);
insert into COMMUNITYMEMBER (c_id, m_id)
values (276, 259923743);
insert into COMMUNITYMEMBER (c_id, m_id)
values (276, 806840454);
insert into COMMUNITYMEMBER (c_id, m_id)
values (277, 205397955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (278, 228322646);
insert into COMMUNITYMEMBER (c_id, m_id)
values (278, 387092329);
insert into COMMUNITYMEMBER (c_id, m_id)
values (279, 466239135);
insert into COMMUNITYMEMBER (c_id, m_id)
values (279, 715505955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (279, 801616613);
insert into COMMUNITYMEMBER (c_id, m_id)
values (280, 498521987);
commit;
prompt 400 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (280, 663430400);
insert into COMMUNITYMEMBER (c_id, m_id)
values (280, 770754632);
insert into COMMUNITYMEMBER (c_id, m_id)
values (280, 872708693);
insert into COMMUNITYMEMBER (c_id, m_id)
values (281, 234029909);
insert into COMMUNITYMEMBER (c_id, m_id)
values (281, 931619511);
insert into COMMUNITYMEMBER (c_id, m_id)
values (281, 995273588);
insert into COMMUNITYMEMBER (c_id, m_id)
values (282, 645064381);
insert into COMMUNITYMEMBER (c_id, m_id)
values (282, 792482323);
insert into COMMUNITYMEMBER (c_id, m_id)
values (282, 952669174);
insert into COMMUNITYMEMBER (c_id, m_id)
values (283, 774685658);
insert into COMMUNITYMEMBER (c_id, m_id)
values (285, 612699405);
insert into COMMUNITYMEMBER (c_id, m_id)
values (285, 731631935);
insert into COMMUNITYMEMBER (c_id, m_id)
values (286, 492827855);
insert into COMMUNITYMEMBER (c_id, m_id)
values (286, 508814603);
insert into COMMUNITYMEMBER (c_id, m_id)
values (287, 418300944);
insert into COMMUNITYMEMBER (c_id, m_id)
values (287, 454248607);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 157482297);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 483122626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 511819336);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 680526159);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 871722354);
insert into COMMUNITYMEMBER (c_id, m_id)
values (288, 968243817);
insert into COMMUNITYMEMBER (c_id, m_id)
values (290, 856012405);
insert into COMMUNITYMEMBER (c_id, m_id)
values (291, 297102804);
insert into COMMUNITYMEMBER (c_id, m_id)
values (291, 773893260);
insert into COMMUNITYMEMBER (c_id, m_id)
values (293, 287920615);
insert into COMMUNITYMEMBER (c_id, m_id)
values (294, 233045254);
insert into COMMUNITYMEMBER (c_id, m_id)
values (295, 124420100);
insert into COMMUNITYMEMBER (c_id, m_id)
values (295, 187453014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (295, 347035403);
insert into COMMUNITYMEMBER (c_id, m_id)
values (295, 474646280);
insert into COMMUNITYMEMBER (c_id, m_id)
values (296, 380007079);
insert into COMMUNITYMEMBER (c_id, m_id)
values (297, 105762273);
insert into COMMUNITYMEMBER (c_id, m_id)
values (297, 490850485);
insert into COMMUNITYMEMBER (c_id, m_id)
values (297, 615586328);
insert into COMMUNITYMEMBER (c_id, m_id)
values (297, 666662014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (298, 209623814);
insert into COMMUNITYMEMBER (c_id, m_id)
values (298, 265633696);
insert into COMMUNITYMEMBER (c_id, m_id)
values (298, 304226614);
insert into COMMUNITYMEMBER (c_id, m_id)
values (298, 738218439);
insert into COMMUNITYMEMBER (c_id, m_id)
values (298, 844609510);
insert into COMMUNITYMEMBER (c_id, m_id)
values (299, 216352282);
insert into COMMUNITYMEMBER (c_id, m_id)
values (299, 382883037);
insert into COMMUNITYMEMBER (c_id, m_id)
values (299, 470423071);
insert into COMMUNITYMEMBER (c_id, m_id)
values (299, 891928720);
insert into COMMUNITYMEMBER (c_id, m_id)
values (299, 957537094);
insert into COMMUNITYMEMBER (c_id, m_id)
values (300, 643623729);
insert into COMMUNITYMEMBER (c_id, m_id)
values (300, 891928720);
insert into COMMUNITYMEMBER (c_id, m_id)
values (301, 271482442);
insert into COMMUNITYMEMBER (c_id, m_id)
values (302, 471939757);
insert into COMMUNITYMEMBER (c_id, m_id)
values (302, 642289450);
insert into COMMUNITYMEMBER (c_id, m_id)
values (302, 682245522);
insert into COMMUNITYMEMBER (c_id, m_id)
values (302, 837052178);
insert into COMMUNITYMEMBER (c_id, m_id)
values (303, 261358978);
insert into COMMUNITYMEMBER (c_id, m_id)
values (303, 914847250);
insert into COMMUNITYMEMBER (c_id, m_id)
values (304, 427084310);
insert into COMMUNITYMEMBER (c_id, m_id)
values (304, 492052662);
insert into COMMUNITYMEMBER (c_id, m_id)
values (304, 527686504);
insert into COMMUNITYMEMBER (c_id, m_id)
values (304, 879622687);
insert into COMMUNITYMEMBER (c_id, m_id)
values (304, 977848457);
insert into COMMUNITYMEMBER (c_id, m_id)
values (305, 349109407);
insert into COMMUNITYMEMBER (c_id, m_id)
values (305, 492827855);
insert into COMMUNITYMEMBER (c_id, m_id)
values (306, 116462353);
insert into COMMUNITYMEMBER (c_id, m_id)
values (306, 440396543);
insert into COMMUNITYMEMBER (c_id, m_id)
values (306, 449060241);
insert into COMMUNITYMEMBER (c_id, m_id)
values (306, 628747616);
insert into COMMUNITYMEMBER (c_id, m_id)
values (306, 770298802);
insert into COMMUNITYMEMBER (c_id, m_id)
values (307, 360000709);
insert into COMMUNITYMEMBER (c_id, m_id)
values (308, 512652034);
insert into COMMUNITYMEMBER (c_id, m_id)
values (308, 854958507);
insert into COMMUNITYMEMBER (c_id, m_id)
values (308, 872708693);
insert into COMMUNITYMEMBER (c_id, m_id)
values (309, 185360775);
insert into COMMUNITYMEMBER (c_id, m_id)
values (309, 532032180);
insert into COMMUNITYMEMBER (c_id, m_id)
values (309, 823928736);
insert into COMMUNITYMEMBER (c_id, m_id)
values (310, 301254976);
insert into COMMUNITYMEMBER (c_id, m_id)
values (310, 995273588);
insert into COMMUNITYMEMBER (c_id, m_id)
values (311, 414190148);
insert into COMMUNITYMEMBER (c_id, m_id)
values (311, 422056449);
insert into COMMUNITYMEMBER (c_id, m_id)
values (311, 926537995);
insert into COMMUNITYMEMBER (c_id, m_id)
values (312, 234029909);
insert into COMMUNITYMEMBER (c_id, m_id)
values (313, 541784559);
insert into COMMUNITYMEMBER (c_id, m_id)
values (313, 617533806);
insert into COMMUNITYMEMBER (c_id, m_id)
values (313, 902058409);
insert into COMMUNITYMEMBER (c_id, m_id)
values (314, 170305645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (314, 457561642);
insert into COMMUNITYMEMBER (c_id, m_id)
values (314, 666662014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (314, 802904951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (315, 708612515);
insert into COMMUNITYMEMBER (c_id, m_id)
values (315, 957537094);
insert into COMMUNITYMEMBER (c_id, m_id)
values (315, 984504236);
insert into COMMUNITYMEMBER (c_id, m_id)
values (316, 518048280);
insert into COMMUNITYMEMBER (c_id, m_id)
values (316, 527445580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (316, 742292557);
insert into COMMUNITYMEMBER (c_id, m_id)
values (317, 353145125);
insert into COMMUNITYMEMBER (c_id, m_id)
values (317, 773893260);
insert into COMMUNITYMEMBER (c_id, m_id)
values (319, 105490171);
insert into COMMUNITYMEMBER (c_id, m_id)
values (319, 357643935);
insert into COMMUNITYMEMBER (c_id, m_id)
values (319, 498768696);
insert into COMMUNITYMEMBER (c_id, m_id)
values (320, 279785948);
insert into COMMUNITYMEMBER (c_id, m_id)
values (320, 329158441);
commit;
prompt 500 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (320, 506915991);
insert into COMMUNITYMEMBER (c_id, m_id)
values (320, 753638601);
insert into COMMUNITYMEMBER (c_id, m_id)
values (320, 890819891);
insert into COMMUNITYMEMBER (c_id, m_id)
values (321, 338247817);
insert into COMMUNITYMEMBER (c_id, m_id)
values (321, 876495432);
insert into COMMUNITYMEMBER (c_id, m_id)
values (322, 242113481);
insert into COMMUNITYMEMBER (c_id, m_id)
values (322, 413834362);
insert into COMMUNITYMEMBER (c_id, m_id)
values (322, 527686504);
insert into COMMUNITYMEMBER (c_id, m_id)
values (323, 277855177);
insert into COMMUNITYMEMBER (c_id, m_id)
values (323, 388592218);
insert into COMMUNITYMEMBER (c_id, m_id)
values (324, 790221207);
insert into COMMUNITYMEMBER (c_id, m_id)
values (325, 715505955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (325, 775266141);
insert into COMMUNITYMEMBER (c_id, m_id)
values (326, 466988754);
insert into COMMUNITYMEMBER (c_id, m_id)
values (326, 611218507);
insert into COMMUNITYMEMBER (c_id, m_id)
values (326, 633701333);
insert into COMMUNITYMEMBER (c_id, m_id)
values (326, 737512334);
insert into COMMUNITYMEMBER (c_id, m_id)
values (326, 864487983);
insert into COMMUNITYMEMBER (c_id, m_id)
values (132, 197218839);
insert into COMMUNITYMEMBER (c_id, m_id)
values (132, 326694357);
insert into COMMUNITYMEMBER (c_id, m_id)
values (132, 425485955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (132, 451921990);
insert into COMMUNITYMEMBER (c_id, m_id)
values (133, 422056449);
insert into COMMUNITYMEMBER (c_id, m_id)
values (134, 553517298);
insert into COMMUNITYMEMBER (c_id, m_id)
values (136, 215499619);
insert into COMMUNITYMEMBER (c_id, m_id)
values (136, 251122348);
insert into COMMUNITYMEMBER (c_id, m_id)
values (136, 500813208);
insert into COMMUNITYMEMBER (c_id, m_id)
values (136, 517114536);
insert into COMMUNITYMEMBER (c_id, m_id)
values (136, 885568274);
insert into COMMUNITYMEMBER (c_id, m_id)
values (137, 359817344);
insert into COMMUNITYMEMBER (c_id, m_id)
values (137, 604494486);
insert into COMMUNITYMEMBER (c_id, m_id)
values (138, 180021901);
insert into COMMUNITYMEMBER (c_id, m_id)
values (139, 482986698);
insert into COMMUNITYMEMBER (c_id, m_id)
values (139, 514339325);
insert into COMMUNITYMEMBER (c_id, m_id)
values (139, 677269787);
insert into COMMUNITYMEMBER (c_id, m_id)
values (140, 816505821);
insert into COMMUNITYMEMBER (c_id, m_id)
values (140, 942515529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (141, 166217087);
insert into COMMUNITYMEMBER (c_id, m_id)
values (141, 457561642);
insert into COMMUNITYMEMBER (c_id, m_id)
values (141, 841499510);
insert into COMMUNITYMEMBER (c_id, m_id)
values (142, 193367254);
insert into COMMUNITYMEMBER (c_id, m_id)
values (142, 310735882);
insert into COMMUNITYMEMBER (c_id, m_id)
values (142, 806840454);
insert into COMMUNITYMEMBER (c_id, m_id)
values (143, 970123677);
insert into COMMUNITYMEMBER (c_id, m_id)
values (144, 471686465);
insert into COMMUNITYMEMBER (c_id, m_id)
values (144, 902558637);
insert into COMMUNITYMEMBER (c_id, m_id)
values (145, 108592361);
insert into COMMUNITYMEMBER (c_id, m_id)
values (145, 153649997);
insert into COMMUNITYMEMBER (c_id, m_id)
values (145, 178737651);
insert into COMMUNITYMEMBER (c_id, m_id)
values (145, 360115867);
insert into COMMUNITYMEMBER (c_id, m_id)
values (145, 768831807);
insert into COMMUNITYMEMBER (c_id, m_id)
values (146, 284519851);
insert into COMMUNITYMEMBER (c_id, m_id)
values (146, 578729163);
insert into COMMUNITYMEMBER (c_id, m_id)
values (146, 643181374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (146, 942044626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (147, 500813208);
insert into COMMUNITYMEMBER (c_id, m_id)
values (147, 931697691);
insert into COMMUNITYMEMBER (c_id, m_id)
values (148, 660043671);
insert into COMMUNITYMEMBER (c_id, m_id)
values (149, 471686465);
insert into COMMUNITYMEMBER (c_id, m_id)
values (149, 778935652);
insert into COMMUNITYMEMBER (c_id, m_id)
values (150, 326809666);
insert into COMMUNITYMEMBER (c_id, m_id)
values (150, 648581103);
insert into COMMUNITYMEMBER (c_id, m_id)
values (150, 818499054);
insert into COMMUNITYMEMBER (c_id, m_id)
values (151, 149248623);
insert into COMMUNITYMEMBER (c_id, m_id)
values (151, 576647580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (153, 402986300);
insert into COMMUNITYMEMBER (c_id, m_id)
values (153, 936769324);
insert into COMMUNITYMEMBER (c_id, m_id)
values (155, 839691671);
insert into COMMUNITYMEMBER (c_id, m_id)
values (156, 454248607);
insert into COMMUNITYMEMBER (c_id, m_id)
values (156, 470423071);
insert into COMMUNITYMEMBER (c_id, m_id)
values (156, 806611140);
insert into COMMUNITYMEMBER (c_id, m_id)
values (156, 895943487);
insert into COMMUNITYMEMBER (c_id, m_id)
values (157, 242113481);
insert into COMMUNITYMEMBER (c_id, m_id)
values (157, 382883037);
insert into COMMUNITYMEMBER (c_id, m_id)
values (157, 443991351);
insert into COMMUNITYMEMBER (c_id, m_id)
values (157, 449060241);
insert into COMMUNITYMEMBER (c_id, m_id)
values (158, 451171514);
insert into COMMUNITYMEMBER (c_id, m_id)
values (158, 858616442);
insert into COMMUNITYMEMBER (c_id, m_id)
values (158, 953132895);
insert into COMMUNITYMEMBER (c_id, m_id)
values (159, 681850365);
insert into COMMUNITYMEMBER (c_id, m_id)
values (159, 943569264);
insert into COMMUNITYMEMBER (c_id, m_id)
values (160, 250253966);
insert into COMMUNITYMEMBER (c_id, m_id)
values (160, 543909374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (160, 611314031);
insert into COMMUNITYMEMBER (c_id, m_id)
values (160, 638404454);
insert into COMMUNITYMEMBER (c_id, m_id)
values (160, 666288551);
insert into COMMUNITYMEMBER (c_id, m_id)
values (161, 138567468);
insert into COMMUNITYMEMBER (c_id, m_id)
values (162, 428983287);
insert into COMMUNITYMEMBER (c_id, m_id)
values (162, 454248607);
insert into COMMUNITYMEMBER (c_id, m_id)
values (162, 509387616);
insert into COMMUNITYMEMBER (c_id, m_id)
values (162, 764463799);
insert into COMMUNITYMEMBER (c_id, m_id)
values (162, 854958507);
insert into COMMUNITYMEMBER (c_id, m_id)
values (163, 238002042);
insert into COMMUNITYMEMBER (c_id, m_id)
values (163, 267556727);
insert into COMMUNITYMEMBER (c_id, m_id)
values (163, 353145125);
insert into COMMUNITYMEMBER (c_id, m_id)
values (163, 728382339);
insert into COMMUNITYMEMBER (c_id, m_id)
values (163, 915559018);
insert into COMMUNITYMEMBER (c_id, m_id)
values (164, 177277974);
insert into COMMUNITYMEMBER (c_id, m_id)
values (164, 686236374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (164, 837052178);
commit;
prompt 600 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (166, 481788951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (166, 506994358);
insert into COMMUNITYMEMBER (c_id, m_id)
values (166, 896975711);
insert into COMMUNITYMEMBER (c_id, m_id)
values (167, 696579829);
insert into COMMUNITYMEMBER (c_id, m_id)
values (168, 549920959);
insert into COMMUNITYMEMBER (c_id, m_id)
values (168, 738218439);
insert into COMMUNITYMEMBER (c_id, m_id)
values (169, 157820082);
insert into COMMUNITYMEMBER (c_id, m_id)
values (170, 104602934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (170, 118236069);
insert into COMMUNITYMEMBER (c_id, m_id)
values (170, 936769324);
insert into COMMUNITYMEMBER (c_id, m_id)
values (170, 982076921);
insert into COMMUNITYMEMBER (c_id, m_id)
values (171, 407652575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (171, 488864046);
insert into COMMUNITYMEMBER (c_id, m_id)
values (171, 982854200);
insert into COMMUNITYMEMBER (c_id, m_id)
values (172, 190360834);
insert into COMMUNITYMEMBER (c_id, m_id)
values (172, 193082739);
insert into COMMUNITYMEMBER (c_id, m_id)
values (172, 526438708);
insert into COMMUNITYMEMBER (c_id, m_id)
values (172, 944530975);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 105836606);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 236023849);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 254571947);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 480996732);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 484656686);
insert into COMMUNITYMEMBER (c_id, m_id)
values (173, 724109514);
insert into COMMUNITYMEMBER (c_id, m_id)
values (174, 263723091);
insert into COMMUNITYMEMBER (c_id, m_id)
values (174, 476772296);
insert into COMMUNITYMEMBER (c_id, m_id)
values (175, 107286193);
insert into COMMUNITYMEMBER (c_id, m_id)
values (175, 527125810);
insert into COMMUNITYMEMBER (c_id, m_id)
values (175, 648872364);
insert into COMMUNITYMEMBER (c_id, m_id)
values (175, 967115372);
insert into COMMUNITYMEMBER (c_id, m_id)
values (176, 287920615);
insert into COMMUNITYMEMBER (c_id, m_id)
values (176, 714440128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (177, 146897612);
insert into COMMUNITYMEMBER (c_id, m_id)
values (177, 481552416);
insert into COMMUNITYMEMBER (c_id, m_id)
values (177, 792482323);
insert into COMMUNITYMEMBER (c_id, m_id)
values (178, 377729240);
insert into COMMUNITYMEMBER (c_id, m_id)
values (178, 496967655);
insert into COMMUNITYMEMBER (c_id, m_id)
values (178, 715916459);
insert into COMMUNITYMEMBER (c_id, m_id)
values (179, 254392497);
insert into COMMUNITYMEMBER (c_id, m_id)
values (179, 300117638);
insert into COMMUNITYMEMBER (c_id, m_id)
values (179, 370249439);
insert into COMMUNITYMEMBER (c_id, m_id)
values (179, 815488313);
insert into COMMUNITYMEMBER (c_id, m_id)
values (179, 912774864);
insert into COMMUNITYMEMBER (c_id, m_id)
values (180, 788322275);
insert into COMMUNITYMEMBER (c_id, m_id)
values (181, 612546655);
insert into COMMUNITYMEMBER (c_id, m_id)
values (182, 364028941);
insert into COMMUNITYMEMBER (c_id, m_id)
values (182, 484656686);
insert into COMMUNITYMEMBER (c_id, m_id)
values (182, 753413531);
insert into COMMUNITYMEMBER (c_id, m_id)
values (183, 157482297);
insert into COMMUNITYMEMBER (c_id, m_id)
values (183, 547079702);
insert into COMMUNITYMEMBER (c_id, m_id)
values (183, 594728451);
insert into COMMUNITYMEMBER (c_id, m_id)
values (183, 818499054);
insert into COMMUNITYMEMBER (c_id, m_id)
values (183, 906671114);
insert into COMMUNITYMEMBER (c_id, m_id)
values (184, 615928170);
insert into COMMUNITYMEMBER (c_id, m_id)
values (185, 811595988);
insert into COMMUNITYMEMBER (c_id, m_id)
values (185, 891928720);
insert into COMMUNITYMEMBER (c_id, m_id)
values (185, 901702266);
insert into COMMUNITYMEMBER (c_id, m_id)
values (186, 208673611);
insert into COMMUNITYMEMBER (c_id, m_id)
values (186, 314544963);
insert into COMMUNITYMEMBER (c_id, m_id)
values (186, 747163297);
insert into COMMUNITYMEMBER (c_id, m_id)
values (187, 216352282);
insert into COMMUNITYMEMBER (c_id, m_id)
values (187, 273451063);
insert into COMMUNITYMEMBER (c_id, m_id)
values (187, 410929065);
insert into COMMUNITYMEMBER (c_id, m_id)
values (187, 545493618);
insert into COMMUNITYMEMBER (c_id, m_id)
values (187, 942044626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (188, 193367254);
insert into COMMUNITYMEMBER (c_id, m_id)
values (188, 731977144);
insert into COMMUNITYMEMBER (c_id, m_id)
values (188, 926537995);
insert into COMMUNITYMEMBER (c_id, m_id)
values (189, 124420100);
insert into COMMUNITYMEMBER (c_id, m_id)
values (189, 682245522);
insert into COMMUNITYMEMBER (c_id, m_id)
values (190, 206312322);
insert into COMMUNITYMEMBER (c_id, m_id)
values (190, 267556727);
insert into COMMUNITYMEMBER (c_id, m_id)
values (191, 360000709);
insert into COMMUNITYMEMBER (c_id, m_id)
values (191, 532032180);
insert into COMMUNITYMEMBER (c_id, m_id)
values (192, 805558047);
insert into COMMUNITYMEMBER (c_id, m_id)
values (192, 856012405);
insert into COMMUNITYMEMBER (c_id, m_id)
values (193, 284087405);
insert into COMMUNITYMEMBER (c_id, m_id)
values (194, 274807987);
insert into COMMUNITYMEMBER (c_id, m_id)
values (194, 339493176);
insert into COMMUNITYMEMBER (c_id, m_id)
values (194, 349109407);
insert into COMMUNITYMEMBER (c_id, m_id)
values (194, 549199038);
insert into COMMUNITYMEMBER (c_id, m_id)
values (194, 872708693);
insert into COMMUNITYMEMBER (c_id, m_id)
values (195, 527445580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (196, 779764377);
insert into COMMUNITYMEMBER (c_id, m_id)
values (197, 138503193);
insert into COMMUNITYMEMBER (c_id, m_id)
values (197, 480996732);
insert into COMMUNITYMEMBER (c_id, m_id)
values (197, 577904602);
insert into COMMUNITYMEMBER (c_id, m_id)
values (197, 607668294);
insert into COMMUNITYMEMBER (c_id, m_id)
values (198, 744764697);
insert into COMMUNITYMEMBER (c_id, m_id)
values (198, 834129951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (198, 995849472);
insert into COMMUNITYMEMBER (c_id, m_id)
values (199, 433173537);
insert into COMMUNITYMEMBER (c_id, m_id)
values (199, 660043671);
insert into COMMUNITYMEMBER (c_id, m_id)
values (200, 166897367);
insert into COMMUNITYMEMBER (c_id, m_id)
values (200, 506994358);
insert into COMMUNITYMEMBER (c_id, m_id)
values (200, 765327686);
insert into COMMUNITYMEMBER (c_id, m_id)
values (202, 366632145);
insert into COMMUNITYMEMBER (c_id, m_id)
values (202, 418481619);
insert into COMMUNITYMEMBER (c_id, m_id)
values (202, 497672990);
insert into COMMUNITYMEMBER (c_id, m_id)
values (202, 576647580);
commit;
prompt 700 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (202, 737627430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (203, 775317838);
insert into COMMUNITYMEMBER (c_id, m_id)
values (204, 214684922);
insert into COMMUNITYMEMBER (c_id, m_id)
values (204, 218193438);
insert into COMMUNITYMEMBER (c_id, m_id)
values (204, 580351317);
insert into COMMUNITYMEMBER (c_id, m_id)
values (205, 402230125);
insert into COMMUNITYMEMBER (c_id, m_id)
values (205, 554661104);
insert into COMMUNITYMEMBER (c_id, m_id)
values (207, 104602934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (207, 215457724);
insert into COMMUNITYMEMBER (c_id, m_id)
values (208, 431546217);
insert into COMMUNITYMEMBER (c_id, m_id)
values (208, 639121639);
insert into COMMUNITYMEMBER (c_id, m_id)
values (208, 895629963);
insert into COMMUNITYMEMBER (c_id, m_id)
values (209, 133984187);
insert into COMMUNITYMEMBER (c_id, m_id)
values (209, 396469378);
insert into COMMUNITYMEMBER (c_id, m_id)
values (209, 733424841);
insert into COMMUNITYMEMBER (c_id, m_id)
values (210, 442274284);
insert into COMMUNITYMEMBER (c_id, m_id)
values (210, 445960804);
insert into COMMUNITYMEMBER (c_id, m_id)
values (210, 849633047);
insert into COMMUNITYMEMBER (c_id, m_id)
values (210, 952669174);
insert into COMMUNITYMEMBER (c_id, m_id)
values (211, 251279284);
insert into COMMUNITYMEMBER (c_id, m_id)
values (212, 244957874);
insert into COMMUNITYMEMBER (c_id, m_id)
values (212, 347912421);
insert into COMMUNITYMEMBER (c_id, m_id)
values (212, 410001958);
insert into COMMUNITYMEMBER (c_id, m_id)
values (212, 798624234);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 240771738);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 315016381);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 529508663);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 532306379);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 653939281);
insert into COMMUNITYMEMBER (c_id, m_id)
values (213, 860551807);
insert into COMMUNITYMEMBER (c_id, m_id)
values (214, 208673611);
insert into COMMUNITYMEMBER (c_id, m_id)
values (214, 931697691);
insert into COMMUNITYMEMBER (c_id, m_id)
values (215, 399077464);
insert into COMMUNITYMEMBER (c_id, m_id)
values (215, 432667348);
insert into COMMUNITYMEMBER (c_id, m_id)
values (215, 522734503);
insert into COMMUNITYMEMBER (c_id, m_id)
values (216, 174074529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (216, 449337529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (217, 146897612);
insert into COMMUNITYMEMBER (c_id, m_id)
values (217, 173927735);
insert into COMMUNITYMEMBER (c_id, m_id)
values (217, 727479428);
insert into COMMUNITYMEMBER (c_id, m_id)
values (217, 776623460);
insert into COMMUNITYMEMBER (c_id, m_id)
values (218, 213253770);
insert into COMMUNITYMEMBER (c_id, m_id)
values (218, 994167808);
insert into COMMUNITYMEMBER (c_id, m_id)
values (219, 105762273);
insert into COMMUNITYMEMBER (c_id, m_id)
values (220, 173927735);
insert into COMMUNITYMEMBER (c_id, m_id)
values (220, 456215620);
insert into COMMUNITYMEMBER (c_id, m_id)
values (220, 465156888);
insert into COMMUNITYMEMBER (c_id, m_id)
values (220, 834129951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (221, 276224889);
insert into COMMUNITYMEMBER (c_id, m_id)
values (221, 839691671);
insert into COMMUNITYMEMBER (c_id, m_id)
values (222, 133984187);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 194549335);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 197218839);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 399077464);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 399864090);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 410929065);
insert into COMMUNITYMEMBER (c_id, m_id)
values (223, 747428052);
insert into COMMUNITYMEMBER (c_id, m_id)
values (224, 297288231);
insert into COMMUNITYMEMBER (c_id, m_id)
values (224, 715916459);
insert into COMMUNITYMEMBER (c_id, m_id)
values (225, 193367254);
insert into COMMUNITYMEMBER (c_id, m_id)
values (225, 524148126);
insert into COMMUNITYMEMBER (c_id, m_id)
values (226, 170305645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (226, 997569877);
insert into COMMUNITYMEMBER (c_id, m_id)
values (228, 105490171);
insert into COMMUNITYMEMBER (c_id, m_id)
values (228, 343015765);
insert into COMMUNITYMEMBER (c_id, m_id)
values (228, 458125190);
insert into COMMUNITYMEMBER (c_id, m_id)
values (228, 971401539);
insert into COMMUNITYMEMBER (c_id, m_id)
values (228, 993619075);
insert into COMMUNITYMEMBER (c_id, m_id)
values (229, 889678021);
insert into COMMUNITYMEMBER (c_id, m_id)
values (230, 366632145);
insert into COMMUNITYMEMBER (c_id, m_id)
values (230, 600244770);
insert into COMMUNITYMEMBER (c_id, m_id)
values (230, 639121639);
insert into COMMUNITYMEMBER (c_id, m_id)
values (230, 773608536);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 116069857);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 120818128);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 216264525);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 369293915);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 514339325);
insert into COMMUNITYMEMBER (c_id, m_id)
values (231, 553517298);
insert into COMMUNITYMEMBER (c_id, m_id)
values (233, 441896465);
insert into COMMUNITYMEMBER (c_id, m_id)
values (233, 557605097);
insert into COMMUNITYMEMBER (c_id, m_id)
values (327, 532306379);
insert into COMMUNITYMEMBER (c_id, m_id)
values (327, 925270311);
insert into COMMUNITYMEMBER (c_id, m_id)
values (327, 989941934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (327, 994167808);
insert into COMMUNITYMEMBER (c_id, m_id)
values (328, 798624234);
insert into COMMUNITYMEMBER (c_id, m_id)
values (328, 996862753);
insert into COMMUNITYMEMBER (c_id, m_id)
values (329, 488283015);
insert into COMMUNITYMEMBER (c_id, m_id)
values (329, 944613878);
insert into COMMUNITYMEMBER (c_id, m_id)
values (330, 400057384);
insert into COMMUNITYMEMBER (c_id, m_id)
values (330, 738839959);
insert into COMMUNITYMEMBER (c_id, m_id)
values (330, 837052178);
insert into COMMUNITYMEMBER (c_id, m_id)
values (331, 104602934);
insert into COMMUNITYMEMBER (c_id, m_id)
values (331, 120024694);
insert into COMMUNITYMEMBER (c_id, m_id)
values (331, 215457724);
insert into COMMUNITYMEMBER (c_id, m_id)
values (331, 494960174);
insert into COMMUNITYMEMBER (c_id, m_id)
values (331, 846842975);
insert into COMMUNITYMEMBER (c_id, m_id)
values (332, 251122348);
insert into COMMUNITYMEMBER (c_id, m_id)
values (332, 666288551);
insert into COMMUNITYMEMBER (c_id, m_id)
values (332, 773608536);
commit;
prompt 800 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (332, 864487983);
insert into COMMUNITYMEMBER (c_id, m_id)
values (333, 175567621);
insert into COMMUNITYMEMBER (c_id, m_id)
values (334, 343057735);
insert into COMMUNITYMEMBER (c_id, m_id)
values (334, 885809424);
insert into COMMUNITYMEMBER (c_id, m_id)
values (334, 892581778);
insert into COMMUNITYMEMBER (c_id, m_id)
values (335, 124420100);
insert into COMMUNITYMEMBER (c_id, m_id)
values (335, 174074529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (335, 259923743);
insert into COMMUNITYMEMBER (c_id, m_id)
values (336, 438150346);
insert into COMMUNITYMEMBER (c_id, m_id)
values (336, 694034701);
insert into COMMUNITYMEMBER (c_id, m_id)
values (336, 844165456);
insert into COMMUNITYMEMBER (c_id, m_id)
values (336, 971185840);
insert into COMMUNITYMEMBER (c_id, m_id)
values (337, 182765780);
insert into COMMUNITYMEMBER (c_id, m_id)
values (337, 505151181);
insert into COMMUNITYMEMBER (c_id, m_id)
values (337, 729277013);
insert into COMMUNITYMEMBER (c_id, m_id)
values (337, 879054575);
insert into COMMUNITYMEMBER (c_id, m_id)
values (338, 359211432);
insert into COMMUNITYMEMBER (c_id, m_id)
values (338, 527445580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (339, 238002042);
insert into COMMUNITYMEMBER (c_id, m_id)
values (339, 437525444);
insert into COMMUNITYMEMBER (c_id, m_id)
values (340, 263723091);
insert into COMMUNITYMEMBER (c_id, m_id)
values (340, 422056449);
insert into COMMUNITYMEMBER (c_id, m_id)
values (340, 570993504);
insert into COMMUNITYMEMBER (c_id, m_id)
values (340, 826802360);
insert into COMMUNITYMEMBER (c_id, m_id)
values (341, 233045254);
insert into COMMUNITYMEMBER (c_id, m_id)
values (341, 549199038);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 182055053);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 463440005);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 591082304);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 685494264);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 741076529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 802904951);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 811695961);
insert into COMMUNITYMEMBER (c_id, m_id)
values (342, 942515529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (343, 257691173);
insert into COMMUNITYMEMBER (c_id, m_id)
values (343, 476308716);
insert into COMMUNITYMEMBER (c_id, m_id)
values (343, 885521932);
insert into COMMUNITYMEMBER (c_id, m_id)
values (343, 887429256);
insert into COMMUNITYMEMBER (c_id, m_id)
values (344, 551526087);
insert into COMMUNITYMEMBER (c_id, m_id)
values (344, 785952021);
insert into COMMUNITYMEMBER (c_id, m_id)
values (345, 140359430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (345, 449060241);
insert into COMMUNITYMEMBER (c_id, m_id)
values (345, 619980182);
insert into COMMUNITYMEMBER (c_id, m_id)
values (345, 682573186);
insert into COMMUNITYMEMBER (c_id, m_id)
values (345, 829260788);
insert into COMMUNITYMEMBER (c_id, m_id)
values (347, 174600853);
insert into COMMUNITYMEMBER (c_id, m_id)
values (348, 205397955);
insert into COMMUNITYMEMBER (c_id, m_id)
values (348, 643623729);
insert into COMMUNITYMEMBER (c_id, m_id)
values (349, 105283129);
insert into COMMUNITYMEMBER (c_id, m_id)
values (349, 233791357);
insert into COMMUNITYMEMBER (c_id, m_id)
values (349, 485506309);
insert into COMMUNITYMEMBER (c_id, m_id)
values (349, 816505320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (349, 892744392);
insert into COMMUNITYMEMBER (c_id, m_id)
values (350, 742612917);
insert into COMMUNITYMEMBER (c_id, m_id)
values (351, 164659178);
insert into COMMUNITYMEMBER (c_id, m_id)
values (351, 543909374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 100148653);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 293210110);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 476772296);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 522099376);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 775317838);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 841499510);
insert into COMMUNITYMEMBER (c_id, m_id)
values (352, 871846808);
insert into COMMUNITYMEMBER (c_id, m_id)
values (353, 449140830);
insert into COMMUNITYMEMBER (c_id, m_id)
values (353, 492313313);
insert into COMMUNITYMEMBER (c_id, m_id)
values (353, 720417144);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 107444785);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 108592361);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 183639285);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 388592218);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 482986698);
insert into COMMUNITYMEMBER (c_id, m_id)
values (354, 763635580);
insert into COMMUNITYMEMBER (c_id, m_id)
values (355, 240089876);
insert into COMMUNITYMEMBER (c_id, m_id)
values (355, 441896465);
insert into COMMUNITYMEMBER (c_id, m_id)
values (355, 669449784);
insert into COMMUNITYMEMBER (c_id, m_id)
values (355, 722081406);
insert into COMMUNITYMEMBER (c_id, m_id)
values (355, 925234625);
insert into COMMUNITYMEMBER (c_id, m_id)
values (356, 453064263);
insert into COMMUNITYMEMBER (c_id, m_id)
values (356, 729277013);
insert into COMMUNITYMEMBER (c_id, m_id)
values (357, 885450349);
insert into COMMUNITYMEMBER (c_id, m_id)
values (358, 159358320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (358, 696812757);
insert into COMMUNITYMEMBER (c_id, m_id)
values (358, 789430577);
insert into COMMUNITYMEMBER (c_id, m_id)
values (359, 359211432);
insert into COMMUNITYMEMBER (c_id, m_id)
values (359, 361791170);
insert into COMMUNITYMEMBER (c_id, m_id)
values (359, 722932897);
insert into COMMUNITYMEMBER (c_id, m_id)
values (360, 159358320);
insert into COMMUNITYMEMBER (c_id, m_id)
values (360, 370498675);
insert into COMMUNITYMEMBER (c_id, m_id)
values (361, 467965675);
insert into COMMUNITYMEMBER (c_id, m_id)
values (361, 611218507);
insert into COMMUNITYMEMBER (c_id, m_id)
values (361, 685494264);
insert into COMMUNITYMEMBER (c_id, m_id)
values (361, 693685227);
insert into COMMUNITYMEMBER (c_id, m_id)
values (362, 327370740);
insert into COMMUNITYMEMBER (c_id, m_id)
values (362, 738309645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (362, 846802745);
insert into COMMUNITYMEMBER (c_id, m_id)
values (363, 138503193);
insert into COMMUNITYMEMBER (c_id, m_id)
values (363, 139741096);
insert into COMMUNITYMEMBER (c_id, m_id)
values (363, 518048280);
insert into COMMUNITYMEMBER (c_id, m_id)
values (364, 244957874);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 274807987);
commit;
prompt 900 records committed...
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 444008216);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 617533806);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 651855962);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 724109514);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 794342149);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 907424842);
insert into COMMUNITYMEMBER (c_id, m_id)
values (365, 978293260);
insert into COMMUNITYMEMBER (c_id, m_id)
values (366, 279868753);
insert into COMMUNITYMEMBER (c_id, m_id)
values (366, 999257848);
insert into COMMUNITYMEMBER (c_id, m_id)
values (367, 140359430);
insert into COMMUNITYMEMBER (c_id, m_id)
values (368, 513603889);
insert into COMMUNITYMEMBER (c_id, m_id)
values (368, 751419335);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 120024694);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 443991351);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 579654604);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 701139371);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 702330680);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 815488313);
insert into COMMUNITYMEMBER (c_id, m_id)
values (369, 981543943);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 204794274);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 441696270);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 444894245);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 488283015);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 864487983);
insert into COMMUNITYMEMBER (c_id, m_id)
values (370, 942044626);
insert into COMMUNITYMEMBER (c_id, m_id)
values (371, 193082739);
insert into COMMUNITYMEMBER (c_id, m_id)
values (371, 744764697);
insert into COMMUNITYMEMBER (c_id, m_id)
values (372, 858481074);
insert into COMMUNITYMEMBER (c_id, m_id)
values (372, 895629963);
insert into COMMUNITYMEMBER (c_id, m_id)
values (373, 112292585);
insert into COMMUNITYMEMBER (c_id, m_id)
values (373, 581307727);
insert into COMMUNITYMEMBER (c_id, m_id)
values (374, 228056872);
insert into COMMUNITYMEMBER (c_id, m_id)
values (374, 496967655);
insert into COMMUNITYMEMBER (c_id, m_id)
values (374, 543909374);
insert into COMMUNITYMEMBER (c_id, m_id)
values (375, 885450349);
insert into COMMUNITYMEMBER (c_id, m_id)
values (376, 208196098);
insert into COMMUNITYMEMBER (c_id, m_id)
values (376, 527280153);
insert into COMMUNITYMEMBER (c_id, m_id)
values (376, 919043255);
insert into COMMUNITYMEMBER (c_id, m_id)
values (377, 829260788);
insert into COMMUNITYMEMBER (c_id, m_id)
values (378, 165069233);
insert into COMMUNITYMEMBER (c_id, m_id)
values (378, 532306379);
insert into COMMUNITYMEMBER (c_id, m_id)
values (379, 187453014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (379, 242113481);
insert into COMMUNITYMEMBER (c_id, m_id)
values (379, 829260788);
insert into COMMUNITYMEMBER (c_id, m_id)
values (380, 141926107);
insert into COMMUNITYMEMBER (c_id, m_id)
values (380, 476772296);
insert into COMMUNITYMEMBER (c_id, m_id)
values (380, 945019903);
insert into COMMUNITYMEMBER (c_id, m_id)
values (381, 126517000);
insert into COMMUNITYMEMBER (c_id, m_id)
values (381, 860545515);
insert into COMMUNITYMEMBER (c_id, m_id)
values (382, 962072334);
insert into COMMUNITYMEMBER (c_id, m_id)
values (383, 682573186);
insert into COMMUNITYMEMBER (c_id, m_id)
values (383, 785974864);
insert into COMMUNITYMEMBER (c_id, m_id)
values (384, 185794095);
insert into COMMUNITYMEMBER (c_id, m_id)
values (384, 299747885);
insert into COMMUNITYMEMBER (c_id, m_id)
values (384, 390050758);
insert into COMMUNITYMEMBER (c_id, m_id)
values (384, 723305141);
insert into COMMUNITYMEMBER (c_id, m_id)
values (385, 715916459);
insert into COMMUNITYMEMBER (c_id, m_id)
values (386, 115967722);
insert into COMMUNITYMEMBER (c_id, m_id)
values (386, 143766014);
insert into COMMUNITYMEMBER (c_id, m_id)
values (386, 351699289);
insert into COMMUNITYMEMBER (c_id, m_id)
values (386, 566318538);
insert into COMMUNITYMEMBER (c_id, m_id)
values (387, 318609792);
insert into COMMUNITYMEMBER (c_id, m_id)
values (387, 942515529);
insert into COMMUNITYMEMBER (c_id, m_id)
values (388, 902558637);
insert into COMMUNITYMEMBER (c_id, m_id)
values (389, 107286193);
insert into COMMUNITYMEMBER (c_id, m_id)
values (389, 170305645);
insert into COMMUNITYMEMBER (c_id, m_id)
values (389, 301145806);
insert into COMMUNITYMEMBER (c_id, m_id)
values (390, 375034734);
insert into COMMUNITYMEMBER (c_id, m_id)
values (391, 157820082);
insert into COMMUNITYMEMBER (c_id, m_id)
values (391, 448882818);
insert into COMMUNITYMEMBER (c_id, m_id)
values (391, 763909026);
insert into COMMUNITYMEMBER (c_id, m_id)
values (391, 775317838);
insert into COMMUNITYMEMBER (c_id, m_id)
values (391, 907424842);
insert into COMMUNITYMEMBER (c_id, m_id)
values (392, 305478453);
insert into COMMUNITYMEMBER (c_id, m_id)
values (392, 484656686);
insert into COMMUNITYMEMBER (c_id, m_id)
values (394, 124420100);
insert into COMMUNITYMEMBER (c_id, m_id)
values (394, 471939757);
insert into COMMUNITYMEMBER (c_id, m_id)
values (394, 648872364);
insert into COMMUNITYMEMBER (c_id, m_id)
values (394, 727479428);
insert into COMMUNITYMEMBER (c_id, m_id)
values (395, 720258585);
insert into COMMUNITYMEMBER (c_id, m_id)
values (395, 917191761);
insert into COMMUNITYMEMBER (c_id, m_id)
values (396, 138503193);
insert into COMMUNITYMEMBER (c_id, m_id)
values (396, 259933017);
insert into COMMUNITYMEMBER (c_id, m_id)
values (396, 515439710);
insert into COMMUNITYMEMBER (c_id, m_id)
values (396, 619987847);
insert into COMMUNITYMEMBER (c_id, m_id)
values (397, 309169041);
insert into COMMUNITYMEMBER (c_id, m_id)
values (397, 774685658);
insert into COMMUNITYMEMBER (c_id, m_id)
values (397, 910680191);
insert into COMMUNITYMEMBER (c_id, m_id)
values (398, 401709948);
insert into COMMUNITYMEMBER (c_id, m_id)
values (398, 917191761);
insert into COMMUNITYMEMBER (c_id, m_id)
values (399, 358818051);
insert into COMMUNITYMEMBER (c_id, m_id)
values (399, 547111578);
insert into COMMUNITYMEMBER (c_id, m_id)
values (399, 775317838);
insert into COMMUNITYMEMBER (c_id, m_id)
values (400, 165069233);
insert into COMMUNITYMEMBER (c_id, m_id)
values (400, 527280153);
insert into COMMUNITYMEMBER (c_id, m_id)
values (400, 619767996);
commit;
prompt 996 records loaded
prompt Loading CONSULTING...
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 5, 746398682);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 3, 454248607);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 4, 654360049);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 5, 816505821);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 7, 992615606);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 2, 638404454);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 1, 693685227);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 3, 677269787);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 3, 297102804);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 4, 734366943);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 4, 237075795);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 8, 840341264);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 4, 209623814);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 5, 926497407);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 6, 234029909);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 10, 107286193);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 10, 310279833);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 2, 694803403);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 3, 524148126);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 4, 640098230);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 7, 779283595);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 9, 609774041);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 6, 538534007);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 9, 685494264);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 10, 440671201);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 945448417);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 10, 981543943);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 7, 768584445);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 3, 190360834);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 6, 834129951);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 3, 823928736);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 2, 488283015);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 9, 370571857);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 1, 876541800);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 2, 753024805);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 2, 672677177);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 1, 185360775);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 5, 226019979);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 496859662);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 9, 851431384);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 6, 854958507);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 3, 901120266);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 2, 299747885);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 4, 958863687);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 3, 644116143);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 3, 182765780);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 3, 915559018);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 8, 901502896);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 2, 274715538);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 3, 282560191);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 4, 331919904);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 7, 966881718);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 5, 847523648);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 10, 339493176);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 3, 466988754);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 2, 996862753);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 4, 557466349);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 6, 388592218);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 2, 372489438);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 4, 861070252);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 4, 439190057);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 10, 968243817);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 10, 351074926);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 9, 402986300);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 7, 197218839);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 474353737);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 3, 579018697);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 10, 446811236);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 1, 734673425);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 4, 215499619);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 9, 559292166);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 10, 682573186);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 4, 181676281);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 1, 480996732);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 5, 251122348);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 8, 154242474);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 2, 300117638);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 2, 485862308);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 200188458);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 3, 518817006);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 6, 816391512);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 10, 221497111);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 182055053);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 234814837);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 10, 578729163);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 3, 698624693);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 3, 478438487);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 8, 962096973);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 2, 346192718);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 2, 878452649);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 3, 428983287);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 6, 816251377);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 9, 888269770);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 329158441);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 3, 789087097);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 6, 448882818);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 10, 492052662);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 8, 473903044);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 8, 166897367);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 10, 509387616);
commit;
prompt 100 records committed...
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 10, 107444785);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 7, 598623933);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 8, 848489360);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 10, 858481074);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 3, 396481548);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 3, 583838247);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 4, 487796197);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 8, 233791357);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 670693235);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 4, 850393521);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 3, 273451063);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 4, 388509855);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 4, 617533806);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 10, 357723571);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 8, 258945756);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 5, 832343421);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 1, 177060427);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 7, 942515529);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 8, 408789796);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 7, 880283169);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 2, 458125190);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 443991351);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 3, 215074393);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 8, 781922286);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 2, 911869430);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 10, 672929772);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 9, 310735882);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 4, 759277745);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 2, 918190109);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 9, 995849472);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 438885298);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 10, 557714154);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 7, 466239135);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 725612282);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 158783600);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 9, 763635580);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 6, 118236069);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 4, 926537995);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 108592361);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 1, 205397955);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 739747358);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 4, 612546655);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 165069233);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 8, 854805518);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 7, 817026839);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 1, 474646280);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 9, 566408163);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 1, 687464649);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 3, 919043255);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 2, 386928076);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 10, 925270311);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 4, 402230125);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 737512334);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 9, 498521987);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 995273588);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 4, 271296079);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 7, 572028348);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 8, 306244196);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 2, 902058409);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 3, 738309645);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 254647820);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 5, 265633696);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 9, 940067704);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 3, 481552416);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 4, 565469376);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 6, 560105519);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 7, 467965675);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 2, 317144977);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 10, 185101463);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 7, 805558047);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 871846808);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 10, 428745222);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 4, 672588466);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 4, 391598548);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 7, 116462353);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 1, 685512872);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 5, 222417749);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 5, 175441465);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 1, 396469378);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 9, 149248623);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 8, 407933782);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 4, 479537259);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 10, 815054512);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 897443171);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 7, 108400326);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 3, 542084528);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 9, 998764869);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 5, 738218439);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 5, 440396543);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 5, 126517000);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 3, 731631935);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 620372277);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 6, 871728908);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 9, 364362923);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 8, 233045254);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 10, 598227354);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 7, 938406845);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 2, 185794095);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 6, 667562726);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 10, 995631486);
commit;
prompt 200 records committed...
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 2, 131145243);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 490041641);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 3, 191356229);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 7, 462028344);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 2, 140417983);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 4, 642289450);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 3, 877677760);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 4, 350723928);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 10, 576647580);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 9, 485506309);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 3, 527686504);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 5, 262643480);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 5, 164877394);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 6, 294004123);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 2, 189535699);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 432597233);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 214271290);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 9, 360000709);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 7, 492313313);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 1, 799597846);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 644414827);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 2, 982076921);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 1, 315456383);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 6, 263763052);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 8, 876495432);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 2, 721527128);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 157482297);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 4, 110437201);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 2, 204794274);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 4, 157623754);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 2, 628747616);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 8, 547111578);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 1, 468127207);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 7, 762821548);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 4, 977848457);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 10, 765327686);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 5, 143766014);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 6, 937043198);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 1, 386637107);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 3, 425485955);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 2, 170846994);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 5, 129195321);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 6, 377729240);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 9, 607902262);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 3, 527445580);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 10, 785202161);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 4, 967138840);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 9, 885809424);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 2, 420154025);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 9, 370249439);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 5, 858616442);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 4, 694209395);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 1, 838763998);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 183639285);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 2, 411001240);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 614694861);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 2, 972229832);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 6, 951821196);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 8, 468477800);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 10, 250253966);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 5, 103639039);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 9, 124420100);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 4, 699214173);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 6, 204329406);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 385313476);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 444008216);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 1, 387289289);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 9, 683617507);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 7, 702330680);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 9, 565182304);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 976175712);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 5, 795466385);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 7, 866234023);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 6, 708612515);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 4, 687537052);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 2, 157540214);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 5, 494960174);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 9, 514339325);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 8, 594728451);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 6, 891087041);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 438150346);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 10, 634913355);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 1, 699262710);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 6, 682245522);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 4, 779757808);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 2, 879861476);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 8, 619767996);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 8, 844173763);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 682304864);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 5, 526438708);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 4, 171796939);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 2, 496967655);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 2, 931697691);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 6, 362479656);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 1, 714440128);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 3, 380007079);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 7, 505151181);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 10, 860551807);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 9, 547079702);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 10, 471686465);
commit;
prompt 300 records committed...
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 3, 906671114);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 1, 388799844);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 4, 581307727);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 1, 895629963);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 6, 971185840);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 7, 216264525);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 2, 146897612);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 4, 488493128);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 451356256);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 3, 874114945);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 4, 133984187);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 8, 936769324);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 1, 593999831);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 8, 482685638);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 1, 667176850);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 6, 284087405);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 7, 994000381);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 8, 276224889);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 10, 366632145);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 1, 801616613);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 4, 358460781);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 1, 777063364);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 2, 140359430);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 1, 332847604);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 7, 846842975);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 10, 844165456);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 4, 506163412);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 1, 737627430);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 1, 360999355);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 6, 169524150);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 4, 349290214);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 4, 377585071);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 1, 148198111);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 5, 164659178);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 8, 879622687);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 7, 742292557);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 6, 914847250);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 8, 997569877);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 1, 453064263);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 10, 973970811);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 8, 680526159);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 9, 635968955);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 2, 872402104);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 5, 558169743);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 6, 277855177);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 5, 173927735);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 4, 316640446);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 9, 720258585);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 7, 907424842);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 894501335);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 5, 282259005);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 482986698);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 2, 750212736);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 10, 100148653);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Financial Consultant', 9, 407652575);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 9, 512652034);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 3, 380288743);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 9, 787229074);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 2, 952352618);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 9, 572005342);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 2, 945019903);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 1, 784915922);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 7, 183828210);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 2, 547461534);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 5, 242113481);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 10, 974400788);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 8, 774685658);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 7, 753413531);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 720417144);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 8, 326809666);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Developmental Consul', 2, 925234625);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 8, 418481619);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 5, 957537094);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Lactation Consultant', 1, 244957874);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Babywearing Consulta', 8, 723305141);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 3, 305478453);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 4, 497672990);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'General', 9, 744764697);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Home Organization Co', 10, 742378510);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 7, 922336964);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 7, 729277013);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 1, 167172437);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 2, 276868998);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Parenting Coach', 10, 837052178);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 4, 725424742);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Postpartum Doula', 3, 616311456);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Pediatric Sleep Spec', 4, 437929378);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 3, 601701489);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 4, 418941549);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 7, 232516560);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 1, 953132895);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Childproofing Consul', 5, 170305645);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Mental Health Counse', 2, 602026165);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Career Coach', 8, 747163297);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 10, 283264539);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Doula', 6, 433116488);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 5, 285418152);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Sleep Consultant', 9, 871722354);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Nutrition Consultant', 5, 887429256);
insert into CONSULTING (cns_location, cns_type, cns_yearsofexperience, sgm_id)
values (null, 'Fitness Trainer', 4, 297288231);
commit;
prompt 400 records loaded
prompt Loading TIMES...
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '21:30', 3, null, 940067704);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:00', '15:30', 4, null, 428745222);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:30', '16:00', 3, null, 326694357);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '22:00', 1, null, 628747616);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '13:00', '15:30', 3, null, 846842975);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:00', '17:30', 2, null, 140359430);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '11:30', '18:00', 3, null, 694209395);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '23:30', 3, null, 774685658);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '21:00', 4, null, 860545515);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '15:30', 3, null, 518817006);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:00', '20:00', 3, null, 488283015);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '13:00', '17:00', 5, null, 805558047);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '23:00', 1, null, 120974857);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '21:00', 4, null, 276868998);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:00', '16:30', 2, null, 428983287);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '14:30', '17:30', 4, null, 713320698);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '18:00', 4, null, 473903044);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '19:30', 5, null, 389621535);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '17:00', 2, null, 970123677);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:00', '17:30', 2, null, 644116143);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '17:00', 5, null, 667562726);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:30', '18:30', 3, null, 997569877);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '22:30', 2, null, 182765780);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:00', '15:00', 4, null, 902058409);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '17:30', 4, null, 687464649);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '15:00', 3, null, 274807987);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '16:30', 4, null, 702330680);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:00', '17:00', 4, null, 873783034);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '22:00', 3, null, 176236963);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '20:30', 4, null, 774685658);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '22:30', 4, null, 526438708);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '19:30', 2, null, 891087041);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:30', '17:30', 4, null, 890819891);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:00', '20:00', 5, null, 734673425);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:00', '19:30', 1, null, 265633696);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:30', '22:00', 2, null, 538534007);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:00', '15:30', 1, null, 511064174);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '17:00', 2, null, 682245522);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '17:00', 3, null, 838763998);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:00', '15:30', 2, null, 267248998);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '21:30', 3, null, 762821548);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '23:30', 3, null, 216090090);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '16:00', 1, null, 227135671);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:00', '16:30', 2, null, 734673425);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '15:00', 5, null, 339493176);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '15:30', 3, null, 407933782);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '14:00', '16:30', 2, null, 834129951);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:00', '23:00', 5, null, 402986300);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '14:30', '17:30', 1, null, 570953732);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '16:30', 2, null, 799597846);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '23:30', 1, null, 725612282);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '22:00', 3, null, 878995495);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:30', '23:00', 1, null, 171853644);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:00', '20:30', 4, null, 100148653);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '23:00', 2, null, 494960174);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '17:00', 4, null, 386637107);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:30', '21:30', 2, null, 612546655);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '19:30', 2, null, 919043255);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '19:00', 1, null, 496967655);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '22:00', 5, null, 549920959);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '22:30', 3, null, 193082739);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '20:30', 3, null, 438150346);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '15:30', 4, null, 826802360);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '20:30', 3, null, 190360834);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:30', '18:30', 4, null, 237075795);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '21:30', 3, null, 511064174);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '22:00', 2, null, 667176850);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:00', '16:00', 2, null, 135014039);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '19:30', 5, null, 468477800);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '17:30', 4, null, 310279833);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:00', '15:00', 5, null, 163103742);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:30', '20:00', 2, null, 444894245);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:00', '18:00', 2, null, 439190057);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:00', '15:30', 3, null, 685494264);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '16:30', 4, null, 566408163);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '16:00', 1, null, 683617507);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '19:30', 2, null, 737512334);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:00', '20:00', 1, null, 407652575);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '17:30', 1, null, 357643935);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '20:00', 3, null, 123959939);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:00', '15:00', 1, null, 567016150);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '23:00', 2, null, 996862753);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '17:00', 1, null, 742292557);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:00', '22:00', 2, null, 326809666);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '21:00', 5, null, 607902262);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '22:00', 1, null, 358460781);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '23:00', 2, null, 110437201);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '23:00', 2, null, 856694332);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:30', '17:30', 3, null, 765327686);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:00', '20:30', 1, null, 940067704);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '19:00', 1, null, 994000381);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '13:30', '15:30', 5, null, 165069233);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:00', '22:00', 2, null, 163103742);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:00', '23:00', 4, null, 547079702);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:00', '15:00', 2, null, 945019903);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:00', '17:30', 1, null, 297102804);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '19:00', 1, null, 163103742);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '15:00', 3, null, 108592361);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '16:00', 5, null, 506994358);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '18:00', 4, null, 369293915);
commit;
prompt 100 records committed...
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:00', '18:30', 4, null, 283264539);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '19:00', 1, null, 259281637);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:00', '18:00', 5, null, 588368340);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '15:30', 4, null, 799597846);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '18:30', 1, null, 858616442);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '15:00', 1, null, 829260788);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:00', '20:00', 5, null, 696579829);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '20:00', 3, null, 994000381);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:00', '17:30', 3, null, 958863687);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:30', '17:00', 3, null, 694803403);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:30', '23:30', 3, null, 789087097);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:00', '15:30', 1, null, 267248998);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:00', '23:30', 3, null, 496967655);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '17:30', 1, null, 458125190);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '18:30', 2, null, 708612515);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:30', '16:00', 4, null, 974400788);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '22:30', 4, null, 981543943);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:00', '18:00', 4, null, 254647820);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:00', '21:30', 4, null, 488493128);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '20:30', 2, null, 170846994);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '23:00', 5, null, 284087405);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '20:30', 2, null, 696579829);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '21:00', 5, null, 576647580);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '21:00', 5, null, 428745222);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '17:30', 5, null, 952669174);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '14:30', '16:30', 4, null, 753413531);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '22:30', 3, null, 448882818);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:30', '18:00', 2, null, 738309645);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:00', '23:30', 4, null, 874834733);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:30', '15:00', 3, null, 967138840);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '20:30', 1, null, 410929065);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '22:00', 5, null, 287920615);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '19:30', 5, null, 205397955);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:00', '23:00', 4, null, 952669174);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '22:00', 5, null, 744764697);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '23:30', 4, null, 826640267);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '22:00', 2, null, 492052662);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '16:30', 4, null, 615586328);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '15:30', 3, null, 233045254);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '21:30', 4, null, 466010638);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:00', '15:30', 4, null, 133984187);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '23:30', 3, null, 167172437);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '23:30', 1, null, 967138840);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:00', '20:00', 1, null, 536750145);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '17:00', 2, null, 516162245);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '21:30', 3, null, 146897612);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '19:30', 3, null, 467965675);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:30', '20:30', 5, null, 829260788);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '19:30', 5, null, 551526087);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:00', '19:00', 3, null, 661216534);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:30', '17:30', 5, null, 615422014);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:00', '20:30', 4, null, 169524150);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '23:30', 2, null, 351074926);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '20:30', 2, null, 609774041);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '21:00', 4, null, 583838247);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:30', '18:00', 2, null, 262643480);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:00', '19:00', 1, null, 242113481);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '18:00', 5, null, 171853644);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:00', '18:00', 4, null, 485506309);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '21:30', 2, null, 940067704);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '19:00', 1, null, 418481619);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '23:30', 1, null, 677269787);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '19:00', 3, null, 777063364);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '15:00', 2, null, 937043198);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:00', '16:30', 1, null, 996862753);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '18:00', 3, null, 816505821);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '21:30', 1, null, 854805518);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '23:00', 5, null, 497672990);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '16:30', 3, null, 796357825);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:00', '15:00', 2, null, 411001240);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:30', '19:00', 5, null, 169524150);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '19:00', 1, null, 315456383);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:00', '17:00', 5, null, 522099376);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '11:30', '15:00', 1, null, 438150346);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '17:00', 2, null, 173398008);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '18:30', 4, null, 490041641);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '22:00', 5, null, 123959939);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:30', '15:30', 2, null, 204794274);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '17:00', 4, null, 584847554);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '17:00', 3, null, 837052178);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:30', '15:30', 2, null, 566408163);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '15:00', 3, null, 257691173);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '17:30', 2, null, 615586328);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '19:30', 4, null, 263763052);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '23:30', 3, null, 821874383);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:00', '21:00', 4, null, 681850365);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '16:00', 4, null, 131145243);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:00', '20:30', 3, null, 291379350);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '11:30', '17:00', 4, null, 821874383);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '16:30', 1, null, 860551807);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:00', '15:00', 3, null, 866234023);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '22:00', 1, null, 640098230);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '20:30', 3, null, 598858081);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '20:30', 5, null, 713320698);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:00', '21:30', 4, null, 729277013);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:30', '16:00', 4, null, 294004123);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '20:30', 4, null, 913264381);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:00', '15:30', 5, null, 693685227);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:00', '15:30', 2, null, 570993504);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:30', '21:30', 1, null, 387092329);
commit;
prompt 200 records committed...
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '22:30', 3, null, 237075795);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:00', '22:00', 2, null, 817026839);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:00', '20:30', 4, null, 620372277);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:30', '21:30', 2, null, 123959939);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:00', '20:30', 2, null, 971185840);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '23:30', 4, null, 498768696);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '15:30', 1, null, 245705265);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:00', '15:00', 2, null, 917191761);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:30', '17:00', 1, null, 663196582);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '14:30', '17:30', 5, null, 974400788);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:30', '15:30', 4, null, 197218839);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '17:30', 1, null, 425485955);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '20:00', 1, null, 890819891);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '21:00', 5, null, 847523648);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '9:00', '15:30', 3, null, 986676799);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:00', '19:00', 4, null, 226019979);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '18:00', 2, null, 851431384);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '18:30', 3, null, 615422014);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '18:30', 4, null, 411001240);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '22:00', 4, null, 879861476);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '20:00', 4, null, 763635580);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '16:30', 2, null, 619980182);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:00', '16:30', 3, null, 213253770);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '19:30', 1, null, 331919904);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '20:30', 3, null, 240921696);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '21:30', 4, null, 496967655);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '10:00', '16:30', 1, null, 176236963);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '19:30', 1, null, 374356341);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:00', '18:00', 5, null, 871722354);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '21:00', 1, null, 805558047);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:30', '23:30', 4, null, 317144977);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '17:00', 3, null, 640098230);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '20:30', 1, null, 953132895);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '15:00', 5, null, 462028344);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '21:00', 1, null, 169524150);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '21:30', 2, null, 547079702);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '19:30', 3, null, 189535699);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '13:00', '15:00', 3, null, 282259005);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:00', '18:00', 5, null, 914847250);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '11:00', '15:30', 1, null, 911869430);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:00', '19:00', 3, null, 619980182);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:00', '21:30', 5, null, 245705265);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '16:30', 2, null, 925234625);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '21:30', 5, null, 921877972);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '23:00', 5, null, 689614398);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '23:30', 3, null, 222417749);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '21:00', 2, null, 698624693);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '17:00', 2, null, 560105519);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '23:00', 1, null, 957537094);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:00', '22:00', 1, null, 598227354);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:00', '20:30', 5, null, 124420100);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '22:00', 5, null, 232516560);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '23:00', 5, null, 126762133);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:30', '17:30', 4, null, 386928076);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '17:30', 4, null, 832343421);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '15:00', 5, null, 973970811);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:00', '22:00', 2, null, 840341264);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '21:00', 1, null, 620372277);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '8:00', '16:00', 4, null, 446811236);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '23:00', 4, null, 672929772);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '23:30', 2, null, 157540214);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '18:30', 5, null, 297288231);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:00', '15:30', 1, null, 731977144);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '21:30', 3, null, 388799844);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '21:00', 4, null, 167172437);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:30', '21:00', 3, null, 960965084);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:00', '18:30', 4, null, 506994358);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '21:00', 1, null, 506163412);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:30', '20:00', 5, null, 781922286);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:00', '18:30', 3, null, 482685638);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:00', '22:00', 4, null, 512652034);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '13:30', '16:00', 3, null, 717787972);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '20:00', 1, null, 238002042);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:30', '16:30', 2, null, 860545515);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '22:00', 2, null, 951075931);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:00', '21:30', 5, null, 785202161);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '18:30', 1, null, 549920959);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '16:30', 3, null, 156162327);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '16:00', 2, null, 721527128);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '18:00', 4, null, 858616442);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '19:00', 3, null, 382678745);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:00', '16:00', 2, null, 594728451);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:30', '17:00', 1, null, 977848457);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '22:30', 2, null, 291379350);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '12:00', '16:00', 5, null, 702330680);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '13:00', '17:30', 2, null, 463520539);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:30', '21:30', 5, null, 680526159);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:30', '17:00', 3, null, 849923350);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '18:30', 4, null, 221497111);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '13:00', '17:30', 4, null, 516162245);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '8:00', '18:00', 4, null, 607668294);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '22:00', 5, null, 349109407);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '20:00', 2, null, 779283595);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '15:00', 5, null, 687537052);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:30', '22:30', 5, null, 266606670);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '19:30', 1, null, 140417983);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '22:30', 4, null, 527686504);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:30', '17:00', 2, null, 514339325);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '10:30', '15:30', 5, null, 518817006);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '12:30', '22:00', 3, null, 734673425);
commit;
prompt 300 records committed...
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '13:30', '22:30', 2, null, 826802360);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '23:00', 3, null, 792482323);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '19:30', 5, null, 524148126);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '15:00', 5, null, 527686504);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '19:00', 2, null, 146897612);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '11:30', '21:00', 1, null, 776623460);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '14:00', '23:00', 4, null, 487397320);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '19:00', 5, null, 126517000);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '17:00', 2, null, 148198111);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:00', '23:00', 1, null, 299747885);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '19:30', 3, null, 482986698);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:30', '15:00', 4, null, 781922286);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:30', '15:00', 4, null, 480996732);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:00', '20:00', 5, null, 487397320);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '16:30', 5, null, 513603889);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:00', '16:30', 2, null, 318609792);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '23:00', 1, null, 523949424);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '23:30', 1, null, 474646280);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '20:30', 5, null, 724109514);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '8:00', '16:30', 5, null, 339607802);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '22:00', 5, null, 251122348);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:00', '22:30', 4, null, 178737651);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '10:30', '16:00', 5, null, 362479656);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '23:00', 5, null, 380007079);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '12:30', '20:00', 2, null, 234029909);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '13:30', '15:30', 2, null, 829260788);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '14:30', '17:00', 5, null, 432597233);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '12:00', '21:00', 1, null, 976175712);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:30', '23:30', 3, null, 238831365);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:30', '23:00', 3, null, 162741206);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '9:00', '23:30', 2, null, 639121639);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:00', '18:30', 3, null, 747163297);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:30', '22:00', 2, null, 931697691);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '13:30', '18:30', 3, null, 399360066);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:30', '15:00', 5, null, 994000381);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '9:00', '15:00', 3, null, 860545515);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:00', '23:00', 1, null, 276224889);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '18:30', 2, null, 284087405);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '11:30', '16:30', 5, null, 938406845);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:00', '17:30', 1, null, 386354445);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '12:30', '15:30', 3, null, 360000709);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:00', '17:00', 3, null, 351074926);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '10:30', '21:00', 3, null, 305478453);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '8:30', '22:30', 4, null, 214271290);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '10:30', '22:00', 4, null, 588368340);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '14:00', '20:00', 5, null, 481552416);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '21:30', 3, null, 444894245);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '11:30', '23:30', 5, null, 193082739);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Thursday', '8:30', '16:30', 2, null, 153649997);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Tuesday', '13:00', '18:00', 1, null, 244957874);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '14:00', '20:30', 1, null, 887429256);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '11:30', '18:30', 5, null, 120974857);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Sunday', '9:00', '15:30', 2, null, 572028348);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Wednesday', '9:30', '23:00', 1, null, 324906557);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '13:30', '21:00', 1, null, 751450151);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:30', '17:30', 1, null, 505151181);
insert into TIMES (t_dayofweek, t_starttime, t_endtime, t_num, t_constraints, sgm_id)
values ('Monday', '9:30', '21:00', 3, null, 536750145);
commit;
prompt 357 records loaded
prompt Loading YOLEDET...
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 100148653);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 396481548);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 816391512);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 753024805);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 821749542);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 877677760);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 651855962);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 866234023);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 511064174);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 566408163);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 557605097);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 590261410);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 721527128);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 156162327);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 297288231);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 958863687);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 481788951);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 326324737);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 377729240);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 164877394);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 221497111);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 604613699);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 895629963);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 982854200);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 406508183);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 331919904);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 605127111);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 326667328);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 998764869);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 926497407);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 418481619);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 902058409);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 129195321);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 551407504);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 994000381);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 382883037);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 987324803);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 995273588);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 747163297);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 206213664);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 527445580);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 776623460);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 154242474);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 609774041);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 891928720);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 858616442);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 694034701);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 663196582);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 182765780);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 240921696);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 488493128);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 294004123);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 645064381);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 615928170);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 687537052);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 900192875);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 907674013);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 584640968);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 696579829);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 931619511);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 251122348);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 942515529);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 991065502);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 656802060);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 149248623);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 766683811);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 427746575);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 580351317);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 249640786);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 434361920);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 756337633);
insert into YOLEDET (y_numofchildern, ym_id)
values (0, 615586328);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 541868230);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 864487983);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 661315918);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 458125190);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 251279284);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 234814837);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 399077464);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 612699405);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 638472575);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 213253770);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 388592218);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 110437201);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 579018697);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 728382339);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 957537094);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 638404454);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 485682956);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 143359256);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 193367254);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 463520539);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 634913355);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 826640267);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 441752575);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 667176850);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 838232400);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 811608430);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 490172289);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 584847554);
commit;
prompt 100 records committed...
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 794769332);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 185360775);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 598623933);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 361791170);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 994167808);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 683067812);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 804309217);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 925234625);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 241637541);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 708135979);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 573087122);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 120974857);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 513923427);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 166217087);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 872713068);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 683894482);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 227242697);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 317144977);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 549920959);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 971185840);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 301145806);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 723305141);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 649501080);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 457561642);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 617533806);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 498521987);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 952669174);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 283264539);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 403418492);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 178737651);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 113103849);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 234449706);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 476772296);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 668312397);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 529485293);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 763635580);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 309169041);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 141926107);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 779283595);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 936769324);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 789087097);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 325043737);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 972229832);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 157820082);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 240089876);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 816251377);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 444894245);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 670693235);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 926537995);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 433116488);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 504048563);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 560105519);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 465156888);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 118236069);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 185794095);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 386637107);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 577184322);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 497974425);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 901502896);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 798624234);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 805558047);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 570993504);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 995849472);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 191356229);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 734673425);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 880283169);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 615422014);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 997569877);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 854805518);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 329865472);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 891087041);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 739747358);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 308829624);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 890819891);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 529348579);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 806840454);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 215074393);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 788322275);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 602026165);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 171853644);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 131889804);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 139741096);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 971401539);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 286942816);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 938406845);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 579654604);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 351074926);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 697015085);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 214932549);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 654360049);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 706326162);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 163103742);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 989941934);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 878452649);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 360999355);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 533177138);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 305926726);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 355146666);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 816505821);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 384575759);
commit;
prompt 200 records committed...
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 598227354);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 446811236);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 398746881);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 553025263);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 661216534);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 420154025);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 157540214);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 504390279);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 784915922);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 455135434);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 616311456);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 400057384);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 377585071);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 792482323);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 487861711);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 873353399);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 512652034);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 820477303);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 644116143);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 795314245);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 532032180);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 442274284);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 846842975);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 879861476);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 235280458);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 327370740);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 518048280);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 992615606);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 611218507);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 536750145);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 753413531);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 797524319);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 887429256);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 817026839);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 770156282);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 944530975);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 478438487);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 441896465);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 329158441);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 777063364);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 146897612);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 277855177);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 516162245);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 615892339);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 824563037);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 799597846);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 488283015);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 670980747);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 785974864);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 271296079);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 871846808);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 749018448);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 986676799);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 200971969);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 304226614);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 214684922);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 418941549);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 725612282);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 182963438);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 652916189);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 572005342);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 553517298);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 785307559);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 683617507);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 733424841);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 997071337);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 197218839);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 876495432);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 936169503);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 871722354);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 654126598);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 554489252);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 666662014);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 867204119);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 619767996);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 737512334);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 821874383);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 734366943);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 438885298);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 768584445);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 922336964);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 410848744);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 558169743);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 687579680);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 463440005);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 242113481);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 258945756);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 293210110);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 860551807);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 359817344);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 962072334);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 466010638);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 492827855);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 806611140);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 380288743);
insert into YOLEDET (y_numofchildern, ym_id)
values (0, 175567621);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 443991351);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 621738771);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 918190109);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 357723571);
commit;
prompt 300 records committed...
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 474646280);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 505992549);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 815910963);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 677269787);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 829260788);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 360000709);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 557466349);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 440671201);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 175518300);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 856694332);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 946331566);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 228056872);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 720258585);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 816505320);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 427084310);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 755209681);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 805723700);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 370336079);
insert into YOLEDET (y_numofchildern, ym_id)
values (0, 973970811);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 725424742);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 907424842);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 595271596);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 445960804);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 337816724);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 742292557);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 437929378);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 525588342);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 260871702);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 199668456);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 689614398);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 520342574);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 310735882);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 347912421);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 370571857);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 912577195);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 482685638);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 962588264);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 237075795);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 287920615);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 502491985);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 108592361);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 440396543);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 208673611);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 943569264);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 612398190);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 625557611);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 710261527);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 741076529);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 204329406);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 479537259);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 720417144);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 611314031);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 801616613);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 267248998);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 576647580);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 123959939);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 787229074);
insert into YOLEDET (y_numofchildern, ym_id)
values (13, 542084528);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 832343421);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 428983287);
insert into YOLEDET (y_numofchildern, ym_id)
values (0, 407933782);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 811695961);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 548330988);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 526438708);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 116462353);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 770754632);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 338247817);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 562560915);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 466988754);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 607902262);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 515439710);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 140417983);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 284087405);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 238002042);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 492052662);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 815540940);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 387289289);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 547106878);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 672677177);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 682245522);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 612797289);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 888269770);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 140359430);
insert into YOLEDET (y_numofchildern, ym_id)
values (14, 669449784);
insert into YOLEDET (y_numofchildern, ym_id)
values (12, 911869430);
insert into YOLEDET (y_numofchildern, ym_id)
values (7, 271482442);
insert into YOLEDET (y_numofchildern, ym_id)
values (11, 323888942);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 897443171);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 648581103);
insert into YOLEDET (y_numofchildern, ym_id)
values (15, 634174678);
insert into YOLEDET (y_numofchildern, ym_id)
values (8, 731977144);
insert into YOLEDET (y_numofchildern, ym_id)
values (3, 672588466);
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 187453014);
insert into YOLEDET (y_numofchildern, ym_id)
values (9, 622700951);
insert into YOLEDET (y_numofchildern, ym_id)
values (4, 594728451);
insert into YOLEDET (y_numofchildern, ym_id)
values (2, 628747616);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 441225071);
insert into YOLEDET (y_numofchildern, ym_id)
values (6, 506163412);
insert into YOLEDET (y_numofchildern, ym_id)
values (1, 902558637);
insert into YOLEDET (y_numofchildern, ym_id)
values (5, 547111578);
commit;
prompt 400 records committed...
insert into YOLEDET (y_numofchildern, ym_id)
values (10, 651934519);
commit;
prompt 401 records loaded
prompt Loading YOLEDETSERVICEGIVER...
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-07-2021', 'dd-mm-yyyy'), '8:30', '17:00', 5, 490172289, 779283595);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-11-2020', 'dd-mm-yyyy'), '14:30', '19:00', 4, 804309217, 490041641);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-03-2023', 'dd-mm-yyyy'), '10:30', '23:00', 3, 878452649, 685512872);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-12-2022', 'dd-mm-yyyy'), '14:00', '20:00', 4, 982854200, 594728451);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-09-2021', 'dd-mm-yyyy'), '9:30', '20:00', 4, 925234625, 885809424);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-07-2022', 'dd-mm-yyyy'), '13:30', '20:30', null, 649501080, 329865472);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-08-2020', 'dd-mm-yyyy'), '14:30', '20:00', null, 677269787, 105490171);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-02-2020', 'dd-mm-yyyy'), '10:30', '20:00', 4, 997071337, 776623460);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-10-2023', 'dd-mm-yyyy'), '8:30', '15:00', 5, 377729240, 262643480);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-10-2023', 'dd-mm-yyyy'), '12:00', '17:00', 4, 821749542, 879054575);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-01-2022', 'dd-mm-yyyy'), '14:00', '18:00', null, 890819891, 182055053);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-09-2023', 'dd-mm-yyyy'), '14:00', '18:30', null, 329158441, 880283169);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-11-2023', 'dd-mm-yyyy'), '13:00', '19:30', 5, 784915922, 878361050);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-06-2023', 'dd-mm-yyyy'), '12:30', '19:30', 4, 116462353, 506994358);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-05-2022', 'dd-mm-yyyy'), '10:00', '21:30', 2, 445960804, 986676799);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-02-2022', 'dd-mm-yyyy'), '13:30', '23:30', 3, 911869430, 750212736);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-07-2021', 'dd-mm-yyyy'), '13:00', '18:00', null, 661216534, 386928076);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-08-2021', 'dd-mm-yyyy'), '8:30', '20:00', 3, 721527128, 105836606);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-09-2023', 'dd-mm-yyyy'), '10:00', '23:00', null, 304226614, 982854200);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-02-2021', 'dd-mm-yyyy'), '11:00', '16:00', 5, 441896465, 902058409);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-09-2023', 'dd-mm-yyyy'), '10:00', '15:30', null, 590261410, 355146666);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-10-2023', 'dd-mm-yyyy'), '10:00', '21:30', 5, 420154025, 242113481);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-09-2023', 'dd-mm-yyyy'), '9:30', '19:00', null, 185360775, 702330680);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-10-2023', 'dd-mm-yyyy'), '9:00', '23:00', null, 687537052, 731977144);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-05-2020', 'dd-mm-yyyy'), '10:30', '22:00', 4, 621738771, 724109514);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-10-2020', 'dd-mm-yyyy'), '8:30', '15:00', 5, 398746881, 468477800);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-03-2023', 'dd-mm-yyyy'), '10:00', '21:00', 4, 204329406, 895943487);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-08-2022', 'dd-mm-yyyy'), '14:30', '18:30', null, 141926107, 326694357);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-04-2021', 'dd-mm-yyyy'), '9:30', '19:00', null, 463440005, 796357825);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-06-2020', 'dd-mm-yyyy'), '13:00', '22:00', 5, 994000381, 105490171);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-03-2022', 'dd-mm-yyyy'), '10:30', '17:00', null, 811695961, 776623460);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-04-2023', 'dd-mm-yyyy'), '14:00', '19:30', 5, 619767996, 446811236);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-12-2022', 'dd-mm-yyyy'), '10:30', '23:30', null, 880283169, 139741096);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-06-2020', 'dd-mm-yyyy'), '12:30', '19:00', null, 788322275, 913264381);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-05-2020', 'dd-mm-yyyy'), '13:00', '17:30', null, 293210110, 672929772);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-10-2020', 'dd-mm-yyyy'), '13:00', '17:30', 4, 428983287, 792482323);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-10-2021', 'dd-mm-yyyy'), '14:00', '16:30', 4, 669449784, 318609792);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-03-2023', 'dd-mm-yyyy'), '10:00', '16:30', 4, 877677760, 907424842);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-04-2020', 'dd-mm-yyyy'), '12:00', '19:30', 4, 725612282, 267080645);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-07-2023', 'dd-mm-yyyy'), '14:30', '20:30', 5, 370571857, 816391512);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-12-2020', 'dd-mm-yyyy'), '8:00', '17:30', 4, 609774041, 451356256);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-12-2020', 'dd-mm-yyyy'), '9:30', '16:30', 3, 612398190, 541784559);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-02-2020', 'dd-mm-yyyy'), '14:30', '17:00', 5, 361791170, 377585071);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-02-2021', 'dd-mm-yyyy'), '8:30', '22:30', null, 466988754, 628747616);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-05-2023', 'dd-mm-yyyy'), '9:30', '15:00', 5, 991065502, 829260788);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-11-2022', 'dd-mm-yyyy'), '10:00', '22:30', 5, 986676799, 129195321);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-03-2021', 'dd-mm-yyyy'), '11:00', '16:00', 5, 310735882, 251279284);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-08-2020', 'dd-mm-yyyy'), '9:30', '22:30', null, 612699405, 215074393);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-01-2023', 'dd-mm-yyyy'), '10:30', '21:00', 5, 815910963, 120974857);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-08-2023', 'dd-mm-yyyy'), '10:30', '18:00', 5, 418481619, 553517298);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-05-2020', 'dd-mm-yyyy'), '14:30', '19:00', 3, 474646280, 310735882);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-03-2022', 'dd-mm-yyyy'), '8:30', '20:00', 5, 708135979, 169524150);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-05-2021', 'dd-mm-yyyy'), '13:30', '15:30', 3, 406508183, 879861476);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2023', 'dd-mm-yyyy'), '12:00', '17:00', 4, 638472575, 844173763);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-07-2021', 'dd-mm-yyyy'), '10:30', '16:00', null, 110437201, 250253966);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-08-2023', 'dd-mm-yyyy'), '8:30', '19:30', 5, 615586328, 906671114);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-11-2022', 'dd-mm-yyyy'), '12:00', '18:30', null, 293210110, 482685638);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-09-2022', 'dd-mm-yyyy'), '8:30', '22:30', 4, 907424842, 529485293);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-02-2020', 'dd-mm-yyyy'), '11:30', '18:00', null, 864487983, 973970811);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-08-2023', 'dd-mm-yyyy'), '9:30', '18:30', 3, 971401539, 837052178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-09-2023', 'dd-mm-yyyy'), '8:00', '19:00', 5, 706326162, 157623754);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-10-2020', 'dd-mm-yyyy'), '10:30', '19:00', null, 360999355, 937043198);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-08-2022', 'dd-mm-yyyy'), '8:00', '23:00', 4, 166217087, 885809424);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-07-2022', 'dd-mm-yyyy'), '8:30', '20:00', 4, 667176850, 844173763);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2023', 'dd-mm-yyyy'), '13:00', '20:30', 3, 511064174, 446811236);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-06-2021', 'dd-mm-yyyy'), '11:30', '19:00', 3, 612797289, 315456383);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-03-2023', 'dd-mm-yyyy'), '13:00', '16:30', 3, 387289289, 437929378);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-11-2021', 'dd-mm-yyyy'), '14:00', '16:00', 4, 326667328, 699214173);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-09-2023', 'dd-mm-yyyy'), '11:30', '21:00', 3, 584640968, 360999355);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-10-2021', 'dd-mm-yyyy'), '11:00', '18:30', 3, 756337633, 362479656);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-12-2022', 'dd-mm-yyyy'), '11:00', '23:30', null, 612797289, 318609792);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-05-2020', 'dd-mm-yyyy'), '14:00', '16:00', 1, 458125190, 890819891);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-06-2023', 'dd-mm-yyyy'), '13:00', '15:00', 4, 590261410, 915559018);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-04-2020', 'dd-mm-yyyy'), '13:00', '19:30', null, 669449784, 785202161);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-07-2022', 'dd-mm-yyyy'), '12:00', '20:30', 5, 529348579, 529485293);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-06-2022', 'dd-mm-yyyy'), '10:00', '23:30', 5, 667176850, 768584445);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-07-2023', 'dd-mm-yyyy'), '12:30', '19:30', null, 527445580, 706326162);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-10-2020', 'dd-mm-yyyy'), '11:00', '16:00', 3, 178737651, 164659178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-11-2021', 'dd-mm-yyyy'), '9:00', '15:30', null, 911869430, 492827855);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-04-2021', 'dd-mm-yyyy'), '13:30', '20:00', 5, 625557611, 385313476);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-06-2020', 'dd-mm-yyyy'), '9:00', '20:00', 2, 768584445, 339493176);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-06-2020', 'dd-mm-yyyy'), '12:00', '15:00', null, 816391512, 446811236);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-02-2020', 'dd-mm-yyyy'), '12:30', '21:30', null, 513923427, 724109514);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-12-2023', 'dd-mm-yyyy'), '13:00', '18:00', 5, 723305141, 466988754);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-04-2022', 'dd-mm-yyyy'), '12:00', '15:00', 4, 441752575, 638404454);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-08-2021', 'dd-mm-yyyy'), '11:30', '20:00', 3, 615892339, 721527128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-10-2023', 'dd-mm-yyyy'), '10:00', '18:00', 5, 856694332, 107444785);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-04-2022', 'dd-mm-yyyy'), '14:00', '19:30', 5, 502491985, 639121639);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-12-2023', 'dd-mm-yyyy'), '10:30', '17:00', 5, 625557611, 945448417);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-03-2020', 'dd-mm-yyyy'), '8:30', '16:30', 3, 994167808, 697015085);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-10-2022', 'dd-mm-yyyy'), '9:30', '19:30', null, 602026165, 542084528);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('15-11-2021', 'dd-mm-yyyy'), '10:00', '15:00', 5, 215074393, 349290214);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-02-2020', 'dd-mm-yyyy'), '12:30', '18:30', null, 428983287, 764463799);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-02-2021', 'dd-mm-yyyy'), '8:30', '17:30', 5, 755209681, 829260788);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-03-2022', 'dd-mm-yyyy'), '8:00', '15:00', null, 398746881, 584847554);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-05-2021', 'dd-mm-yyyy'), '13:00', '20:00', 3, 284087405, 529348579);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-07-2020', 'dd-mm-yyyy'), '10:30', '20:30', 4, 805723700, 764463799);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-10-2022', 'dd-mm-yyyy'), '14:30', '18:30', 5, 445960804, 432597233);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-07-2022', 'dd-mm-yyyy'), '12:00', '19:00', 3, 444894245, 816505320);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-10-2020', 'dd-mm-yyyy'), '14:00', '16:30', 5, 879861476, 257691173);
commit;
prompt 100 records committed...
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-04-2022', 'dd-mm-yyyy'), '8:00', '15:30', 4, 785307559, 957537094);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-12-2020', 'dd-mm-yyyy'), '12:30', '16:00', 4, 466010638, 420154025);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-06-2023', 'dd-mm-yyyy'), '8:00', '22:30', 3, 505992549, 177060427);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-08-2021', 'dd-mm-yyyy'), '11:30', '15:00', 5, 560105519, 962501060);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-11-2021', 'dd-mm-yyyy'), '14:30', '16:30', 5, 485682956, 694209395);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-08-2020', 'dd-mm-yyyy'), '13:00', '16:30', null, 382883037, 583838247);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-03-2020', 'dd-mm-yyyy'), '12:00', '19:30', 1, 683617507, 640098230);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-05-2022', 'dd-mm-yyyy'), '10:00', '21:30', null, 310735882, 329865472);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-12-2022', 'dd-mm-yyyy'), '12:30', '22:00', null, 420154025, 445960804);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-01-2020', 'dd-mm-yyyy'), '13:00', '21:30', 4, 562560915, 547079702);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('15-01-2023', 'dd-mm-yyyy'), '13:00', '19:30', 4, 708135979, 816251377);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-01-2023', 'dd-mm-yyyy'), '13:00', '17:00', 5, 301145806, 310279833);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-08-2020', 'dd-mm-yyyy'), '13:00', '21:00', 4, 649501080, 962501060);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-12-2022', 'dd-mm-yyyy'), '9:30', '21:00', 4, 513923427, 560105519);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-09-2021', 'dd-mm-yyyy'), '14:30', '17:00', null, 611218507, 370571857);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-11-2020', 'dd-mm-yyyy'), '13:00', '16:30', 3, 615422014, 860551807);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-03-2021', 'dd-mm-yyyy'), '10:30', '22:00', null, 820477303, 482986698);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-02-2022', 'dd-mm-yyyy'), '8:30', '19:00', null, 497974425, 730570311);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-04-2021', 'dd-mm-yyyy'), '13:30', '23:30', 3, 794769332, 191356229);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-08-2022', 'dd-mm-yyyy'), '8:30', '21:00', null, 481788951, 815054512);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-06-2022', 'dd-mm-yyyy'), '8:30', '19:00', 1, 952669174, 241637541);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-01-2020', 'dd-mm-yyyy'), '8:30', '21:00', 4, 747163297, 858481074);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-01-2022', 'dd-mm-yyyy'), '14:00', '15:00', 4, 441225071, 482685638);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-02-2020', 'dd-mm-yyyy'), '13:00', '18:00', 5, 689614398, 576647580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-04-2021', 'dd-mm-yyyy'), '11:00', '15:00', 4, 529485293, 762821548);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-01-2020', 'dd-mm-yyyy'), '11:00', '15:00', 5, 666662014, 584847554);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-09-2023', 'dd-mm-yyyy'), '12:00', '21:30', 3, 669449784, 779757808);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-07-2022', 'dd-mm-yyyy'), '14:30', '18:30', 5, 492052662, 432597233);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-01-2022', 'dd-mm-yyyy'), '9:00', '23:00', 5, 304226614, 126762133);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-02-2023', 'dd-mm-yyyy'), '11:00', '16:00', 4, 438885298, 339493176);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-02-2021', 'dd-mm-yyyy'), '13:30', '18:30', 5, 616311456, 860551807);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-07-2020', 'dd-mm-yyyy'), '14:30', '17:30', 4, 570993504, 329865472);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-04-2020', 'dd-mm-yyyy'), '9:00', '16:30', null, 611314031, 251279284);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-07-2023', 'dd-mm-yyyy'), '10:30', '20:00', null, 946331566, 146897612);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-08-2020', 'dd-mm-yyyy'), '11:00', '16:00', 5, 541868230, 721527128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-10-2021', 'dd-mm-yyyy'), '8:00', '17:30', null, 854805518, 966881718);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-01-2023', 'dd-mm-yyyy'), '12:00', '19:30', null, 437929378, 601701489);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-08-2020', 'dd-mm-yyyy'), '13:00', '16:00', 4, 667176850, 874114945);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-10-2023', 'dd-mm-yyyy'), '10:00', '21:00', 4, 182765780, 607902262);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-08-2023', 'dd-mm-yyyy'), '9:00', '23:00', null, 387289289, 139741096);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-06-2020', 'dd-mm-yyyy'), '12:00', '23:30', 3, 785974864, 906671114);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-05-2023', 'dd-mm-yyyy'), '9:00', '18:00', null, 505992549, 382678745);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-06-2023', 'dd-mm-yyyy'), '13:00', '17:00', 5, 697015085, 176236963);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-05-2020', 'dd-mm-yyyy'), '13:00', '21:00', 5, 616311456, 816505320);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-02-2022', 'dd-mm-yyyy'), '10:00', '16:30', 4, 634174678, 164659178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-10-2021', 'dd-mm-yyyy'), '12:00', '15:00', 5, 433116488, 907424842);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-12-2023', 'dd-mm-yyyy'), '10:30', '17:30', 4, 922336964, 108400326);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-12-2023', 'dd-mm-yyyy'), '13:30', '15:00', 5, 549920959, 360000709);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-12-2020', 'dd-mm-yyyy'), '10:00', '17:30', 3, 957537094, 360999355);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-05-2023', 'dd-mm-yyyy'), '13:30', '23:00', 2, 407933782, 816391512);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-09-2020', 'dd-mm-yyyy'), '13:00', '23:00', null, 982854200, 478765875);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-06-2023', 'dd-mm-yyyy'), '8:30', '18:30', 4, 689614398, 411001240);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-01-2021', 'dd-mm-yyyy'), '10:30', '15:00', 5, 570993504, 116462353);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-12-2020', 'dd-mm-yyyy'), '14:30', '20:30', 4, 387289289, 966881718);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-08-2020', 'dd-mm-yyyy'), '8:00', '15:30', 3, 515439710, 721527128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-02-2021', 'dd-mm-yyyy'), '8:00', '16:00', 5, 811695961, 614694861);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-11-2021', 'dd-mm-yyyy'), '14:00', '19:30', 2, 386637107, 992615606);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-05-2020', 'dd-mm-yyyy'), '8:30', '23:30', 5, 228056872, 221497111);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-10-2021', 'dd-mm-yyyy'), '10:00', '20:30', 4, 434361920, 449337529);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('15-11-2020', 'dd-mm-yyyy'), '12:30', '15:30', 3, 557466349, 432597233);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-04-2022', 'dd-mm-yyyy'), '14:30', '19:00', 5, 815540940, 274715538);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-04-2021', 'dd-mm-yyyy'), '12:30', '21:30', 3, 697015085, 854805518);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-08-2021', 'dd-mm-yyyy'), '13:30', '19:30', 5, 241637541, 485506309);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-08-2023', 'dd-mm-yyyy'), '12:00', '18:30', 4, 360999355, 837052178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-06-2020', 'dd-mm-yyyy'), '11:30', '15:00', 4, 178737651, 901702266);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-03-2020', 'dd-mm-yyyy'), '8:00', '20:30', 5, 725424742, 360999355);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-01-2021', 'dd-mm-yyyy'), '11:00', '22:00', 5, 873353399, 957537094);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-10-2023', 'dd-mm-yyyy'), '10:00', '21:00', 4, 652916189, 851431384);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-09-2021', 'dd-mm-yyyy'), '12:00', '15:30', 4, 580351317, 635968955);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-02-2023', 'dd-mm-yyyy'), '9:00', '18:30', 1, 911869430, 572028348);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-12-2023', 'dd-mm-yyyy'), '10:30', '18:30', 3, 891928720, 408789796);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-01-2021', 'dd-mm-yyyy'), '12:00', '21:00', null, 123959939, 157623754);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-11-2022', 'dd-mm-yyyy'), '14:00', '21:30', null, 995849472, 215074393);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-06-2021', 'dd-mm-yyyy'), '12:00', '15:30', null, 139741096, 462028344);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-11-2021', 'dd-mm-yyyy'), '12:30', '18:00', 3, 185794095, 369293915);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-04-2020', 'dd-mm-yyyy'), '8:00', '23:00', null, 901502896, 962501060);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-11-2023', 'dd-mm-yyyy'), '11:30', '22:30', 4, 877677760, 551407504);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-11-2023', 'dd-mm-yyyy'), '10:00', '16:30', 2, 697015085, 468127207);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-07-2021', 'dd-mm-yyyy'), '9:30', '20:00', null, 776623460, 764463799);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-11-2023', 'dd-mm-yyyy'), '8:00', '23:00', 4, 652916189, 732364554);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-03-2020', 'dd-mm-yyyy'), '8:30', '19:00', 5, 918190109, 185101463);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-02-2020', 'dd-mm-yyyy'), '9:00', '22:30', null, 516162245, 917191761);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-11-2020', 'dd-mm-yyyy'), '8:30', '17:00', 5, 682245522, 894501335);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-05-2023', 'dd-mm-yyyy'), '10:30', '16:30', null, 542084528, 331919904);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-06-2022', 'dd-mm-yyyy'), '11:30', '21:30', 5, 488493128, 490850485);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-09-2021', 'dd-mm-yyyy'), '13:00', '21:00', 5, 838232400, 974400788);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-03-2021', 'dd-mm-yyyy'), '8:30', '18:00', 4, 110437201, 274807987);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-08-2023', 'dd-mm-yyyy'), '11:00', '19:30', 3, 742292557, 396481548);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-09-2020', 'dd-mm-yyyy'), '10:30', '20:30', 5, 972229832, 485506309);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-12-2020', 'dd-mm-yyyy'), '8:00', '22:00', null, 504390279, 511064174);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-03-2023', 'dd-mm-yyyy'), '12:00', '23:30', null, 579018697, 467965675);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-01-2023', 'dd-mm-yyyy'), '11:00', '17:30', 3, 654360049, 482685638);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-03-2020', 'dd-mm-yyyy'), '14:30', '16:30', null, 816505821, 250253966);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-11-2023', 'dd-mm-yyyy'), '13:30', '23:00', 4, 634174678, 123959939);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-12-2022', 'dd-mm-yyyy'), '14:00', '15:30', null, 377585071, 560105519);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-12-2020', 'dd-mm-yyyy'), '11:00', '18:30', null, 440671201, 837052178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-07-2021', 'dd-mm-yyyy'), '8:00', '20:00', 5, 595271596, 133984187);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-09-2021', 'dd-mm-yyyy'), '9:30', '23:00', 5, 789087097, 118236069);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-07-2023', 'dd-mm-yyyy'), '11:00', '22:00', 5, 854805518, 860551807);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-05-2022', 'dd-mm-yyyy'), '11:00', '18:00', 5, 973970811, 525588342);
commit;
prompt 200 records committed...
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-08-2020', 'dd-mm-yyyy'), '10:30', '22:00', 5, 251279284, 721527128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-11-2022', 'dd-mm-yyyy'), '11:00', '22:30', 3, 434361920, 638472575);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-08-2023', 'dd-mm-yyyy'), '13:00', '17:00', 5, 418481619, 873783034);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-05-2021', 'dd-mm-yyyy'), '14:00', '15:00', null, 682245522, 339493176);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-10-2020', 'dd-mm-yyyy'), '14:00', '17:30', null, 325043737, 129195321);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-02-2021', 'dd-mm-yyyy'), '9:00', '20:30', 3, 602026165, 744764697);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-02-2021', 'dd-mm-yyyy'), '12:00', '22:30', 4, 206213664, 418481619);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-05-2021', 'dd-mm-yyyy'), '10:30', '22:00', 5, 487861711, 694803403);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-07-2020', 'dd-mm-yyyy'), '12:00', '20:00', 5, 683894482, 339607802);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-10-2023', 'dd-mm-yyyy'), '12:30', '15:30', 3, 721527128, 126762133);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-03-2021', 'dd-mm-yyyy'), '8:30', '16:00', 5, 309169041, 485862308);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-04-2023', 'dd-mm-yyyy'), '9:00', '21:30', 5, 271482442, 115967722);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-09-2021', 'dd-mm-yyyy'), '8:30', '18:30', null, 901502896, 837052178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-02-2023', 'dd-mm-yyyy'), '13:00', '16:00', null, 992615606, 837052178);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-05-2020', 'dd-mm-yyyy'), '14:30', '23:30', 5, 973970811, 478765875);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-03-2021', 'dd-mm-yyyy'), '10:30', '16:30', 5, 936769324, 468127207);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-07-2021', 'dd-mm-yyyy'), '14:30', '19:00', null, 821874383, 462552035);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-01-2021', 'dd-mm-yyyy'), '9:30', '15:00', 5, 654126598, 846842975);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-07-2022', 'dd-mm-yyyy'), '11:30', '22:30', null, 396481548, 915559018);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-06-2022', 'dd-mm-yyyy'), '11:00', '16:00', 5, 645064381, 734673425);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-07-2020', 'dd-mm-yyyy'), '10:30', '18:30', 5, 768584445, 120974857);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-06-2020', 'dd-mm-yyyy'), '8:30', '19:30', 3, 697015085, 533177138);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-11-2022', 'dd-mm-yyyy'), '14:00', '19:30', 3, 497974425, 768584445);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-10-2023', 'dd-mm-yyyy'), '8:00', '17:30', 3, 991065502, 529485293);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-05-2022', 'dd-mm-yyyy'), '11:00', '15:30', null, 511064174, 911869430);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-10-2021', 'dd-mm-yyyy'), '9:00', '21:30', 4, 360999355, 815054512);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-09-2023', 'dd-mm-yyyy'), '13:00', '21:00', null, 197218839, 164877394);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-03-2023', 'dd-mm-yyyy'), '12:00', '18:00', 4, 907424842, 259281637);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-03-2022', 'dd-mm-yyyy'), '12:30', '22:30', 5, 187453014, 576647580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-10-2022', 'dd-mm-yyyy'), '8:00', '21:00', null, 474646280, 259281637);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-11-2022', 'dd-mm-yyyy'), '12:00', '15:30', null, 616311456, 349290214);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-03-2020', 'dd-mm-yyyy'), '9:30', '17:00', 5, 228056872, 902058409);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-07-2022', 'dd-mm-yyyy'), '8:00', '21:30', 3, 518048280, 770156282);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-07-2022', 'dd-mm-yyyy'), '14:00', '19:00', 4, 998764869, 972229832);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('05-06-2021', 'dd-mm-yyyy'), '10:30', '19:00', 4, 553025263, 107444785);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-04-2023', 'dd-mm-yyyy'), '12:00', '20:30', null, 441896465, 576647580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2021', 'dd-mm-yyyy'), '10:00', '17:00', 5, 625557611, 559292166);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('15-02-2021', 'dd-mm-yyyy'), '11:00', '23:00', null, 206213664, 274807987);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-10-2023', 'dd-mm-yyyy'), '11:00', '19:00', 4, 912577195, 277855177);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-06-2022', 'dd-mm-yyyy'), '14:30', '18:00', null, 308829624, 854805518);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-11-2022', 'dd-mm-yyyy'), '9:00', '19:30', 5, 221497111, 287920615);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-05-2020', 'dd-mm-yyyy'), '9:00', '18:00', 4, 611218507, 702330680);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-09-2021', 'dd-mm-yyyy'), '10:30', '15:00', 4, 551407504, 140359430);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-01-2021', 'dd-mm-yyyy'), '11:30', '18:30', 4, 441752575, 250253966);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-04-2020', 'dd-mm-yyyy'), '11:00', '22:00', 4, 193367254, 425485955);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2023', 'dd-mm-yyyy'), '14:00', '22:30', 5, 277855177, 968243817);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-03-2022', 'dd-mm-yyyy'), '14:30', '21:00', 3, 240921696, 992615606);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-09-2023', 'dd-mm-yyyy'), '11:00', '17:00', 4, 420154025, 816251377);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-01-2021', 'dd-mm-yyyy'), '9:00', '18:30', 4, 992615606, 840341264);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-09-2021', 'dd-mm-yyyy'), '12:00', '18:30', null, 794769332, 480996732);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-07-2023', 'dd-mm-yyyy'), '11:00', '20:00', 5, 504048563, 779757808);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-03-2020', 'dd-mm-yyyy'), '12:00', '16:30', 3, 667176850, 687537052);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-01-2020', 'dd-mm-yyyy'), '10:30', '21:30', 4, 785307559, 714440128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-08-2021', 'dd-mm-yyyy'), '11:00', '16:00', 4, 200971969, 242113481);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-05-2023', 'dd-mm-yyyy'), '12:30', '16:30', 5, 293210110, 399360066);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-11-2021', 'dd-mm-yyyy'), '11:30', '22:00', 4, 801616613, 541784559);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-07-2023', 'dd-mm-yyyy'), '10:30', '23:00', 5, 805723700, 385313476);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-09-2021', 'dd-mm-yyyy'), '11:30', '17:00', 5, 858616442, 140359430);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-09-2022', 'dd-mm-yyyy'), '13:30', '20:30', 1, 856694332, 974400788);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-03-2021', 'dd-mm-yyyy'), '14:30', '16:00', 4, 308829624, 876541800);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-05-2021', 'dd-mm-yyyy'), '11:00', '19:30', null, 943569264, 433116488);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-05-2022', 'dd-mm-yyyy'), '10:00', '22:30', null, 706326162, 737627430);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-10-2021', 'dd-mm-yyyy'), '12:00', '19:00', 4, 337816724, 274807987);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-01-2020', 'dd-mm-yyyy'), '12:00', '16:30', 4, 360000709, 972229832);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-03-2022', 'dd-mm-yyyy'), '9:00', '20:30', 4, 598623933, 753638601);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-11-2020', 'dd-mm-yyyy'), '9:30', '15:00', 5, 294004123, 583838247);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-02-2020', 'dd-mm-yyyy'), '9:00', '22:30', null, 651855962, 799597846);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-08-2021', 'dd-mm-yyyy'), '8:00', '20:30', 4, 377729240, 895629963);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-07-2022', 'dd-mm-yyyy'), '10:30', '22:00', null, 410848744, 601701489);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-02-2020', 'dd-mm-yyyy'), '14:00', '17:30', 4, 926537995, 792482323);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-10-2020', 'dd-mm-yyyy'), '11:00', '17:30', 3, 741076529, 789087097);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-04-2022', 'dd-mm-yyyy'), '8:30', '19:00', 5, 598227354, 462552035);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-09-2021', 'dd-mm-yyyy'), '12:00', '18:30', null, 541868230, 388799844);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-04-2020', 'dd-mm-yyyy'), '9:30', '18:00', null, 525588342, 355146666);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-11-2021', 'dd-mm-yyyy'), '10:00', '23:00', 4, 776623460, 522099376);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-12-2023', 'dd-mm-yyyy'), '10:00', '22:30', 5, 403418492, 185794095);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-08-2022', 'dd-mm-yyyy'), '8:00', '22:30', 4, 697015085, 724109514);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-10-2022', 'dd-mm-yyyy'), '8:00', '22:30', 3, 251279284, 799597846);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-11-2020', 'dd-mm-yyyy'), '10:00', '21:00', 5, 444894245, 542084528);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-08-2021', 'dd-mm-yyyy'), '9:30', '19:00', null, 755209681, 374356341);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-08-2023', 'dd-mm-yyyy'), '12:30', '18:30', null, 175518300, 640098230);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-06-2022', 'dd-mm-yyyy'), '11:00', '22:30', 5, 580351317, 763635580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-09-2022', 'dd-mm-yyyy'), '13:00', '19:30', 4, 638404454, 721527128);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-09-2023', 'dd-mm-yyyy'), '10:00', '19:30', 5, 995849472, 194549335);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-12-2021', 'dd-mm-yyyy'), '13:30', '20:00', 3, 326667328, 402986300);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-02-2023', 'dd-mm-yyyy'), '13:30', '19:00', 5, 878452649, 448882818);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-06-2023', 'dd-mm-yyyy'), '9:30', '15:30', null, 141926107, 204794274);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-01-2020', 'dd-mm-yyyy'), '10:00', '23:00', 5, 308829624, 448882818);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-08-2022', 'dd-mm-yyyy'), '13:00', '22:00', 3, 234814837, 420154025);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-06-2022', 'dd-mm-yyyy'), '8:30', '17:00', null, 621738771, 763635580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('26-08-2022', 'dd-mm-yyyy'), '10:30', '20:30', 5, 725612282, 274715538);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-08-2021', 'dd-mm-yyyy'), '11:00', '22:30', 3, 478438487, 799597846);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-08-2021', 'dd-mm-yyyy'), '8:00', '21:30', 3, 410848744, 482685638);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-12-2022', 'dd-mm-yyyy'), '9:30', '16:30', 4, 880283169, 566408163);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-12-2022', 'dd-mm-yyyy'), '14:30', '23:00', null, 998764869, 572028348);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-09-2020', 'dd-mm-yyyy'), '11:00', '15:00', null, 598227354, 697015085);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-05-2022', 'dd-mm-yyyy'), '10:30', '19:00', 5, 670693235, 607668294);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-09-2020', 'dd-mm-yyyy'), '11:30', '22:00', null, 139741096, 386928076);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-07-2022', 'dd-mm-yyyy'), '8:00', '16:30', 4, 880283169, 177060427);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-01-2023', 'dd-mm-yyyy'), '13:30', '22:30', 5, 661315918, 282560191);
commit;
prompt 300 records committed...
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-10-2023', 'dd-mm-yyyy'), '11:30', '23:00', null, 609774041, 182055053);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-12-2020', 'dd-mm-yyyy'), '14:30', '17:00', 4, 323888942, 445960804);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-10-2022', 'dd-mm-yyyy'), '14:30', '16:30', 5, 720258585, 103639039);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-07-2023', 'dd-mm-yyyy'), '11:30', '15:30', 4, 616311456, 399360066);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-09-2023', 'dd-mm-yyyy'), '10:30', '17:30', null, 854805518, 560105519);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-06-2022', 'dd-mm-yyyy'), '9:00', '23:00', 4, 609774041, 816505320);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-05-2020', 'dd-mm-yyyy'), '12:00', '15:30', 2, 327370740, 737627430);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-07-2022', 'dd-mm-yyyy'), '10:00', '23:00', 3, 331919904, 770156282);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-07-2023', 'dd-mm-yyyy'), '8:30', '17:00', 4, 826640267, 747163297);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-01-2021', 'dd-mm-yyyy'), '12:00', '15:30', 4, 235280458, 420154025);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-04-2023', 'dd-mm-yyyy'), '13:30', '21:30', null, 779283595, 926497407);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-09-2021', 'dd-mm-yyyy'), '14:00', '20:30', 5, 505992549, 912774864);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-01-2020', 'dd-mm-yyyy'), '13:30', '16:00', 5, 370336079, 765327686);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-12-2021', 'dd-mm-yyyy'), '9:30', '16:00', 5, 116462353, 724109514);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-12-2022', 'dd-mm-yyyy'), '12:30', '18:00', 4, 110437201, 644116143);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-10-2023', 'dd-mm-yyyy'), '14:30', '15:30', 4, 897443171, 118236069);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-03-2021', 'dd-mm-yyyy'), '8:30', '23:00', 5, 418481619, 957537094);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-12-2023', 'dd-mm-yyyy'), '10:30', '20:00', 4, 305926726, 214271290);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-01-2022', 'dd-mm-yyyy'), '8:00', '23:30', 4, 267248998, 129195321);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-02-2021', 'dd-mm-yyyy'), '8:30', '19:30', null, 504390279, 182055053);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-03-2022', 'dd-mm-yyyy'), '8:00', '21:30', 4, 656802060, 970123677);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-08-2022', 'dd-mm-yyyy'), '10:00', '21:30', null, 654126598, 829260788);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-05-2022', 'dd-mm-yyyy'), '13:00', '21:00', 2, 826640267, 694209395);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-03-2023', 'dd-mm-yyyy'), '13:30', '15:30', 4, 661216534, 890819891);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('15-10-2021', 'dd-mm-yyyy'), '13:00', '18:30', 5, 434361920, 712214343);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-06-2023', 'dd-mm-yyyy'), '9:00', '22:00', 4, 286942816, 638472575);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-04-2021', 'dd-mm-yyyy'), '13:30', '19:30', 3, 200971969, 343057735);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-11-2020', 'dd-mm-yyyy'), '14:00', '23:00', 5, 258945756, 907424842);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-10-2021', 'dd-mm-yyyy'), '13:00', '17:30', 4, 938406845, 310279833);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-09-2020', 'dd-mm-yyyy'), '10:00', '18:00', 5, 768584445, 274807987);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-05-2023', 'dd-mm-yyyy'), '10:30', '20:00', 4, 572005342, 895943487);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-05-2022', 'dd-mm-yyyy'), '8:00', '16:00', 5, 651855962, 482986698);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-07-2023', 'dd-mm-yyyy'), '8:00', '18:00', 5, 579654604, 129195321);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-05-2022', 'dd-mm-yyyy'), '14:30', '23:00', 4, 214684922, 977848457);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-07-2020', 'dd-mm-yyyy'), '11:30', '15:30', 5, 997569877, 854805518);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-01-2021', 'dd-mm-yyyy'), '11:30', '15:00', 4, 573087122, 570993504);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-07-2023', 'dd-mm-yyyy'), '13:00', '15:30', 3, 554489252, 796357825);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-06-2021', 'dd-mm-yyyy'), '12:30', '22:30', 4, 157820082, 234029909);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-12-2023', 'dd-mm-yyyy'), '12:30', '16:30', null, 171853644, 682573186);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-10-2023', 'dd-mm-yyyy'), '14:30', '22:00', 1, 441752575, 143766014);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-09-2021', 'dd-mm-yyyy'), '14:30', '15:30', 5, 785974864, 462552035);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-06-2020', 'dd-mm-yyyy'), '8:30', '19:30', 4, 406508183, 694209395);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-03-2020', 'dd-mm-yyyy'), '11:00', '21:30', 1, 617533806, 251279284);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-09-2022', 'dd-mm-yyyy'), '8:00', '20:00', null, 604613699, 547461534);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2021', 'dd-mm-yyyy'), '8:00', '23:30', null, 753413531, 221497111);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-03-2023', 'dd-mm-yyyy'), '8:30', '19:30', null, 553517298, 294004123);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('20-01-2023', 'dd-mm-yyyy'), '11:00', '18:00', 3, 871722354, 541784559);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-01-2023', 'dd-mm-yyyy'), '13:00', '22:30', 4, 580351317, 382678745);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-04-2020', 'dd-mm-yyyy'), '11:30', '19:30', 3, 308829624, 487955324);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('07-08-2022', 'dd-mm-yyyy'), '12:00', '18:30', 3, 355146666, 377585071);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-09-2021', 'dd-mm-yyyy'), '12:30', '22:30', 4, 763635580, 108400326);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-10-2023', 'dd-mm-yyyy'), '9:30', '19:30', 2, 652916189, 576647580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-02-2021', 'dd-mm-yyyy'), '14:00', '18:30', 3, 529485293, 171796939);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-02-2021', 'dd-mm-yyyy'), '14:30', '19:00', null, 249640786, 271296079);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-07-2020', 'dd-mm-yyyy'), '12:00', '21:30', null, 529485293, 370571857);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('24-09-2020', 'dd-mm-yyyy'), '10:30', '23:00', 3, 234449706, 189535699);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-08-2020', 'dd-mm-yyyy'), '9:00', '18:00', 5, 305926726, 135014039);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-07-2022', 'dd-mm-yyyy'), '14:30', '19:00', 5, 770156282, 879054575);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('31-05-2023', 'dd-mm-yyyy'), '13:00', '23:30', 5, 723305141, 357643935);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-05-2023', 'dd-mm-yyyy'), '12:00', '20:00', 4, 438885298, 660043671);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-03-2023', 'dd-mm-yyyy'), '8:00', '23:30', 3, 668312397, 635968955);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-09-2023', 'dd-mm-yyyy'), '10:00', '23:30', null, 570993504, 194549335);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('13-05-2021', 'dd-mm-yyyy'), '10:00', '15:00', 5, 667176850, 185794095);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-04-2022', 'dd-mm-yyyy'), '11:30', '21:30', 4, 492052662, 551526087);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-09-2020', 'dd-mm-yyyy'), '13:00', '17:30', 4, 487861711, 385313476);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('08-01-2023', 'dd-mm-yyyy'), '10:00', '16:30', 4, 838232400, 516162245);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-10-2020', 'dd-mm-yyyy'), '11:30', '23:30', 4, 877677760, 274715538);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-07-2021', 'dd-mm-yyyy'), '11:00', '19:30', 5, 584640968, 976175712);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('02-03-2020', 'dd-mm-yyyy'), '10:00', '20:30', null, 609774041, 992615606);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-02-2020', 'dd-mm-yyyy'), '14:30', '15:30', 3, 271296079, 360999355);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('06-06-2023', 'dd-mm-yyyy'), '13:00', '16:00', 4, 558169743, 318609792);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('04-05-2022', 'dd-mm-yyyy'), '11:30', '17:30', null, 805558047, 937043198);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('18-11-2023', 'dd-mm-yyyy'), '9:00', '16:00', null, 672588466, 720417144);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-11-2023', 'dd-mm-yyyy'), '13:30', '15:30', null, 816391512, 617533806);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('09-04-2022', 'dd-mm-yyyy'), '8:30', '21:00', 5, 986676799, 274807987);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-04-2023', 'dd-mm-yyyy'), '8:30', '20:30', 3, 403418492, 177060427);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('23-07-2021', 'dd-mm-yyyy'), '13:30', '19:00', 5, 710261527, 763635580);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-08-2020', 'dd-mm-yyyy'), '13:30', '21:00', 3, 175567621, 339493176);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('28-08-2021', 'dd-mm-yyyy'), '14:30', '17:30', 3, 441225071, 360000709);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-05-2020', 'dd-mm-yyyy'), '12:30', '20:00', null, 129195321, 937043198);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('11-03-2022', 'dd-mm-yyyy'), '12:00', '19:00', 3, 199668456, 785202161);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('16-12-2021', 'dd-mm-yyyy'), '8:00', '21:00', 5, 305926726, 885809424);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-03-2021', 'dd-mm-yyyy'), '10:30', '21:30', 4, 943569264, 995631486);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-09-2022', 'dd-mm-yyyy'), '14:30', '21:00', 4, 989941934, 731631935);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('29-01-2022', 'dd-mm-yyyy'), '12:30', '22:00', 5, 806611140, 644414827);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('30-08-2020', 'dd-mm-yyyy'), '14:00', '21:30', 5, 479537259, 840341264);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('19-12-2023', 'dd-mm-yyyy'), '10:30', '21:30', 5, 742292557, 164877394);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('17-12-2020', 'dd-mm-yyyy'), '12:30', '19:30', 3, 185794095, 443991351);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('03-11-2020', 'dd-mm-yyyy'), '12:00', '20:00', 5, 228056872, 490850485);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('22-12-2022', 'dd-mm-yyyy'), '11:30', '17:00', 4, 792482323, 310735882);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('12-02-2020', 'dd-mm-yyyy'), '10:30', '18:30', null, 962588264, 566408163);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('14-11-2022', 'dd-mm-yyyy'), '14:30', '16:00', 4, 323888942, 799597846);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('27-05-2021', 'dd-mm-yyyy'), '12:30', '18:30', 4, 891087041, 694803403);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-05-2020', 'dd-mm-yyyy'), '12:00', '16:00', 3, 557605097, 110437201);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('10-04-2023', 'dd-mm-yyyy'), '11:30', '18:00', 3, 553025263, 708612515);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('21-08-2021', 'dd-mm-yyyy'), '11:00', '17:00', 4, 293210110, 458408009);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-01-2022', 'dd-mm-yyyy'), '14:30', '18:30', 3, 463520539, 907424842);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-10-2021', 'dd-mm-yyyy'), '12:00', '15:30', null, 621738771, 871846808);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('01-05-2022', 'dd-mm-yyyy'), '10:30', '21:30', 3, 553517298, 129195321);
insert into YOLEDETSERVICEGIVER (ysg_dateofservice, ysg_starttime, ysg_endtime, ysg_rating, ym_id, sgm_id)
values (to_date('25-09-2023', 'dd-mm-yyyy'), '14:00', '16:00', null, 806840454, 595271596);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for SERVICEGIVER...
alter table SERVICEGIVER enable constraint SYS_C008591;
prompt Enabling foreign key constraints for BABYSITTING...
alter table BABYSITTING enable constraint SYS_C008600;
prompt Enabling foreign key constraints for CLEANING...
alter table CLEANING enable constraint SYS_C008603;
prompt Enabling foreign key constraints for COMMUNITYMEMBER...
alter table COMMUNITYMEMBER enable constraint SYS_C008615;
alter table COMMUNITYMEMBER enable constraint SYS_C008616;
prompt Enabling foreign key constraints for CONSULTING...
alter table CONSULTING enable constraint SYS_C008596;
prompt Enabling foreign key constraints for TIMES...
alter table TIMES enable constraint SYS_C008623;
prompt Enabling foreign key constraints for YOLEDET...
alter table YOLEDET enable constraint SYS_C008588;
prompt Enabling foreign key constraints for YOLEDETSERVICEGIVER...
alter table YOLEDETSERVICEGIVER enable constraint SYS_C008630;
alter table YOLEDETSERVICEGIVER enable constraint SYS_C008631;
prompt Enabling triggers for CMEMBER...
alter table CMEMBER enable all triggers;
prompt Enabling triggers for SERVICEGIVER...
alter table SERVICEGIVER enable all triggers;
prompt Enabling triggers for BABYSITTING...
alter table BABYSITTING enable all triggers;
prompt Enabling triggers for CLEANING...
alter table CLEANING enable all triggers;
prompt Enabling triggers for COMMUNITY...
alter table COMMUNITY enable all triggers;
prompt Enabling triggers for COMMUNITYMEMBER...
alter table COMMUNITYMEMBER enable all triggers;
prompt Enabling triggers for CONSULTING...
alter table CONSULTING enable all triggers;
prompt Enabling triggers for TIMES...
alter table TIMES enable all triggers;
prompt Enabling triggers for YOLEDET...
alter table YOLEDET enable all triggers;
prompt Enabling triggers for YOLEDETSERVICEGIVER...
alter table YOLEDETSERVICEGIVER enable all triggers;

set feedback on
set define on
prompt Done
