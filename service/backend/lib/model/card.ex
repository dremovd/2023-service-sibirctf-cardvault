defmodule CardVault.Model.Card do
  defstruct [
    :pan,
    :exp_date_year,
    :exp_date_month,
    :cvv,
    :cardholder
  ]

  def create(pan, exp_date_year, exp_date_month, cvv, cardholder) do
    card = %CardVault.Model.Card{
      pan: pan,
      exp_date_year: exp_date_year,
      exp_date_month: exp_date_month,
      cvv: cvv,
      cardholder: cardholder
    }

    {:ok, card}
    |> validate_pan
    |> validates_exp_date_year
    |> validates_exp_date_month
    |> validates_cvv
    |> validates_cardholder
  end

  defp validate_pan({:ok, %{pan: pan}} = card) do
    validate(card, pan, ~r/\A[0-9]{16,19}\z/i, "Invalid pan", "pan is empty")
  end

  defp validate_pan(error), do: error

  defp validates_exp_date_year({:ok, %{exp_date_year: exp_date_year}} = card) do
    validate(
      card,
      exp_date_year,
      ~r/\A[0-9]{1,2}\z/i,
      "Invalid exp_date_year",
      "exp_date_year is empty"
    )
  end

  defp validates_exp_date_year(error), do: error

  defp validates_exp_date_month({:ok, %{exp_date_month: exp_date_month}} = card) do
    validate(
      card,
      exp_date_month,
      ~r/\A[0-9]{1,2}\z/i,
      "Invalid exp_date_month",
      "exp_date_month is empty"
    )
  end

  defp validates_exp_date_month(error), do: error

  defp validates_cvv({:ok, %{cvv: nil}} = _card), do: {:error, "cvv is empty"}
  defp validates_cvv(error), do: error

  defp validates_cardholder({:ok, %{cardholder: cardholder}} = card) do
    validate(card, cardholder, ~r/\A[a-z\-\.\s]+\z/i, "Invalid cardholder", "cardholder is empty")
  end

  defp validates_cardholder(error), do: error

  defp validate(_card, nil, _regex, _invalid_message, empty_message), do: {:error, empty_message}

  defp validate(card, field, regex, error_message, _empty_message) do
    if String.match?(field, regex) do
      card
    else
      {:error, error_message}
    end
  end
end
