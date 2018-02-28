require 'date'
require './modules/date_handler'
require './test/test_helper'
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

  def test_were_invalid_days_worked
    audit = Audit.new
    company = Company.new
    file = { employees: './data/employees.csv',
              projects: './data/projects.csv',
              timesheets: './data/timesheets.csv'}
    company.load_employees(file[:employees])
    company.load_projects(file[:projects])
    company.load_timesheets(file[:timesheets])
    audit.load_company(company)

    employee_id = 3
    project_id = 3
    date = DateHandler.string_to_date("2017-04-04")
    expected = "A timesheet was submitted for Acme Project under an invalid employee ID"
    assert_equal expected, audit.run_report(employee_id, project_id, date)

    employee_id_2 = 1
    project_id_2 = 2
    date_2 = DateHandler.string_to_date("2017-02-15")
    expected = "None"
    assert_equal expected, audit.run_report(employee_id_2, project_id_2, date_2)
  end
end
