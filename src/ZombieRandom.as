package  
{
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author bms
	 */
	public class ZombieRandom implements AIState 
	{
		private var parent:Zombie;
		private var angle:Number = 0;
		public function create(parent:Object):void 
		{
			this.parent = parent as Zombie;
		}
		
		public function update():void 
		{
			if (parent.player.alive)
			{
				if (Math.random() < 0.1)
				{
					angle = Math.random() * Math.PI * 2;
				}
				parent.body.ApplyForce(new b2Vec2(Math.cos(angle)*2, Math.sin(angle)*2), parent.body.GetPosition());
			}
			
			if (Math.random() < 0.01)
			{
				parent.currentState = parent.seekState;
			}
		}
	}
}