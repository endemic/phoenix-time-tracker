defmodule TimeTracker.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeTracker.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> TimeTracker.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        email: "some email",
        name: "some name",
        state: "some state",
        zip: "some zip"
      })
      |> TimeTracker.Accounts.create_client()

    client
  end

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    client = client_fixture()
    {:ok, project} =
      attrs
      |> Enum.into(%{
        client_id: client.id,
        name: "some name"
      })
      |> TimeTracker.Accounts.create_project()

    project
  end
end
