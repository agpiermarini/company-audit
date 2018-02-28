require 'date'
require './modules/date_handler'
require './test/test_helper'
require './lib/company'

class CompanyTest < Minitest::Test
  def test_existance
    company = Company.new
    assert_instance_of Company, company
  end

  def test_attributes
    company = Company.new

    assert_equal [], company.employees
    assert_equal [], company.projects
    assert_equal [], company.timesheets
  end

  def test_it_can_load_employees
    company = Company.new
    filename = './data/employees.csv'
    success_key =  { success: true, error: nil }

    assert_equal [], company.employees

    company.load_employees(filename)
    assert_equal 2, company.employees.size
    assert_instance_of Employee, company.employees.first
    assert_equal success_key, company.load_employees(filename)

  end

  def test_it_can_detect_bad_employee_data
    company = Company.new
    filename = './data/bad_employees.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.employees

    assert_equal bad_data, company.load_employees(filename)
  end

  def test_it_can_load_projects
    company = Company.new
    filename = './data/projects.csv'
    success_key =  { success: true, error: nil }


    assert_equal [], company.employees

    company.load_projects(filename)
    assert_equal 3, company.projects.size
    assert_instance_of Project, company.projects.first
    assert_equal success_key, company.load_projects(filename)
  end

  def test_it_can_detect_bad_project_data
    company = Company.new
    filename = './data/bad_projects.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.projects

    assert_equal bad_data, company.load_projects(filename)
  end

  def test_it_can_load_timesheets
    company = Company.new
    filename = './data/timesheets.csv'
    success_key =  { success: true, error: nil }

    assert_equal [], company.employees

    company.load_timesheets(filename)
    assert_equal 25, company.timesheets.size
    assert_instance_of Timesheet, company.timesheets.first
    assert_equal success_key, company.load_timesheets(filename)
  end

  def test_it_can_detect_bad_timesheet_data
    company = Company.new
    filename = './data/bad_timesheets.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.timesheets

    assert_equal bad_data, company.load_timesheets(filename)
  end

  def test_it_can_find_employee_by_id
    company = Company.new
    filename = './data/employees.csv'
    company.load_employees(filename)

    assert_instance_of Employee, company.find_employee_by_id(1)
    assert_instance_of Employee, company.find_employee_by_id(2)
  end

  def test_it_can_find_project_by_id
    company = Company.new
    filename = './data/projects.csv'
    company.load_projects(filename)

    assert_instance_of Project, company.find_project_by_id(1)
    assert_instance_of Project, company.find_project_by_id(2)
    assert_instance_of Project, company.find_project_by_id(3)
  end

  def test_timesheet_valid_id_method
    company = Company.new
    filename = './data/employees.csv'
    company.load_employees(filename)

    assert company.timesheet_valid_id?(1)
    refute company.timesheet_valid_id?(100)
  end
end
