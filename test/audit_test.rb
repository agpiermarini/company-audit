require 'date'
require './modules/date_handler'
require './test/test_helper'
# require './lib/company'
require './lib/audit'

class AuditTest < Minitest::Test
  def test_existance
    audit = Audit.new
    assert_instance_of Audit, audit
  end

  def test_it_can_load_companys
    audit = Audit.new
    company = Company.new
    file = { employees: './data/employees.csv',
              projects: './data/projects.csv',
              timesheets: './data/timesheets.csv'}
    success_key = {:success=>true, :error=>nil}

    assert_equal success_key, company.load_employees(file[:employees])
    assert_equal success_key, company.load_projects(file[:projects])
    assert_equal success_key, company.load_timesheets(file[:timesheets])
  end

  def test_it_can_load_company
    audit = Audit.new
    company = Company.new
    file = { employees: './data/employees.csv',
              projects: './data/projects.csv',
              timesheets: './data/timesheets.csv'}
    company.load_employees(file[:employees])
    company.load_projects(file[:projects])
    company.load_timesheets(file[:timesheets])
    success_key = {:success=>true, :error=>nil}

    audit.load_company(company)
    assert_instance_of Company, audit.company
  end
end
