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
		[Embed(source="assets/box.png")]
		static public const BOX1_SPRITE:Class;
		[Embed(source="assets/boxSmall.png")]
		static public const BOX2_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const SHOTGUN_ICON_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const PISTOL_ICON_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const BAIT_ICON_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const UZI_ICON_SPRITE:Class;
		[Embed(source="assets/bait.png")]
		static public const BOMB_ICON_SPRITE:Class;
		[Embed(source="assets/boxGibs.png")]
		static public const BOX_GIBS_SPRITE:Class;

		
		[Embed(source="assets/maps/weaponzTestImg.png")]
		static public const MAP1_SPRITE:Class;
		[Embed(source = "assets/maps/weaponzTestData.txt", mimeType="application/octet-stream")]
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
		[Embed(source="assets/sound/zombie1.mp3")]
		static public const ZOMBIE1_SOUND:Class;
		[Embed(source="assets/sound/zombie2.mp3")]
		static public const ZOMBIE2_SOUND:Class;
		[Embed(source="assets/sound/zombie3.mp3")]
		static public const ZOMBIE3_SOUND:Class;
		[Embed(source="assets/sound/music.mp3")]
		static public const MUSIC_SOUND:Class;
		
		
		static public const WEAPON_SPRITES:Object = { "bait":BAIT_ICON_SPRITE, "pistol":PISTOL_ICON_SPRITE, "uzi":UZI_ICON_SPRITE, "bomb":BOMB_ICON_SPRITE, "shotgun":SHOTGUN_ICON_SPRITE };
	}
}