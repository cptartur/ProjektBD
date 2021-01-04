import random
import sys
from faker import Faker
fake = Faker()

people = []
if len(sys.argv) > 1:
    n = int(sys.argv[1])
    for i in range(n):
        name, surename = fake.name().split()
        pesel = random.randint(10000000000, 99999999999)
        ulga = 'NULL'
        person = f'(\'{name}\', \'{surename}\', {pesel}, {ulga}),\n'
        people.append(person)
    people[-1] = people[-1].rstrip(',\n')
    with open('people.txt', 'w') as f:
        f.write('VALUES\n')
        for i in people:
            f.write(i)
else:
    print('not enough arguments')