package;
import flixel.FlxSprite;
import flixel.*;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


class WarningState extends MusicBeatState
{
	override function create()
	{
		super.create();
		var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('WARNINGSCRENWARNINGSCREN', 'preload'));
		add(thx);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new ThankYouState());
		}
		super.update(elapsed);
	}
	
}