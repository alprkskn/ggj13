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
			if (Math.random() < 0.1)
			{
				parent.currentState = parent.seekState;
			}
		}
	}
}