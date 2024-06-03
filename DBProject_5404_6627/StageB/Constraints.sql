------ DEFAULT ------

alter table Yoledet 
      modify Y_numOfChildern INT default 1;


insert into EFRAT.YOLEDET (YM_ID)
values (100148653);

select * from yoledet y where y.ym_id=100148653;


-- NULLABLE COLUMN --

alter table Community modify C_location null;


insert into COMMUNITY (C_ID, C_NAME, C_DESCRIPTION, C_NUMOFMEMBERS)
values (401, 'AAA', 'aaa', 100);     --threw error before altering

select * from Community c where c.c_id=401;


------ CHECK -------

alter table YoledetServiceGiver
      add constraint check_different_members
      check (YM_id != SGM_id);


insert into EFRAT.YOLEDETSERVICEGIVER (YSG_DATEOFSERVICE, YSG_STARTTIME, YSG_ENDTIME, YSG_RATING, YM_ID, SGM_ID)
values (to_date('02-07-2021', 'dd-mm-yyyy'), '8:30', '17:00', 5, 779283595, 779283595);           --threw error after altering




