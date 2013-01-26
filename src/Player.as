package  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Player extends FlxB2Sprite implements Damageble
	{
		public var runCounter:Number = 0;
		public const MAX_HEALTH:int = 80;
		
		public function Player(X:Number, Y:Number) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.PLAYER_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2Filter.categoryBits = 8;
			b2LinearDamping = 10;
			b2FixedRotation = true;
			createCircle();
			updateAngle = false;
			health = MAX_HEALTH;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (health < MAX_HEALTH)
			{
				health += 0.1;
			}
			
			var flag:int = 0;
			if (FlxG.keys.A)
			{
				body.ApplyForce(new b2Vec2( -20, 0), body.GetPosition());
				flag |= 1;
			}
			if (FlxG.keys.D)
			{
				body.ApplyForce(new b2Vec2( 20, 0), body.GetPosition());
				flag |= 1;
			}
			if (FlxG.keys.S)
			{
				body.ApplyForce(new b2Vec2( 0, 20), body.GetPosition());
				flag |= 2;
			}
			if (FlxG.keys.W)
			{
				body.ApplyForce(new b2Vec2( 0, -20), body.GetPosition());
				flag |= 2;
			}
			
			if (flag)
			{
				runCounter += 1;
			}
			
			var mpos:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
			mpos.Multiply(1.0 / FlxG.B2SCALE);
			mpos.Subtract(body.GetPosition());
			var angle:Number = Math.atan2(mpos.y, mpos.x);
			this.angle = angle * 180 / Math.PI+Math.sin(runCounter/5)*10;
		}
		
		public function doDamage(damage:Number):void 
		{
			hurt(damage);
		}
	}
}