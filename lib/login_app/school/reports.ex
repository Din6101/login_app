defmodule LoginApp.School.Reports do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :name, :string
    field :course_id, :string
    field :evaluation, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reports, attrs) do
    reports
    |> cast(attrs, [:name, :course_id, :evaluation])
    |> validate_required([:name, :course_id, :evaluation])
  end
end
