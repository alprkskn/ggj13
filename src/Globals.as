package  
{
	/**
	 * ...
	 * @author bms
	 */
	public class Globals 
	{
		public static var AMMO:Object = { "bomb":10, "pistol":10, "uzi":10, "shotgun":10, "bait":10 };
		
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