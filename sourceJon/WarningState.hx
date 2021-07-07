package;
import flixel.FlxSprite;
import flixel.*;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


class WarningState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();

		FlxG.sound.playMusic(Paths.music('BobWarningScreen'), 1);
		var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('WARNINGSCRENWARNINGSCREN', 'preload'));
		add(thx);
	}
	public override function update(elapsed)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new TitleState());
		}
		super.update(elapsed);
	}
	
}