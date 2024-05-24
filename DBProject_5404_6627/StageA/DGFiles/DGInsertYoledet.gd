
[General]
Version=1

[Preferences]
Username=
Password=2237
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=YOLEDET
Count=400

[Record]
Name=Y_NUMOFCHILDERN
Type=NUMBER
Size=
Data=Random(1,15)
Master=

[Record]
Name=YM_ID
Type=NUMBER
Size=
Data=List(select M_id from CMember)
Master=

