package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author bms
	 */
	public class WeaponGrenade implements AIState 
	{
		private var parent:GameState;
		private var counter:int = 100;
		public function create(parent:Object):void 
		{
			this.parent = parent as GameState;
		}
		
		public function update():void 
		{
			if (FlxG.mouse.pressed() && counter > 100 && Globals.checkAmmo("bomb"))
			{
				counter = 0;
				var bulvec:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
				bulvec.Multiply(1.0 / FlxG.B2SCALE);
				bulvec.Subtract(parent.player.body.GetPosition());
				bulvec.Normalize();
				bulvec.Multiply(15);
				
				var bullet:Explosive = new Explosive(parent.player.getMidpoint().x, parent.player.getMidpoint().y, bulvec);
				parent.bullets.add(bullet);
			}
			counter++;
		}
	}

}