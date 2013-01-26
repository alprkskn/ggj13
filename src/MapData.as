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
		public var name:String;
		public var wallVertices:Array;
		public var entities:Array;
		
		public var bmpData:BitmapData;
		
		public function MapData() {
			wallVertices = new Array();
			entities = new Array();
		}
		
		public function loadMap(img:Class, json:Class):void {
			
			var data:String = (new json() as ByteArray).toString();
			var dt:Object = JSON.decode(data);
			bmpData = (new img() as Bitmap).bitmapData;
			
			for each(var o:Object in dt.vertices)
			{
				wallVertices.push(new Point(o.x, o.y));
			}
			
			for each(o in dt.entities)
			{
				entities.push( { "name":o.name, "x":o.pos.x, "y":o.pos.y } );
			}
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