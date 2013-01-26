package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxB2Sprite;
	
	/**
	 * @author bms
	 */
	public class Bullet extends FlxB2Sprite 
	{
		
		public function Bullet(X:Number, Y:Number, vel:b2Vec2) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.BULLET_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2FixedRotation = true;
			createCircle();
		}
	}
}