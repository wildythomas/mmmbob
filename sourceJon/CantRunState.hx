package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * i took this code from pompom im sorry
 */
class CantRunState extends FlxState
{
	
	public function new(goodEnding:Bool = true) 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		super.create();
		var end:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('bob/cantruncantrunfartpiss', 'shared'));
		FlxG.sound.playMusic(Paths.music("youcantrun"),1,false);
		add(end);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
		
		
		new FlxTimer().start(24, endIt);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
	
	
	public function endIt(e:FlxTimer=null){
		trace("ENDING");
		FlxG.switchState(new PlayState());
	}
	
}