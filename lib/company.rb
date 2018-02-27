require 'csv'
class Company
  attr_reader :employees, :projects, :timesheets
  def initialize
    @employees = []
    @projects = []
    @timesheets = []
  end

  def load_employees(filename)
    contents = CSV.readlines(filename)
  end

end
