class Player

  attr_reader :name

  def initialize(name)
    self.name = name
  end

  private
  attr_writer :name

end