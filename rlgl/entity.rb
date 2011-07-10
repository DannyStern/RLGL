class Entity
  attr_accessor :shape
  attr_accessor :body
  attr_accessor :image
  def initialize (mass, x_pos, y_pos, x_size, y_size, window, movable = true)
    if movable
      @body  = CP::Body.new(mass, CP.moment_for_box(mass, x_size, y_size))
    else
      @body  = CP::Body.new_static()
      @body.velocity_func() { |body, gravity, damping, dt| vec2(0,0)}
    end
    @x_size = x_size
    @y_size = y_size
    x_off = @x_size / 2.0
    y_off = @y_size / 2.0
    
    @body.p = vec2(x_pos + x_off, y_pos - y_off)
    @vecs = Array.new
    @vecs = [vec2(-x_off,-y_off),vec2(-x_off,y_off),vec2(x_off,y_off),vec2(x_off,-y_off)]
    @shape = CP::Shape::Poly.new(@body, @vecs)
    @shape.e = 0.0
    @shape.bb
    @image = Gosu::Image.new(window, './media/block.png')
    @color = 0xffaaaaaa
  end

  def update

  end

  def draw(game_level)
    @image.draw_as_quad(@body.p.x - game_level.offset_x + @shape.vert(0).x, @body.p.y + @shape.vert(0).y, @color,
                        @body.p.x - game_level.offset_x + @shape.vert(1).x, @body.p.y + @shape.vert(1).y, @color,
                        @body.p.x - game_level.offset_x + @shape.vert(2).x, @body.p.y + @shape.vert(2).y, @color,
                        @body.p.x - game_level.offset_x + @shape.vert(3).x, @body.p.y + @shape.vert(3).y, @color,
                        ZOrder::Platforms)
  end
end