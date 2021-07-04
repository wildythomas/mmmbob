package;
import flixel.*;
import flixel.addons.ui.FlxUIText;
import Song.SwagSong;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * i took this code from pompom im sorry
 */
class EndingState extends FlxState
{
	public function new(goodEnding:Bool = true) 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		super.create();
		var texty:FlxText;
		var dialogue:Array<String> = ["thats odd.", "you people weren't meant to pass", "especially you..", " ", "i can see you...."," ","scared you with that one huh?"," ","some day you're gonna forget me.","as for me.","I L L  N E V E R  F O R G E T  Y O U"];
		texty = new FlxUIText(532,550, 0, "");
		texty.setFormat("Arial", 30, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		var neverforget:FlxText;
		neverforget = new FlxUIText(208,342, 0, "");
		neverforget.setFormat("Arial",50,FlxColor.WHITE,FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		var bobissssssss:FlxSprite = new FlxSprite(0, 0);
		bobissssssss.frames = Paths.getSparrowAtlas('bob/20215211567');
		bobissssssss.animation.addByPrefix('idle', 'idle', 24, true);
		bobissssssss.animation.addByPrefix('scaryidle', 'scary', 24, false);
		bobissssssss.antialiasing = true;
		FlxG.sound.playMusic(Paths.music("youcantrun"),0);
		/*add(texty);
		new FlxTimer().start(4, function(deadTime:FlxTimer)
		{
			var dialognumber:Int = 0;
			var textdialog:String;
			FlxG.sound.playMusic(Paths.music("ILL_NEVER_FORGET_YOU"),1);
			add(bobissssssss);
			bobissssssss.animation.play('idle');
			new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				if (textdialog == "I L L  N E V E R  F O R G E T  Y O U")
				{
					FlxG.sound.playMusic(Paths.music("ILL_NEVER_FORGET_YOU"),0);
					remove(texty);
					bobissssssss.animation.play('scaryidle');
					//bobissssssss.play('scaryidle');
					new FlxTimer().start(4, function(deadTime:FlxTimer)
					{
						add(neverforget);
						neverforget.text = "I L L  N E V E R  F O R G E T  Y O U";
						new FlxTimer().start(3, function(deadTime:FlxTimer)
						{
							crash = true;
						});
					});
				}
				else
				{
					textdialog = dialogue[dialognumber];
					texty.text = textdialog;
				}
				dialognumber = dialognumber + 1;
			}, 11);
		});*/
		//please dont look at this god awful code
		new FlxTimer().start(4, function(deadTime:FlxTimer)
		{
			FlxG.sound.playMusic(Paths.music("ILL_NEVER_FORGET_YOU"),1);
			add(bobissssssss);
			bobissssssss.animation.play('idle');
			new FlxTimer().start(3, function(deadTime:FlxTimer)
			{
				add(texty);
				texty.text = "thats odd.";
				new FlxTimer().start(3, function(deadTime:FlxTimer)
				{
					texty.text = "you people weren't meant to pass";
					new FlxTimer().start(3, function(deadTime:FlxTimer)
					{
						texty.text = "especially you..";
						new FlxTimer().start(3, function(deadTime:FlxTimer)
						{
							texty.text = " ";
							new FlxTimer().start(3, function(deadTime:FlxTimer)
							{
								texty.text = "i can see you....";
								new FlxTimer().start(3, function(deadTime:FlxTimer)
								{
									texty.text = " ";
									new FlxTimer().start(3, function(deadTime:FlxTimer)
									{
										texty.text = "scared you with that one huh?";
										new FlxTimer().start(3, function(deadTime:FlxTimer)
										{
											texty.text = " ";
											new FlxTimer().start(3, function(deadTime:FlxTimer)
											{
												texty.text = "some day you're gonna forget me.";
												new FlxTimer().start(3, function(deadTime:FlxTimer)
												{
													texty.text = "as for me.";
													new FlxTimer().start(3, function(deadTime:FlxTimer)
													{
														FlxG.sound.playMusic(Paths.music("ILL_NEVER_FORGET_YOU"),0);
														remove(texty);
														bobissssssss.animation.play('scaryidle');
														//bobissssssss.play('scaryidle');
														new FlxTimer().start(4, function(deadTime:FlxTimer)
														{
															add(neverforget);
															neverforget.text = "I L L  N E V E R  F O R G E T  Y O U";
															new FlxTimer().start(3, function(deadTime:FlxTimer)
															{
																Sys.exit(0);
															});
														});
													});
												});
											});
										});
									});
								});
							});
						});
					});
				});
			});
		});
		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}