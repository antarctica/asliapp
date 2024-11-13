#!/usr/bin/env python3
import asli
import argparse
import matplotlib.pyplot as plt
from pathlib import Path

# Get and parse the arguments from the command line
parser = argparse.ArgumentParser()
parser.add_argument("--plot_year", help="year to plot", type=str, required=True)
args = parser.parse_args()

a = asli.ASLICalculator(data_dir="s3://asli", 
                   mask_filename="zarr-lsm",
                   msl_pattern="zarr-msl"
                   )

a.read_mask_data()
a.read_msl_data()
a.import_from_csv("asli_calculation_2024.csv")

year = args.plot_year

a.plot_region_year(year)

# a.plot_region_year([args.plot_year])

plt.savefig("inst/app/www/plt.png")
