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

  def load_employees(filename)
    find_attributes(filename).each do |attribute, _nil|
    @employees << { success: nil,
                    error: nil,
                    employee_id: attribute[0],
                    name: attribute[1],
                    role: attribute[2],
                    start_date: attribute[3],
                    end_date: attribute[4]
                  }
    end
  end
end

# @employees << Employee.new(employee_id:      attribute[0],
#                           name:             attribute[1],
#                           role:             attribute[2],
#                           start_date:       attribute[3],
#                           end_date:         attribute[4])
