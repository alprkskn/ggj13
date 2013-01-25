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
	public class Player extends FlxB2Sprite 
	{
		
		public function Player(X:Number, Y:Number) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.PLAYER_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2LinearDamping = 10;
			b2FixedRotation = true;
			createCircle();
		}
		
		override public function update():void 
		{
			super.update();
			var flag:int = 0;
			if (FlxG.keys.A)
			{
				body.ApplyForce(new b2Vec2( -10, 0), body.GetPosition());
			}
			if (FlxG.keys.D)
			{
				body.ApplyForce(new b2Vec2( 10, 0), body.GetPosition());
				
			}
			if (FlxG.keys.S)
			{
				body.ApplyForce(new b2Vec2( 0, 10), body.GetPosition());
				
			}
			if (FlxG.keys.W)
			{
				body.ApplyForce(new b2Vec2( 0, -10), body.GetPosition());
			}
		}
	}
}