import sys
from faker import Faker

fake = Faker('pl_PL')
if len(sys.argv) > 2:
    n = int(sys.argv[1])
    type = sys.argv[2]
    stops = []
    for i in range(n):
        name = fake.street_name()
        coord = fake.coordinate()
        stop = f'(\'{name}\', \'{coord}\', \'{type}\', 0),\n'
        stops.append(stop)
    stops[-1] = stops[-1].rstrip(',\n')
    with open('stops.txt', 'w', encoding='utf-8') as f:
        f.write('INSERT INTO Przystanki\nVALUES\n')
        for i in stops:
            f.write(i)
else:
    print('not enough arguments')