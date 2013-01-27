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
	public class Zombie extends FlxB2Sprite implements Damageble
	{
		public var player:Player;
		public var currentState:AIState;
		public var seekState:ZombieSeek = new ZombieSeek();
		public var baitState:ZombieBaitRush = new ZombieBaitRush();
		public var randomState:ZombieRandom = new ZombieRandom();
		
		public function Zombie(X:Number, Y:Number) 
		{
			super((FlxG.state as GameState).world, X, Y, Assets.ZOMBIE_SPRITE);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2LinearDamping = 10;
			b2Density = 0.5;
			b2FixedRotation = true;
			b2Filter.categoryBits = 2;
			createCircle(8);
			
			player = (FlxG.state as GameState).player;
			
			seekState.create(this);
			randomState.create(this);
			baitState.create(this);
			
			health = 10;
			
			updateAngle = false;
			
			currentState = seekState;
		}
		
		override public function update():void 
		{
			super.update();
			currentState.update();
		}
		override public function kill():void 
		{
			super.kill();
			(FlxG.state as GameState).gibsDispenser.x = x;
			(FlxG.state as GameState).gibsDispenser.y = y;
			(FlxG.state as GameState).gibsDispenser.start(true, 0, 1, 3);
		}
		public function doDamage(damage:Number):void 
		{
			if (alive)
			{
				hurt(damage);
				(FlxG.state as GameState).bloodDispenser.x = x;
				(FlxG.state as GameState).bloodDispenser.y = y;
				(FlxG.state as GameState).bloodDispenser.start(true, 0, 1, 5);
			}
		}
	}
}