defmodule LoginApp.Repo.Migrations.CreateCertifications do
  use Ecto.Migration

  def change do
    create table(:certifications) do
      add :name, :string
      add :course_id, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
