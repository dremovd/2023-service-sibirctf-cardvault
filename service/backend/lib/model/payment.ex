defmodule CardVault.Model.Payment do
  defstruct [
    :amount,
    :items,
    :order_id,
    :card,
    :token,
    :terminal_key,
    :created_at,
    status: "pending"
  ]

  def create(terminal_key, params) do
    %{
      "amount" => amount,
      "items" => items,
      "order_id" => order_id,
      "card" => %{
        "cardholder" => cardholder,
        "cvv" => cvv,
        "exp_date_month" => exp_date_month,
        "exp_date_year" => exp_date_year,
        "pan" => pan
      }
    } = params

    {:ok, card} =
      CardVault.Model.Card.create(
        pan,
        exp_date_year,
        exp_date_month,
        cvv,
        cardholder
      )

    items =
      Enum.map(items, fn item ->
        %{"price" => price, "description" => description} = item

        {:ok, card} =
          CardVault.Model.Item.create(
            description,
            price
          )

        card
      end)

    payment = %CardVault.Model.Payment{
      amount: amount,
      items: items,
      order_id: order_id,
      card: card,
      terminal_key: terminal_key,
      created_at: Calendar.strftime(DateTime.utc_now(), "%d/%m/%y %H:%M:%S"),
      token: UUID.uuid4()
    }

    {:ok, payment}
    |> validates_order_id
  end

  def update(data, params) do
    payment = %{
      amount: data["amount"],
      card: data["card"],
      items: data["items"],
      order_id: data["order_id"],
      token: data["token"],
      terminal_key: data["terminal_key"],
      status: params["status"],
      created_at: data["created_at"]
    }

    {:ok, payment}
    |> validate_status
  end

  defp validate_status({:ok, %{status: status}} = payment) do
    validate(
      payment,
      status,
      ~r/\b(pending|decline|accepted)\b/i,
      "Invalid status",
      "wrong state"
    )
  end

  defp validate_status(error), do: error

  defp validates_terminal_key({:ok, %{terminal_key: terminal_key}} = payment) do
    validate(
      payment,
      terminal_key,
      ~r/\w{1,255}\z/i,
      "Invalid terminal_key",
      "terminal_key is empty"
    )
  end

  defp validates_terminal_key(error), do: error

  defp validates_order_id({:ok, %{order_id: nil}} = _payment), do: {:error, "order_id is empty"}
  defp validates_order_id(error), do: error

  defp validate(_payment, nil, _regex, _invalid_message, empty_message),
    do: {:error, empty_message}

  defp validate(payment, field, regex, error_message, _empty_message) do
    if String.match?(field, regex) do
      payment
    else
      {:error, error_message}
    end
  end
end
