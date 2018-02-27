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
    company.load_employees(filename)
  end
end
