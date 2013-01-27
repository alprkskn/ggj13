package  
{
	import Box2D.Common.Math.b2Vec2;
	import flash.utils.getTimer;
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
		private var counter:Number = 0;
		public function create(parent:Object):void 
		{
			this.parent = parent as Zombie;
			gameState = (FlxG.state as GameState);
			counter = Math.random() * 100;
		}
		
		public function update():void 
		{
			var min:Number = Number.MAX_VALUE;
			counter += 0.1;
			
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
				if (dd > 15)
				{
					target = null;
					return;
				}
				parent.angle = Math.atan2(dy, dx) * 180 / Math.PI+10*Math.sin(counter);
				parent.body.ApplyForce(new b2Vec2( dx / dd * 5, dy / dd * 5), parent.body.GetPosition());
			} else
			{
				target = null;
				return;
			}
		}
	}
}