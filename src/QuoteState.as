package  {
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.system.FlxTilemapBuffer;
	/**
	$(CBI)* ...
	$(CBI)* @author alper keskin
	$(CBI)*/
	public class QuoteState extends FlxState {
		private var splash:FlxSprite;
		
		
		private var fadeOut:Boolean = false;
		
		private var tmr:FlxTimer;
		
		override public function create():void {
			super.create();
			splash = new FlxSprite(0, 0, Assets.QUOTE_SPRITE);
			add(splash);
			splash.y = 100;
			splash.x = (FlxG.width - splash.width) / 2;
			splash.alpha = 0;
			tmr = new FlxTimer();
		}
		
		override public function update():void {
			super.update();
			if (!fadeOut && splash.alpha < 0.9) {
				splash.alpha += 0.01;
				return;
			}
			
			if(!fadeOut)
				tmr.start(2, 1, startOut);
				
			if (fadeOut) {
				splash.alpha -= 0.01;
				if (splash.alpha < 0.001) {
					FlxG.switchState(new GameState);
				}
			}
		}
		
		private function startOut(f:FlxTimer):void {
			trace("don");
			fadeOut = true;
		}
	}

}