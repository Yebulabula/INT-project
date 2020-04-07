(define (problem CITYMANAGER)
        (:domain CITY_MANAGER)
        (:objects Hub - hub
                  
                  Waterloo - position
                  Strand - position
                  LONDON_EYE - position
                  China_Town - position
                  National_Gallery -position
                 
                  car1 - car
                  car2 - car

                  package1 - goods
                  package2 - goods
                  package3 - goods
                  package4 - goods
                  
                  UAV1 - UAV
                  
                  robot1 - robot
                  robot2 - robot
        )
                  
        (:init (free car1) (free car2) (free UAV1) (free robot1) (free robot2) (at car1 Hub) (at car2 Hub) (located package1 Hub)
               (located package2 Hub) (located package3 Hub) (located package4 Hub) (in package1 car1)
               (in package2 car1) (in package3 car2) (in package4 car2)  (equip robot1 car1)
               (equip robot2 car2)  (not(carrying UAV1))
               (not(carrying robot1)) (not(carrying robot2)) 

               (path Waterloo Strand) (path Strand Waterloo)
               (path Waterloo LONDON_EYE) (path LONDON_EYE Waterloo)
               (path Strand National_Gallery) (path National_Gallery Strand)
               (path Strand China_Town) (path China_Town Strand)
               (path China_Town National_Gallery) (path National_Gallery China_Town)

               (=(weight package1)50) (=(weight package2)50) (=(weight package3)50) (=(weight package4)50)
               (=(distance_land Waterloo Strand)4000) (=(distance_land Strand Waterloo)4000)
               (=(distance_land Waterloo LONDON_EYE)6000) (=(distance_land LONDON_EYE Waterloo)6000) 
               (=(distance_land Strand National_Gallery)5000) (=(distance_land National_Gallery Strand)5000)
               (=(distance_land Strand China_Town)15000) (=(distance_land China_Town Strand)15000) 
               (=(distance_land China_Town National_Gallery)7000) (=(distance_land National_Gallery China_Town)7000)

               (=(distance_air hub Waterloo)3900) (=(distance_air Waterloo hub)3900) 
               (=(distance_air hub LONDON_EYE)5000) (=(distance_air LONDON_EYE hub)5000) 
               (=(distance_air hub Strand)3000) (=(distance_air Strand hub)3000) 
               (=(distance_air hub National_Gallery)2000) (=(distance_air Waterloo hub)2000) 
               (=(distance_air hub China_Town)3000) (=(distance_air China_Town hub)3000) ,

               (=(speed car1)60) (=(speed car2)70) (=(speed UAV1)30) (=(speed robot1)10) (=(speed robot2)10) 

               (=(power_used_rate car1)20) (=(power_used_rate car2)21) (=(power_used_rate UAV1)10)
               (=(power_used_rate robot1)5) (=(power_used_rate robot2)5)

               (=(load_time car1)1) (=(load_time car2)1) (=(unload_time car1)1) (=(unload_time car2)1)

               (=(carrying_capacity UAV1)1) (=(carrying_capacity robot1)1) (=(carrying_capacity robot2)1) 

               (=(goods_position_available car1)3) (=(goods_position_available car2)3) (=(robot_position_available car1)1)

               (=(robot_position_available car2)1) (=(max_robot_position car1)1) (=(max_robot_position car2)1)

               (=(charge_rate_in_hub car1)30) (=(charge_rate_in_hub car2)30) (=(charge_rate_in_hub UAV1)40)
               (=(charge_rate_in_hub robot1)40) (=(charge_rate_in_hub robot2)40) 

               (=(power_level car1)1000) (=(power_level car2)1000) (=(power_level UAV1)100) (=(power_level robot1)100)
               (=(power_level robot2)100)
        )


        (:goal (and  (at car1 Hub) (at car2 Hub)
                (at package1 Waterloo) (at package2 Strand) (at package3 LONDON_EYE) (at package4 China_Town)
                (not(carrying UAV1)) (not(carrying robot1)) (not(carrying robot2))
                (not(equip robot1 car1)) (not(equip robot2 car2))
                )
        
        )
)
