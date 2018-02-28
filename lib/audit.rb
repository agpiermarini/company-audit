require './lib/company'

class Audit
  attr_reader :company
  def initialize
    @company = company
  end

  def load_company(company)
    @company = company
  end
end
