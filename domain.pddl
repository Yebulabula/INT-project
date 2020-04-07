;INT_project domain

(define (domain CITY_MANAGER)

(:requirements :typing :durative-actions:fluents:duration-inequalities:equality :negative-preconditions :disjunctive-preconditions)
(:types 
        hub position - location
        goods - object
        vehicle - movable
        container carrier - vehicle
        UAV robot - carrier
        car - container
)

(:predicates
    ;the vehicle is chargable 
    (free ?v - vehicle)
    ;the location of movable object
    (at ?v - vehicle ?l - location)
        ;the location of movable object
    (located ?g - goods ?l - location)
    ;goods in the vehicle
    (in ?g - goods ?v - vehicle)
    ;car equip robot
    (equip ?r - robot ?c - car)
    ;carrier can load things
    (carrying ?c - carrier)
    ;road between two location
    (path ?l1?l2 - location)
)

(:functions
            
            (weight ?g - goods)

            (distance_land ?l1?l2 - location)   ;两点陆地距离
            (distance_air ?l1?l2 - location)    ;两点天空距离

            (speed ?v -vehicle)                 ;移动速度
            (power_used_rate ?v -vehicle)       ;每单位时间耗电
            (load_time ?v -vehicle)
            (unload_time ?v -vehicle) 
            (carrying_capacity ?c -carrier)  
            (goods_position_available ?c - car)   
            (robot_position_available ?c - car) 
            (max_robot_position ?c - car)
            (charge_rate_in_hub ?v - vehicle) ;recharge rate in hub
            (power_level ?v -vehicle)
)



(:durative-action charge_in_hub
    :parameters (?h - hub ?v - vehicle)
    :duration (= ?duration (/ (- 80 (power_level ?v)) (charge_rate_in_hub ?v)))
    :condition (and
        (at start(< (power_level ?v) 80))
        (over all (free ?v))
        (over all (at ?v ?h))
    )
    :effect (and 
        (increase (power_level ?v)(* (charge_rate_in_hub ?v)#t))
    )
)

(:durative-action charge_in_car
    :parameters (?c - car ?r - robot ?l1 ?l2 - location)
    :duration (= ?duration (/(distance_land ?l1 ?l2) (speed ?c)))
    :condition (and
        (at start(< (power_level ?r)100))
        (over all (free ?r))
        (over all (equip ?r ?c))
    )
    :effect (and 
        (increase (power_level ?r)#t)
        (decrease (power_level ?c)#t)
    )
)

(:durative-action load_carrier
    :parameters (?g - goods ?c - carrier ?h - hub)
    :duration (= ?duration (load_time ?c))
    :condition (and 
        (at start (not(carrying ?c)))
        (at start (>= (power_level ?c) 10)) 
        (at start (>=(carrying_capacity ?c)(weight ?g)))
        (at start (located ?g ?h))
        (over all (at ?c ?h))
    )
    :effect (and 
        (at start (not(located ?g ?h)))
        (at start (carrying ?c))
        (at start (not(free ?c)))
        (at end (free ?c))
        (at end (in ?g ?c))
    )
)

(:durative-action load_car
    :parameters (?g - goods ?r - robot ?c - car ?h - hub)
    :duration (= ?duration (load_time ?c))
    :condition (and 
        (at start (not(carrying ?r)))
        (at start (>= (power_level ?r) 10)) 
        (at start (>= (power_level ?c) 10)) 
        (at start (>=(carrying_capacity ?r)(weight ?g)))
        (at start (>=(goods_position_available ?c)1))
        (at start (located ?g ?h))
        (over all (at ?c ?h))
        (over all (at ?r ?h))
    )
    :effect (and 
        (at start (not(located ?g ?h)))
        (at start (carrying ?r))
        (at start (decrease (goods_position_available ?c) 1))
        (at start (decrease (power_level ?r) 5))
        (at start (not(free ?c)))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (free ?c))
        (at end (in ?g ?c))
        (at end (not(carrying ?r)))
    )
)

(:durative-action equip_robot
    :parameters (?r - robot ?c - car ?l - location)
    :duration (= ?duration 0.3)
    :condition (and 
        (at start (>=(robot_position_available ?c)1))
        (at start (>= (power_level ?r) 10)) 
        (at start (>= (power_level ?c) 10)) 
        (at start (not(carrying ?r)))
        (at start (at ?r ?l))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at start (not(at ?r ?l)))
        (at start (decrease (power_level ?r) 1))
        (at start (decrease (robot_position_available ?c) 1))
        (at start (not(free ?c)))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (free ?c))
        (at end (equip ?r ?c))
    )
)

(:durative-action unequip
    :parameters (?r - robot ?c - car ?h - hub)
    :duration (= ?duration 0.3)
    :condition (and 
        (at start (>= (power_level ?r) 10)) 
        (at start (>= (power_level ?c) 10)) 
        (at start (<(robot_position_available ?c)(max_robot_position ?c)))
        (at start (not(carrying ?r)))
        (at start (equip ?r ?c))
        (over all (at ?c ?h))
    )
    :effect (and
        (at start (not(equip ?r ?c)))
        (at start (decrease (power_level ?r) 1))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (increase (robot_position_available ?c) 1))
        (at end (not(equip ?r ?c)))
        (at end (at ?r ?h))
    )
)

(:durative-action unload_carrier
    :parameters (?g - goods ?c - carrier ?l - location)
    :duration (= ?duration (unload_time ?c))
    :condition (and 
        (at start (carrying ?c)) 
        (at start (>= (power_level ?c) 8)) 
        (at start (in ?g ?c))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at start (not(in ?g ?c)))
        (at end (not(carrying ?c)))
        (at end (located ?g ?l))
    )
)

(:durative-action unload_car
    :parameters (?g - goods ?r - robot ?c - car ?l - location)
    :duration (= ?duration (+(unload_time ?c)(load_time ?r)))
    :condition (and 
        (at start (in ?g ?c))
        (at start (>= (power_level ?c) 8)) 
        (at start (>= (power_level ?r) 8)) 
        (at start (equip ?r ?c))
        (at start (not(carrying ?r)))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at start (carrying ?r))
        (at start (not(in ?g ?c)))
        (at start (in ?g ?r))
        (at start (decrease (power_level ?r) 5))
        (at end (increase(robot_position_available ?c)1))
        (at end (increase(goods_position_available ?c)1))
        (at end (not(equip ?r ?c)))
        (at end (at ?r ?l))
    )
)

(:durative-action move_robot_or_car
    :parameters (?r - (either robot car) ?f - location ?t - location)
    :duration (= ?duration (/(distance_land ?f?t)(speed ?r)))
    :condition (and
        (over all (not (= ?f ?t)))
        (over all(path ?f?t))
        (at start (at ?r ?f))
        (at start (>= (power_level ?r) 20)) 
    )
    :effect (and
        (at start (not(at ?r ?f)))
        (decrease (power_level ?r)(* (power_used_rate ?r)#t))
        (at end (at ?r ?t))
    )
)

(:durative-action move_UAV
    :parameters (?u - UAV ?f - location ?t - location ?h - hub)
    :duration (= ?duration (/(distance_air ?f?t)(speed ?u)))
    :condition (and
        (over all (not (= ?f ?t)))
        (at start (at ?u ?f))
        (at start (>= (power_level ?u)20))
        ; (at start (or(and(= ?f ?h)(> (/(power_level ?u)(power_used_rate ?u)) (*(/(distance_land ?f?t)(speed ?u))2)))
        ;           (and (not(= ?f ?h)) (> (/(power_level ?u)(power_used_rate ?u)) (/(distance_land ?f?t)(speed ?u))) (= ?t ?h) ))
        ; )
    )
    :effect (and
        (at start (not(at ?u ?f)))
        (decrease (power_level ?u)(* (power_used_rate ?u)#t))
        (at end (at ?u ?t))
    )
)



)
