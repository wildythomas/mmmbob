package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;


using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;
	var dropText:FlxText;
	
	var caniskip:Bool = true;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitGloop:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitRightBF:FlxSprite;
	var portraitRightGF:FlxSprite;

	var bgFade:FlxSprite;

	var BOOM:FlxSound;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'sunshine':
				FlxG.sound.playMusic(Paths.music('PhaseOne'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'withered':
				FlxG.sound.playMusic(Paths.music('PhaseTwo'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'run':
				FlxG.sound.playMusic(Paths.music('PhaseThreeRUNRUNHESCOMING'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'withered':
				box = new FlxSprite(0, 0);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('bob/dialogueBox-bob');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
				box.animation.addByPrefix('bobCRUSH', 'Bob DESTROYS the dialog box DAYUMNNNN', 24, false);
			case 'run':
				box = new FlxSprite(0, 0);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('bob/dialogueBox-bobevil');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'senpai':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);
			case 'thorns':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'little-man':
				hasDialog = false;
			default:
				box = new FlxSprite(0, 0);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('bob/dialogueBox-bob');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
		}

		this.dialogueList = dialogueList;
		if (PlayState.SONG.song.toLowerCase() == 'onslaught')
		{
			portraitGloop = new FlxSprite(0, 0);
			portraitGloop.frames = Paths.getSparrowAtlas('bob/glitchedBobPortrait');
			portraitGloop.animation.addByPrefix('enter', 'Bob Enter', 24, false);
			portraitGloop.updateHitbox();
			portraitGloop.scrollFactor.set();
			add(portraitGloop);
			portraitGloop.visible = false;
		}
		else
		{
			portraitGloop = new FlxSprite(0, 0);
			portraitGloop.frames = Paths.getSparrowAtlas('bob/gloopBobPortrait');
			portraitGloop.animation.addByPrefix('enter', 'Bob Enter', 24, false);
			portraitGloop.updateHitbox();
			portraitGloop.scrollFactor.set();
			add(portraitGloop);
			portraitGloop.visible = false;
		}
		if (!hasDialog)
			return;
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		if (PlayState.SONG.song.toLowerCase() == 'sunshine')
		{
			portraitLeft = new FlxSprite(0, 0);
			portraitLeft.frames = Paths.getSparrowAtlas('bob/bobPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Bob Portrait Enter', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		if (PlayState.SONG.song.toLowerCase() == 'withered')
		{
			portraitLeft = new FlxSprite(0, 0);
			portraitLeft.frames = Paths.getSparrowAtlas('bob/bobPortraitPOAT');
			portraitLeft.animation.addByPrefix('enter', 'Bob Portrait Enter Mad', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		if (PlayState.SONG.song.toLowerCase() == 'run')
		{
			portraitLeft = new FlxSprite(0, 0);
			portraitLeft.frames = Paths.getSparrowAtlas('bob/bobPortraitPOAT');
			portraitLeft.animation.addByPrefix('enter', 'Bob Portrait Enter HELL', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		if (PlayState.SONG.song.toLowerCase() == 'ron' || PlayState.SONG.song.toLowerCase() == 'trouble')
		{
			portraitLeft = new FlxSprite(0, 0);
			portraitLeft.frames = Paths.getSparrowAtlas('bob/ronPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Ron Enter', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}

		portraitRight = new FlxSprite(0, 0);
		portraitRight.frames = Paths.getSparrowAtlas('bob/bfPortrait');
		portraitRight.animation.addByPrefix('enterNormal', 'Boyfriend portrait enter', 24, false);
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitRightBF = new FlxSprite(0, 0);
		portraitRightBF.frames = Paths.getSparrowAtlas('bob/bfPortraitExpressions');
		portraitRightBF.animation.addByPrefix('enterSad', 'Boyfriend portrait enter sad', 24, false);
		portraitRightBF.animation.addByPrefix('enterShocked', 'Boyfriend portrait enter shocked', 24, false);
		portraitRightBF.updateHitbox();
		portraitRightBF.scrollFactor.set();
		add(portraitRightBF);
		portraitRightBF.visible = false;

		portraitRightGF = new FlxSprite(0, 0);
		portraitRightGF.frames = Paths.getSparrowAtlas('bob/WOOOOAH');
		portraitRightGF.animation.addByPrefix('enter', 'GF portrait enter', 24, false);
		portraitRightGF.updateHitbox();
		portraitRightGF.scrollFactor.set();
		add(portraitRightGF);
		portraitRightGF.visible = false;
		
		box.animation.play('normalOpen');
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		}
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		if (PlayState.SONG.song.toLowerCase() == 'onslaught')
			portraitGloop.screenCenter(X);
		else
			portraitLeft.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}
		dropText = new FlxText(242, 438, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 436, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			if (caniskip == true)
			{
				remove(dialogue);
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;

						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'sunshine' || PlayState.SONG.song.toLowerCase() == 'withered' || PlayState.SONG.song.toLowerCase() == 'run' || PlayState.SONG.song.toLowerCase() == 'withered' || PlayState.SONG.song.toLowerCase() == 'ron')
							FlxG.sound.music.fadeOut(2.2, 0);

						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							
							if (PlayState.SONG.song.toLowerCase() == 'onslaught')
								portraitGloop.visible = false;
							else
								portraitLeft.visible = false;

							portraitGloop.visible = false;
							portraitRight.visible = false;
							portraitRightBF.visible = false;
							portraitRightGF.visible = false;
							swagDialogue.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);

						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				}
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;

		if (dialogueList[0] == '....' && curCharacter == 'gloopBob')
		{
			#if linux
				Sys.command('/usr/bin/xdg-open', ['https://ayetsg.github.io/img/bob_says_fuck_you.jpg', "&"]);
			#else
				FlxG.openURL('https://ayetsg.github.io/img/bob_says_fuck_you.jpg');
			#end
		}
		
		if (dialogueList[0] == 'this is the part where bob absolubley destroys the dialog box like an awesome person' && curCharacter == 'dad')
		{
			caniskip == false;
			box.animation.play('bobCRUSH');
			portraitLeft.visible = false;
			portraitGloop.visible = false;
			portraitRight.visible = false;
			portraitRightBF.visible = false;
			portraitRightGF.visible = false;
			trace(dialogueList[0]);
			new FlxTimer().start(0.6, function(tmr:FlxTimer)
			{
				FlxG.sound.play(Paths.sound('Squeaky'));
				swagDialogue.resetText(dialogueList[0]);
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.sound.playMusic(Paths.music('ByYourSide'));
					caniskip == true;
				});
			});
		}
		else
		{
			trace(dialogueList[0]);
			swagDialogue.resetText(dialogueList[0]);
			swagDialogue.start(0.04, true);

			switch (curCharacter)
			{
				case 'doodoofartasslol':
					portraitRight.visible = false;
					portraitRightBF.visible = false;
					portraitLeft.visible = false;
					portraitGloop.visible = false;
					if (!portraitRightGF.visible)
					{
						portraitRightGF.visible = true;
						portraitRightGF.animation.play('enter');
				}
				case 'dad':
					portraitRightGF.visible = false;
					portraitRightBF.visible = false;
					portraitRight.visible = false;
					portraitGloop.visible = false;
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('enter');
					}
				case 'bf':
					portraitRightGF.visible = false;
					portraitRightBF.visible = false;

					if (PlayState.SONG.song.toLowerCase() == 'onslaught')
						portraitGloop.visible = false;
					else
						portraitLeft.visible = false;

					if (!portraitRight.visible)
					{
						portraitRight.visible = true;
						portraitRight.animation.play('enterNormal');
					}
				case 'bfsad':
					if (BOOM != null && BOOM.playing) {
						BOOM.stop();
					}
	
					BOOM = new FlxSound().loadEmbedded(Paths.sound('BOOM'));
					BOOM.play();

					portraitRightGF.visible = false;
					portraitRight.visible = false;
					portraitLeft.visible = false;
					portraitGloop.visible = false;
					if (!portraitRightBF.visible)
					{
						portraitRightBF.visible = true;
						portraitRightBF.animation.play('enterSad');
						FlxG.sound.music.stop();
					}
				case 'bfshocked':
					portraitRightGF.visible = false;
					portraitRight.visible = false;
					portraitLeft.visible = false;
					portraitGloop.visible = false;
					if (!portraitRightBF.visible)
					{
						portraitRightBF.visible = true;
						portraitRightBF.animation.play('enterShocked');
					}
				case 'gloopBob':
					portraitRightGF.visible = false;
					portraitRight.visible = false;
					
					if (PlayState.SONG.song.toLowerCase() == 'onslaught')
						portraitGloop.visible = false;
					else
						portraitLeft.visible = false;

					if (!portraitGloop.visible)
					{
						portraitGloop.visible = true;
						portraitGloop.animation.play('enter');
					}
			}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
