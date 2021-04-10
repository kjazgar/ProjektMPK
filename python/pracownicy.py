import random
# Using readlines()
file1 = open('names.txt', 'r')
Lines = file1.readlines()

count = 0
# Strips the newline character
ctr = 0
for line in Lines:
    ctr += 1
    name, surrname = line[:-1].split(" ")
    sex = 'M'
    if name[-1] == 'a':
        sex = 'K'

    if ctr <= 50:
        print("EXEC Wstaw_motorniczego " + name + ", " + surrname + ", " + sex + ", " + str(random.randint(1, 3)))
    else:
        print("EXEC Wstaw_kierowce " + name + ", " + surrname + ", " + sex + ", " + str(random.randint(1, 3)))