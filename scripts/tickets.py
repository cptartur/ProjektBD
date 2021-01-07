import random
import sys
import time
from datetime import datetime, timedelta

def random_date(seed):
    random.seed(seed)
    d = random.randint(1, int(time.time()))
    x =  datetime.fromtimestamp(d)
    x1 = x + timedelta(days=30)
    return x.strftime('%Y-%m-%d'), x1.strftime('%Y-%m-%d')

if len(sys.argv) > 1:
    n = int(sys.argv[1])
    tickets = []
    types = [
        ('normalny', 50)
    ]
    for i in range(1, n + 1):
        id = i
        type = random.choice(types)
        start_date, expiration_date = random_date(random.randint(100, 200))
        point_id = random.randint(2, 5)
        ticket = (f'({id}, \'{type[0]}\', {type[1]}.00, \'{start_date}\', '
                  f'\'{expiration_date}\', {point_id}),\n')
        tickets.append(ticket)
    tickets[-1] = tickets[-1].rstrip(',\n')
    with open('stops.txt', 'w', encoding='utf-8') as f:
        f.write('INSERT INTO Bilety\nVALUES\n')
        for i in tickets:
            f.write(i)
else:
    print('not enough arguments')