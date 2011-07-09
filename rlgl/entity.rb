class Entity
  attr_accessor :shape
  attr_accessor :body
  def initialize (mass, x_pos, y_pos, x_size, y_size, window, movable = true)
    if movable
      @body  = CP::Body.new(mass, CP.moment_for_box(mass, x_size, y_size))
    else
      @body  = CP::Body.new_static()
      self.body.velocity_func() { |body, gravity, damping, dt| vec2(0,0)}
    end
    @body.p = vec2(x_pos, y_pos - y_size)
    @x_size = x_size
    @y_size = y_size
    @vecs = Array.new
    @vecs = [vec2(0,0),vec2(0,y_size),vec2(x_size,y_size),vec2(x_size,0)]
    @shape = CP::Shape::Poly.new(@body, @vecs)
    @image = Gosu::Image.new(window, './media/block.png')
    @color = 0xaaaaaaaa
  end

  def update

  end

  def draw
    @image.draw_as_quad(@body.p.x + @vecs[0].x, @body.p.y + @vecs[0].y, @color,
                        @body.p.x + @vecs[1].x, @body.p.y + @vecs[1].y, @color,
                        @body.p.x + @vecs[2].x, @body.p.y + @vecs[2].y, @color,
                        @body.p.x + @vecs[3].x, @body.p.y + @vecs[3].y, @color,
                        ZOrder::Platforms)
  end
end