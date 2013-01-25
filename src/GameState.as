package  
{
	import org.flixel.FlxB2State;
	
	/**
	 * ...
	 * @author bms
	 */
	public class GameState extends FlxB2State 
	{
		private var _player:Player;
		
		override public function create():void 
		{
			super.create();
			
			_player = new Player();
		}
	}
}