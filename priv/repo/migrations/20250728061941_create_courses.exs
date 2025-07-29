defmodule LoginApp.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :course_id, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
