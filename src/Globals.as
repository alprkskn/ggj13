package  
{
	/**
	 * ...
	 * @author bms
	 */
	public class Globals 
	{
		public static var AMMO:Object = { "bomb":0, "pistol":0, "uzi":0, "shotgun":0, "bait":0 };
		
		public static var LEVEL:int = 0;
		public static var LEVELS:Array = [
		{ "img":Assets.MAP1_SPRITE, "data":Assets.MAP1_JSON },
		{ "img":Assets.MAP2_SPRITE, "data":Assets.MAP2_JSON },
		{ "img":Assets.MAP3_SPRITE, "data":Assets.MAP3_JSON }
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