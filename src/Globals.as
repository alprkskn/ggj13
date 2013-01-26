package  
{
	/**
	 * ...
	 * @author bms
	 */
	public class Globals 
	{
		public static var AMMO:Object = { "grenade":40, "pistol":40, "uzi":40, "shotgun":40, "bait":40 };
		
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