require 'date'
require './test/test_helper'
require './lib/employee'

class EmployeeTest < Minitest::Test
  def test_instantiation
    employee_id = '5'
    name = 'Sally Jackson'
    role = 'Engineer'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    employee = Employee.new(employee_id, name, role, start_date, end_date)

    assert_instance_of Employee, employee
  end

  def test_attributes
    employee_id = '5'
    name = 'Sally Jackson'
    role = 'Engineer'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    employee = Employee.new(employee_id, name, role, start_date, end_date)

    assert_equal employee_id.to_i, employee.id
    assert_instance_of Integer, employee.id.class
    assert_equal name, employee.name
    assert_equal role, employee.role
    assert_equal Date.new(2015, 1, 1), employee.start_date
    assert_equal Date.new(2018, 1, 1), employee.end_date
  end
end
