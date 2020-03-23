Config = {}
Config.Locale = "pl"
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}
options =
{
  ['seed_weed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'weed',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
    
    ['seed_sativa'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'weed_sativa',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
    
    
    ['seed_hybrid'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'weed_hybrid',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
    
    
   ['seed_coke100'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'coke100',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
           {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
    
    
    ['seed_coke90'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'coke90',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
    },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
    
    
    ['seed_coke70'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Roślina zwiędła!',
        success_msg = 'Zebrano uprawy!',
        start_msg = 'Sadzenie rośliny...',
        success_item = 'coke70',
        first_step = 1.70,
        steps = 1,
        cords = {
          --{x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          --{x = 2223.95, y = 5576.98, z = 53, distance = 10.25},
          --{x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          --{x = 706.05, y = 1269.25, z = 358, distance = 10.25},
          {x = 1344.05, y = 4387.25, z = 44, distance = 10.25},
          --{x = 1540.85, y = 6335.87, z = 24, distance = 10.25},
          {x = 530.74, y = 3093.65, z = 40, distance = 10.25},
          {x = -1493.47, y = 4406.66, z = 21.88, distance = 10.25},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim ='enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '3500'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@base', anim ='base', timeout = '8000'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '9000'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '4500'},
        },
        grow = {
          1.00
        },
        questions = {
            {
                title = 'Uprawa rośliny',
                steps = {
                    {label = 'Pielęgnuj i zbierz', value = 1, min = 5, max = 5},
                },
                correct = 1
            },
        },
      },
}
