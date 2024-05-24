
[General]
Version=1

[Preferences]
Username=
Password=2744
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=COMMUNITYMEMBER
Count=1000

[Record]
Name=C_ID
Type=NUMBER
Size=
Data=List(select C_id from Community)
Master=

[Record]
Name=M_ID
Type=NUMBER
Size=
Data=List(select M_id from CMember)
Master=

