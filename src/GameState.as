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
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import mx.core.BitmapAsset;
	import org.flixel.FlxB2Sprite;
	import org.flixel.FlxB2State;
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author bms
	 */
	public class GameState extends FlxB2State 
	{
		public var expDispAmount:Number = 0;
		public var dispAmount:Number = 0;
		public var player:Player;
		public var glow:FlxSprite;
		
		public var fovPoints:Array = [];
		public var fovRayObject:Object = null;
		
		public var foreground:FlxCamera;
		public var background:FlxCamera;
		public var fovShape:Shape;
		public var dispMapExp:BitmapData;
		public var dispMapWeapon:BitmapData;
		public var noiseBitmap:BitmapData;

		public var zombies:FlxGroup;
		public var bullets:FlxGroup;
		public var baits:FlxGroup;
		public var boxes:FlxGroup;
		public var barrels:FlxGroup;

		public var weaponState:AIState;
		public var pistolState:WeaponPistol = new WeaponPistol();
		public var shotgunState:WeaponShotgun = new WeaponShotgun();
		public var uziState:WeaponUzi = new WeaponUzi();
		public var baitState:WeaponBait = new WeaponBait();
		public var grenadeState:WeaponGrenade = new WeaponGrenade();
		
		public var bloodDispenser:FlxEmitter = new FlxEmitter(0, 0);
		public var gibsDispenser:FlxEmitter = new FlxEmitter(0, 0);
		public var boxDispenser:FlxEmitter = new FlxEmitter(0, 0);
		public var smokeDispenser:FlxEmitter = new FlxEmitter(0, 0, 10);
		
		private var heatBeatCounter:Number = 0;
		private var heatBeatPeriod:Number = 10;
		
		private var levelFinishPoint:FlxPoint;
		private var noiseSound:FlxSound;
		private var inventory:FlxText;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.bgColor = 0xFF261918;
			background = FlxG.camera;
			
			var contactListener:ContactListener = new ContactListener();
			world.SetContactListener(contactListener);
			
			// this is just used for its bitmap layer
			foreground = new FlxCamera(0, 0, FlxG.width, FlxG.height, 0);
			
			var mapdata:MapData = new MapData();
			mapdata.loadMap(Globals.LEVELS[Globals.LEVEL].img, Globals.LEVELS[Globals.LEVEL].data);
			
			var mapImage:FlxSprite = new FlxSprite(0, 0, Globals.LEVELS[Globals.LEVEL].img);
			add(mapImage);
			
			bloodDispenser.setSize(16, 16);
			bloodDispenser.setXSpeed(-10, 10);
			bloodDispenser.setYSpeed( -10, 10);
			bloodDispenser.particleDrag = new FlxPoint(100, 100);
			bloodDispenser.setRotation(0, 0);
			bloodDispenser.makeParticles(Assets.BLOOD_SPRITE, 500, 16, true);
			add(bloodDispenser);
			
			boxDispenser.setSize(16, 16);
			boxDispenser.setXSpeed(-80, 80);
			boxDispenser.setYSpeed( -80, 80);
			boxDispenser.particleDrag = new FlxPoint(50, 50);
			boxDispenser.setRotation(0, 0);
			boxDispenser.makeParticles(Assets.BOX_GIBS_SPRITE, 200, 16, true);
			add(boxDispenser);
			
			gibsDispenser.setSize(16, 16);
			gibsDispenser.setXSpeed( -100, 100);
			gibsDispenser.setYSpeed( -100, 100);
			gibsDispenser.particleDrag = new FlxPoint(100, 100);
			gibsDispenser.setRotation(0, 20);
			gibsDispenser.makeParticles(Assets.GIBS_SPRITE, 100, 16, true);
			add(gibsDispenser);
			
			var objectCount:int = mapdata.wallVertices.length / 3;
			for (var i:int = 0; i < objectCount; i++)
			{
				var wall:FlxB2Sprite = new FlxB2Sprite(world);
				wall.b2Position.Set(0, 0);
				var arr:Array = mapdata.getVerticesOfIndex(i);
				
				wall.createPolygon(arr);
				add(wall);
			}
			
			boxes = new FlxGroup();
			add(boxes);
			
			barrels = new FlxGroup();
			add(barrels);
			
			// put this here so zombies can access it
			player = new Player(FlxG.width / 2, FlxG.height / 2);
			
			baits = new FlxGroup();
			add(baits);
			
			zombies = new FlxGroup();
			add(zombies);
			
			var entityCount:int = mapdata.entities.length;
			for (i = 0; i < entityCount; i++)
			{
				if ("playerSpawner" == mapdata.entities[i].name)
				{
					player.body.SetPosition(new b2Vec2(mapdata.entities[i].x / FlxG.B2SCALE, mapdata.entities[i].y / FlxG.B2SCALE));
				} else if ("zombieSpawner" == mapdata.entities[i].name)
				{
					var zombie:Zombie = new Zombie(mapdata.entities[i].x, mapdata.entities[i].y);
					zombies.add(zombie);
				} else if ("levelFinish" == mapdata.entities[i].name)
				{
					levelFinishPoint = new FlxPoint(mapdata.entities[i].x, mapdata.entities[i].y);
				} else if ("chest" == mapdata.entities[i].name)
				{
					var box:Box = new Box(mapdata.entities[i].x, mapdata.entities[i].y,  mapdata.entities[i].content);
					boxes.add(box);
				} else if ("bait" == mapdata.entities[i].name)
				{
					var gi:GroundItem = new GroundItem(mapdata.entities[i].x, mapdata.entities[i].y, mapdata.entities[i].name);
					boxes.add(gi);
				} else if ("barrel" == mapdata.entities[i].name)
				{
					var bar:Barrel = new Barrel(mapdata.entities[i].x, mapdata.entities[i].y);
					barrels.add(bar);
				}
			}
			
			bullets = new FlxGroup()
			add(bullets);
			
			glow = new FlxSprite(0, 0, Assets.GLOW_SPRITE);
			glow.offset.x = glow.width * 0.5;
			glow.offset.y = glow.height * 0.5;
			add(glow);
			
			smokeDispenser.setRotation(0, 0);
			gibsDispenser.setSize(80, 80);
			smokeDispenser.setXSpeed( 0, 0);
			smokeDispenser.setYSpeed( 0, 0);
			for (var k:int = 0; k < smokeDispenser.maxSize; k++)
			{
				smokeDispenser.add(new Smoke());
			}
			add(smokeDispenser);
			
			add(player);
			FlxG.camera.follow(player);
			
			dispMapExp = (new Assets.DISP_MAP_EXP_SPRITE() as BitmapAsset).bitmapData;
			dispMapWeapon = (new Assets.DISP_MAP_WEAPON_SPRITE() as BitmapAsset).bitmapData;
			noiseBitmap = (new Assets.NOISE_SPRITE() as BitmapAsset).bitmapData;
			
			shotgunState.create(this);
			uziState.create(this);
			pistolState.create(this);
			baitState.create(this);
			grenadeState.create(this);
			
			weaponState = grenadeState;
			
			noiseSound = FlxG.play(Assets.NOISE_SOUND, 0, true);
			
			inventory = new FlxText(0, 0, FlxG.width, "");
			add(inventory);
		}
		
		private function rayCallback(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number):Number
		{
			if (fixture.GetFilterData().categoryBits & 128 || fixture.GetFilterData().categoryBits & 64 || fixture.GetFilterData().categoryBits & 2 || fixture.GetFilterData().categoryBits & 32 || fixture.GetFilterData().categoryBits & 4 || fixture.GetFilterData().categoryBits & 16)
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
		
		private function heartBeat(x:Number):Number
		{
			if (x >= 0 && x <= 3*Math.PI)
				return Math.sin(x);
			return 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			noiseSound.volume = 0.5*(1 - (player.health / player.MAX_HEALTH));
			
			heatBeatPeriod = Math.max(player.health, 20)/2;
			
			heatBeatCounter += 0.4;
			if(heatBeatCounter > heatBeatPeriod)
			{
				FlxG.play(Assets.HEARTBEAT_SOUND);
				heatBeatCounter = 0;
			}
			var mpos:b2Vec2 = new b2Vec2(FlxG.mouse.x, FlxG.mouse.y);
			mpos.Multiply(1.0 / FlxG.B2SCALE);
			mpos.Subtract(player.body.GetPosition());
			var angle:Number = Math.atan2(mpos.y, mpos.x);
			fovPoints = [];
			for (var i:int = 0; i < 16; i++)
			{
				fovRayObject = null;
				const mr:Number = 12;
				var fov:Number = (i - 7.5) / (400 / heatBeatPeriod);
				if (fov < 0)
					fov -= (0.1 * heartBeat(heatBeatCounter));
				else
					fov += (0.1 * heartBeat(heatBeatCounter));
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
			if (player.alive)
			{
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
			}
			glow.x = player.getMidpoint().x;
			glow.y = player.getMidpoint().y;
			
			if (FlxG.keys.THREE)
				weaponState = uziState;
			if (FlxG.keys.TWO)
				weaponState = shotgunState;
			if (FlxG.keys.ONE)
				weaponState = pistolState;
			if (FlxG.keys.FOUR)
				weaponState = baitState;
			if (FlxG.keys.FIVE)
				weaponState = grenadeState;
			weaponState.update();
			
			dispAmount += 0.1 * (-dispAmount);
			expDispAmount += 0.1 * ( -expDispAmount);
			
			for each(var box:FlxSprite in boxes.members)
			{
				if (!box.alive)
				{
					continue;
				}
				
				var dx:Number = player.getMidpoint().x - box.getMidpoint().x;
				var dy:Number = player.getMidpoint().y - box.getMidpoint().y;
				var dd:Number = Math.sqrt(dx * dx + dy * dy);
				if (dd < 20 && box is GroundItem)
				{
					box.kill();
					trace((box as GroundItem).content);
					Globals.AMMO[(box as GroundItem).content] += 10;
				}
			}
			if (player.alive)
			{
				inventory.text = "[1] pistol x" + Globals.AMMO["pistol"] + "\n";
				inventory.text += "[2] shotgun x" + Globals.AMMO["shotgun"] + "\n";
				inventory.text += "[3] smg x" + Globals.AMMO["uzi"] + "\n";
				inventory.text += "[4] brains x" + Globals.AMMO["bait"] + "\n";
				inventory.text += "[5] grenade x" + Globals.AMMO["bomb"];
			} else
			{
				inventory.text = "you died. press space";
				if (FlxG.keys.SPACE)
				{
					FlxG.resetState();
				}
			}
		}
		
		public function explode(x:Number, y:Number):void 
		{
			smokeDispenser.x = x;
			smokeDispenser.y = y;
			
			smokeDispenser.start(true, 10, 0, 1);
			FlxG.play(Assets.EXPLOSION_SOUND);
			for (var i:int = 0; i < zombies.length; i++)
			{
				var zombie:Zombie = zombies.members[i];
				if (zombie.alive)
				{
					var dx:Number = x - zombie.x;
					var dy:Number = y - zombie.y;
					var dd:Number = Math.sqrt(dx * dx + dy * dy);
					if (dd < 100)
					{
						zombie.doDamage(8);
						var force:b2Vec2 = new b2Vec2(dx / dd, dy / dd);
						force.Multiply(-200);
						zombie.body.ApplyForce(force, zombie.body.GetPosition());
					}
				}
			}
			for (i = 0; i < barrels.length; i++)
			{
				if (barrels.members[i] is Barrel)
				{
					var barrel:Barrel= barrels.members[i];
					if (barrel.alive)
					{
						dx = x - barrel.x;
						dy = y - barrel.y;
						dd = Math.sqrt(dx * dx + dy * dy);
						if (dd < 100)
						{
							barrel.doDamage(100);
						}
					}
				}
			}
			for (i = 0; i < boxes.length; i++)
			{
				if (boxes.members[i] is Box)
				{
					var box:Box = boxes.members[i];
					if (box.alive)
					{
						dx = x - box.x;
						dy = y - box.y;
						dd = Math.sqrt(dx * dx + dy * dy);
						if (dd < 100)
						{
							box.doDamage(100);
						}
					}
				}
			}
			if (levelFinishPoint)
			{
				dx = player.x - levelFinishPoint.x;
				dy = player.y - levelFinishPoint.y;
				dd = Math.sqrt(dx * dx + dy * dy);
				if (dd < 30)
				{
					//Globals.LEVEL++;
					FlxG.resetState();
				}
			}
		}
		
		override public function draw():void 
		{
			super.draw();
			
			foreground.buffer.fillRect(foreground.buffer.rect, 0);
			var mat:Matrix = new Matrix();
			mat.translate( -background.scroll.x, -background.scroll.y);
			
			foreground.buffer.draw(fovShape, mat);
			foreground.buffer.applyFilter(foreground.buffer, foreground.buffer.rect, new Point(), new BlurFilter(30, 30));
			background.buffer.threshold(foreground.buffer, foreground.buffer.rect, new Point(), "<=", 0x22222222, 0xFF000000);
			var dmfExp:DisplacementMapFilter = new DisplacementMapFilter(dispMapExp, new Point(FlxG.width / 2 - dispMapExp.width / 2, FlxG.height / 2 - dispMapExp.height / 2), BitmapDataChannel.RED, BitmapDataChannel.GREEN, expDispAmount, expDispAmount, DisplacementMapFilterMode.CLAMP);
			var dmf:DisplacementMapFilter = new DisplacementMapFilter(dispMapWeapon, new Point(FlxG.width / 2 - dispMapWeapon.width / 2, FlxG.height / 2 - dispMapWeapon.height / 2), BitmapDataChannel.RED, BitmapDataChannel.GREEN, dispAmount, dispAmount, DisplacementMapFilterMode.CLAMP);
			
			var noiseMat:Matrix = new Matrix();
			noiseMat.scale(2, 2);
			noiseMat.translate(-Math.random()*200, -Math.random()*200);
			background.buffer.draw(noiseBitmap, noiseMat, new ColorTransform(1,1,1,1-(player.health/player.MAX_HEALTH)), BlendMode.ADD);
			
			background.buffer.applyFilter(background.buffer, background.buffer.rect, new Point(), dmfExp);
			background.buffer.applyFilter(background.buffer, background.buffer.rect, new Point(), dmf);
			
			mat = new Matrix();
			mat.translate(10, 10);
			background.buffer.draw(inventory.pixels, mat);
		}
	}
}


























