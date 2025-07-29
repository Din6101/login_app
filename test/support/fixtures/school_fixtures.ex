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
      |> LoginApp.School.create_student()

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

  @doc """
  Generate a courses.
  """
  def courses_fixture(attrs \\ %{}) do
    {:ok, courses} =
      attrs
      |> Enum.into(%{
        course_id: "some course_id",
        description: "some description",
        name: "some name"
      })
      |> LoginApp.School.create_courses()

    courses
  end

  @doc """
  Generate a enrollments.
  """
  def enrollments_fixture(attrs \\ %{}) do
    {:ok, enrollments} =
      attrs
      |> Enum.into(%{
        course_id: "some course_id",
        description: "some description",
        name: "some name"
      })
      |> LoginApp.School.create_enrollments()

    enrollments
  end

  @doc """
  Generate a results.
  """
  def results_fixture(attrs \\ %{}) do
    {:ok, results} =
      attrs
      |> Enum.into(%{
        course_id: "some course_id",
        grade: "some grade",
        name: "some name",
        score: "some score",
        status: "some status"
      })
      |> LoginApp.School.create_results()

    results
  end

  @doc """
  Generate a certifications.
  """
  def certifications_fixture(attrs \\ %{}) do
    {:ok, certifications} =
      attrs
      |> Enum.into(%{
        course_id: "some course_id",
        name: "some name",
        status: "some status"
      })
      |> LoginApp.School.create_certifications()

    certifications
  end

  @doc """
  Generate a reports.
  """
  def reports_fixture(attrs \\ %{}) do
    {:ok, reports} =
      attrs
      |> Enum.into(%{
        course_id: "some course_id",
        evaluation: "some evaluation",
        name: "some name"
      })
      |> LoginApp.School.create_reports()

    reports
  end
end
