package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Sunshine', 'Withered', 'run'],
		['Ron', 'Trouble', 'Onslaught']
	];
	var curDifficulty_1:Int = 1;
	var curDifficulty_2:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true];

	var weekCharacters:Array<Dynamic> = [
		['bob', 'bf', 'gf'],
		['bob', 'bf', 'gf']
	];

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var grpLocks:FlxTypedGroup<FlxSprite>;
	
	var bgBack:FlxSprite;
	var bgFront:FlxSprite;
	var Week1:FlxSprite;
	var Week2:FlxSprite;
	var mainthingidk:FlxSprite;

	var difficultySelectors_1:FlxGroup;
	var sprDifficulty_1:FlxSprite;
	var leftArrow_1:FlxSprite;
	var rightArrow_1:FlxSprite;

	var difficultySelectors_2:FlxGroup;
	var sprDifficulty_2:FlxSprite;
	var leftArrow_2:FlxSprite;
	var rightArrow_2:FlxSprite;

	var bobWeekIndicator:FlxSprite;
	var bobOnslaughtIndicator:FlxSprite;

	var choose:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("choosing", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		persistentUpdate = persistentDraw = true;
		
		
		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);
		
		bgBack = new FlxSprite( -21.4, -1.2).loadGraphic(Paths.image('bob/Sky_Bob', 'shared'));
		bgFront = new FlxSprite(0, 37.2).loadGraphic(Paths.image('bob/Screen_Sky', 'shared'));
		Week1 = new FlxSprite(538.55,-26.45);
		Week1.frames = Paths.getSparrowAtlas('bob/BobSelectScreen', 'shared');
		Week1.animation.addByPrefix('idle', 'Bob Onslaught', 24, true);
		Week1.antialiasing = true;
		Week2 = new FlxSprite(-55.5, 61.4);
		Week2.frames = Paths.getSparrowAtlas('bob/BobSelectScreen', 'shared');
		Week2.animation.addByPrefix('idle', 'Bob Week', 24, true);
		Week2.antialiasing = true;
		mainthingidk = new FlxSprite(0, 0).loadGraphic(Paths.image('bob/SelectScreen_Bob', 'shared'));
		add(bgBack);
		add(bgFront);
		add(Week1);
		add(Week2);
		Week1.animation.play('idle');
		Week2.animation.play('idle');
		add(mainthingidk);
		moveBg();
		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		trace("Line 96");

		difficultySelectors_1 = new FlxGroup();
		add(difficultySelectors_1);

		difficultySelectors_2 = new FlxGroup();
		add(difficultySelectors_2);

		trace("Line 124");


		leftArrow_1 = new FlxSprite(-10,637.25);
		leftArrow_1.frames = ui_tex;
		leftArrow_1.animation.addByPrefix('idle', "arrow left");
		leftArrow_1.animation.addByPrefix('press', "arrow push left");
		leftArrow_1.scale.x = 0.8;
		leftArrow_1.scale.y = 0.8;
		leftArrow_1.animation.play('idle');
		difficultySelectors_1.add(leftArrow_1);

		leftArrow_2 = new FlxSprite(FlxG.width - 405, 637.25);
		leftArrow_2.frames = ui_tex;
		leftArrow_2.animation.addByPrefix('idle', "arrow left");
		leftArrow_2.animation.addByPrefix('press', "arrow push left");
		leftArrow_2.scale.x = 0.8;
		leftArrow_2.scale.y = 0.8;
		leftArrow_2.animation.play('idle');
		difficultySelectors_2.add(leftArrow_2);

		sprDifficulty_1 = new FlxSprite(leftArrow_1.x + 130, leftArrow_1.y + 30);
		sprDifficulty_1.frames = ui_tex;
		sprDifficulty_1.animation.addByPrefix('easy', 'EASY');
		sprDifficulty_1.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty_1.animation.addByPrefix('hard', 'HARD');
		sprDifficulty_1.scale.x = 0.95;
		sprDifficulty_1.scale.y = 0.95;
		sprDifficulty_1.animation.play('easy');

		difficultySelectors_1.add(sprDifficulty_1);

		sprDifficulty_2 = new FlxSprite(leftArrow_2.x + 130, leftArrow_2.y + 30);
		sprDifficulty_2.frames = ui_tex;
		sprDifficulty_2.animation.addByPrefix('easy', 'EASY');
		sprDifficulty_2.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty_2.animation.addByPrefix('hard', 'HARD');
		sprDifficulty_2.scale.x = 0.95;
		sprDifficulty_2.scale.y = 0.95;
		sprDifficulty_2.animation.play('easy');
		changeDifficulty();

		// temp fix
		sprDifficulty_2.y = leftArrow_2.y + 15;

		difficultySelectors_2.add(sprDifficulty_2);

		rightArrow_1 = new FlxSprite(sprDifficulty_1.x + sprDifficulty_1.width + 20, leftArrow_1.y);
		rightArrow_1.frames = ui_tex;
		rightArrow_1.animation.addByPrefix('idle', 'arrow right');
		rightArrow_1.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow_1.animation.play('idle');
		rightArrow_1.scale.x = 0.8;
		rightArrow_1.scale.y = 0.8;
		difficultySelectors_1.add(rightArrow_1);

		rightArrow_2 = new FlxSprite(sprDifficulty_2.x + sprDifficulty_2.width + 20, leftArrow_2.y);
		rightArrow_2.frames = ui_tex;
		rightArrow_2.animation.addByPrefix('idle', 'arrow right');
		rightArrow_2.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow_2.animation.play('idle');
		rightArrow_2.scale.x = 0.8;
		rightArrow_2.scale.y = 0.8;
		difficultySelectors_1.add(rightArrow_2);

		trace("Line 150");
		// add(rankText);
		add(scoreText);

		//updateText();

		trace("Line 165");

		bobWeekIndicator = new FlxSprite(15, FlxG.height - 170).loadGraphic(Paths.image("bob/bobweek1", "shared"));
		bobWeekIndicator.antialiasing = true;
		bobWeekIndicator.scale.x = 0.85;
		bobWeekIndicator.scale.y = 0.85;
		add(bobWeekIndicator);

		bobOnslaughtIndicator = new FlxSprite(FlxG.width - 510, FlxG.height - 180).loadGraphic(Paths.image("bob/bobweek2", "shared"));
		bobOnslaughtIndicator.antialiasing = true;
		bobOnslaughtIndicator.scale.x = 0.55;
		bobOnslaughtIndicator.scale.y = 0.55;
		add(bobOnslaughtIndicator);

		choose = new FlxSprite(FlxG.width / 2, 5).loadGraphic(Paths.image("bob/choose", "shared"));
		choose.antialiasing = true;
		choose.scale.x = 0.85;
		choose.scale.y = 0.85;
		choose.screenCenter(X);
		add(choose);

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors_1.visible = weekUnlocked[curWeek];
		difficultySelectors_2.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});
		if (curWeek == 0)
		{
			Week1.visible = false;
			Week2.visible = true;
		}
		else
		{
			Week1.visible = true;
			Week2.visible = false;
		}
		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT) {
					if (curWeek == 0)
						rightArrow_1.animation.play('press');
					else
						rightArrow_1.animation.play('idle');

					if (curWeek == 1)
						rightArrow_2.animation.play('press');
					else
						rightArrow_2.animation.play('idle');
					}
				else {
					rightArrow_1.animation.play('idle');
					rightArrow_2.animation.play('idle');
				}

				if (controls.LEFT) {
					if (curWeek == 0)
						leftArrow_1.animation.play('press');
					else
						leftArrow_1.animation.play('idle');

					if (curWeek == 1)
						leftArrow_2.animation.play('press');
					else
						leftArrow_2.animation.play('idle');
				}
				else {
						leftArrow_1.animation.play('idle');
						leftArrow_2.animation.play('idle');
				}

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;
	/**function moveBgF()
	{
		FlxTween.tween(bgFront, {y: -27.9}, 10, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				moveBgF2();
			}
		});
	}
	function moveBgF2()
	{
		FlxTween.tween(bgFront, {y: 37.2}, 10, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				moveBgF();
			}
		});
	}**/
	function moveBg()
	{
		FlxTween.tween(bgFront, {y: -27.9}, 5, {ease: FlxEase.cubeInOut});
		FlxTween.tween(bgBack, {y: -24.45}, 5, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				moveBg2();
			}
		});
	}
	function moveBg2()
	{
		FlxTween.tween(bgFront, {y: 37.2}, 5, {ease: FlxEase.cubeInOut});
		FlxTween.tween(bgBack, {y: -1.2}, 5, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				moveBg();
			}
		});
	}
	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				//grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty_1)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			switch (curDifficulty_2)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			if (curWeek == 0)
				PlayState.storyDifficulty = curDifficulty_1;
			else if (curWeek == 1)
				PlayState.storyDifficulty = curDifficulty_2;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;

			if (curWeek == 1) {
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new VideoState(Paths.video('ronPreCutscene'), new PlayState()));
				});
			}

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		if (curWeek == 0)
			curDifficulty_1 += change;

		if (curWeek == 1)
			curDifficulty_2 += change;

		if (curDifficulty_1 < 0)
			curDifficulty_1 = 2;
		if (curDifficulty_1 > 2)
			curDifficulty_1 = 0;

		if (curDifficulty_2 < 0)
			curDifficulty_2 = 2;
		if (curDifficulty_2 > 2)
			curDifficulty_2 = 0;

		if (curWeek == 0)
			sprDifficulty_1.offset.x = 0;

		if (curWeek == 1)
			sprDifficulty_2.offset.x = 0;

		switch (curDifficulty_1)
		{
			case 0:
				sprDifficulty_1.animation.play('easy');
				sprDifficulty_1.offset.x = 20;
			case 1:
				sprDifficulty_1.animation.play('normal');
				sprDifficulty_1.offset.x = 70;
			case 2:
				sprDifficulty_1.animation.play('hard');
				sprDifficulty_1.offset.x = 20;
		}

		switch (curDifficulty_2)
		{
			case 0:
				sprDifficulty_2.animation.play('easy');
				sprDifficulty_2.offset.x = 20;
			case 1:
				sprDifficulty_2.animation.play('normal');
				sprDifficulty_2.offset.x = 70;
			case 2:
				sprDifficulty_2.animation.play('hard');
				sprDifficulty_2.offset.x = 20;
		}

		if (curWeek == 0)
			sprDifficulty_1.alpha = 0;

		if (curWeek == 1)
			sprDifficulty_2.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		if (curWeek == 0)
			sprDifficulty_1.y = leftArrow_1.y - 15;

		if (curWeek == 1)
			sprDifficulty_2.y = leftArrow_2.y - 15;
		
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty_1);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty_1);
		#end

		if (curWeek == 0)
			FlxTween.tween(sprDifficulty_1, {y: leftArrow_1.y + 15, alpha: 1}, 0.07);

		if (curWeek == 1)
			FlxTween.tween(sprDifficulty_2, {y: leftArrow_2.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty_1);

		//updateText();
	}

	/**function updateText()
	{
		grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore_1 = Highscore.getWeekScore(curWeek, curDifficulty_1);
		#end
	}**/
}
