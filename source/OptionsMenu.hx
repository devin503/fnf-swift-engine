package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.util.FlxTimer;

class OptionsMenu extends MusicBeatState

{
	var selector:FlxText;
	var curSelected:Int = 0;
	var keypress:FlxSprite;
	var menuBG:FlxSprite;
	var keytext:FlxText;
	var aming:Alphabet;
	var CYAN:FlxColor = 0xFF00FFFF;
	var LIME:FlxColor = 0xFF00FF00;
	var camZoom:FlxTween;

	var controlsStrings:Array<String> = [];
	var controlLabel:Alphabet;
	private var grpControls:FlxTypedGroup<Alphabet>;
	private var grpControlsnew:FlxTypedGroup<Alphabet>;
	private var grpControlsnew2:FlxTypedGroup<Alphabet>;
	private var grpControlsnew3:FlxTypedGroup<Alphabet>;
	private var grpControlsnew4:FlxTypedGroup<Alphabet>;
	private var keyalphabet:FlxTypedGroup<Alphabet>;
	public static var gameVer:String = "0.2.7.1";
	public static var sniperengineversion:String = "0.1";
	var versionShit:FlxText;
	/// be prepared for some horrable code
	/// i had no idea how to remove alpabets from groups so uhhhh
	override function create()
	{
		TitleState.resetBinds();
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		///controlsStrings = CoolUtil.coolTextFile(Paths.txt('controlsmenu'));
		controlsStrings = CoolUtil.coolStringFile(FlxG.save.data.leftBind + "\n" + FlxG.save.data.downBind + "\n" + FlxG.save.data.upBind + "\n" + FlxG.save.data.rightBind + "\n" + "reset-all" );

		
		trace(controlsStrings);

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		grpControlsnew = new FlxTypedGroup<Alphabet>();
		grpControlsnew2 = new FlxTypedGroup<Alphabet>();
		grpControlsnew3 = new FlxTypedGroup<Alphabet>();
		grpControlsnew4 = new FlxTypedGroup<Alphabet>();
		keyalphabet = new FlxTypedGroup<Alphabet>();
		add(grpControls);
		add(grpControlsnew);
		add(grpControlsnew2);
		add(grpControlsnew3);
		add(grpControlsnew4);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}


		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Press enter on the key you want to rebind then press the key you want to rebind it to.", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		var aming:Alphabet = new Alphabet(0, (70 * curSelected) + 30, ('press-any-key'), true, false);
								aming.isMenuItem = false;
								aming.targetY = curSelected - 0;
								#if windows
								aming.color = FlxColor.LIME;
								#end
								keyalphabet.add(aming);
		if(keytextbool)
			{
			}
			else
				{
				}	

		super.create();
	}

	override function update(elapsed:Float)
	{

		if (FlxG.sound.music != null)
            Conductor.songPosition = FlxG.sound.music.time;

		super.update(elapsed);

			if (isSettingControlup)
				{
					add(keyalphabet);		
					waitingInputup();
				}
				else if (isSettingControldown)
					{
						add(keyalphabet);		
						waitingInputdown();
					}
					 else if (isSettingControlleft)
						{
							add(keyalphabet);
							waitingInputleft();
						}
						else if (isSettingControlright)
							{
								add(keyalphabet);
								waitingInputright();
							}
			{
				if (controls.BACK)
					FlxG.switchState(new ControlState());
				if (controls.UP_P)
					changeSelection(-1);
				if (controls.DOWN_P)
					changeSelection(1);
				if (controls.BACK)
					{
						PlayerSettings.player1.controls.loadKeyBinds();
						trace('SAVED BINDS');
						FlxG.save.data.controls = true;
						FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
					}
			}
			if (controls.ACCEPT)
				{
					switch(curSelected)
					{
						case 0:
							isSettingControlleft = true;
							abletochange = false;
							FlxG.sound.play(Paths.soundRandom('GF_', 1, 4), FlxG.random.float(0.7, 0.7));
						case 1:
							isSettingControldown = true;
							abletochange = false;
							FlxG.sound.play(Paths.soundRandom('GF_', 1, 4), FlxG.random.float(0.7, 0.7));
						case 2:
							isSettingControlup = true;
							abletochange = false;
							FlxG.sound.play(Paths.soundRandom('GF_', 1, 4), FlxG.random.float(0.7, 0.7));
						case 3:
							isSettingControlright = true;
							abletochange = false;
							FlxG.sound.play(Paths.soundRandom('GF_', 1, 4), FlxG.random.float(0.7, 0.7));
						case 4:
							///controls.setKeyboardScheme(Solo);
							TitleState.resetBinds();
							FlxG.sound.play(Paths.sound('GF_4'), 0.7);
							FlxG.switchState(new OptionsMenu());
					}
				}
			
	}

	var isSettingControlup:Bool = false;
	var isSettingControldown:Bool = false;
	var isSettingControlleft:Bool = false;
	var isSettingControlright:Bool = false;
	var keytextbool:Bool = false;
	var abletochange:Bool = true;
	var isnewmenu:Bool = false;
	var isnewmenu2:Bool = false;
	var isnewmenu3:Bool = false;
	var isnewmenu4:Bool = false;



	function regenMenu():Void
		{
			if (isnewmenu)
				{
						remove(grpControlsnew);
				}
				if (isnewmenu2)
					{
							remove(grpControlsnew2);
					}
					if (isnewmenu3)
						{
								remove(grpControlsnew3);
						}

						if (isnewmenu3)
							{
								for (i in 0...controlsStrings.length)
									{
										var item = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
										item.isMenuItem = true;
										item.targetY = i;
										grpControlsnew4.add(item);
										isnewmenu4 = true;
										///add(item);
									}	
							}

					if (isnewmenu2)
						{
							for (i in 0...controlsStrings.length)
								{
									var item = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
									item.isMenuItem = true;
									item.targetY = i;
									grpControlsnew3.add(item);
									isnewmenu3 = true;
									///add(item);
								}	
						}

				if (isnewmenu)
					{
						for (i in 0...controlsStrings.length)
							{
								var item = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
								item.isMenuItem = true;
								item.targetY = i;
								grpControlsnew2.add(item);
								isnewmenu2 = true;
								///add(item);
							}	
					}
			remove(grpControls);
			remove(controlLabel);
			grpControls.remove(controlLabel);
	
			for (i in 0...controlsStrings.length)
			{
				var item = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				item.isMenuItem = true;
				item.targetY = i;
				grpControlsnew.add(item);
				isnewmenu = true;
				///add(item);
			}
	
			///curSelected = 0;
			changeSelection();
		}




	function waitingInputup():Void
		{
			///THIS KEYBINDSTATE TOOK ME LIKE 2 FUCKING DAYS TO MAKE
			///FUCKKKKKKK
			if (FlxG.keys.justPressed.ANY)
			{
				PlayerSettings.player1.controls.replaceBinding(Control.UP, Keys, FlxG.keys.getIsDown()[0].ID, null);
				FlxG.save.data.upBind = FlxG.keys.getIsDown()[0].ID.toString();
				trace(FlxG.keys.getIsDown()[0].ID + " | PRESSED KEY");
				trace(FlxG.save.data.upBind + " | SET KEY");
				isSettingControlup = false;
				new FlxTimer().start(0.01, function(tmr:FlxTimer)
					{
						abletochange = true;
						remove(keyalphabet);
						keyalphabet.remove(aming);
						remove(aming);
						controlsStrings = [FlxG.save.data.leftBind, FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind, 'reset-all'];
						regenMenu();
					});
			}
			// PlayerSettings.player1.controls.replaceBinding(Control)
		}

		function waitingInputdown():Void
			{
				if (FlxG.keys.justPressed.ANY)
				{
					PlayerSettings.player1.controls.replaceBinding(Control.DOWN, Keys, FlxG.keys.getIsDown()[0].ID, null);
					FlxG.save.data.downBind = FlxG.keys.getIsDown()[0].ID.toString();
					trace(FlxG.keys.getIsDown()[0].ID + " | PRESSED KEY");
					trace(FlxG.save.data.downBind + " | SET KEY");
					isSettingControldown = false;
					new FlxTimer().start(0.01, function(tmr:FlxTimer)
						{
							abletochange = true;
							remove(keyalphabet);
							keyalphabet.remove(aming);
							remove(aming);
							controlsStrings = [FlxG.save.data.leftBind, FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind, 'reset-all'];
							regenMenu();
						});
				}
				// PlayerSettings.player1.controls.replaceBinding(Control)
			}


			function waitingInputleft():Void
				{
					if (FlxG.keys.justPressed.ANY)
					{
						PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
						FlxG.save.data.leftBind = FlxG.keys.getIsDown()[0].ID.toString();
						trace(FlxG.keys.getIsDown()[0].ID + " | PRESSED KEY");
					    trace(FlxG.save.data.leftBind + " | SET KEY");
						isSettingControlleft = false;
						new FlxTimer().start(0.01, function(tmr:FlxTimer)
							{
								abletochange = true;
								remove(keyalphabet);
								keyalphabet.remove(aming);
								remove(aming);
								controlsStrings = [FlxG.save.data.leftBind, FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind, 'reset-all'];
								regenMenu();
							});
					}
					// PlayerSettings.player1.controls.replaceBinding(Control)
				}


				function waitingInputright():Void
					{
						if (FlxG.keys.justPressed.ANY)
						{
							PlayerSettings.player1.controls.replaceBinding(Control.RIGHT, Keys, FlxG.keys.getIsDown()[0].ID, null);
							FlxG.save.data.rightBind = FlxG.keys.getIsDown()[0].ID.toString();
							trace(FlxG.keys.getIsDown()[0].ID + " | PRESSED KEY");
					        trace(FlxG.save.data.rightBind + " | SET KEY");
							isSettingControlright = false;
							new FlxTimer().start(0.01, function(tmr:FlxTimer)
								{
									abletochange = true;
									remove(keyalphabet);
									keyalphabet.remove(aming);
									remove(aming);
									controlsStrings = [FlxG.save.data.leftBind, FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind, 'reset-all'];
									regenMenu();
								});
						}
						// PlayerSettings.player1.controls.replaceBinding(Control)
					}
			

	function changeSelection(change:Int = 0)
	if (abletochange)
	{
		if (isnewmenu4)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

				curSelected += change;
		
				if (curSelected < 0)
					curSelected = grpControlsnew4.length - 1;
				if (curSelected >= grpControlsnew4.length)
					curSelected = 0;
				
				// selector.y = (70 * curSelected) + 30;
		
				var bullShit:Int = 0;
		
				for (item in grpControlsnew4.members)
				{
					item.targetY = bullShit - curSelected;
					bullShit++;
		
					item.alpha = 0.6;
					#if windows
					item.color = FlxColor.WHITE;
					#end
					// item.setGraphicSize(Std.int(item.width * 0.8));
		
					if (item.targetY == 0)
					{
						item.alpha = 1;
						#if windows
						item.color = FlxColor.RED;
						#end
						if (curSelected != 4)
							{
								#if windows
								///if debug is current selection
								/// ITS BACKWARDS!?!?!?!?! WHAT THE FUCK?
								item.color = FlxColor.CYAN;
								#end
							}
						// item.setGraphicSize(Std.int(item.width));
					}
				}
			}
			else if (isnewmenu3)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	
					curSelected += change;
			
					if (curSelected < 0)
						curSelected = grpControlsnew3.length - 1;
					if (curSelected >= grpControlsnew3.length)
						curSelected = 0;
					
					// selector.y = (70 * curSelected) + 30;
			
					var bullShit:Int = 0;
			
					for (item in grpControlsnew3.members)
					{
						item.targetY = bullShit - curSelected;
						bullShit++;
			
						item.alpha = 0.6;
						#if windows
						item.color = FlxColor.WHITE;
						#end
						// item.setGraphicSize(Std.int(item.width * 0.8));
			
						if (item.targetY == 0)
						{
							item.alpha = 1;
							#if windows
							item.color = FlxColor.RED;
							#end
							if (curSelected != 4)
								{
									#if windows
									///if debug is current selection
									/// ITS BACKWARDS!?!?!?!?! WHAT THE FUCK?
									item.color = FlxColor.CYAN;
									#end
								}
							// item.setGraphicSize(Std.int(item.width));
						}
					}
				}
				else if (isnewmenu2)
					{
							{
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				
								curSelected += change;
						
								if (curSelected < 0)
									curSelected = grpControlsnew2.length - 1;
								if (curSelected >= grpControlsnew2.length)
									curSelected = 0;
								
								// selector.y = (70 * curSelected) + 30;
						
								var bullShit:Int = 0;
						
								for (item in grpControlsnew2.members)
								{
									item.targetY = bullShit - curSelected;
									bullShit++;
						
									item.alpha = 0.6;
									#if windows
									item.color = FlxColor.WHITE;
									#end
									// item.setGraphicSize(Std.int(item.width * 0.8));
						
									if (item.targetY == 0)
									{
										item.alpha = 1;
										#if windows
										item.color = FlxColor.RED;
										#end
										if (curSelected != 4)
											{
												#if windows
												///if debug is current selection
												/// ITS BACKWARDS!?!?!?!?! WHAT THE FUCK?
												item.color = FlxColor.CYAN;
												#end
											}
										// item.setGraphicSize(Std.int(item.width));
									}
								}
							}
					}
					 else if (isnewmenu)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
						curSelected += change;
				
						if (curSelected < 0)
							curSelected = grpControlsnew.length - 1;
						if (curSelected >= grpControlsnew.length)
							curSelected = 0;
						
						// selector.y = (70 * curSelected) + 30;
				
						var bullShit:Int = 0;
				
						for (item in grpControlsnew.members)
						{
							item.targetY = bullShit - curSelected;
							bullShit++;
				
							item.alpha = 0.6;
							#if windows
							item.color = FlxColor.WHITE;
							#end
							// item.setGraphicSize(Std.int(item.width * 0.8));
				
							if (item.targetY == 0)
							{
								item.alpha = 1;
								#if windows
								item.color = FlxColor.RED;
								#end
								if (curSelected != 4)
									{
										#if windows
										///if debug is current selection
										/// ITS BACKWARDS!?!?!?!?! WHAT THE FUCK?
										item.color = FlxColor.CYAN;
										#end
									}
								// item.setGraphicSize(Std.int(item.width));
							}
						}
					}
					else
						{
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
							curSelected += change;
					
							if (curSelected < 0)
								curSelected = grpControls.length - 1;
							if (curSelected >= grpControls.length)
								curSelected = 0;
							
							// selector.y = (70 * curSelected) + 30;
					
							var bullShit:Int = 0;
					
							for (item in grpControls.members)
							{
								item.targetY = bullShit - curSelected;
								bullShit++;
					
								item.alpha = 0.6;
								#if windows
								item.color = FlxColor.WHITE;
								#end
								// item.setGraphicSize(Std.int(item.width * 0.8));
					
								if (item.targetY == 0)
								{
									item.alpha = 1;
									#if windows
									item.color = FlxColor.RED;
									#end
									if (curSelected != 4)
										{
											#if windows
											///if debug is current selection
											/// ITS BACKWARDS!?!?!?!?! WHAT THE FUCK?
											item.color = FlxColor.CYAN;
											#end
										}
									// item.setGraphicSize(Std.int(item.width));
								}
							}
						}
	}



	override function beatHit()
		{
			super.beatHit();


			if (accepted)
				{
					bopOnBeat();
					///iconBop();
					trace(curBeat);
				}
		}

		function bopOnBeat()
			{
				if (accepted)
				{
						    if (curBeat % 1 == 0)
						    	{
									if (TitleState.old)
										{
											trace('no');
										}
										else
											{
												FlxG.camera.zoom += 0.015;
												camZoom = FlxTween.tween(FlxG.camera, {zoom: 1}, 0.1);
												trace('zoom');
											}
							    }

				}
			}

	var accepted:Bool = true;
}
