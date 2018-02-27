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

end
