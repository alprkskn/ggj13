package org.flixel
{
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	
	public class FlxB2Sprite extends FlxSprite
	{
		public var updateAngle:Boolean = true;;
		public var fixtureDef:b2FixtureDef;
		public var bodyDef:b2BodyDef
		public var body:b2Body;
		public var world:b2World;
		
		/** The body type: static, kinematic, or dynamic. A member of the b2BodyType class
		 * Note: if a dynamic body would have zero mass, the mass is set to one.
		 * @see b2Body#b2_staticBody
		 * @see b2Body#b2_dynamicBody
		 * @see b2Body#b2_kinematicBody
		 */
		public var b2Type:uint;
		
		/**
		 * The world position of the body. Avoid creating bodies at the origin
		 * since this can lead to many overlapping shapes.
		 */
		public var b2Position:b2Vec2 = new b2Vec2();
		
		/**
		 * The world angle of the body in radians.
		 */
		public var b2Angle:Number;
		
		/**
		 * The linear velocity of the body's origin in world co-ordinates.
		 */
		public var b2LinearVelocity:b2Vec2 = new b2Vec2();
		
		/**
		 * The angular velocity of the body.
		 */
		public var b2AngularVelocity:Number;
		
		/**
		 * Linear damping is use to reduce the linear velocity. The damping parameter
		 * can be larger than 1.0f but the damping effect becomes sensitive to the
		 * time step when the damping parameter is large.
		 */
		public var b2LinearDamping:Number;
		
		/**
		 * Angular damping is use to reduce the angular velocity. The damping parameter
		 * can be larger than 1.0f but the damping effect becomes sensitive to the
		 * time step when the damping parameter is large.
		 */
		public var b2AngularDamping:Number;
		
		/**
		 * Set this flag to false if this body should never fall asleep. Note that
		 * this increases CPU usage.
		 */
		public var b2AllowSleep:Boolean;
		
		/**
		 * Is this body initially awake or sleeping?
		 */
		public var b2IsAwake:Boolean;
		
		/**
		 * Should this body be prevented from rotating? Useful for characters.
		 */
		public var b2FixedRotation:Boolean;
		
		/**
		 * Is this a fast moving body that should be prevented from tunneling through
		 * other moving bodies? Note that all bodies are prevented from tunneling through
		 * static bodies.
		 * @warning You should use this flag sparingly since it increases processing time.
		 */
		public var b2IsBullet:Boolean;
		
		/**
		 * Does this body start out active?
		 */
		public var b2IsActive:Boolean;
		
		/**
		 * Use this to store application specific body data.
		 */
		public var b2UserData:*;
		
		/**
		 * The shape, this must be set. The shape will be cloned, so you
		 * can create the shape on the stack.
		 */
		public var b2FixtureShape:b2Shape;
		
		/**
		 * The friction coefficient, usually in the range [0,1].
		 */
		public var b2Friction:Number;
		
		/**
		 * The restitution (elasticity) usually in the range [0,1].
		 */
		public var b2Restitution:Number;
		
		/**
		 * The density, usually in kg/m^2.
		 */
		public var b2Density:Number;
		
		/**
		 * A sensor shape collects contact information but never generates a collision
		 * response.
		 */
		public var b2IsSensor:Boolean;
		
		/**
		 * Contact filtering data.
		 */
		public var b2Filter:b2FilterData = new b2FilterData();
		
		public function FlxB2Sprite(World:b2World, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
			
			// set world
			world = World;
			
			// body
			b2UserData = this;
			b2Angle = 0;
			b2Position.Set((X + width * 0.5) / FlxG.B2SCALE , (Y + height * 0.5) / FlxG.B2SCALE);
			b2LinearVelocity.Set(0, 0);
			b2AngularVelocity = 0.0;
			b2LinearDamping = 0.0;
			b2AngularDamping = 0.0;
			b2AllowSleep = true;
			b2IsAwake = true;
			b2FixedRotation = false;
			b2IsBullet = false;
			b2Type = b2Body.b2_staticBody;
			b2IsActive = true;
			
			// fixture
			b2FixtureShape = null;
			b2Friction = 0.2;
			b2Restitution = 0.0;
			b2Density = 1.0;
			b2Filter.categoryBits = 0x0001;
			b2Filter.maskBits = 0xFFFF;
			b2Filter.groupIndex = 0;
			b2IsSensor = false;
		}
		/*
		 * @param vertices is an array of numbers in x,y order
		 */
		public function createPolygon(vertices:Array):void
		{
			var vrts:Array = new Array();
			var poly:b2PolygonShape = new b2PolygonShape();
			
			if (vertices.length % 2 == 1)
				throw("Error: createPolygon: Wrong vertex array");
			
			for (var i:int = 0; i < vertices.length; i+=2)
				vrts.push(new b2Vec2(vertices[i] / FlxG.B2SCALE, vertices[i + 1] / FlxG.B2SCALE));
			
			poly.SetAsArray(vrts, vrts.length);
			b2FixtureShape = poly;
			
			// don't forget
			createBody();
		}
		/*
		 * Leave empty for sprite width/height
		 */
		public function createCircle(radius:Number = -1):void
		{
			if (radius < 0)
				radius = Math.max(width, height) / 2;
			
			b2FixtureShape = new b2CircleShape(radius / FlxG.B2SCALE );
			
			// don't forget
			createBody();
		}
		/*
		 * Leave empty for sprite width/height
		 */
		public function createBox(W:Number = -1, H:Number = -1):void
		{
			var box:b2PolygonShape = new b2PolygonShape();
			
			if (W < 0)
				W = width;
			if (H < 0)
				H = height;
			
			box.SetAsBox(W * 0.5 / FlxG.B2SCALE, H * 0.5 / FlxG.B2SCALE);
			
			b2FixtureShape = box;
			
			// don't forget
			createBody();
		}
		protected function createBody():void
		{
			bodyDef = new b2BodyDef();
			bodyDef.userData = b2UserData;
			bodyDef.angle = b2Angle;
			bodyDef.position = b2Position.Copy();
			bodyDef.linearVelocity = b2LinearVelocity.Copy();
			bodyDef.angularVelocity = b2AngularVelocity;
			bodyDef.linearDamping = b2LinearDamping;
			bodyDef.angularDamping = b2AngularDamping;
			bodyDef.allowSleep = b2AllowSleep;
			bodyDef.awake = b2IsAwake;
			bodyDef.fixedRotation = b2FixedRotation;
			bodyDef.bullet = b2IsBullet;
			bodyDef.type = b2Type;
			bodyDef.active = b2IsActive;
			
			// fixture
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = b2FixtureShape;
			fixtureDef.friction = b2Friction;
			fixtureDef.restitution = b2Restitution;
			fixtureDef.density = b2Density;
			fixtureDef.filter = b2Filter.Copy();
			fixtureDef.isSensor = b2IsSensor;
			
			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
		}
		
		override public function update():void
		{
			super.update();
			
			x = (body.GetPosition().x * FlxG.B2SCALE) - width*.5 ;
			y = (body.GetPosition().y * FlxG.B2SCALE) - height * .5;
			if (updateAngle)
				angle = body.GetAngle() * 180 / Math.PI;
		}
		
		override public function kill():void 
		{
			super.kill();
			body.SetActive(false);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			world.DestroyBody(body);
		}
	}
}