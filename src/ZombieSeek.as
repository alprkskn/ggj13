package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.utils.getTimer;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author bms
	 */
	public class ZombieSeek implements AIState 
	{
		private var parent:Zombie;
		private var counter:Number = 0;
		
		public function create(parent:Object):void 
		{
			this.parent = parent as Zombie;
			counter = Math.random() * 100;
		}
		
		public function update():void 
		{
			counter += 0.1;
			if (Math.random() < 0.0008)
			{
				FlxG.play(Assets.ZOMBIE1_SOUND, 0.1);
			}
			if (Math.random() < 0.0008)
			{
				FlxG.play(Assets.ZOMBIE2_SOUND, 0.1);
			}
			if (Math.random() < 0.0008)
			{
				FlxG.play(Assets.ZOMBIE3_SOUND, 0.1);
			}
			if (parent.player.alive)
			{
				var dx:Number = parent.player.body.GetPosition().x - parent.body.GetPosition().x;
				var dy:Number = parent.player.body.GetPosition().y - parent.body.GetPosition().y;
				var dd:Number = Math.sqrt(dx * dx + dy * dy);
				if (dd > 10)
				{
					parent.currentState = parent.randomState;
					return;
				}
				parent.body.ApplyForce(new b2Vec2( dx / dd * 4.5, dy / dd * 4.5), parent.body.GetPosition());
				parent.angle = Math.atan2(dy, dx) * 180 / Math.PI+10*Math.sin(counter);
			} else
			{
				parent.currentState = parent.randomState;
				return;
			}
		}
	}
}