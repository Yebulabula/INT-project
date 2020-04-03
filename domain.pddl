;INT_project domain

(define (domain CITY_MANAGER)

(:requirements :typing :durative-actions:fluents:duration-inequalities:equality)
(:types 
        docker position -location
        vehicle goods -object
        car UAV robot -vehicle
)

(:predicates

    ;robot is at table t
    (at-table ?t -table)
    ;check if the hand is empty
    (handEmpty ?h -hand)
    ;carry dish d on hand j
    (carry ?d -dish ?h -hand)
    ;robot is at private room pr
    (at-private_room ?pr - private_room)
    ;check if the box has available space
    (full ?b -box)
    ;dish d is in box b
    (in ?d -dish ?b -box)
    ;the distance between two tables
    (distance ?t1?t2 -table)
    ;the distance between table and kitchen
    (Take_food_diatance ?t-table ?k-kitchen)
    ;check if the robot is power off
    (canWork ?r-robot)
)

(:functions 
            (Carrying_capacity ?v -vehicle)
            (time_to_charge ?r -robot)
            (time_to_arrive ?from ?to -location ?v -vehicle)
            (load_time ?v -vehicle)
            (unload_time ?v -vehicle)
            (power_used ?from ?to -location ?v -vehicle)
            (charge_in_docker)
            (charge_in_car)
        　　 (total_power ?v -vehicle)
)

; this action greets one thing by its name
(:action say-hello
    :parameters (?t - thing)
    :precondition (and
        ; we only ever need to greet once
        (not (said_hello_to ?t))
        ; only greet someone if they are near
        (can_hear ?t)
    )
    :effect (and
        ; record that we said hello
        (said_hello_to ?t)
    )
)

)