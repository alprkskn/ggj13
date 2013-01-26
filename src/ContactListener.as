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
			var ad:uint = contact.GetFixtureA().GetFilterData().categoryBits;
			var bd:uint = contact.GetFixtureB().GetFilterData().categoryBits;
			
			if ((ad & 8 && bd & 16) || (ad & 16 && bd & 8))
			{
				contact.SetEnabled(false);
			}
			
			if ((ad & 8 && bd & 32) || (ad & 32 && bd & 8))
			{
				contact.SetEnabled(false);
			}
			
			if ((ad & 8 && bd & 4) || (ad & 4 && bd & 8))
			{
				contact.SetEnabled(false);
			}
			if (ad & 4 && bd & 4)
			{
				contact.SetEnabled(false);
			}
		}
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			super.PostSolve(contact, impulse);
			
			var ad:uint = contact.GetFixtureA().GetFilterData().categoryBits;
			var bd:uint = contact.GetFixtureB().GetFilterData().categoryBits;
			var au:* = contact.GetFixtureA().GetBody().GetUserData();
			var bu:* = contact.GetFixtureB().GetBody().GetUserData();
			
			if ((ad & 2 && bd & 4) || (ad & 4 && bd & 2))
			{
				(au as Damageble).doDamage(1);
				(bu as Damageble).doDamage(1);
			}
			if (bd & 4)
			{
				(bu as Damageble).doDamage(1);
			} else if (ad & 4)
			{
				(au as Damageble).doDamage(1);
			}
		}
	}
}