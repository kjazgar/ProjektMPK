import re
file1 = open('przystanki.txt', 'r')
Lines = file1.readlines()
stops = {}

counter = 0
for line in Lines:
    counter += 1
    name = " ".join(line[:-1].split(" ")[1:])
    stops[counter] = name

file1 = open('linie.txt', 'r')
Lines = file1.readlines()

liniiosy = {}
count = 0
for line in Lines:
    number, rest = line.split("-")
    a, b = rest.split('.')
    if a[-1] != '0':
        continue

    count += 1

    is_tram = 0 if len(number) > 2 else 1
    liniiosy[int(number)] = count

print("INSERT INTO Godziny_odjazdow")
print("VALUES")

file1 = open('linie.txt', 'r')
file_names = file1.readlines()
wrong = []
relation_id = 0
relations = {}
id_opis_trasy = 0
opisy_trasy = {}
count = 0
for file in file_names:
    try:
        file1 = open("lines/" + file[:-1], 'r')
        Lines = file1.readlines()

        line_id = liniiosy[int(Lines[0][:-1])]
        for i in range(3, len(Lines), 4):
            line = Lines[i].strip()
            stop_id = int(line)+1
            if i == 3:
                start_stop = stop_id

            if i == len(Lines)-1:
                end_stop = stop_id

        relation_id += 1
        relations[file[:-1]] = relation_id

        previous_id = "NULL"
        current_id = "NULL"
        next_id = "NULL"
        for i in range(3, len(Lines), 4):
            line = Lines[i].strip()
            if i+4 < len(Lines):
                next_id = Lines[i+4].strip()
            else:
                next_id = "NULL"
            previous_id = current_id
            current_id = int(line)+1

            id_opis_trasy += 1
            opisy_trasy[(relation_id, current_id)] = id_opis_trasy

        for i in range(3, len(Lines), 4):
            line = Lines[i].strip()
            current_id = int(line)+1

            ot_id = opisy_trasy[(relation_id, current_id)]

            old_times = []
            for j in range(1,4):
                rodzaj_dnia = ""
                if j == 1:
                    rodzaj_dnia = "POWSZEDNI"
                elif j == 2:
                    rodzaj_dnia = "SOBOTA"
                else:
                    rodzaj_dnia = "NIEDZIELA"

                new_line = Lines[i+j].strip()

                times = []
                if new_line == "BRAK":
                    continue
                elif new_line == "JAKWYZEJ":
                    times = old_times
                else:
                    times = Lines[i+j].strip().split(',')

                for time in times:
                    time = re.sub('\D', '', time)
                    time = "'" + time[:-2] + ":" + time[-2:] + "'"
                    count += 1
                    if count >= 10000:
                        raise Exception

                    if count%900 == 0:
                        print("INSERT INTO Godziny_odjazdow")
                        print("VALUES")

                    print('( ' + str(ot_id) + ", " + str(time) + ", '" + str(rodzaj_dnia) + "' ),")


    except:
        wrong.append(file)
        continue

