package  
{
	import Box2D.Dynamics.b2Body;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Box extends FlxB2Sprite implements Damageble
	{
		public var content:String;
		public function Box(X:Number, Y:Number, content:String) 
		{
			var ic:Class;
			if (Math.random() > .5)
			{
				ic = Assets.BOX1_SPRITE;
			} else
			{
				ic = Assets.BOX2_SPRITE;
			}
			
			super((FlxG.state as GameState).world, X, Y, ic);
			
			// init box2d
			b2Type = b2Body.b2_dynamicBody;
			b2Density = 20;
			b2AngularDamping = 3;
			b2Angle = Math.random() * Math.PI * 2;
			b2Filter.categoryBits = 64;
			b2LinearDamping = 3;
			createBox();
			
			this.content = content;
		}
		override public function kill():void 
		{
			super.kill();
			
			trace(content);
			
			if (content)
			{
				(FlxG.state as GameState).boxes.add(new GroundItem(x, y, content));
				trace("added:",content);
			}
		}
		
		public function doDamage(damage:Number):void 
		{
			if (alive)
			{
				kill();
				(FlxG.state as GameState).boxDispenser.x = x;
				(FlxG.state as GameState).boxDispenser.y = y;
				(FlxG.state as GameState).boxDispenser.start(true, 3, 1, 5);
			}
		}
	}

}