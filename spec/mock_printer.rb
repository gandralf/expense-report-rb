class MockPrinter
  attr_reader :text

  def print(msg)
    @text ||= ''
    @text += msg
  end
end