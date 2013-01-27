package  
{
	/**
	 * ...
	 * @author bms
	 */
	public class Globals 
	{
		public static var AMMO:Object = { "bomb":1, "pistol":10, "uzi":0, "shotgun":0, "bait":2 };
		
		public static var LEVEL:int = 0;
		public static var LEVELS:Array = [
		{ "img":Assets.MAP1_SPRITE, "data":Assets.MAP1_JSON },
		{ "img":Assets.MAP2_SPRITE, "data":Assets.MAP2_JSON }
		];
		
		static public function checkAmmo(string:String):Boolean 
		{
			if (AMMO[string] > 0)
			{
				AMMO[string]--;
				return true;
			}
			return false;
		}
	}
}