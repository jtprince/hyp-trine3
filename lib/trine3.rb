require 'gosu'

class GameWindow < Gosu::Window
  def initialize(fullscreen=false)
    super 1024, 768, fullscreen
    self.caption = "Joshua's game"
    @background_image = Gosu::Image.new(self, "media/background/morning-sun-rays-forest-1024x768.jpg", true)
    @player = Player.new(self)
    @player.warp(320,240)
  end

  def draw
    @player.draw
    @background_image.draw(0,0,0)
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0
      @player.accelerate
    end
    if button_down? Gosu::KbDown
      @player.backwards
    end
    @player.move
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


class Player
  def initialize(window)
    @window = window
    @image = Gosu::Image.new(window, "media/character/ninja-w100.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def backwards
    @vel_x -= Gosu::offset_x(@angle, 0.5)
    @vel_y -= Gosu::offset_y(@angle, 0.5)
  end


  def move
    @x += @vel_x
    @y += @vel_y
    @x %= @window.width
    @y %= @window.height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end


