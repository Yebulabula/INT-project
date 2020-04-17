(define 
    (problem CITYMANAGER)
    (:domain CITY_MANAGER)
    (:objects 
        Hub1 - hub
            
        Waterloo - position
        Strand - position
        LONDON_EYE - position
        China_Town - position
        National_Gallery - position
        
        car1 - car      
        car2 - car

        package1 - goods
        package2 - goods
        package3 - goods
        package4 - goods
        package5 - goods
        
        UAV1 - UAV
        
        robot1 - robot
        robot2 - robot
    )
  
    (:init
        (free car1) (free car2) (free UAV1) (free robot1) (free robot2)
        (at UAV1 Hub1) (at robot1 Hub1) (at robot2 Hub1) (at car1 Hub1) (at car2 Hub1)
        (at package1 Hub1) (at package2 Hub1) (at package3 Hub1) (at package4 Hub1) (at package5 Hub1)
        
        ; path between Hub and Location
        (path Hub1 Waterloo) (path Waterloo Hub1)
        (path Hub1 Strand) (path Strand Hub1)
        (path Hub1 LONDON_EYE) (path LONDON_EYE Hub1)
        (path Hub1 China_Town) (path China_Town Hub1)
        (path Hub1 National_Gallery) (path National_Gallery Hub1)

        ; path between locations
        (path Waterloo Strand) (path Strand Waterloo)
        ;(path Waterloo LONDON_EYE) (path LONDON_EYE Waterloo)
        ;(path National_Gallery LONDON_EYE) (path LONDON_EYE National_Gallery)
        (path China_Town National_Gallery) (path National_Gallery China_Town)

        (=(total_power)0)
        
        (=(distance_land Hub1 Waterloo)160) (=(distance_land Waterloo Hub1)160)
        (=(distance_land Hub1 Strand)230) (=(distance_land Strand Hub1)230)
        (=(distance_land Hub1 LONDON_EYE)180) (=(distance_land LONDON_EYE Hub1)180)
        (=(distance_land Hub1 China_Town)350) (=(distance_land China_Town Hub1)350)
        (=(distance_land Hub1 National_Gallery)310) (=(distance_land National_Gallery Hub1)310)

        (=(distance_land Waterloo Strand)80) (=(distance_land Strand Waterloo)80)
        ;(=(distance_land Waterloo LONDON_EYE)60) (=(distance_land LONDON_EYE Waterloo)60) 
        ;(=(distance_land National_Gallery LONDON_EYE)80) (=(distance_land LONDON_EYE National_Gallery)80)
        (=(distance_land China_Town National_Gallery)50) (=(distance_land National_Gallery China_Town)50)
        

        (=(distance_air Hub1 Waterloo)130) (=(distance_air Waterloo Hub1)130) 
        (=(distance_air Hub1 LONDON_EYE)160) (=(distance_air LONDON_EYE Hub1)160) 
        (=(distance_air Hub1 Strand)210) (=(distance_air Strand Hub1)210) 
        (=(distance_air Hub1 National_Gallery)280) (=(distance_air National_Gallery Hub1)280) 
        (=(distance_air Hub1 China_Town)300) (=(distance_air China_Town Hub1)300) 

        ; max total movement for car:1000km
        ; max total movement for UAV: 400km
        ; max total movement for robot: 500km
            
        (=(weight package1)50) (=(weight package2)60) (=(weight package3)60) (=(weight package4)70) (=(weight package5)30) 
        
        (=(speed car1)150) (=(speed car2)150) (=(speed UAV1)120) (=(speed robot1)50) (=(speed robot2)50) 

        (=(power_used_rate car1)12) (=(power_used_rate car2)12) (=(power_used_rate UAV1)30)
        (=(power_used_rate robot1)10) (=(power_used_rate robot2)10)

        (=(load_time car1)0.1) (=(load_time car2)0.1) (=(unload_time car1)0.1) (=(unload_time car2)0.1)
        (=(load_time robot1)0.1)  (=(load_time robot2)0.1)  (=(load_time UAV1)0.1) 
        (=(unload_time robot1)0.1)  (=(unload_time robot2)0.1)  (=(unload_time UAV1)0.1) 

        (=(carrying_capacity UAV1)50) (=(carrying_capacity robot1)100) (=(carrying_capacity robot2)100) 

        (=(goods_position_available car1)3) (=(goods_position_available car2)3) 
        (=(goods_position_available robot1)1) (=(goods_position_available robot2)1)
        (=(goods_position_available UAV1)1)

        (=(robot_position_available car1)2) (=(robot_position_available car2)2) 
        (=(max_robot_position car1)2) (=(max_robot_position car2)2)

        (=(max_goods_position car1)3) (=(max_goods_position car2)3)
        (=(max_goods_position robot1)1) (=(max_goods_position robot2)1)
        (=(max_goods_position UAV1)1)

        (=(charge_rate_in_hub car1)20) (=(charge_rate_in_hub car2)20) (=(charge_rate_in_hub UAV1)30)
        (=(charge_rate_in_hub robot1)30) (=(charge_rate_in_hub robot2)30)  
        (=(charge_rate_in_car robot1)5) (=(charge_rate_in_car robot2)5)
        (=(power_level car1)100) (=(power_level car2)100) (=(power_level UAV1)100) (=(power_level robot1)100)
        (=(power_level robot2)100)
    )

    (:goal
        (and  
            (at package1 China_Town) (at package2 Strand) (at package3 Waterloo) (at package4 National_Gallery) (at package5 LONDON_EYE) 
        )
    )

    (:metric 
        ; minimize (+(*(total-time)1)(*(total_power)0.1))
        minimize (total-time)
    )
)
