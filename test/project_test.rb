require './test/test_helper'
require './lib/project'

class ProjectTest < Minitest::Test
  def test_existance
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    project = Project.new('123', 'Widget Maker', '2015-01-01', '2018-01-01')

    assert_instance_of Project, project.class
  end

  def test_attributes
    skip
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'

    project = Project.new(project_id, name, start_date, end_date)

    assert_equal 123, project.project_id
    assert_equal 'Widget Maker', project.name
    assert_equal Date.new(start_date), project.start_date
    assert_equal Date.new(end_date), project.end_date
  end
end
