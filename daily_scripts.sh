#!/bin/bash
yyyy=2023
mm=06
dd=28
datestr = ${yyyy}${mm}${dd}


cat > pressure.py << EOF
import cdsapi

c = cdsapi.Client()

c.retrieve(
    'reanalysis-era5-pressure-levels',
    {
        'product_type':'reanalysis',
        'format':'grib',
        'pressure_level':[
            '1','2','3',
            '5','7','10',
            '20','30','50',
            '70','100','125',
            '150','175','200',
            '225','250','300',
            '350','400','450',
            '500','550','600',
            '650','700','750',
            '775','800','825',
            '850','875','900',
            '925','950','975',
            '1000'
        ],
        'date':'${datestr}/${datestr}',
        'time':'00/to/23/by/1',
        'variable':[
            'geopotential','relative_humidity','specific_humidity',
            'temperature','u_component_of_wind','v_component_of_wind'
        ]
    },
    'era5-pressure.grib')
EOF

python pressure.py



cat > surface.py << EOF
import cdsapi

c = cdsapi.Client()

c.retrieve(
    'reanalysis-era5-single-levels',
    {
        'product_type':'reanalysis',
        'format':'grib',
        'variable':[
            '10m_u_component_of_wind','10m_v_component_of_wind','2m_dewpoint_temperature',
            '2m_temperature','land_sea_mask','mean_sea_level_pressure',
            'sea_ice_cover','sea_surface_temperature','skin_temperature',
            'snow_depth','soil_temperature_level_1','soil_temperature_level_2',
            'soil_temperature_level_3','soil_temperature_level_4','surface_pressure',
            'volumetric_soil_water_layer_1','volumetric_soil_water_layer_2','volumetric_soil_water_layer_3',
            'volumetric_soil_water_layer_4'
        ],
        'date':'${datestr}/${datestr}',
        'time':'00/to/23/by/1',
    },
    'era5-surface.grib')
EOF

python surface.py

echo "Done!"


