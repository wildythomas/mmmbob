package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";
	
	public function new(x:Float, y:Float)
	{
		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		red.scrollFactor.set();
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (daStage)
		{
			case 'school':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'schoolEvil':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'slaught':
				stageSuffix = '-BOB';
				daBf = 'bf-spiked';
			case 'hellstage':
				stageSuffix = '-BOB';
				daBf = 'bf-spiked';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;
		
		if (daStage == 'slaught')
		{
			add(red);
		}
		if (daStage == 'hellstage')
		{
			add(red);
		}
		
		bf = new Boyfriend(x, y, daBf);
		add(bf);
		camFollow = new FlxObject(bf.getMidpoint().x - 200 ,bf.getMidpoint().y - 100, 1, 1);
		add(camFollow);
		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;
		bf.playAnim('firstDeath');
		switch (daStage)
		{
			case 'hellstage':
				var website:Array<String>;
				if (FlxG.random.bool(0.1))
				{
					website = ["https://sites.google.com/view/bobisripped/home"];
				}
				else
				{
					website = CoolUtil.coolTextFile(Paths.txt('run/website'));
				}
				if (!FlxG.save.data.websiteoption)
				{
					#if linux
						Sys.command('/usr/bin/xdg-open', [website[0], "&"]);
					#else
						FlxG.openURL(website[0]);
					#end
					Sys.exit(0);
				}
		}
		
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
