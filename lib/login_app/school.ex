defmodule LoginApp.School do
  @moduledoc """
  The School context.
  """

  import Ecto.Query, warn: false
  alias LoginApp.Repo

  alias LoginApp.School.Student
  alias LoginApp.School.Teacher

  def count_teachers do
    Repo.aggregate(Teacher, :count, :id)
  end

  def count_students do
    Repo.aggregate(Student, :count, :id)
  end


  def list_students_paginated(params \\ %{}) do
    Student
    |> order_by(desc: :inserted_at)
    |> LoginApp.Repo.paginate(params)
  end

  @spec list_teachers_paginated(Keyword.t()) :: Scrivener.Page.t()
def list_teachers_paginated(opts \\ [page: 1, page_size: 10]) do
  Teacher
  |> order_by([t], desc: t.inserted_at)
  |> Repo.paginate(opts)
end





  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end

  alias LoginApp.School.Teacher

  @doc """
  Returns the list of teachers.

  ## Examples

      iex> list_teachers()
      [%Teacher{}, ...]

  """
  def list_teachers do
    Repo.all(Teacher)
  end

  @doc """
  Gets a single teacher.

  Raises `Ecto.NoResultsError` if the Teacher does not exist.

  ## Examples

      iex> get_teacher!(123)
      %Teacher{}

      iex> get_teacher!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teacher!(id), do: Repo.get!(Teacher, id)

  @doc """
  Creates a teacher.

  ## Examples

      iex> create_teacher(%{field: value})
      {:ok, %Teacher{}}

      iex> create_teacher(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teacher(attrs \\ %{}) do
    %Teacher{}
    |> Teacher.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teacher.

  ## Examples

      iex> update_teacher(teacher, %{field: new_value})
      {:ok, %Teacher{}}

      iex> update_teacher(teacher, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teacher(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a teacher.

  ## Examples

      iex> delete_teacher(teacher)
      {:ok, %Teacher{}}

      iex> delete_teacher(teacher)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teacher(%Teacher{} = teacher) do
    Repo.delete(teacher)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teacher changes.

  ## Examples

      iex> change_teacher(teacher)
      %Ecto.Changeset{data: %Teacher{}}

  """
  def change_teacher(%Teacher{} = teacher, attrs \\ %{}) do
    Teacher.changeset(teacher, attrs)
  end

  alias LoginApp.School.Courses

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Courses{}, ...]

  """
  def list_courses do
    Repo.all(Courses)
  end

  @doc """
  Gets a single courses.

  Raises `Ecto.NoResultsError` if the Courses does not exist.

  ## Examples

      iex> get_courses!(123)
      %Courses{}

      iex> get_courses!(456)
      ** (Ecto.NoResultsError)

  """
  def get_courses!(id), do: Repo.get!(Courses, id)

  @doc """
  Creates a courses.

  ## Examples

      iex> create_courses(%{field: value})
      {:ok, %Courses{}}

      iex> create_courses(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_courses(attrs \\ %{}) do
    %Courses{}
    |> Courses.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a courses.

  ## Examples

      iex> update_courses(courses, %{field: new_value})
      {:ok, %Courses{}}

      iex> update_courses(courses, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_courses(%Courses{} = courses, attrs) do
    courses
    |> Courses.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a courses.

  ## Examples

      iex> delete_courses(courses)
      {:ok, %Courses{}}

      iex> delete_courses(courses)
      {:error, %Ecto.Changeset{}}

  """
  def delete_courses(%Courses{} = courses) do
    Repo.delete(courses)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking courses changes.

  ## Examples

      iex> change_courses(courses)
      %Ecto.Changeset{data: %Courses{}}

  """
  def change_courses(%Courses{} = courses, attrs \\ %{}) do
    Courses.changeset(courses, attrs)
  end

  alias LoginApp.School.Enrollments

  @doc """
  Returns the list of enrollments.

  ## Examples

      iex> list_enrollments()
      [%Enrollments{}, ...]

  """
  def list_enrollments do
    Repo.all(Enrollments)
  end

  @doc """
  Gets a single enrollments.

  Raises `Ecto.NoResultsError` if the Enrollments does not exist.

  ## Examples

      iex> get_enrollments!(123)
      %Enrollments{}

      iex> get_enrollments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enrollments!(id), do: Repo.get!(Enrollments, id)

  @doc """
  Creates a enrollments.

  ## Examples

      iex> create_enrollments(%{field: value})
      {:ok, %Enrollments{}}

      iex> create_enrollments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enrollments(attrs \\ %{}) do
    %Enrollments{}
    |> Enrollments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enrollments.

  ## Examples

      iex> update_enrollments(enrollments, %{field: new_value})
      {:ok, %Enrollments{}}

      iex> update_enrollments(enrollments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enrollments(%Enrollments{} = enrollments, attrs) do
    enrollments
    |> Enrollments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a enrollments.

  ## Examples

      iex> delete_enrollments(enrollments)
      {:ok, %Enrollments{}}

      iex> delete_enrollments(enrollments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enrollments(%Enrollments{} = enrollments) do
    Repo.delete(enrollments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enrollments changes.

  ## Examples

      iex> change_enrollments(enrollments)
      %Ecto.Changeset{data: %Enrollments{}}

  """
  def change_enrollments(%Enrollments{} = enrollments, attrs \\ %{}) do
    Enrollments.changeset(enrollments, attrs)
  end

  alias LoginApp.School.Results

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Results{}, ...]

  """
  def list_results do
    Repo.all(Results)
  end

  @doc """
  Gets a single results.

  Raises `Ecto.NoResultsError` if the Results does not exist.

  ## Examples

      iex> get_results!(123)
      %Results{}

      iex> get_results!(456)
      ** (Ecto.NoResultsError)

  """
  def get_results!(id), do: Repo.get!(Results, id)

  @doc """
  Creates a results.

  ## Examples

      iex> create_results(%{field: value})
      {:ok, %Results{}}

      iex> create_results(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_results(attrs \\ %{}) do
    %Results{}
    |> Results.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a results.

  ## Examples

      iex> update_results(results, %{field: new_value})
      {:ok, %Results{}}

      iex> update_results(results, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_results(%Results{} = results, attrs) do
    results
    |> Results.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a results.

  ## Examples

      iex> delete_results(results)
      {:ok, %Results{}}

      iex> delete_results(results)
      {:error, %Ecto.Changeset{}}

  """
  def delete_results(%Results{} = results) do
    Repo.delete(results)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking results changes.

  ## Examples

      iex> change_results(results)
      %Ecto.Changeset{data: %Results{}}

  """
  def change_results(%Results{} = results, attrs \\ %{}) do
    Results.changeset(results, attrs)
  end

  alias LoginApp.School.Certifications

  @doc """
  Returns the list of certifications.

  ## Examples

      iex> list_certifications()
      [%Certifications{}, ...]

  """
  def list_certifications do
    Repo.all(Certifications)
  end

  @doc """
  Gets a single certifications.

  Raises `Ecto.NoResultsError` if the Certifications does not exist.

  ## Examples

      iex> get_certifications!(123)
      %Certifications{}

      iex> get_certifications!(456)
      ** (Ecto.NoResultsError)

  """
  def get_certifications!(id), do: Repo.get!(Certifications, id)

  @doc """
  Creates a certifications.

  ## Examples

      iex> create_certifications(%{field: value})
      {:ok, %Certifications{}}

      iex> create_certifications(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_certifications(attrs \\ %{}) do
    %Certifications{}
    |> Certifications.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a certifications.

  ## Examples

      iex> update_certifications(certifications, %{field: new_value})
      {:ok, %Certifications{}}

      iex> update_certifications(certifications, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_certifications(%Certifications{} = certifications, attrs) do
    certifications
    |> Certifications.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a certifications.

  ## Examples

      iex> delete_certifications(certifications)
      {:ok, %Certifications{}}

      iex> delete_certifications(certifications)
      {:error, %Ecto.Changeset{}}

  """
  def delete_certifications(%Certifications{} = certifications) do
    Repo.delete(certifications)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking certifications changes.

  ## Examples

      iex> change_certifications(certifications)
      %Ecto.Changeset{data: %Certifications{}}

  """
  def change_certifications(%Certifications{} = certifications, attrs \\ %{}) do
    Certifications.changeset(certifications, attrs)
  end

  alias LoginApp.School.Reports

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Reports{}, ...]

  """
  def list_reports do
    Repo.all(Reports)
  end

  @doc """
  Gets a single reports.

  Raises `Ecto.NoResultsError` if the Reports does not exist.

  ## Examples

      iex> get_reports!(123)
      %Reports{}

      iex> get_reports!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reports!(id), do: Repo.get!(Reports, id)

  @doc """
  Creates a reports.

  ## Examples

      iex> create_reports(%{field: value})
      {:ok, %Reports{}}

      iex> create_reports(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reports(attrs \\ %{}) do
    %Reports{}
    |> Reports.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reports.

  ## Examples

      iex> update_reports(reports, %{field: new_value})
      {:ok, %Reports{}}

      iex> update_reports(reports, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reports(%Reports{} = reports, attrs) do
    reports
    |> Reports.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reports.

  ## Examples

      iex> delete_reports(reports)
      {:ok, %Reports{}}

      iex> delete_reports(reports)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reports(%Reports{} = reports) do
    Repo.delete(reports)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reports changes.

  ## Examples

      iex> change_reports(reports)
      %Ecto.Changeset{data: %Reports{}}

  """
  def change_reports(%Reports{} = reports, attrs \\ %{}) do
    Reports.changeset(reports, attrs)
  end
end
