defmodule LoginApp.School.Results do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results" do
    field :name, :string
    field :status, :string
    field :course_id, :string
    field :score, :string
    field :grade, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(results, attrs) do
    results
    |> cast(attrs, [:name, :course_id, :score, :grade, :status])
    |> validate_required([:name, :course_id, :score, :grade, :status])
  end
end
