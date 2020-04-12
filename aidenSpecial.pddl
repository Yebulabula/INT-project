;INT_project domain

(define (domain CITY_MANAGER)

(:requirements :typing :durative-actions:fluents:duration-inequalities:equality:derived-predicates)
(:types 
        hub position - location
        vehicle goods - movable
        car carrier - vehicle
        UAV robot - carrier
)

(:predicates
    ;the vehicle is chargable or moveable
    (free ?v - vehicle)
    ;the location of movable object
    (at ?v - movable ?l - location)
    ;goods in the vehicle
    (in ?g - goods ?v - vehicle)
    ;car equip robot
    (equip ?r - robot ?c - car)
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
            (charge_rate_in_hub ?v - vehicle) ;recharge rate in hub
            (charge_rate_in_car ?r - robot)
            (power_level ?v -vehicle)
            (goods_position_available ?v - vehicle)
            (max_goods_position ?v - vehicle)   
            (robot_position_available ?c - car) 
            (max_robot_position ?c - car)
            ;the max weight of one goods
            (carrying_capacity ?c -carrier)
)


(:durative-action charge_in_hub
    :parameters (?h - hub ?v - vehicle)
    :duration (<= ?duration 5)
    :condition (and
        (at start (free ?v))
        (over all(< (power_level ?v)100))
        (over all (at ?v ?h))
    )
    :effect (and 
        (at start (not(free ?v)))
        (at end (free ?v))
        (at end
        (increase (power_level ?v)(* (charge_rate_in_hub ?v)?duration)))    
    )
)

(:durative-action charge_in_car
    :parameters (?c - car ?r - robot)
    :duration (<= ?duration 20)
    :condition (and
        (over all (< (power_level ?r)100))
        (at start(free ?r))
        (over all (> (power_level ?c)10))
        (over all (equip ?r ?c))
    )
    :effect (and 
        (at start(not(free ?r)))
        (at end (increase (power_level ?r)(*(charge_rate_in_car ?r)?duration)))
        (at end (decrease (power_level ?c)(*(*(charge_rate_in_car ?r)?duration)0.1)))
        (at end(free ?r))
    )
)

(:durative-action load_carrier
    :parameters (?g - goods ?c - carrier ?h - hub)
    :duration (= ?duration (load_time ?c))
    :condition (and 
        (at start (>=(goods_position_available ?c)1))
        (at start (>= (power_level ?c) 10))
        (at start (>=(carrying_capacity ?c)(weight ?g)))
        (at start (at ?g ?h))
        (at start (free ?c))
        (over all (at ?c ?h))
    )
    :effect (and 
        (at start (not(at ?g ?h)))
        (at start (not(free ?c)))
        (at start (decrease (goods_position_available ?c) 1))
        (at end (free ?c))
        (at end (in ?g ?c))
    )
)

(:durative-action load_car
    :parameters (?g - goods ?r - robot ?c - car ?h - hub)
    :duration (= ?duration (load_time ?c))
    :condition (and 
        (at start (>=(goods_position_available ?r)1))
        (at start (>= (power_level ?r) 10))
        (at start (>=(carrying_capacity ?r)(weight ?g)))
        (at start (>=(goods_position_available ?c)1))
        (at start (free ?r))
        (at start (at ?g ?h))
        (over all (at ?c ?h))
        (over all (at ?r ?h))
    )
    :effect (and 
        (at start (not(at ?g ?h)))
        (at start (decrease (goods_position_available ?c) 1))
        (at start (decrease (power_level ?r) 5))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (in ?g ?c))
    )
)


(:durative-action equip_robot
    :parameters (?r - robot ?c - car ?l - location)
    :duration (= ?duration 0.3)
    :condition (and 
        (at start (>=(robot_position_available ?c)1))
        (at start (>= (power_level ?r) 10)) 
        (at start (>=(goods_position_available ?r)1))
        (at start (at ?r ?l))
        (at start (free ?r))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at start (not(at ?r ?l)))
        (at start (decrease (power_level ?r) 1))
        (at start (decrease (robot_position_available ?c) 1))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (equip ?r ?c))
    )
)

(:durative-action unequip
    :parameters (?r - robot ?c - car ?h - hub)
    :duration (= ?duration 0.3)
    :condition (and 
        (at start (>= (power_level ?r) 10)) 
        (at start (equip ?r ?c))
        (at start (free ?r))
        (at start (free ?c))
        (over all (at ?c ?h))
    )
    :effect (and
        (at start (decrease (power_level ?r) 1))
        (at start (not(equip ?r ?c)))
        (at start (not(free ?r)))
        (at start (not(free ?c)))
        (at end (free ?c))
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
        (at start (>= (power_level ?c) 8)) 
        (at start (in ?g ?c))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at start (not(in ?g ?c)))
        (at start (not(free ?c)))
        (at end (free ?c))
        (at end (increase (goods_position_available ?c) 1))
        (at end (at ?g ?l))
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
        (at start (>=(goods_position_available ?r)1))
        (over all (at ?c ?l))
    )
    :effect (and 
        (at end (decrease(goods_position_available ?r)1))
        (at start (not(in ?g ?c)))
        (at start (in ?g ?r))
        (at start (decrease (power_level ?r) 5))
        (at start (not(free ?c)))
        (at start (not(free ?r)))
        (at end (free ?r))
        (at end (free ?c))
        (at end (increase(robot_position_available ?c)1))
        (at end (increase(goods_position_available ?c)1))
        (at end (not(equip ?r ?c)))
        (at end (at ?r ?l))
    )
)

(:durative-action move_robot
   :parameters (?r - robot ?f - location ?t - location)
   :duration (= ?duration (/(distance_land ?f?t)(speed ?r)))
   :condition (and
       (over all (not (= ?f ?t)))
       (at start (path ?f?t))
       (at start (at ?r ?f))
       (at start (free ?r))
       (at start (>= (power_level ?r) 20))
   )
   :effect (and
       (at start (not(at ?r ?f)))
       (at start (not(free ?r)))
       (at end (free ?r))
       (at end (at ?r ?t))
       (at end (decrease (power_level ?r)(*(power_used_rate ?r)?duration)))
   )
)


(:durative-action departure_car
    :parameters (?c - car ?f - hub ?t - location)
    :duration (= ?duration (/(distance_land ?f?t)(speed ?c)))
    :condition (and
        (over all (not (= ?f ?t)))
        (at start (path ?f?t))
        (at start (at ?c ?f))
        (at start (free ?c))
        (at start (>= (power_level ?c) 20))
        (at start (<(robot_position_available ?c)(max_robot_position ?c)))
    )
    :effect (and
        (at start (not(at ?c ?f)))
        (at start (not(free ?c)))
        (at end (free ?c))
        (at end (at ?c ?t))
        (at end (decrease (power_level ?c)(*(power_used_rate ?c)?duration)))
    )
)

(:durative-action move_car
    :parameters (?c - car ?f - position ?t - location)
    :duration (= ?duration (/(distance_land ?f?t)(speed ?c)))
    :condition (and
        (over all (not (= ?f ?t)))
        (at start (path ?f?t))
        (at start (at ?c ?f))
        (at start (free ?c))
        (at start (>= (power_level ?c) 20))
    )
    :effect (and
        (at start (not(at ?c ?f)))
        (at start (not(free ?c)))
        (at end (free ?c))
        (at end (at ?c ?t))
        (at end (decrease (power_level ?c)(*(power_used_rate ?c)?duration)))
    )
)

(:durative-action transport_UAV
    :parameters (?u - UAV ?f - hub ?t - location)
    :duration (= ?duration (/(distance_air ?f?t)(speed ?u)))
    :condition (and
        (over all (not (= ?f ?t)))
        (at start (free ?u))
        (at start (at ?u ?f))
        (at start (<(goods_position_available ?u)(max_goods_position ?u)))
        (at start (>= (/(power_level ?u)(power_used_rate ?u)) (*(/(distance_air ?f?t)(speed ?u))2)))
    )
    :effect (and
        (at start (not(at ?u ?f)))
        (at start (not(free ?u)))
        (at end (free ?u))
        (at end (at ?u ?t))
        (at end (decrease (power_level ?u)(*(power_used_rate ?u)?duration)))
    )
)

;return to one of hubs
(:durative-action return_UAV
    :parameters (?u - UAV ?f - location ?t - hub)
    :duration (= ?duration (/(distance_air ?f?t)(speed ?u)))
    :condition (and
        (over all (not (= ?f ?t)))
        (at start (free ?u))
        (at start (at ?u ?f))
        (at start (>= (/(power_level ?u)(power_used_rate ?u)) (/(distance_air ?f?t)(speed ?u))))
    )
    :effect (and
        (at start (not(at ?u ?f)))
        (at start (not(free ?u)))
        (at end (free ?u))
        (at end (at ?u ?t))
        (at end (decrease (power_level ?u)(*(power_used_rate ?u)?duration)))
    )
)



)
