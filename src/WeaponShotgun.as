package  
{
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author bms
	 */
	public class WeaponShotgun implements AIState 
	{
		private var parent:GameState;
		private var counter:int = 0;
		public function create(parent:Object):void 
		{
			this.parent = parent as GameState;
		}
		
		public function update():void 
		{
			if (FlxG.mouse.justPressed()  && counter > 40 && Globals.checkAmmo("shotgun"))
			{
				counter = 0;
				var bulvec:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
				bulvec.Multiply(1.0 / FlxG.B2SCALE);
				bulvec.Subtract(parent.player.body.GetPosition());
				bulvec.Normalize();
				bulvec.Multiply(20);
				bulvec.Add(new b2Vec2(Math.random() * 5 - 2.5, Math.random() * 5 - 2.5));
				var bullet:Bullet = new Bullet(parent.player.getMidpoint().x, parent.player.getMidpoint().y, bulvec);
				parent.bullets.add(bullet);

				bulvec.Add(new b2Vec2(Math.random() * 5 - 2.5, Math.random() * 5 - 2.5));
				bullet = new Bullet(parent.player.getMidpoint().x, parent.player.getMidpoint().y, bulvec);
				parent.bullets.add(bullet);
				
				bulvec.Add(new b2Vec2(Math.random() * 5 - 2.5, Math.random() * 5 - 2.5));
				bullet = new Bullet(parent.player.getMidpoint().x, parent.player.getMidpoint().y, bulvec);
				parent.bullets.add(bullet);
				
				parent.dispAmount = -100;
				
				FlxG.play(Assets.SHOTGUN_SOUND, 0.4);
			}
			counter++;
			
		}
	}

}