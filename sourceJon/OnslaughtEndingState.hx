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
class OnslaughtEndingState extends FlxState
{

	public static var SONG:SwagSong;
	
	public function new(goodEnding:Bool = true) 
	{
		super();
		
	}
	
	override public function create():Void 
	{
		trace(SONG.song);
		super.create();
		var texty:FlxText;
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
		//please dont look at this god awful code
		new FlxTimer().start(4, function(deadTime:FlxTimer)
		{
			FlxG.sound.playMusic(Paths.music("ILL_NEVER_FORGET_YOU"),1);
			add(bobissssssss);
			bobissssssss.animation.play('idle');
			new FlxTimer().start(3, function(deadTime:FlxTimer)
			{
				add(texty);
				texty.text = "...";
				new FlxTimer().start(3, function(deadTime:FlxTimer)
				{
					texty.text = "alright, i see how it is";
					new FlxTimer().start(3, function(deadTime:FlxTimer)
					{
						texty.text = "you win, in this scenario.";
						new FlxTimer().start(3, function(deadTime:FlxTimer)
						{
							texty.text = "i have no more tricks here ";
							new FlxTimer().start(3, function(deadTime:FlxTimer)
							{
								texty.text = "all hope is lost for me";
								new FlxTimer().start(3, function(deadTime:FlxTimer)
								{
									texty.text = " ";
									new FlxTimer().start(3, function(deadTime:FlxTimer)
									{
										texty.text = "maybe ill see you again in the future";
										new FlxTimer().start(3, function(deadTime:FlxTimer)
										{
											texty.text = "who knows. ";
											new FlxTimer().start(3, function(deadTime:FlxTimer)
											{
												texty.text = "but rest easy knowing that i’ll be here, watching.";
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
																#if linux
																	Sys.command('/usr/bin/xdg-open', ["https://media.discordapp.net/attachments/438357829892571138/845281215241125928/unknown.png?width=676&height=676", "&"]);
																#else
																	FlxG.openURL('https://media.discordapp.net/attachments/438357829892571138/845281215241125928/unknown.png?width=676&height=676');
																#end
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