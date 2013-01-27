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
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author bms
	 */
	public class MenuState extends FlxState 
	{
		public var noiseBitmap:BitmapData;
		public var mainBitmap:BitmapData;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.playMusic(Assets.MUSIC_SOUND);
			noiseBitmap = (new Assets.NOISE_SPRITE() as BitmapAsset).bitmapData;
			mainBitmap = (new Assets.MAIN_SPRITE() as BitmapAsset).bitmapData;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.SPACE)
			{
				FlxG.switchState(new GameState());
			}
		}
		
		override public function draw():void 
		{
			super.draw();
			var mat:Matrix;
			var noiseMat:Matrix = new Matrix();
			noiseMat.scale(2, 2);
			noiseMat.translate(-Math.random()*200, -Math.random()*200);
			FlxG.camera.buffer.draw(noiseBitmap, noiseMat, null, BlendMode.ADD);
			
			mat = new Matrix();
			mat.translate(FlxG.width/2 - mainBitmap.width/2, FlxG.height/2 - mainBitmap.height/2);
			mat.translate(Math.random()*2-1, Math.random()*2-1);
			FlxG.camera.buffer.draw(mainBitmap, mat);
			mat.translate(Math.random()*2-1, Math.random()*2-1);
			mat.scale(1+Math.random()*0.01, 1+Math.random()*0.01);
			FlxG.camera.buffer.draw(mainBitmap, mat);
		}
	}
}


























