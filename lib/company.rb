require 'csv'
require './lib/employee'
require './lib/project'
require './lib/timesheet'

class Company
  attr_reader :employees, :projects, :timesheets
  def initialize
    @employees = []
    @projects = []
    @timesheets = []
  end

  def find_attributes(filename)
    CSV.readlines(filename)
  end

  def success_key
    { success: true, error: nil }
  end

  def failure_key
    { success: false, error: 'bad data'}
  end

  def load_employees(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element.nil? } || attribute.length < 5
        return failure_key
      else
        @employees << Employee.new(attribute[0],
                                   attribute[1],
                                   attribute[2],
                                   attribute[3],
                                   attribute[4])
      end
    end
    success_key
  end

  def load_projects(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element == nil? } || attribute.length < 4
        return failure_key
      else
        @projects << Project.new(attribute[0],
                                 attribute[1],
                                 attribute[2],
                                 attribute[3])

      end
    end
    success_key
  end

  def load_timesheets(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element.nil? } || attribute.length < 4
        return failure_key
      else
        @timesheets << Timesheet.new(attribute[0],
                                     attribute[1],
                                     attribute[2],
                                     attribute[3])
      end
    end
    success_key
  end

  def find_employee_by_id(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_project_by_id(id)
    @projects.find { |project| project.project_id == id }
  end

  def timesheet_id_valid?(id)
    @employees.any? { |employee| employee.id == id }
  end

  def project_id_valid?(id)
    @projects.any? { |project| project.project_id == id }
  end

  def bill_during_project_date?(date, project_id)
    date_billed = DateHandler.string_to_date(date)
    dh = DateHandler::DHDate.new(date_billed)
    project = @projects.find { |project| project.project_id == project_id }
    dh.date_between(project.start_date, project.end_date)
  end

  def work_during_week?(date)
    date_billed = DateHandler.string_to_date(date)
    bool = [date_billed.saturday?, date_billed.sunday?]
    bool.each { |check| return false if check == true }
  end
end
