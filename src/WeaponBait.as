package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxG;
	/**
	 * @author bms
	 */
	public class WeaponBait implements AIState 
	{
		private var parent:GameState;
		private var counter:int = 100;
		public function create(parent:Object):void 
		{
			this.parent = parent as GameState;
		}
		
		public function update():void 
		{
			if (FlxG.mouse.justPressed() && counter > 100 && Globals.checkAmmo("bait"))
			{
				var bulvec:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
				bulvec.Multiply(1.0 / FlxG.B2SCALE);
				bulvec.Subtract(parent.player.body.GetPosition());
				bulvec.Normalize();
				bulvec.Multiply(5);
				
				var bait:Bait = new Bait(parent.player.getMidpoint().x, parent.player.getMidpoint().y, bulvec);
				parent.baits.add(bait);
				
				for (var i:int = 0; i < parent.zombies.length; i++)
				{
					var obj:Zombie = parent.zombies.members[i];
					if (obj.alive)
					{
						obj.currentState = obj.baitState;
					}
				}
				counter = 0;
			}
			counter++;
		}
	}
}