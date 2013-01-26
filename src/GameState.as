package  
{
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import mx.core.BitmapAsset;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxB2State;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author bms
	 */
	public class GameState extends FlxB2State 
	{
		public var player:Player;
		private var glow:FlxSprite;
		
		private var fovPoints:Array = [];
		private var fovRayObject:Object = null;
		
		private var foreground:FlxCamera;
		private var background:FlxCamera;
		private var fovShape:Shape;
		private var dispMap:BitmapData;
		
		public var zombies:FlxGroup;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.bgColor = 0xFF261918;
			background = FlxG.camera;
			
			// this is just used for its bitmap layer
			foreground = new FlxCamera(0, 0, FlxG.width, FlxG.height, 0);
			
			for (var i:int = 0; i < 10; i++)
			{
				var wall:FlxB2Sprite = new FlxB2Sprite(world, Math.random() * FlxG.width, Math.random() * FlxG.height, Assets.WALL_SPRITE);
				wall.b2Angle = Math.random() * 2 * Math.PI;
				wall.createBox();
				add(wall);
			}
			
			// put this here so zombies can access it
			player = new Player(FlxG.width / 2, FlxG.height / 2);
			
			zombies = new FlxGroup();
			for (i = 0; i < 10; i++)
			{
				var zombie:Zombie = new Zombie(Math.random() * FlxG.width, Math.random() * FlxG.height);
				zombies.add(zombie);
			}
			add(zombies);
			
			glow = new FlxSprite(0, 0, Assets.GLOW_SPRITE);
			glow.offset.x = glow.width * 0.5;
			glow.offset.y = glow.height * 0.5;
			add(glow);
			
			add(player);
			FlxG.camera.follow(player);
			
			dispMap = (new Assets.DISP_MAP_SPRITE() as BitmapAsset).bitmapData;
		}
		
		private function rayCallback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number):Number
		{
			if (fixture.GetFilterData().categoryBits & 2)
				return 1;
			
			if (null == fovRayObject)
			{
				point.Multiply(FlxG.B2SCALE);
				fovRayObject = {"point" : point, "fraction" : fraction };
			} else if (fovRayObject.fraction > fraction)
			{
				point.Multiply(FlxG.B2SCALE);
				fovRayObject = {"point" : point, "fraction" : fraction };
			}
			return 1;
		}
		
		override public function update():void 
		{
			super.update();
			
			var mpos:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
			mpos.Multiply(1.0 / FlxG.B2SCALE);
			mpos.Subtract(player.body.GetPosition());
			var angle:Number = Math.atan2(mpos.y, mpos.x);
			fovPoints = [];
			for (var i:int = 0; i < 10; i++)
			{
				fovRayObject = null;
				const mr:Number = 12;
				var fov:Number = (i - 4.5) / (10);
				var rv:b2Vec2 = b2Math.AddVV(player.body.GetPosition(), new b2Vec2(Math.cos(angle-fov) * mr, Math.sin(angle-fov) * mr));
				world.RayCast(rayCallback, player.body.GetPosition(), rv);
				if (fovRayObject != null)
				{
					fovPoints.push(fovRayObject.point);
				} else
				{
					rv.Multiply(FlxG.B2SCALE);
					fovPoints.push(rv);
				}
			}
			
			fovShape = new Shape();
			fovShape.graphics.beginFill(0xFFFFFF, 1);
			fovShape.graphics.drawCircle(player.getMidpoint().x, player.getMidpoint().y, 12);
			fovShape.graphics.endFill();
			
			fovShape.graphics.beginFill(0xFFFFFF, 1);
			fovShape.graphics.moveTo(player.getMidpoint().x, player.getMidpoint().y);
			for (i = 0; i < fovPoints.length; i++ )
			{
				fovShape.graphics.lineTo(fovPoints[i].x, fovPoints[i].y);
			}
			fovShape.graphics.endFill();
			
			glow.x = player.getMidpoint().x;
			glow.y = player.getMidpoint().y;
		}
		
		override public function draw():void 
		{
			super.draw();
			foreground.buffer.fillRect(foreground.buffer.rect, 0);
			
			var mat:Matrix = new Matrix();
			mat.translate( -background.scroll.x, -background.scroll.y);
			
			foreground.buffer.draw(fovShape, mat);
			//var dmf:DisplacementMapFilter = new DisplacementMapFilter(dispMap, new Point(Math.random()*100,Math.random()*100), BitmapDataChannel.RED, BitmapDataChannel.GREEN,100,100);
			foreground.buffer.applyFilter(foreground.buffer, foreground.buffer.rect, new Point(), new BlurFilter(30, 30));
			//background.buffer.applyFilter(background.buffer, background.buffer.rect, new Point(), dmf);
			//background.buffer.threshold(foreground.buffer, foreground.buffer.rect, new Point(), "<=", 0x22222222, 0xFF000000);
		}
	}
}


























