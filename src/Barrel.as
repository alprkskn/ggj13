package  
{
	import Box2D.Dynamics.b2Body;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	
	/**
	 * @author bms
	 */
	public class Barrel extends FlxB2Sprite implements Damageble
	{
		
		public function Barrel(X:Number, Y:Number)
		{
			super((FlxG.state as GameState).world, X, Y, Assets.BARREL_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2Density = 5;
			b2AngularDamping = 3;
			b2Angle = Math.random() * Math.PI * 2;
			b2Filter.categoryBits = 128;
			b2LinearDamping = 3;
			health = 3;
			createBox();
		}
		override public function kill():void 
		{
			super.kill();
			(FlxG.state as GameState).explode(getMidpoint().x, getMidpoint().y);
			(FlxG.state as GameState).expDispAmount = -200;
		}
		public function doDamage(damage:Number):void 
		{
			hurt(damage);
		}
	}
}