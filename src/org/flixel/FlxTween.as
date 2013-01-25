package org.flixel {
	import org.flixel.FlxJob;
	import org.flixel.FlxManager;

	/**
	 * Tween frontend class for ease of use
	 * @author Yusuke Kawasaki
	 * @version 1.0.1
	 * @see net.kawa.tween.FlxManager
	 * @see net.kawa.tween.FlxJob
	 */
	public class FlxTween {
		/**
		 * The global FlxManager instance.
		 */
		static private var manager:FlxManager = new FlxManager();
		/**
		 * FlxJob class to create FlxJob instances. FlxJob is default.
		 */
		static public var jobClass:Class = FlxJob;

		/**
		 * Starts a new FlxTween job specifying the first (beginning) status.
		 * The last (ending) status will be back the current status.
		 * 
		 * @param target   	The target object to be tweened.
		 * @param duration 	The length of the tween in seconds.
		 * @param from 	 	The object which contains the first (beginning) status in each property.
		 * @param ease 	 	The easing equation function. Quad.easeOut is default.
		 * @param callback	The callback function invoked after the tween completed as onClose.
		 * @return			The FlxTween job instance.
		 */
		static public function from(target:*, duration:Number, from:Object, ease:Function = null, callback:Function = null):FlxJob {
			var job:FlxJob = new jobClass(target);
			job.from = from;
			job.duration = duration;
			if (ease != null) job.ease = ease;
			job.onClose = callback;
			queue(job);
			return job;
		}

		/**
		 * Starts a new FlxTween job specifying the last (ending) status.
		 * The current status is used as the first (beginning) status.
		 * 
		 * @param target   	The target object to be tweened.
		 * @param duration 	The length of the tween in seconds.
		 * @param to 	 	The object which contains the last (ending) status in each property.
		 * @param ease 	 	The easing equation function. Quad.easeOut is default.
		 * @param callback	The callback function invoked after the tween completed as onClose.
		 * @return			The FlxTween job instance.
		 */
		static public function to(target:*, duration:Number, to:Object, ease:Function = null, callback:Function = null):FlxJob {
			var job:FlxJob = new jobClass(target);
			job.to = to;
			job.duration = duration;
			if (ease != null) job.ease = ease;
			job.onClose = callback;
			queue(job);
			return job;
		}

		/**
		 * Starts a new FlxTween job.
		 * 
		 * @param target   	The target object to be tweened.
		 * @param duration 	The length of the tween in seconds.
		 * @param from 	 	The object which contains the first (beginning) status in each property.
		 * @param to 	 	The object which contains the last (ending) status in each property.
		 * @param ease 	 	The easing equation function. Quad.easeOut is default.
		 * @param callback	The callback function invoked after the tween completed as onClose.
		 * @return			The FlxTween job instance.
		 */
		static public function fromTo(target:*, duration:Number, from:Object, to:Object, ease:Function = null, callback:Function = null):FlxJob {
			var job:FlxJob = new jobClass(target);
			job.from = from;
			job.to = to;
			job.duration = duration;
			if (ease != null) job.ease = ease;
			job.onClose = callback;
			queue(job);
			return job;
		}

		/**
		 * Regists a new tween job to the job queue.
		 *
		 * @param job 		A job to be added to queue.
		 * @param delay 	Delay until job started in seconds.
		 * @throws ArgumentError A Function instance is not allowed for the .from or .to property.
		 **/
		static public function queue(job:FlxJob, delay:Number = 0):void {
			if (job.from is Function) {
				throw new ArgumentError('Function is not allowed for the .from property.');
				return;
			}
			if (job.to is Function) {
				throw new ArgumentError('Function is not allowed for the .to property.');
				return;
			}
			manager.queue(job, delay);
		}

		/**
		 * Terminates all tween jobs immediately
		 * @see net.kawa.tween.FlxJob#abort()
		 */
		static public function abort():void {
			manager.abort();
		}

		/**
		 * Stops and rollbacks to the first (beginning) status of all tween jobs.
		 * @see net.kawa.tween.FlxJob#cancel()
		 */
		static public function cancel():void {
			manager.cancel();
		}

		/**
		 * Forces to finish all tween jobs.
		 * @see net.kawa.tween.FlxJob#complete()
		 */
		static public function complete():void {
			manager.complete();
		}		

		/**
		 * Pauses all tween jobs.
		 * @see net.kawa.tween.FlxJob#pause()
		 */
		static public function pause():void {
			manager.pause();
		}		

		/**
		 * Proceeds with all tween jobs paused.
		 * @see net.kawa.tween.FlxJob#resume()
		 */
		static public function resume():void {
			manager.resume();
		}
	}
}
