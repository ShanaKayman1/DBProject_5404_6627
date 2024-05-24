
[General]
Version=1

[Preferences]
Username=
Password=2371
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=YOLEDETSERVICEGIVER
Count=400

[Record]
Name=YSG_DATEOFSERVICE
Type=DATE
Size=
Data=Random(1/1/2020, 1/1/2024)
Master=

[Record]
Name=YSG_STARTTIME
Type=VARCHAR2
Size=5
Data=random(08,14) List(':00',':30')
Master=

[Record]
Name=YSG_ENDTIME
Type=VARCHAR2
Size=5
Data=random(15,23) List(':00',':30')
Master=

[Record]
Name=YSG_RATING
Type=NUMBER
Size=
Data=List(,,,,,,,,,,1,2,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5)
Master=

[Record]
Name=YM_ID
Type=NUMBER
Size=
Data=List(select YM_id from Yoledet)
Master=

[Record]
Name=SGM_ID
Type=NUMBER
Size=
Data=List(select SGM_id from ServiceGiver)
Master=

