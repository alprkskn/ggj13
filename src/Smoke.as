package  
{
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	
	/**
	 * ...
	 * @author bms
	 */
	public class Smoke extends FlxParticle 
	{
		
		public function Smoke() 
		{
			super();
			loadGraphic(Assets.SMOKE_SPRITE);
			visible = false;
		}
		
		override public function onEmit():void 
		{
			super.onEmit();
			visible = true;
			alpha = 1;
		}
		
		override public function update():void 
		{
			super.update();
			
			alpha -= 0.01;
			if (alpha < 0)
			{
				kill();
			}
		}
	}
}