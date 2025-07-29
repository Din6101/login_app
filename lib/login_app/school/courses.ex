defmodule LoginApp.School.Courses do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    field :description, :string
    field :course_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(courses, attrs) do
    courses
    |> cast(attrs, [:name, :course_id, :description])
    |> validate_required([:name, :course_id, :description])
  end
end
