defmodule LoginApp.School.Student do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias LoginApp.Repo

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

  def list_students_paginated(page \\ 1, page_size \\ 10) do
    __MODULE__
    |> order_by([s], desc: s.inserted_at)
    |> Repo.paginate(page: page, page_size: page_size)
  end
end
