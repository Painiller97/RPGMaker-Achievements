class Pokemon_Achievements_Scene
  def pbStartScene
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    @sprites["bg"]=IconSprite.new(0,0,@viewport) 
    @sprites["bg"].setBitmap("Graphics/Pictures/Logros/background")
    @sprites["overlay"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    pbText
  end
  
  def pbText
    overlay=@sprites["overlay"].bitmap
    pubid=sprintf("%05d",$Trainer.publicID($Trainer.id))
    baseColor=Color.new(72,72,72)
    shadowColor=Color.new(160,160,160)
    textPositions=[
       [_INTL("{1}",$Trainer.name),468,64,1,baseColor,shadowColor],
       [_INTL("${1}",$Trainer.money),468,270,1,baseColor,shadowColor],
       [_INTL("Logro Maestro"),274,326,false,baseColor,shadowColor]
      ]
    pbDrawTextPositions(overlay,textPositions)   
  end 
      
    
  def PokemonAchievements
    ach=Pokemon_Achievements_Scene.new()
    ach.pbStartScene
  end  
end