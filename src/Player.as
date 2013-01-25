package  
{
	import org.flixel.FlxB2Sprite;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Player extends FlxB2Sprite 
	{
		
		public function Player() 
		{
			super(world, X, Y, Assets.PLAYER_SPRITE);
		}
	}
}