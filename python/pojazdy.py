names_tram = ['KWADRACIAK', 'LAJKONIK', 'KRAKOWIAK']
names_bus = ['SOLARIS', 'MERCEDES', 'ELECTRON']

for i in range(31):
    if i <= 10:
        print("EXEC Wstaw_tramwaj " + names_tram[0] + str(i) + ", 1")
    elif 10 < i and i <= 20:
        print("EXEC Wstaw_tramwaj " + names_tram[1] + str(i) + ", 2")
    elif 20 < i and i <= 30:
        print("EXEC Wstaw_tramwaj " + names_tram[2] + str(i) + ", 3")

for i in range(31):
    if i <= 10:
        print("EXEC Wstaw_autobus " + names_bus[0] + str(i) + ", 0")
    elif 10 < i and i <= 20:
        print("EXEC Wstaw_autobus " + names_bus[1] + str(i) + ", 0")
    elif 20 < i and i <= 30:
        print("EXEC Wstaw_autobus " + names_bus[2] + str(i) + ", 1")
