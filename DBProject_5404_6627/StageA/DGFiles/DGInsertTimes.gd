
[General]
Version=1

[Preferences]
Username=
Password=2019
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=TIMES
Count=400

[Record]
Name=T_DAYOFWEEK
Type=VARCHAR2
Size=20
Data=List(Sunday, Monday, Tuesday, Wednesday, Thursday)
Master=

[Record]
Name=T_STARTTIME
Type=VARCHAR2
Size=5
Data=random(08,14) List(':00',':30')
Master=

[Record]
Name=T_ENDTIME
Type=VARCHAR2
Size=5
Data=random(15,23) List(':00',':30')
Master=

[Record]
Name=T_NUM
Type=NUMBER
Size=
Data=random(1,5)
Master=

[Record]
Name=T_CONSTRAINTS
Type=VARCHAR2
Size=100
Data=
Master=

[Record]
Name=SGM_ID
Type=NUMBER
Size=
Data=List(select SGM_id from ServiceGiver)
Master=

