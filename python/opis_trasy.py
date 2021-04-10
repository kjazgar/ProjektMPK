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

print("INSERT INTO Opis_trasy")
print("VALUES")

file1 = open('linie.txt', 'r')
file_names = file1.readlines()
wrong = []
relation_id = 0
relations = {}
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
                next_id = int(Lines[i+4].strip()) + 1
            else:
                next_id = "NULL"
            previous_id = current_id
            current_id = int(line)+1

            count += 1

            if count%900 == 0:
                print("INSERT INTO Opis_trasy")
                print("VALUES")
            print('( ' + str(relation_id) + ", " + str(current_id) + ", " + str(previous_id) + ", " + str(next_id) + " ),")


    except:
        wrong.append(file)
        continue

