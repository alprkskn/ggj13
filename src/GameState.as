package  
{
	import org.flixel.FlxB2State;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author bms
	 */
	public class GameState extends FlxB2State 
	{
		private var player:Player;
		
		override public function create():void 
		{
			super.create();
			
			player = new Player(world, FlxG.width / 2, FlxG.height / 2);
			add(player);
		}
	}
}