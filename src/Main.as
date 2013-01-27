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
		public function Main():void
		{
			super(640, 480, MenuState, 1, 60, 30, true);
			FlxG.debug = true;
		}
	}
}