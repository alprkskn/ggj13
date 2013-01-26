package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author bms
	 */
	public class ZombieSeek implements AIState 
	{
		private var parent:Zombie;
		
		public function create(parent:Object):void 
		{
			this.parent = parent as Zombie;
		}
		
		public function update():void 
		{
			if (parent.player.alive)
			{
				var dx:Number = parent.player.body.GetPosition().x - parent.body.GetPosition().x;
				var dy:Number = parent.player.body.GetPosition().y - parent.body.GetPosition().y;
				var dd:Number = Math.sqrt(dx * dx + dy * dy);
				if (dd > 15)
				{
					parent.currentState = parent.randomState;
					return;
				}
				parent.body.ApplyForce(new b2Vec2( dx / dd * 5, dy / dd * 5), parent.body.GetPosition());
				
				parent.angle = Math.atan2(dy, dx) * 180 / Math.PI;
			} else
			{
				parent.currentState = parent.randomState;
				return;
			}
		}
	}
}