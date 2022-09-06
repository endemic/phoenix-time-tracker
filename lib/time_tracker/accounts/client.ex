defmodule TimeTracker.Accounts.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias TimeTracker.Accounts.Project

  schema "clients" do
    field :address, :string
    field :city, :string
    field :email, :string
    field :name, :string
    field :state, :string
    field :zip, :string

    has_many :projects, Project

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :address, :city, :state, :zip, :email])
    |> validate_required([:name, :address, :city, :state, :zip, :email])
  end
end
