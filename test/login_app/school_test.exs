defmodule LoginApp.SchoolTest do
  use LoginApp.DataCase

  alias LoginApp.School

  describe "students" do
    alias LoginApp.School.Stdudent

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, users: nil, age: nil, grade: nil}

    test "list_students/0 returns all students" do
      stdudent = stdudent_fixture()
      assert School.list_students() == [stdudent]
    end

    test "get_stdudent!/1 returns the stdudent with given id" do
      stdudent = stdudent_fixture()
      assert School.get_stdudent!(stdudent.id) == stdudent
    end

    test "create_stdudent/1 with valid data creates a stdudent" do
      valid_attrs = %{name: "some name", users: "some users", age: 42, grade: "some grade"}

      assert {:ok, %Stdudent{} = stdudent} = School.create_stdudent(valid_attrs)
      assert stdudent.name == "some name"
      assert stdudent.users == "some users"
      assert stdudent.age == 42
      assert stdudent.grade == "some grade"
    end

    test "create_stdudent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_stdudent(@invalid_attrs)
    end

    test "update_stdudent/2 with valid data updates the stdudent" do
      stdudent = stdudent_fixture()
      update_attrs = %{name: "some updated name", users: "some updated users", age: 43, grade: "some updated grade"}

      assert {:ok, %Stdudent{} = stdudent} = School.update_stdudent(stdudent, update_attrs)
      assert stdudent.name == "some updated name"
      assert stdudent.users == "some updated users"
      assert stdudent.age == 43
      assert stdudent.grade == "some updated grade"
    end

    test "update_stdudent/2 with invalid data returns error changeset" do
      stdudent = stdudent_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_stdudent(stdudent, @invalid_attrs)
      assert stdudent == School.get_stdudent!(stdudent.id)
    end

    test "delete_stdudent/1 deletes the stdudent" do
      stdudent = stdudent_fixture()
      assert {:ok, %Stdudent{}} = School.delete_stdudent(stdudent)
      assert_raise Ecto.NoResultsError, fn -> School.get_stdudent!(stdudent.id) end
    end

    test "change_stdudent/1 returns a stdudent changeset" do
      stdudent = stdudent_fixture()
      assert %Ecto.Changeset{} = School.change_stdudent(stdudent)
    end
  end

  describe "teachers" do
    alias LoginApp.School.Teacher

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, subject: nil, years_of_experience: nil}

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert School.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert School.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      valid_attrs = %{name: "some name", subject: "some subject", years_of_experience: 42}

      assert {:ok, %Teacher{} = teacher} = School.create_teacher(valid_attrs)
      assert teacher.name == "some name"
      assert teacher.subject == "some subject"
      assert teacher.years_of_experience == 42
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      update_attrs = %{name: "some updated name", subject: "some updated subject", years_of_experience: 43}

      assert {:ok, %Teacher{} = teacher} = School.update_teacher(teacher, update_attrs)
      assert teacher.name == "some updated name"
      assert teacher.subject == "some updated subject"
      assert teacher.years_of_experience == 43
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_teacher(teacher, @invalid_attrs)
      assert teacher == School.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = School.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> School.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = School.change_teacher(teacher)
    end
  end

  describe "courses" do
    alias LoginApp.School.Courses

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, description: nil, course_id: nil}

    test "list_courses/0 returns all courses" do
      courses = courses_fixture()
      assert School.list_courses() == [courses]
    end

    test "get_courses!/1 returns the courses with given id" do
      courses = courses_fixture()
      assert School.get_courses!(courses.id) == courses
    end

    test "create_courses/1 with valid data creates a courses" do
      valid_attrs = %{name: "some name", description: "some description", course_id: "some course_id"}

      assert {:ok, %Courses{} = courses} = School.create_courses(valid_attrs)
      assert courses.name == "some name"
      assert courses.description == "some description"
      assert courses.course_id == "some course_id"
    end

    test "create_courses/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_courses(@invalid_attrs)
    end

    test "update_courses/2 with valid data updates the courses" do
      courses = courses_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", course_id: "some updated course_id"}

      assert {:ok, %Courses{} = courses} = School.update_courses(courses, update_attrs)
      assert courses.name == "some updated name"
      assert courses.description == "some updated description"
      assert courses.course_id == "some updated course_id"
    end

    test "update_courses/2 with invalid data returns error changeset" do
      courses = courses_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_courses(courses, @invalid_attrs)
      assert courses == School.get_courses!(courses.id)
    end

    test "delete_courses/1 deletes the courses" do
      courses = courses_fixture()
      assert {:ok, %Courses{}} = School.delete_courses(courses)
      assert_raise Ecto.NoResultsError, fn -> School.get_courses!(courses.id) end
    end

    test "change_courses/1 returns a courses changeset" do
      courses = courses_fixture()
      assert %Ecto.Changeset{} = School.change_courses(courses)
    end
  end

  describe "enrollments" do
    alias LoginApp.School.Enrollments

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, description: nil, course_id: nil}

    test "list_enrollments/0 returns all enrollments" do
      enrollments = enrollments_fixture()
      assert School.list_enrollments() == [enrollments]
    end

    test "get_enrollments!/1 returns the enrollments with given id" do
      enrollments = enrollments_fixture()
      assert School.get_enrollments!(enrollments.id) == enrollments
    end

    test "create_enrollments/1 with valid data creates a enrollments" do
      valid_attrs = %{name: "some name", description: "some description", course_id: "some course_id"}

      assert {:ok, %Enrollments{} = enrollments} = School.create_enrollments(valid_attrs)
      assert enrollments.name == "some name"
      assert enrollments.description == "some description"
      assert enrollments.course_id == "some course_id"
    end

    test "create_enrollments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_enrollments(@invalid_attrs)
    end

    test "update_enrollments/2 with valid data updates the enrollments" do
      enrollments = enrollments_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", course_id: "some updated course_id"}

      assert {:ok, %Enrollments{} = enrollments} = School.update_enrollments(enrollments, update_attrs)
      assert enrollments.name == "some updated name"
      assert enrollments.description == "some updated description"
      assert enrollments.course_id == "some updated course_id"
    end

    test "update_enrollments/2 with invalid data returns error changeset" do
      enrollments = enrollments_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_enrollments(enrollments, @invalid_attrs)
      assert enrollments == School.get_enrollments!(enrollments.id)
    end

    test "delete_enrollments/1 deletes the enrollments" do
      enrollments = enrollments_fixture()
      assert {:ok, %Enrollments{}} = School.delete_enrollments(enrollments)
      assert_raise Ecto.NoResultsError, fn -> School.get_enrollments!(enrollments.id) end
    end

    test "change_enrollments/1 returns a enrollments changeset" do
      enrollments = enrollments_fixture()
      assert %Ecto.Changeset{} = School.change_enrollments(enrollments)
    end
  end

  describe "results" do
    alias LoginApp.School.Results

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, status: nil, course_id: nil, score: nil, grade: nil}

    test "list_results/0 returns all results" do
      results = results_fixture()
      assert School.list_results() == [results]
    end

    test "get_results!/1 returns the results with given id" do
      results = results_fixture()
      assert School.get_results!(results.id) == results
    end

    test "create_results/1 with valid data creates a results" do
      valid_attrs = %{name: "some name", status: "some status", course_id: "some course_id", score: "some score", grade: "some grade"}

      assert {:ok, %Results{} = results} = School.create_results(valid_attrs)
      assert results.name == "some name"
      assert results.status == "some status"
      assert results.course_id == "some course_id"
      assert results.score == "some score"
      assert results.grade == "some grade"
    end

    test "create_results/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_results(@invalid_attrs)
    end

    test "update_results/2 with valid data updates the results" do
      results = results_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", course_id: "some updated course_id", score: "some updated score", grade: "some updated grade"}

      assert {:ok, %Results{} = results} = School.update_results(results, update_attrs)
      assert results.name == "some updated name"
      assert results.status == "some updated status"
      assert results.course_id == "some updated course_id"
      assert results.score == "some updated score"
      assert results.grade == "some updated grade"
    end

    test "update_results/2 with invalid data returns error changeset" do
      results = results_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_results(results, @invalid_attrs)
      assert results == School.get_results!(results.id)
    end

    test "delete_results/1 deletes the results" do
      results = results_fixture()
      assert {:ok, %Results{}} = School.delete_results(results)
      assert_raise Ecto.NoResultsError, fn -> School.get_results!(results.id) end
    end

    test "change_results/1 returns a results changeset" do
      results = results_fixture()
      assert %Ecto.Changeset{} = School.change_results(results)
    end
  end

  describe "certifications" do
    alias LoginApp.School.Certifications

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, status: nil, course_id: nil}

    test "list_certifications/0 returns all certifications" do
      certifications = certifications_fixture()
      assert School.list_certifications() == [certifications]
    end

    test "get_certifications!/1 returns the certifications with given id" do
      certifications = certifications_fixture()
      assert School.get_certifications!(certifications.id) == certifications
    end

    test "create_certifications/1 with valid data creates a certifications" do
      valid_attrs = %{name: "some name", status: "some status", course_id: "some course_id"}

      assert {:ok, %Certifications{} = certifications} = School.create_certifications(valid_attrs)
      assert certifications.name == "some name"
      assert certifications.status == "some status"
      assert certifications.course_id == "some course_id"
    end

    test "create_certifications/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_certifications(@invalid_attrs)
    end

    test "update_certifications/2 with valid data updates the certifications" do
      certifications = certifications_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", course_id: "some updated course_id"}

      assert {:ok, %Certifications{} = certifications} = School.update_certifications(certifications, update_attrs)
      assert certifications.name == "some updated name"
      assert certifications.status == "some updated status"
      assert certifications.course_id == "some updated course_id"
    end

    test "update_certifications/2 with invalid data returns error changeset" do
      certifications = certifications_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_certifications(certifications, @invalid_attrs)
      assert certifications == School.get_certifications!(certifications.id)
    end

    test "delete_certifications/1 deletes the certifications" do
      certifications = certifications_fixture()
      assert {:ok, %Certifications{}} = School.delete_certifications(certifications)
      assert_raise Ecto.NoResultsError, fn -> School.get_certifications!(certifications.id) end
    end

    test "change_certifications/1 returns a certifications changeset" do
      certifications = certifications_fixture()
      assert %Ecto.Changeset{} = School.change_certifications(certifications)
    end
  end

  describe "reports" do
    alias LoginApp.School.Reports

    import LoginApp.SchoolFixtures

    @invalid_attrs %{name: nil, course_id: nil, evaluation: nil}

    test "list_reports/0 returns all reports" do
      reports = reports_fixture()
      assert School.list_reports() == [reports]
    end

    test "get_reports!/1 returns the reports with given id" do
      reports = reports_fixture()
      assert School.get_reports!(reports.id) == reports
    end

    test "create_reports/1 with valid data creates a reports" do
      valid_attrs = %{name: "some name", course_id: "some course_id", evaluation: "some evaluation"}

      assert {:ok, %Reports{} = reports} = School.create_reports(valid_attrs)
      assert reports.name == "some name"
      assert reports.course_id == "some course_id"
      assert reports.evaluation == "some evaluation"
    end

    test "create_reports/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_reports(@invalid_attrs)
    end

    test "update_reports/2 with valid data updates the reports" do
      reports = reports_fixture()
      update_attrs = %{name: "some updated name", course_id: "some updated course_id", evaluation: "some updated evaluation"}

      assert {:ok, %Reports{} = reports} = School.update_reports(reports, update_attrs)
      assert reports.name == "some updated name"
      assert reports.course_id == "some updated course_id"
      assert reports.evaluation == "some updated evaluation"
    end

    test "update_reports/2 with invalid data returns error changeset" do
      reports = reports_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_reports(reports, @invalid_attrs)
      assert reports == School.get_reports!(reports.id)
    end

    test "delete_reports/1 deletes the reports" do
      reports = reports_fixture()
      assert {:ok, %Reports{}} = School.delete_reports(reports)
      assert_raise Ecto.NoResultsError, fn -> School.get_reports!(reports.id) end
    end

    test "change_reports/1 returns a reports changeset" do
      reports = reports_fixture()
      assert %Ecto.Changeset{} = School.change_reports(reports)
    end
  end
end
