package com.nolithius.chronophase.turns
{
	import com.nolithius.chronophase.actor.Actor;
	
	
	public class TurnManager
	{
		public var turnQueue:Vector.<Actor> = new Vector.<Actor>();
		

		public function resolveTurns():void
		{
			var actor:Actor = turnQueue[0];
			
			while(actor.type != Actor.ACTOR_TYPE_PLAYER)
			{
				actor.act();
				actor = turnQueue[0];
			}
			
			normalize();
		}
		
		
		public function registerActor(actor:Actor, id:int = 0):void
		{
			actor.id = id;
			turnQueue.push(actor);
			sortPriorityQueue();
		}
		
		
		public function removeActor(p_actor:Actor):void
		{
			var index:int = turnQueue.indexOf(p_actor);

			if (index > 0)
			{
				turnQueue.splice(index, 1);
			}
		}
		
		
		public function sortPriorityQueue()
		{
			turnQueue.sort(Actor.compareEnergy);
		}
				
		
		public function spendEnergy(actor:Actor, energy:int = 1000)
		{
			actor.energy += energy;
			sortPriorityQueue();
		}
		
		
		// Sets smallest value to 0 and adjusts all other values. This prevents the priority queue from storing very large numbers
		public function normalize():void
		{
			var smallestValue:int = turnQueue[0].energy;
			
			var turnQueueLength:uint = turnQueue.length;
			for(var i:uint = 0; i < turnQueueLength; i++)
			{
				if (turnQueue[i])
				{
					turnQueue[i].energy -= smallestValue;
				}
			}
		}
	}
}