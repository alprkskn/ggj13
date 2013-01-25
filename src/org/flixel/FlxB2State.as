package org.flixel 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	public class FlxB2State extends FlxState 
	{
		public var world:b2World = new b2World(new b2Vec2(), true);
		public var velocityIterations:int = 2;
		public var positionIterations:int = 2;
		
		override public function update():void 
		{
			super.update();
			
			world.Step(FlxG.elapsed, velocityIterations, positionIterations);
			world.ClearForces();
		}
	}
}