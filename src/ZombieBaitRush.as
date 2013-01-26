package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author bms
	 */
	public class ZombieBaitRush implements AIState 
	{
		
		private var parent:Zombie;
		private var target:Bait;
		private var gameState:GameState;
		public function create(parent:Object):void 
		{
			this.parent = parent as Zombie;
			gameState = (FlxG.state as GameState);
		}
		
		public function update():void 
		{
			var min:Number = Number.MAX_VALUE;
			if (null == target)
			{
				for (var i:int = 0; i < gameState.baits.length; i++)
				{
					var obj:Bait = gameState.baits.members[i];
					if (obj.alive)
					{
						var dx:Number = obj.body.GetPosition().x - parent.body.GetPosition().x;
						var dy:Number = obj.body.GetPosition().y - parent.body.GetPosition().y;
						var dd:Number = Math.sqrt(dx * dx + dy * dy);
						if (dd < min)
						{
							target = obj;
						}
					}
				}
				if (null == target)
				{
					parent.currentState = parent.randomState;
				}
			}
			if (target && target.alive)
			{
				dx = target.body.GetPosition().x - parent.body.GetPosition().x;
				dy = target.body.GetPosition().y - parent.body.GetPosition().y;
				dd = Math.sqrt(dx * dx + dy * dy);
				parent.angle = Math.atan2(dy, dx) * 180 / Math.PI;
				parent.body.ApplyForce(new b2Vec2( dx / dd * 5, dy / dd * 5), parent.body.GetPosition());
			} else
			{
				target = null;
				return;
			}
		}
	}
}