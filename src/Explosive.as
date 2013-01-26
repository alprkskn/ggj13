package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Explosive extends FlxB2Sprite 
	{
		
		private var counter:int = 0;
		public function Explosive(X:Number, Y:Number, vel:b2Vec2) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.BAIT_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2FixedRotation = true;
			b2LinearVelocity = vel;
			b2Filter.categoryBits = 32;
			b2Angle = Math.atan2(vel.y, vel.x);
			b2LinearDamping = 1.5;
			createCircle();
			
			offset.x = width * 0.5;
			offset.y = height * 0.5;
		}
		override public function update():void 
		{
			super.update();
			if (counter > 100)
			{
				(FlxG.state as GameState).explode(getMidpoint().x, getMidpoint().y);
				(FlxG.state as GameState).expDispAmount = -200;
				kill();
			}
			counter++;
		}
		
	}

}