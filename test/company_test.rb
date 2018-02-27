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

    assert_equal [], company.employees

    company.load_employees(filename)
    assert_equal 2, company.employees.size
    assert_instance_of Hash, company.employees.first
  end

  def test_it_can_detect_bad_employee_data
    company = Company.new
    filename = './data/bad_employees.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.employees

    company.load_employees(filename)
    assert_equal 2, company.employees.size
    assert_equal bad_data, company.employees.first
    assert_equal bad_data, company.employees.last
  end

  def test_it_can_load_projects
    company = Company.new
    filename = './data/projects.csv'

    assert_equal [], company.employees

    company.load_projects(filename)
    assert_equal 3, company.projects.size
    assert_instance_of Hash, company.projects.first
  end

  def test_it_can_detect_bad_project_data
    company = Company.new
    filename = './data/bad_projects.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.projects

    company.load_projects(filename)
    assert_equal 3, company.projects.size
    refute_equal bad_data, company.projects[0]
    assert_equal bad_data, company.projects[1]
    refute_equal bad_data, company.projects[2]
  end
end
