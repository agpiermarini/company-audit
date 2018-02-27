require './test/test_helper'
require './lib/employee'

class EmployeeTest < Minitest::Test
  def test_instantiation
    employee = Employee.new

    assert_instance_of Employee, employee
  end

  def test_attributes
  end
end
