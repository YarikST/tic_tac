class Call

  attr_reader :position
  attr_accessor :move_type

  def initialize(position)
    self.position = position
  end

  private
  attr_writer :position

end