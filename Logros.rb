NOMBRES_LOGRO=[
"Logro 1",
"Logro 2",
"Logro 3"
]

DESCRIPCIONES_LOGRO=[
"Este es el Logro 1",
"Este es el Logro 2",
"Este es el Logro 3"
]

class Logro
    attr_accessor :icono
    attr_accessor :nombre
    attr_accessor :desc
    attr_accessor :iconogrande
 
    def initialize(icono, nombre, desc, iconogrande, viewport)
        self.icono = Sprite.new(viewport)
        self.icono.bitmap=RPG::Cache.picture(icono)
        self.iconogrande = Sprite.new(viewport)
        self.iconogrande.bitmap=RPG::Cache.picture(iconogrande)
        self.iconogrande.x = 163
        self.iconogrande.y = 24
        self.nombre = nombre
        self.desc = desc
     end   
    
   
    def update()
        self.icono.update
        self.iconogrande.update
    end
end
 
class Pokemon_Achievements_Scene
  def pbStartScene
    @page=0
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    @sprites["bg"]=IconSprite.new(0,0,@viewport)
    @sprites["bg"].setBitmap("Graphics/Pictures/Logros/background")
    @red=Color.new(255,0,0)
    @select = 0
   
    @space_logros = 20
    @offset = 20
   
    @sprites["overlay"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
   
    @logros = []
   
    @logros[0] = Logro.new("Logros/LogroMini/LogroMini1", "Logro 1", "Este es el logro 1", "Logros/LogroGrande/Logro1", @viewport)
    @logros[1] = Logro.new("Logros/LogroMini/LogroMini2", "Logro 2", "Este es el logro 2", "Logros/LogroGrande/Logro2", @viewport)
    @logros[2] = Logro.new("Logros/LogroMini/LogroMini3", "Logro 3", "Este es el logro 3", "Logros/LogroGrande/Logro3", @viewport)
   
    @sprites["selector"] = @uparrow=AnimatedSprite.create("Graphics/Pictures/uparrow",8,2,@viewport)
    @sprites["selector"].x = (@logros[0].icono.bitmap.width)/2 + @offset - @sprites["selector"].framewidth/2
    @sprites["selector"].y = Graphics.height/2 + 25
    @sprites["selector"].play
    
    #Cosas página2
    
    @sprites["TitleBox"]=IconSprite.new(0,0,@viewport)
    @sprites["TitleBox"].x = 152
    @sprites["TitleBox"].y = 245
    @sprites["TitleBox"].visible=false
    @sprites["TitleBox"].setBitmap("Graphics/Pictures/Logros/LogroGrande/TitleBox")
    
    @sprites["TextBox"]=IconSprite.new(0,0,@viewport)
    @sprites["TextBox"].x = 6
    @sprites["TextBox"].y = 299
    @sprites["TextBox"].visible=false
    @sprites["TextBox"].setBitmap("Graphics/Pictures/Logros/LogroGrande/DescriptionBox")
    
    @sprites["overlay2"]=BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @sprites["overlay2"].visible=false
    pbSetSystemFont(@sprites["overlay"].bitmap)
    pbSetSystemFont(@sprites["overlay2"].bitmap)
    @nombrelogro = NOMBRES_LOGRO
    @desclogro = DESCRIPCIONES_LOGRO
    pbText
    pbInput
  end
 
  def pbText
    overlay=@sprites["overlay"].bitmap
    pubid=sprintf("%05d",$Trainer.publicID($Trainer.id))
    baseColor=Color.new(72,72,72)
    shadowColor=Color.new(160,160,160)
    textPositions=[
       [_INTL("Texto Prueba"),274,326,false,baseColor,shadowColor]
      ]
    pbDrawTextPositions(overlay,textPositions)  
  end
 
  def update
    if @page==0
     @logros[0].iconogrande.visible = false
    end
    if @select==0
      @logros[0].iconogrande.x = 163
      @logros[0].iconogrande.y = 24
      @logros[1].iconogrande.visible = false
      @logros[2].iconogrande.visible = false
    end
      @logros[0].update
    nicon = 0
    for logro in @logros
        logro.icono.x = (logro.icono.bitmap.width + @space_logros) * nicon + @offset
        logro.icono.y = Graphics.height/2 - logro.icono.bitmap.height / 2
    @sprites["selector"].x = ((@logros[0].icono.bitmap.width + @space_logros) * @select )+ (@logros[0].icono.bitmap.width)/2 + @offset - @sprites["selector"].framewidth/2
        logro.update
        nicon += 1
    end  
   
    pbUpdateSpriteHash(@sprites)
    Input.update
  end  
 
  def pbInput
    if @page==0
      if Input.trigger?(Input::RIGHT) && !(@select==@logros.length - 1)
          @select+=1; pbSEPlay("Select")
      end    
      if Input.trigger?(Input::LEFT) && !(@select==0)
          @select-=1; pbSEPlay("Select")
        end
      end  
    if Input.trigger?(Input::C) 
      pbSEPlay("Select")
      switchPage
    end
  end  
 
  def pbLogros
    loop do
      Graphics.update
      Input.update
      self.pbInput
      self.update
      if Input.trigger?(Input::B)
       pbSEPlay("expfull")
        break
      end
    end
  end
  
  def switchPage
    if @page==1
      firstPage
    else
      secondPage
    end
  end  
  
  def firstPage
    @page=0
    @sprites["overlay"].visible=true
    for logro in @logros
      logro.icono.visible=true
    end  
    
    @sprites["selector"].visible=true
    @sprites["overlay"].visible=true
    @sprites["TitleBox"].visible=false
    @sprites["TextBox"].visible=false
    @sprites["overlay2"].visible=false
    @logros[0].iconogrande.visible = false
    @logros[1].iconogrande.visible = false
    @logros[2].iconogrande.visible = false
    @logros[0].nombre.visible = false
    @logros[1].nombre.visible = false
    @logros[2].nombre.visible = false
  end
  
  def secondPage
    @page=1
    @sprites["overlay"].visible=false
    for logro in @logros
      logro.icono.visible=false
    end
   
    @sprites["selector"].visible=false
    @sprites["overlay"].visible=false
    @sprites["TitleBox"].visible=true
    @sprites["TextBox"].visible=true
    @sprites["overlay2"].visible=true
    if @select==0
      @logros[0].iconogrande.visible = true
      @logros[1].iconogrande.visible = false
      @logros[0].nombre.visible = true
      @logros[1].nombre.visible = false
    end  
    if @select==1
      @logros[0].iconogrande.visible = false
      @logros[1].iconogrande.visible = true
      @logros[0].nombre.visible = false
      @logros[1].nombre.visible = true
    end
  end
  
  def pbEndScene
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end
 
def pbCallAchievements
  scene=Pokemon_Achievements_Scene.new
  screen=Pokemon_Achievements.new(scene)
  screen.pbStartScreen
end
 
class Pokemon_Achievements
  def initialize(scene)
    @scene=scene
  end
 
  def pbStartScreen
    @scene.pbStartScene
    @scene.pbLogros
    @scene.pbEndScene
  end
end

end
  


class Pokemon_Achievements
  def initialize(scene)
    @scene=scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbLogros
    @scene.pbEndScene
  end
end