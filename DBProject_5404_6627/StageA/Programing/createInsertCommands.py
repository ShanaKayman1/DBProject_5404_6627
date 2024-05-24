from random import randint

with open('insertCommunity.sql', 'w') as file:
    names1 = ['Beit', 'Ohel', 'Neve', 'Orot', 'Bnei', 'Har', 'Gan']
    names2 = ['Avraham', 'Yitzhak', 'Yaakov', 'Moshe', 'Aharon', 'David', 'Shlomo', 'Eliezer', 'Eliyaho', 'Yisrael',
              'Reuven', 'Shimon', 'Levi', 'Yehoda', 'Dan', 'Naftali', 'Gad', 'Asher', 'Yosef', 'Binyamin',
              'Menashe', 'Ephraim', 'Sarah', 'Rivka', 'Rachel', ' Lea', 'Dvora', 'Michal', 'Tamar', 'Ester',
              'Rina', 'Tehila ', 'Shalom']
    locations = ['Tel Aviv', 'Jerusalem', 'Haifa', 'Beer Sheva', 'Eilat',
                 'Netanya', 'Ashdod', 'Rishon LeZion', 'Petah Tikva', 'Holon',
                 'Bnei Brak', 'Bat Yam', 'Ashkelon', 'Rehovot', 'Herzliya',
                 'Ramat Gan', 'Kfar Saba', 'Hadera', 'Raanana', 'Modiin',
                 'Nahariya', 'Beit Shemesh', 'Tiberias', 'Kiryat Gat', 'Lod',
                 'Maale Adumim', 'Afula', 'Dimona', 'Kfar Saba', 'Zichron Yaakov']
    len1 = len(names1)
    len2 = len(names2)
    len3 = len(locations)
    for i in range(400):
        C_NAME = names1[i % len1] + ' ' + names2[i % len2]
        C_LOCATION = locations[i % len3]
        C_NUMOFMEMBERS = randint(10, 500)
        C_DESCRIPTION = 'The ' + C_NAME + ' community is located in ' + C_LOCATION + ' and has ' + str(
            C_NUMOFMEMBERS) + ' members.'
        file.write(f"""insert into COMMUNITY (C_ID, C_NAME, C_DESCRIPTION, C_LOCATION, C_NUMOFMEMBERS)
values ({i + 1}, '{C_NAME}', '{C_DESCRIPTION}', '{C_LOCATION}', {C_NUMOFMEMBERS});\n""")

    file.write("commit;\n")
