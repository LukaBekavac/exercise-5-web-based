// personal assistant agent 

/* Task 2 Start of your solution */

// Inference rule for infering the belief wakeUp with the users preffered waking up methods
best_option("artificial"):- prefer_wakeup_with_art(Art) & prefer_wakeup_with_nat(Nat) & prefer_wakeup_with_vib(Vib) & Art < Nat & Art < Vib.
best_option("vibration"):- prefer_wakeup_with_art(Art) & prefer_wakeup_with_nat(Nat) &  prefer_wakeup_with_vib(Vib) & Vib < Nat & Vib < Art.
best_option("natural"):- prefer_wakeup_with_art(Art) & prefer_wakeup_with_nat(Nat) &  prefer_wakeup_with_vib(Vib) & Nat < Vib & Nat < Art.


// beliefs how the User wants to be wake up
prefer_wakeup_with_art(2).
prefer_wakeup_with_nat(1).
prefer_wakeup_with_vib(0).




// The agent has the initial goal to start
!start.
@start_plan
+!start : true <-
    .print("Managing the User");
    !checkUser;
    .wait(4000);
    !start.



/*
 * Plan for reacting to the addition of the goal !checkUser
 * Triggering event: addition of goal !checkUser
 * Context: the agent believes that the lights are off and that the room requires brightening
 * Body: the agent performs the action of greeting the user
*/
@greetingsUserAwake
+!checkUser :  upcoming_event("now") & owner_state("awake") <-
    .print("Enjoy your event!");.

/*
 * Plan for reacting to the addition of the goal !checkUser
 * Triggering event: addition of goal !checkUser
 * Context: the agent believes that the lights are off and that the room requires brightening
 * Body: the agent performs the action of starting the wake up routine
*/
@greetingsUserAsleep
+!checkUser :  upcoming_event("now") & owner_state("asleep") & best_option("vibration")  <-
    .print("Starting wake-up routine!");
    .print("waking up the User through vibrations!");
     setVibrationsMode.
     usedMethod("vibration").
+!checkUser :  upcoming_event("now") & owner_state("asleep") & best_option("artificial") <-
    .print("Starting wake-up routine!");
    .print("waking up the User through artificial light!");
     turnOnLights.
     usedMethod("artificial").
+!checkUser :  upcoming_event("now") & owner_state("asleep") & best_option("natural") <-
    .print("Starting wake-up routine!");
    .print("waking up the User through natural light!");
     raiseBlinds.
     usedMethod("natural").

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