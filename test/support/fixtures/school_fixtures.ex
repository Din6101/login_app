defmodule LoginApp.SchoolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LoginApp.School` context.
  """

  @doc """
  Generate a stdudent.
  """
  def stdudent_fixture(attrs \\ %{}) do
    {:ok, stdudent} =
      attrs
      |> Enum.into(%{
        age: 42,
        grade: "some grade",
        name: "some name",
        users: "some users"
      })
      |> LoginApp.School.create_stdudent()

    stdudent
  end

  @doc """
  Generate a teacher.
  """
  def teacher_fixture(attrs \\ %{}) do
    {:ok, teacher} =
      attrs
      |> Enum.into(%{
        name: "some name",
        subject: "some subject",
        years_of_experience: 42
      })
      |> LoginApp.School.create_teacher()

    teacher
  end
end
