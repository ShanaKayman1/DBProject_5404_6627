
[General]
Version=1

[Preferences]
Username=
Password=2400
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=BABYSITTING
Count=400

[Record]
Name=B_GENDER
Type=VARCHAR2
Size=1
Data=List('F','M','B')
Master=

[Record]
Name=B_AGE
Type=NUMBER
Size=
Data=random(1,12)
Master=

[Record]
Name=B_YEARSOFEXPERIENCE
Type=NUMBER
Size=
Data=random(0,10)
Master=

[Record]
Name=B_MAXNUMOFCHILDREN
Type=NUMBER
Size=
Data=random(1,10)
Master=

[Record]
Name=SGM_ID
Type=NUMBER
Size=
Data=List(select SGM_id from ServiceGiver)
Master=

