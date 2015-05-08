--
-- Author: wzg
-- Date: 2038-01-02 05:49:27
--
    testInitHerosData = {
        player = {
            size = 3,
            ['1'] = {id = 1,type="animal",life=1200,pos=1,hero="tauren",icon="icons/icon001.png",skeletonID=1,
                attHurt=149,skiHurt=240,actionTime=13,isNpc=0,autoAttType=1},
            ['2'] = {id = 2,type="animal",life=2200,pos=3,hero="tauren",icon="icons/icon002.png",skeletonID=2,
                attHurt=210,skiHurt=160,actionTime=17,isNpc=0,autoAttType=2},
            ['3'] = {id = 3,type="hero",life=2200,pos=7,hero="tauren",icon="icons/iconA.png",skeletonID=5,
                attHurt=0,skiHurt=520,actionTime=10,isNpc=0,autoAttType=2}
        },
        npc = {
            ['npc1'] = {
                size = 3,
                ['1'] = {id = 1,type="animal",life=300,pos=1,hero="tauren",icon="icons/BattleUnit004.png",skeletonID=3,
                    attHurt=83,skiHurt=130,actionTime=15,isNpc=1,autoAttType=1},
                ['2'] = {id = 2,type="animal",life=300,pos=6,hero="tauren",icon="icons/BattleUnit005.png",skeletonID=4,
                    attHurt=99,skiHurt=240,actionTime=13,isNpc=1,autoAttType=1},
                ['3'] = {id = 3,type="hero",life=600,pos=7,hero="tauren",icon="icons/BattleCharMale.png",skeletonID=6,
                    attHurt=0,skiHurt=410,actionTime=11,isNpc=1,autoAttType=2},
            },
            ['npc2'] = {
                size = 3,
                ['1'] = {id = 1,type="animal",life=600,pos=3,hero="tauren",icon="icons/BattleUnit003.png",skeletonID=3,
                    attHurt=83,skiHurt=130,actionTime=15,isNpc=1,autoAttType=1},
                ['2'] = {id = 2,type="animal",life=600,pos=5,hero="tauren",icon="icons/BattleUnit005.png",skeletonID=4,
                    attHurt=99,skiHurt=240,actionTime=13,isNpc=1,autoAttType=2},
                ['3'] = {id = 3,type="hero",life=600,pos=7,hero="tauren",icon="icons/BattleCharMale.png",skeletonID=6,
                    attHurt=0,skiHurt=410,actionTime=11,isNpc=1,autoAttType=2},
            },
            ['npc3'] = {
                size = 3,
                ['1'] = {id = 1,type="animal",life=1300,pos=2,hero="tauren",icon="icons/BattleUnit003.png",skeletonID=3,
                    attHurt=83,skiHurt=130,actionTime=15,isNpc=1,autoAttType=2},
                ['2'] = {id = 2,type="animal",life=1300,pos=4,hero="tauren",icon="icons/BattleUnit004.png",skeletonID=4,
                    attHurt=99,skiHurt=240,actionTime=13,isNpc=1,autoAttType=1},
                ['3'] = {id = 3,type="hero",life=600,pos=7,hero="tauren",icon="icons/BattleCharMale.png",skeletonID=6,
                    attHurt=0,skiHurt=410,actionTime=11,isNpc=1,autoAttType=2},
            }
        }
    }





    -- testFightCmds = {
    --     ['f1'] = {
    --         ['c1'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 50,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c2'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 370,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c3'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,    
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = false,
    --                         hurtValue = 70,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c4'] = {
    --             isNpc = false,             
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 468,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         }
    --     },


    --     ['f2'] = {
    --         ['c1'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 50,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c2'] = {
    --             isNpc = false,
    --             size = 1 , 
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 170,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c3'] = {
    --             size = 1,
    --             isNpc = true,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = false,
    --                         hurtValue = 70,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c4'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 168,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c5'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 268,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c6'] = {
    --             isNpc = false,
    --             size = 2,
    --             ['1'] = {
    --                 runnerID = 3,
    --                 attType = 2,
    --                 behurtInfos = {
    --                     hurtSize = 2,
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 268,
    --                         hurtStatus = 1
    --                     },
    --                     ['2'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 461,
    --                         hurtStatus = 1
    --                     },
    --                 }
    --             },
    --             ['2'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 468,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }                
    --         },
    --     },

    --     ['f3'] = {
    --         ['c1'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 150,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c2'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 370,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c3'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = false,
    --                         hurtValue = 170,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c4'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 468,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c5'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 268,
    --                         hurtStatus = 1
    --                     }
    --                 }
    --             }
    --         },
    --         ['c6'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 3,
    --                 isNpc = false,
    --                 attType = 2,
    --                 behurtInfos = {
    --                     hurtSize = 2,
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 468,
    --                         hurtStatus = 1
    --                     },
    --                     ['2'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 461,
    --                         hurtStatus = 1
    --                     },
    --                 }
    --             }
    --         },
    --         ['c7'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 3,
    --                 attType = 2,
    --                 behurtInfos = {
    --                     hurtSize = 2,
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 668,
    --                         hurtStatus = 1
    --                     },
    --                     ['2'] = {
    --                         hurtID = 1,
    --                         isNpc = false,
    --                         hurtValue = 761,
    --                         hurtStatus = 1
    --                     },
    --                 }
    --             }
    --         },
    --         ['c8'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 isNpc = true,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 1,
    --                         isNpc = false,
    --                         hurtValue = 280,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c9'] = {
    --             isNpc = true,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 1,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = false,
    --                         hurtValue = 170,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c10'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 2,
    --                 isNpc = false,
    --                 attType = 1,
    --                 behurtInfos = {
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 170,
    --                         hurtStatus = 0
    --                     }
    --                 }
    --             }
    --         },
    --         ['c11'] = {
    --             isNpc = false,
    --             size = 1,
    --             ['1'] = {
    --                 runnerID = 3,
    --                 attType = 2,
    --                 behurtInfos = {
    --                     hurtSize = 2,
    --                     ['1'] = {
    --                         hurtID = 2,
    --                         isNpc = true,
    --                         hurtValue = 1468,
    --                         hurtStatus = 1
    --                     },
    --                     ['2'] = {
    --                         hurtID = 1,
    --                         isNpc = true,
    --                         hurtValue = 1461,
    --                         hurtStatus = 1
    --                     },
    --                 }
    --             }
    --         },
    --     },
    -- }

    testFightCmds = {
        ['f1'] = {
            ['c1'] = "1,1CMD1,1HS2_0_50_0",
            ['c2'] = "0,1CMD1,1HS1_1_370_1",
            ['c3'] = "1,1CMD2,1HS1_0_70_0",
            ['c4'] = "0,1CMD2,1HS2_1_468_1"
        },

        ['f2'] = {
            ['c1'] = "1,1CMD1,1HS2_0_50_0",
            ['c2'] = "0,1CMD1,1HS1_1_170_1",
            ['c3'] = "1,1CMD2,1HS1_0_70_0",
            ['c4'] = "0,1CMD2,1HS2_1_168_1",
            ['c5'] = "1,1CMD2,1HS2_0_268_1",
            ['c6'] = "0,2CMD3,2HS2_1_268_1HP1_1_461_1AS2,1HS2_1_468_1"
        },

        ['f3'] = {
            ['c1'] = "1,1CMD1,1HS2_0_150_0",
            ['c2'] = "0,1CMD1,1HS1_1_370_1",
            ['c3'] = "1,1CMD2,1HS1_0_170_0",
            ['c4'] = "0,1CMD2,1HS2_1_468_1",
            ['c5'] = "1,1CMD2,1HS2_0_268_1",
            ['c6'] = "0,1CMD3,2HS2_1_468_1HP1_1_461_1",
            ['c7'] = "1,1CMD3,2HS2_0_668_1HP1_0_761_1",
            ['c8'] = "1,1CMD2,1HS1_0_280_0",
            ['c9'] = "1,1CMD1,1HS2_0_170_0",
            ['c10'] = "0,1CMD2,1HS2_1_170_0",
            ['c11'] = "0,1CMD3,2HS2_1_1468_1HP1_1_1461_1"
        }
    }




