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
	import org.flixel.FlxEmitter;
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
		public var glow:FlxSprite;
		
		public var fovPoints:Array = [];
		public var fovRayObject:Object = null;
		
		public var foreground:FlxCamera;
		public var background:FlxCamera;
		public var fovShape:Shape;
		public var dispMap:BitmapData;
		
		public var zombies:FlxGroup;
		public var bullets:FlxGroup;
		
		public var weaponState:AIState;
		public var pistolState:WeaponPistol = new WeaponPistol();
		public var shotgunState:WeaponShotgun = new WeaponShotgun();
		public var uziState:WeaponUzi = new WeaponUzi();
		
		public var bloodDispenser:FlxEmitter = new FlxEmitter(0, 0);
		public var gibsDispenser:FlxEmitter = new FlxEmitter(0, 0);
		
		override public function create():void 
		{
			super.create();
			
			FlxG.bgColor = 0xFF261918;
			background = FlxG.camera;
			
			var contactListener:ContactListener = new ContactListener();
			world.SetContactListener(contactListener);
			
			// this is just used for its bitmap layer
			foreground = new FlxCamera(0, 0, FlxG.width, FlxG.height, 0);
			
			bloodDispenser.setSize(16, 16);
			bloodDispenser.setXSpeed(-50, 50);
			bloodDispenser.setYSpeed( -50, 50);
			bloodDispenser.particleDrag = new FlxPoint(100, 100);
			bloodDispenser.setRotation(0, 0);
			bloodDispenser.makeParticles(Assets.BLOOD_SPRITE, 500, 16, true);
			add(bloodDispenser);
			
			gibsDispenser.setSize(16, 16);
			gibsDispenser.setXSpeed( -100, 100);
			gibsDispenser.setYSpeed( -100, 100);
			gibsDispenser.particleDrag = new FlxPoint(100, 100);
			gibsDispenser.setRotation(0, 0);
			gibsDispenser.makeParticles(Assets.GIBS_SPRITE, 100, 16, true);
			add(gibsDispenser);
			
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
			
			bullets = new FlxGroup()
			add(bullets);
			
			glow = new FlxSprite(0, 0, Assets.GLOW_SPRITE);
			glow.offset.x = glow.width * 0.5;
			glow.offset.y = glow.height * 0.5;
			add(glow);
			
			add(player);
			FlxG.camera.follow(player);
			
			dispMap = (new Assets.DISP_MAP_SPRITE() as BitmapAsset).bitmapData;
			
			shotgunState.create(this);
			uziState.create(this);
			pistolState.create(this);
			
			weaponState = uziState;
		}
		
		private function rayCallback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number):Number
		{
			if (fixture.GetFilterData().categoryBits & 2 || fixture.GetFilterData().categoryBits & 4)
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
			
			if (FlxG.keys.ONE)
				weaponState = uziState;
			if (FlxG.keys.TWO)
				weaponState = shotgunState;
			if (FlxG.keys.THREE)
				weaponState = pistolState;
			weaponState.update();
		}
		
		override public function draw():void 
		{
			super.draw();
			
			foreground.buffer.fillRect(foreground.buffer.rect, 0);
			
			var mat:Matrix = new Matrix();
			mat.translate( -background.scroll.x, -background.scroll.y);
			
			foreground.buffer.draw(fovShape, mat);
			foreground.buffer.applyFilter(foreground.buffer, foreground.buffer.rect, new Point(), new BlurFilter(30, 30));
			//background.buffer.threshold(foreground.buffer, foreground.buffer.rect, new Point(), "<=", 0x22222222, 0xFF000000);
			//var dmf:DisplacementMapFilter = new DisplacementMapFilter(dispMap, new Point(FlxG.width/2-dispMap.width/2,FlxG.height/2-dispMap.height/2), BitmapDataChannel.RED, BitmapDataChannel.GREEN,dispAmount,dispAmount);
			//background.buffer.applyFilter(background.buffer, background.buffer.rect, new Point(), dmf);
		}
	}
}


























