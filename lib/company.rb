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
        failure_key
      else
        @employees << { employee_id: attribute[0],
                        name: attribute[1],
                        role: attribute[2],
                        start_date: attribute[3],
                        end_date: attribute[4]
                      }
        success_key
      end
    end
  end

  def load_projects(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element == nil? } || attribute.length < 4
        failure_key
      else
        @projects << {  project_id: attribute[0],
                        name: attribute[1],
                        start_date: attribute[2],
                        end_date: attribute[3]
                      }
        success_key
      end
    end
  end

  def load_timesheets(filename)
    attributes = find_attributes(filename)
    attributes.each do |attribute|
      if attribute.any? { |element| element.nil? } || attribute.length < 4
        failure_key
      else
        @timesheets << { employee_id: attribute[0],
                         project_id: attribute[1],
                         date: attribute[2],
                         minutes: attribute[3]
                      }
        success_key
      end
    end
  end
end

# @employees << Employee.new(employee_id:      attribute[0],
#                           name:             attribute[1],
#                           role:             attribute[2],
#                           start_date:       attribute[3],
#                           end_date:         attribute[4])
