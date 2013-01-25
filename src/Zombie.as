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
	public class Zombie extends FlxB2Sprite 
	{
		public var player:Player;
		public var currentState:AIState;
		public var seekState:ZombieSeek;
		public var randomState:ZombieRandom;
		
		public function Zombie(X:Number, Y:Number) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.ZOMBIE_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2LinearDamping = 10;
			b2Density = 0.5;
			b2FixedRotation = true;
			createCircle();
			
			player = (FlxG.state as GameState).player;
			seekState = new ZombieSeek();
			randomState = new ZombieRandom();
			
			seekState.create(this);
			randomState.create(this);
			
			currentState = seekState;
		}
		
		override public function update():void 
		{
			super.update();
			currentState.update();
		}
	}
}