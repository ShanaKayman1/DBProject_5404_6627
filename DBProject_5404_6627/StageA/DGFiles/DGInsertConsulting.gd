
[General]
Version=1

[Preferences]
Username=
Password=2596
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=EFRAT
Name=CONSULTING
Count=400

[Record]
Name=CNS_LOCATION
Type=VARCHAR2
Size=100
Data=
Master=

[Record]
Name=CNS_TYPE
Type=VARCHAR2
Size=20
Data=List(General,Lactation Consultant, Sleep Consultant, Postpartum Doula, Parenting Coach, Nutrition Consultant, Mental Health Counselor, Financial Consultant, Career Coach, Babywearing Consultant, Childproofing Consultant, Pediatric Sleep Specialist, Fitness Trainer, Doula, Developmental Consultant, Home Organization Consultant)
Master=

[Record]
Name=CNS_YEARSOFEXPERIENCE
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

