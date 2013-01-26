package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Main extends FlxGame 
	{
		public static var DEBUG:Sprite;
		public function Main():void
		{
			super(640, 480, GameState, 1, 60, 30, true);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			FlxG.debug = true;
		}
		private function addedToStage(e:Event):void {
			DEBUG = new Sprite();
			//DEBUG.graphics.beginFill(0xFFFFFF, 1);
			//DEBUG.graphics.drawCircle(10, 10, 10);
			//DEBUG.graphics.endFill();
			FlxG.stage.addChild(DEBUG);
		}
	}
}