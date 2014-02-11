class Expense
  attr_accessor :type, :amount

  def initialize(type, amount)
    self.type = type
    self.amount = amount
  end
end