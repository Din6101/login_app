defmodule LoginApp.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :name, :string
      add :course_id, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
