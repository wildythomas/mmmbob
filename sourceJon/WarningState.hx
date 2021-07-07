package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class WarningState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";

	override function create()
	{
		super.create();
		FlxG.sound.playMusic(Paths.music('BobWarningScreen'), 1);
		var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('WARNINGSCRENWARNINGSCREN', 'preload'));
		add(thx);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new TitleState());
		}
		super.update(elapsed);
	}
}
