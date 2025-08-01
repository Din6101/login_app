defmodule LoginApp.School.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teachers" do
    field :name, :string
    field :subject, :string
    field :years_of_experience, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :subject, :years_of_experience])
    |> validate_required([:name, :subject, :years_of_experience])
  end



end
