class Project
  attr_reader :project_id, :name, :start_date, :end_date
  def initialize(project_id, name, start_date, end_date)
    @project_id = project_id.to_i
    @name = name
    @start_date = Date.new(start_date)
    @end_date = Date.new(end_date)
  end
end
