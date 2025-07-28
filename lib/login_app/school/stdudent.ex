defmodule LoginApp.School.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :users, :string
    field :age, :integer
    field :grade, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:users, :name, :age, :grade])
    |> validate_required([:users, :name, :age, :grade])
  end
end
