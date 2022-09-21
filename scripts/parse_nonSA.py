import pandas as pd
import numpy as np
import sys

source_file = sys.argv[1] # file name for the .grouped files; choose from the following
# mature_sense
# Rnor_6_0_cdna_sense
# Rnor_6_0_genomic_tRNA_sense
# Rnor_6_0_RNAcentral_sense
# Rnor_6_0_ncRNA_sense

to_keep = "read count (mult. map. adj.)" # one column from the .grouped files; choose from the following
# unique reads	
# read count	
# read count (mult. map. adj.)	
# RPM (lib)	
# RPM (total)	
# coordinateString	
# RPM_adj (lib)	
# RPM_adj (total)

all_lib_counts = None # read count matrix to be constructed

# loop through all libraries
for i in range(1,41):

    # set library index and locate source file
    ind = ""
    if i < 10: 
        ind = "0" + str(i)
    elif i == 37: 
        continue
    else: 
        ind = str(i)
    path = "sRNAbench\Library_" + ind + ".fastq\\" + source_file + ".grouped"

    # read data from the source file
    with open(path, "r") as file:
        rows = file.read().splitlines() 
    rows = [rows[i].split("\t") for i in range(len(rows))]
    keys = rows.pop(0) # column names
    names = np.array(rows)[:,0]
    counts = np.array(rows)[:,keys.index(to_keep)].astype(np.float64) # str -> float
    
    # convert to DataFrame
    single_lib_counts = pd.DataFrame({"name" : names, "Library_"+ind : counts})
    single_lib_counts = single_lib_counts.groupby("name").sum() # sum up rows with the same RNA
    single_lib_counts["Library_"+ind] = (single_lib_counts["Library_"+ind] + 0.5).astype(int) # rounding = int(x+0.5)
    
    # merge read count matrices
    if i == 1:
        all_lib_counts = single_lib_counts
    else:
        all_lib_counts = pd.concat([all_lib_counts, single_lib_counts], axis=1)

# replace NaN with 0    
all_lib_counts = all_lib_counts.fillna(0)

# save as .csv
all_lib_counts.to_csv(source_file+"_counts.csv")