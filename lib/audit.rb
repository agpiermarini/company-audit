require './lib/company'

class Audit
  attr_reader :company
  def initialize
    @company = company
  end

  def load_company(company)
    @company = company
  end

  def run_report(employee_id, project_id, date)
    employee = company.find_employee_by_id(employee_id)
    project = company.find_project_by_id(project_id)
    if company.employee_id_invalid?(employee_id)
      "A timesheet was submitted for #{project.name} under an invalid employee ID"
    elsif company.project_id_invalid?(project_id)
      "#{employee.name} submitted a timesheet on #{date} for an invalid project"
    elsif company.bill_outside_project_date?(date, project_id)
      "#{employee.name} worked on #{project.name} on #{date}, it was outside of project dates"
    elsif company.work_during_weekend?(date)
      "#{employee.name} worked on #{project.name} on #{date}, it was a weekend"
    else
      nil
    end
  end

  def were_invalid_days_worked
    reports = []
    company.timesheets.each do |timesheet|
      employee_id = timesheet.employee_id
      project_id = timesheet.project_id
      date = timesheet.date
      reports << run_report(employee_id, project_id, date)
    end
    puts "Invalid days worked:"
    reports.compact.size == 0 ? (puts "None") : (puts "#{puts reports.compact}")
    reports
  end
end
