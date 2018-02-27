require './test/test_helper'
require './lib/employee'

class EmployeeTest < Minitest::Test
  def test_instantiation
    employee = Employee.new('5', 'Sally Jackson', 'Engineer', '2015-01-01', '2018-01-01')

    assert_instance_of Employee, employee
  end

  def test_attributes
    employee = Employee.new('5', 'Sally Jackson', 'Engineer', '2015-01-01', '2018-01-01')

    assert_equal 5, employee.id
    assert_instance_of Integer, employee.id
    assert_equal 'Sally Jackson', employee.name
    assert_equal 'Engineer', employee.role
    assert_equal Date.new(2015, 1, 1), employee.start_date
    assert_equal Date.new(2018, 1, 1), employee.end_date
  end
end
