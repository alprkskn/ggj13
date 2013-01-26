package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import org.flixel.FlxPoint;
	import com.adobe.serialization.json.JSON;
	/**
	$(CBI)* ...
	$(CBI)* @author alper keskin
	$(CBI)*/
	public class MapData {
		//[Embed(source="assets/maps/zaaaData.txt")]
		[Embed(source = "assets/maps/zaaaData.txt",mimeType="application/octet-stream")]
		private const test_map:Class;
		
		[Embed(source = "assets/maps/zaaaImage.png")]
		public const test_map_image:Class;
		
		public var name:String;
		public var wallVertices:Array;
		public var bmpData:BitmapData;
		public function MapData() {
			wallVertices = new Array();
		}
		
		public function loadMap(n:String):void {
			//var file:FileReference = new FileReference();
			//file.load();
			var data:String = (new test_map() as ByteArray).toString();
			var dt:Object = JSON.decode(data);
			name = n;
			bmpData = (new test_map_image() as Bitmap).bitmapData;
			for each(var o:Object in dt.vertices)
				wallVertices.push(new Point(o.x, o.y));
		}
		
		public function getVerticesOfIndex(i:int):Array {
			var array:Array = new Array();
			array.push(wallVertices[i * 3].x, wallVertices[i * 3].y);
			array.push(wallVertices[i * 3 + 1].x, wallVertices[i * 3 + 1].y);
			array.push(wallVertices[i * 3 + 2].x, wallVertices[i * 3 + 2].y);
			return array;
		}
		
	}

}