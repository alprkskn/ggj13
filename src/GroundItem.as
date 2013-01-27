package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author bms
	 */
	public class GroundItem extends FlxSprite 
	{
		public var content:String;
		public function GroundItem(X:Number, Y:Number, content:String) 
		{
			super(X, Y, Assets.WEAPON_SPRITES[content]);
			this.content = content;
		}
	}
}