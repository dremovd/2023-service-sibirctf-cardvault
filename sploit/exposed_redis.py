import requests
import random
import json
from urllib.parse import urlparse

BACK_PORT = 7000
FRONT_PORT = 8080
redis_host = host = '144.76.26.107'

def build_payment(goods, cvv):
    return {
      'amount': sum([g['price'] for g in goods]),
      'items': goods,
      'order_id': random.randint(100000, 999999),
      'card': {
        'pan': "2222405343248877",
        'exp_date_month': "01",
        'exp_date_year': "25",
        'cardholder': "Ivan Ivanov",
        'cvv': cvv
      }
    }

items = [
    { "description": 'Fatty Doo Doo DVD', "price": 0.8 },
    { "description": 'Guzungas Gentlemans Magazine', "price": 0.7 },
    { "description": 'The Spirit of Christmas Film Reel', "price": 0.8 },
    { "description": 'VHS What Are These Changes? VHS', "price": 0.4 },
    { "description": 'What Happened To My School', "price": 1.0 },
    { "description": 'A Bowl of Craft Dinner', "price": 0.5 },
    { "description": 'Afghani Goat', "price": 4.0 },
    { "description": 'Alabama Man', "price": 0.5 },
    { "description": 'Antonio Banderas Love Doll', "price": 0.7 },
    { "description": 'Asses of Fire 2 poster', "price": 0.2 },
]

def send_payment_1(custom):
    endpoint = f"http://{host}:{BACK_PORT}/{custom}/payments"
    print(f"[ SENDPAYMENT ] set demo payment to {endpoint}")
    data = build_payment(
        goods=random.sample(items, random.randint(1, 6)),
        cvv=str(random.randint(100, 999))
    )
    response = requests.post(endpoint, json=data, headers={'Content-Type': 'application/json', 'Accept': 'application/json'})
    print(f"[ SENDPAYMENT ] payment data {data}")
    return response.text[14:-4]  # Assuming specific response formatting

terminal_key = "test_123"
send_payment_1(terminal_key)
import redis
redis_port = 8899
r = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)

all_keys = r.keys('*')
for key in r.scan_iter("*"):
    value = r.get(key)
    print(f"{key = }")
    print(f"{value = }")
    url = f'http://{host}:{BACK_PORT}/{terminal_key}/payments/{key.split(":")[-1]}'
    print(url)
    response = requests.get(url, verify=False)
    print(response.status_code)
    print(response.text)

    # delete the key from redis
    r.delete(key)
