defmodule LoginApp.School.Enrollments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrollments" do
    field :name, :string
    field :description, :string
    field :course_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(enrollments, attrs) do
    enrollments
    |> cast(attrs, [:name, :course_id, :description])
    |> validate_required([:name, :course_id, :description])
  end
end
