defmodule LoginApp.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :subject, :string
      add :years_of_experience, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
