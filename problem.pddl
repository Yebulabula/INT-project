        (define (problem CITYMANAGER)
                (:domain CITY_MANAGER)
                (:objects Hub - Hub
                        
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
                        
                        UAV1 - UAV
                        
                        robot1 - robot
                        robot2 - robot
                )
                        
                (:init (free car1) (free car2) (free UAV1) (free robot1) (free robot2) (at car1 Hub) (at car2 Hub) (at package1 Hub)
                (at package2 Hub) (at package3 Hub) (at package4 Hub)

                (at UAV1 Hub)


                (path Hub Waterloo)  (path Waterloo Hub)
                (path Hub Strand)  (path Strand Hub)
                (path Hub LONDON_EYE) (path LONDON_EYE Hub)
                (path Hub National_Gallery) (path National_Gallery Hub)
                (path Hub China_Town) (path China_Town Hub)
                (path Waterloo Strand) (path Strand Waterloo)
                (path Waterloo LONDON_EYE) (path LONDON_EYE Waterloo)
                (path Strand National_Gallery) (path National_Gallery Strand)
                (path Strand China_Town) (path China_Town Strand)
                (path China_Town National_Gallery) (path National_Gallery China_Town)

                (=(weight package1)50) (=(weight package2)50) (=(weight package3)50) (=(weight package4)50)
                (=(distance_land Waterloo Strand)40) (=(distance_land Strand Waterloo)40)
                (=(distance_land Waterloo LONDON_EYE)60) (=(distance_land LONDON_EYE Waterloo)60) 
                (=(distance_land Strand National_Gallery)50) (=(distance_land National_Gallery Strand)50)
                (=(distance_land Strand China_Town)15) (=(distance_land China_Town Strand)15) 
                (=(distance_land China_Town National_Gallery)70) (=(distance_land National_Gallery China_Town)70)

                (=(distance_air Hub Waterloo)39) (=(distance_air Waterloo Hub)39) 
                (=(distance_air Hub LONDON_EYE)50) (=(distance_air LONDON_EYE Hub)50) 
                (=(distance_air Hub Strand)30) (=(distance_air Strand Hub)30) 
                (=(distance_air Hub National_Gallery)20) (=(distance_air Waterloo Hub)20) 
                (=(distance_air Hub China_Town)30) (=(distance_air China_Town Hub)30) 

                (=(speed car1)60) (=(speed car2)70) (=(speed UAV1)30) (=(speed robot1)10) (=(speed robot2)10) 

                (=(power_used_rate car1)20) (=(power_used_rate car2)21) (=(power_used_rate UAV1)10)
                (=(power_used_rate robot1)5) (=(power_used_rate robot2)5)

                (=(load_time car1)1) (=(load_time car2)1) (=(unload_time car1)1) (=(unload_time car2)1)

                (=(carrying_capacity UAV1)100) (=(carrying_capacity robot1)1) (=(carrying_capacity robot2)1) 

                (=(goods_position_available car1)3) (=(goods_position_available car2)3) 
                (=(goods_position_available robot1)1) (=(goods_position_available robot2)1)
                (=(goods_position_available UAV1)1)

                (=(robot_position_available car1)1) (=(robot_position_available car2)1) 

                (=(max_robot_position car1)1) (=(max_robot_position car2)1)

                (=(charge_rate_in_hub car1)30) (=(charge_rate_in_hub car2)30) (=(charge_rate_in_hub UAV1)40)
                (=(charge_rate_in_hub robot1)40) (=(charge_rate_in_hub robot2)40)  

                (=(power_level car1)1000) (=(power_level car2)1000) (=(power_level UAV1)100) (=(power_level robot1)100)
                (=(power_level robot2)100)
                )


                (:goal (and  (at car1 Hub) (at car2 Hub)
                        (at package1 Waterloo) 
                        )
                )
        )