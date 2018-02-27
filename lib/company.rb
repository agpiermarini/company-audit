require 'csv'

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
        @employees << failure_key
      else
        @employees << { success_key: success_key,
                        employee_id: attribute[0],
                        name: attribute[1],
                        role: attribute[2],
                        start_date: attribute[3],
                        end_date: attribute[4]
                      }
      end
    end
  end

  def load_projects(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element.nil? } || attribute.length < 4
        @projects << failure_key
      else
        @projects << { success_key: success_key,
                        project_id: attribute[0],
                        name: attribute[1],
                        start_date: attribute[2],
                        end_date: attribute[3]
                      }
      end
    end
  end
end

# @employees << Employee.new(employee_id:      attribute[0],
#                           name:             attribute[1],
#                           role:             attribute[2],
#                           start_date:       attribute[3],
#                           end_date:         attribute[4])
