import random
# Using readlines()
file1 = open('linie.txt', 'r')
Lines = file1.readlines()

print("INSERT INTO Linie")
print("VALUES")

count = 0
for line in Lines:
    number, rest = line.split("-")
    a, b = rest.split('.')
    if a[-1] != '0':
        continue

    is_tram = 0 if len(number) > 2 else 1
    print('( ' + number + ", " + str(is_tram) + ' ),')


