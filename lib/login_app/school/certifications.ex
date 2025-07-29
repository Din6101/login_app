defmodule LoginApp.School.Certifications do
  use Ecto.Schema
  import Ecto.Changeset

  schema "certifications" do
    field :name, :string
    field :status, :string
    field :course_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(certifications, attrs) do
    certifications
    |> cast(attrs, [:name, :course_id, :status])
    |> validate_required([:name, :course_id, :status])
  end
end
