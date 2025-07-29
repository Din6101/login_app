defmodule LoginApp.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :name, :string
      add :course_id, :string
      add :score, :string
      add :grade, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
