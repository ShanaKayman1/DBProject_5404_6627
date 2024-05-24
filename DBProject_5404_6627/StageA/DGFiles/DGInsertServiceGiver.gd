
[General]
Version=1

[Preferences]
Username=
Password=2402
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=SERVICEGIVER
Count=600

[Record]
Name=SG_PRICE
Type=NUMBER
Size=
Data=List(,,,,,,,,,10.00,20.00,25.00,30.00)
Master=

[Record]
Name=SG_DETAILS
Type=VARCHAR2
Size=100
Data=components.description
Master=

[Record]
Name=SGM_ID
Type=NUMBER
Size=
Data=List(select M_id from CMember)
Master=

