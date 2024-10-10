import asli
import matplotlib.pyplot as plt
from pathlib import Path

a = asli.ASLICalculator(data_dir="s3://asli", 
                   mask_filename="zarr-lsm",
                   msl_pattern="zarr-msl"
                   )

a.read_mask_data()
a.read_msl_data()
a.import_from_csv("asli_calculation_2024.csv")
a.plot_region_all()
print("Ding!")
plt.savefig("inst/app/www/plt.png")
