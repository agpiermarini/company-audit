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

  def test_it_can_detect_bad_data
    company = Company.new
    filename = './data/bad_employees.csv'
    bad_data = { success: false, error: 'bad data' }

    assert_equal [], company.employees

    company.load_employees(filename)
    assert_equal 2, company.employees.size
    assert_equal bad_data, company.employees.first
    assert_equal bad_data, company.employees.last
  end
end
