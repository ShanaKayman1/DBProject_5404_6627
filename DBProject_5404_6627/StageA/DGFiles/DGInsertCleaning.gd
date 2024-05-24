
[General]
Version=1

[Preferences]
Username=
Password=2932
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=CLEANING
Count=400

[Record]
Name=CL_TYPEOFCLEANING
Type=VARCHAR2
Size=20
Data=List(,floors,windows,dishes,laundry,ironing,everything,dusting)
Master=

[Record]
Name=SGM_ID
Type=NUMBER
Size=
Data=List(select SGM_id from ServiceGiver)
Master=

