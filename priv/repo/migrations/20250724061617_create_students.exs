defmodule LoginApp.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :users, :string
      add :name, :string
      add :age, :integer
      add :grade, :string

      timestamps(type: :utc_datetime)
    end
  end
end
