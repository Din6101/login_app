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
end
