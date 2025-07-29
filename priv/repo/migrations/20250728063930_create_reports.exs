defmodule LoginApp.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :name, :string
      add :course_id, :string
      add :evaluation, :string

      timestamps(type: :utc_datetime)
    end
  end
end
