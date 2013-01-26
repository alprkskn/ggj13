package  
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import org.flixel.*;
	
	public class ContactListener extends b2ContactListener 
	{
		public function ContactListener()
		{
			super();
		}
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			super.PreSolve(contact, oldManifold);
			var ad:uint = contact.GetFixtureA().GetBody().GetUserData();
			var bd:uint = contact.GetFixtureB().GetBody().GetUserData();
		}
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			super.PostSolve(contact, impulse);
			var bd:uint = contact.GetFixtureA().GetBody().GetUserData();
			var ad:uint = contact.GetFixtureB().GetBody().GetUserData();
			
			var afd:uint = contact.GetFixtureA().GetUserData();
			var bfd:uint = contact.GetFixtureB().GetUserData();
		}
	}
}