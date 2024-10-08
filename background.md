## What is the Amundsen Sea Low Index (ASLI)?
The Amundsen Seas Low (ASL) is a highly dynamic and mobile climatological low pressure system located in the Pacific sector of the Southern Ocean. In this sector, variability in sea-level pressure is greater than anywhere in the Southern Hemisphere, making it challenging to isolate local fluctuations in the ASL from larger-scale shifts in atmospheric pressure. The position and strength of the ASL are crucial for understanding regional change over West Antarctica.

More information can be found [on Scott Hosking's website](https://scotthosking.com/asl_index).

### Python Package
This application uses a python package (`asli`) which implements the ASL calculation methods described in [Hosking *et al.* (2016)](http://dx.doi.org/10.1002/2015GL067143). 

This package was developed by David Wilby at the British Antarctic Survey. You can find more about this package in this [Github repository](https://github.com/davidwilby/amundsen-sea-low-index).

## Demonstrating NERC EDS services
The aim of this application is to demonstrate the usage of different services provided by the [NERC Environmental Data Service (NERC EDS)](https://eds.ukri.org/environmental-data-service).

We are using a [JASMIN](https://jasmin.ac.uk/) group workspace (GWS) to run a data processing pipeline. Using an API, ERA5 data is read in from the [Copernicus Climate Data Store](https://cds.climate.copernicus.eu/#!/home). Calculations are then performed on [LOTUS](https://help.jasmin.ac.uk/docs/batch-computing/lotus-overview/), and output data is stored on [JASMIN Object Storage](https://help.jasmin.ac.uk/docs/short-term-project-storage/using-the-jasmin-object-store/). This data is read in and displayed by this application. This application in turn is [hosted on Datalabs](https://datalab.datalabs.ceh.ac.uk/). 

This means compute, data storage and application hosting are all separated. Each component could also be deployed on different infrastructure, for example BAS HPCs or commercial cloud providers.

### Reproducible Pipline
The data processing pipeline is ***WIP*** [documented on Github](https://github.com/antarctica/boost-eds-pipeline), and can be deployed on other platforms. 

### Technical Overview


# Citations
Hosking, J. S., A. Orr, T. J. Bracegirdle, and J. Turner (2016), Future circulation changes off West Antarctica: Sensitivity of the Amundsen Sea Low to projected anthropogenic forcing, Geophys. Res. Lett., 43, 367–376, doi:10.1002/2015GL067143. 

Hosking, J. S., & Wilby, D. asli [Computer software]. https://github.com/scotthosking/amundsen-sea-low-index