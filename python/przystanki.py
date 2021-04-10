file1 = open('przystanki.txt', 'r')
Lines = file1.readlines()

print("INSERT INTO Przystanki")
print("VALUES")

counter = 0
for line in Lines:
    name = " ".join(line[:-1].split(" ")[1:])
    print("( '" + name +"' ),")