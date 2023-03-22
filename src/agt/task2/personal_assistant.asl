// personal assistant agent 

/* Task 2 Start of your solution */

// Inference rule for infering the belief wakeUp with the users preffered waking up methods
best_option_vibration :- artificial_light_wakeup(rank_art) & natural_light_wakeup(rank_nat) & vibration_wakeup(rank_vib) & rank_vib > (rank_art|rank_nat).
best_option_artificial :- artificial_light_wakeup(rank_art) & natural_light_wakeup(rank_nat) & vibration_wakeup(rank_vib) & rank_art > (rank_vib|rank_nat).
best_option_natural :- artificial_light_wakeup(rank_art) & natural_light_wakeup(rank_nat) & vibration_wakeup(rank_vib) & rank_nat > (rank_art|rank_vib).



artificial_light_wakeup(2).
natural_light_wakeup(1).
vibration_wakeup(0).

// The agent has the initial goal to start
!start.
@start_plan
+!start : true <-
    .print("Managing the User");
    !checkUser;
    .wait(4000);.




/*
 * Plan for reacting to the addition of the goal !GreetUser
 * Triggering event: addition of goal !GreetUser
 * Context: the agent believes that the lights are off and that the room requires brightening
 * Body: the agent performs the action of greeting the user
*/
@greetingsUserAwake
+!checkUser :  upcoming_event("now") & owner_state("awake") <-
    .print("Enjoy your event!");.

/*
 * Plan for reacting to the addition of the goal !GreetUser
 * Triggering event: addition of goal !GreetUser
 * Context: the agent believes that the lights are off and that the room requires brightening
 * Body: the agent performs the action of starting the wake up routine
*/
@greetingsUserAsleep
+!checkUser :  upcoming_event("now") & owner_state("asleep") <-
    .print("Starting wake-up routine!");.

/*
 * Plan for reacting to the addition of the belief mattress(State)
 * Triggering event: addition of belief mattress(State)
 * Context: true (the plan is always applicable)
 * Body: prints the state of the mattress
*/
@mattress_plan
+mattress(State) : true <-
    .print("The mattress is ", State).

/*
 * Plan for reacting to the addition of the belief blinds(State)
 * Triggering event: addition of belief blinds(State)
 * Context: true (the plan is always applicable)
 * Body: prints the state of the blinds
*/
@blinds_plan
+blinds(State) : true <-
    .print("The blinds are ", State).


/*
 * Plan for reacting to the addition of the belief lights(State)
 * Triggering event: addition of belief lights(State)
 * Context: true (the plan is always applicable)
 * Body: prints the state of the lights
*/
@lights_plan
+lights(State) : true <-
    .print("The lights are ", State).


/*
 * Plan for reacting to the addition of the belief upcoming_event(State)
 * Triggering event: addition of belief upcoming_event(State)
 * Context: true (the plan is always applicable)
 * Body: prints the state of the upcoming_event
*/
@upcoming_event_plan
+upcoming_event(State) : true <-
    .print("The upcoming event is ", State).

/*
 * Plan for reacting to the addition of the belief owner_state(State)
 * Triggering event: addition of belief owner_state(State)
 * Context: true (the plan is always applicable)
 * Body: prints the state of the owner
*/
@owner_state_plan
+owner_state(State) : true <-
    .print("The owner is ", State).
/* Task 2 End of your solution */

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }