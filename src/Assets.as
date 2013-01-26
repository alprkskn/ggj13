package  
{
	/**
	 * ...
	 * @author bms
	 */
	public class Assets 
	{
		[Embed(source="assets/player.png")]
		public static const PLAYER_SPRITE:Class;
		[Embed(source="assets/wall.png")]
		public static const WALL_SPRITE:Class;
		[Embed(source="assets/glow.png")]
		static public const GLOW_SPRITE:Class;
		[Embed(source="assets/zombie.png")]
		static public const ZOMBIE_SPRITE:Class;
		[Embed(source="assets/dispMapExp.png")]
		static public const DISP_MAP_EXP_SPRITE:Class;
		[Embed(source="assets/dispMapGun.png")]
		static public const DISP_MAP_WEAPON_SPRITE:Class;
		[Embed(source="assets/bullet.png")]
		static public const BULLET_SPRITE:Class;
		[Embed(source="assets/blood.png")]
		static public const BLOOD_SPRITE:Class;
		[Embed(source="assets/gibs.png")]
		static public const GIBS_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const BAIT_SPRITE:Class;
		[Embed(source="assets/smoke.png")]
		static public const SMOKE_SPRITE:Class;
		[Embed(source="assets/noise.png")]
		static public const NOISE_SPRITE:Class;
		
		[Embed(source="assets/maps/zaaaImage.png")]
		static public const MAP1_SPRITE:Class;
		[Embed(source = "assets/maps/zaaaData.txt", mimeType="application/octet-stream")]
		static public const MAP1_JSON:Class;
		
		[Embed(source="assets/sound/Heart.mp3")]
		static public const HEARTBEAT_SOUND:Class;
		[Embed(source="assets/sound/shotgun.mp3")]
		static public const SHOTGUN_SOUND:Class;
		[Embed(source="assets/sound/Pistol.mp3")]
		static public const PISTOL_SOUND:Class;
		[Embed(source="assets/sound/Explosion.mp3")]
		static public const EXPLOSION_SOUND:Class;
		[Embed(source="assets/sound/Noise.mp3")]
		static public const NOISE_SOUND:Class;
		
	}
}