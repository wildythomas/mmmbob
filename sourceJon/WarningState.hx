package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class WarningState extends FlxState
{
	public function new() 
	{
		super();
	}

	override public function create()
	{
		super.create();
		FlxG.sound.playMusic(Paths.music('BobWarningScreen'), 1);
		var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('WARNINGSCRENWARNINGSCREN', 'preload'));
		add(thx);
	}

	public override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new TitleState());
		}
		super.update(elapsed);
	}
}
