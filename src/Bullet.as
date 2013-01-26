package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	
	/**
	 * @author bms
	 */
	public class Bullet extends FlxB2Sprite implements Damageble
	{
		
		public function Bullet(X:Number, Y:Number, vel:b2Vec2) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.BULLET_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2FixedRotation = true;
			b2LinearVelocity = vel;
			b2IsBullet = true;
			b2Filter.categoryBits = 4;
			b2Angle = Math.atan2(vel.y, vel.x);
			createCircle();
			
			offset.x = width * 0.5;
			offset.y = height * 0.5;
		}
		
		public function doDamage(damage:Number):void 
		{
			if (alive)
			{
				kill();
			}
		}
	}
}