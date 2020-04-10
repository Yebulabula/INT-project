 
 (define (problem CITYMANAGER)
                (:domain CITY_MANAGER)
                (:objects Hub1 - hub
                        
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
                        
                (:init (free car1) (free car2) (free UAV1) (free robot1) (free robot2) (at car1 Hub1)  (at package1 Hub1)
                (at package2 Hub1) (at package3 Hub1) (at package4 Hub1) (at package5 Hub1)

                (at robot1 Hub1) (at robot2 Hub1) (at car2 Hub1)
                (at UAV1 Hub1)

                (path Hub1 Strand)  (path Strand Hub1)
                
                (path Waterloo Strand) (path Strand Waterloo)
                (path Waterloo LONDON_EYE) (path LONDON_EYE Waterloo)
                (path Strand National_Gallery) (path National_Gallery Strand)
                (path Strand China_Town) (path China_Town Strand)
                (path China_Town National_Gallery) (path National_Gallery China_Town)
                
                (=(distance_land Hub1 Waterloo)2000) (=(distance_land Waterloo Hub1)2000) 
                (=(distance_land Hub1 Strand)400) (=(distance_land Strand Hub1)400) 
                (=(distance_land Hub1 LONDON_EYE)3000) (=(distance_land LONDON_EYE Hub1)3000) 
                (=(distance_land Hub1 National_Gallery)80) (=(distance_land National_Gallery Hub1)80) 
                (=(distance_land Hub1 China_Town)40) (=(distance_land China_Town Hub1)40) 

                (=(distance_land Waterloo Strand)1400) (=(distance_land Strand Waterloo)1400)
                (=(distance_land Waterloo LONDON_EYE)700) (=(distance_land LONDON_EYE Waterloo)700) 
                (=(distance_land Strand National_Gallery)500) (=(distance_land National_Gallery Strand)500)
                (=(distance_land Strand China_Town)150) (=(distance_land China_Town Strand)150) 
                (=(distance_land China_Town National_Gallery)700) (=(distance_land National_Gallery China_Town)700)

                (=(distance_air Hub1 Waterloo)1200) (=(distance_air Waterloo Hub1)1200) 
                (=(distance_air Hub1 LONDON_EYE)1000) (=(distance_air LONDON_EYE Hub1)1000) 
                (=(distance_air Hub1 Strand)500) (=(distance_air Strand Hub1)500) 
                (=(distance_air Hub1 National_Gallery)200) (=(distance_air Waterloo Hub1)200) 
                (=(distance_air Hub1 China_Town)300) (=(distance_air China_Town Hub1)300) 

                (=(weight package1)50) (=(weight package2)50) (=(weight package3)50) (=(weight package4)50) (=(weight package5)50)
                
                (=(speed car1)600) (=(speed car2)700) (=(speed UAV1)800) (=(speed robot1)10) (=(speed robot2)10) 

                (=(power_used_rate car1)2) (=(power_used_rate car2)2) (=(power_used_rate UAV1)5)
                (=(power_used_rate robot1)3) (=(power_used_rate robot2)3)

                (=(load_time car1)1) (=(load_time car2)1) (=(unload_time car1)1) (=(unload_time car2)1)
                (=(load_time robot1)1)  (=(load_time robot2)1)  (=(load_time UAV1)1) 
                (=(unload_time robot1)1)  (=(unload_time robot2)1)  (=(unload_time UAV1)1) 

                (=(carrying_capacity UAV1)100) (=(carrying_capacity robot1)100) (=(carrying_capacity robot2)100) 

                (=(goods_position_available car1)3) (=(goods_position_available car2)3) 
                (=(goods_position_available robot1)1) (=(goods_position_available robot2)1)
                (=(goods_position_available UAV1)1)

                (=(robot_position_available car1)2) (=(robot_position_available car2)2) 

                (=(max_robot_position car1)2) (=(max_robot_position car2)2)

                (=(charge_rate_in_hub car1)30) (=(charge_rate_in_hub car2)30) (=(charge_rate_in_hub UAV1)40)
                (=(charge_rate_in_hub robot1)40) (=(charge_rate_in_hub robot2)40)  
                (=(charge_rate_in_car robot1)5) (=(charge_rate_in_car robot2)5)
                (=(power_level car1)300) (=(power_level car2)300) (=(power_level UAV1)100) (=(power_level robot1)100)
                (=(power_level robot2)100) 

                )


                (:goal (and  
                        (at package1 China_Town)(at package2 Strand)  (at package5 Waterloo) (at package3 LONDON_EYE) (at package4 National_Gallery) 
                        )
                )
                (:metric 
                minimize (total-time)
                )
        )
