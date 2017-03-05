#!/bin/bash

cd $1

export LD_LIBRARY_PATH=/apps/all/icc/2017.0.098-GCC-5.4.0-2.26/compilers_and_libraries_2017.0.098/linux/compiler/lib/mic:$LD_LIBRARY_PATH

threads=(60 120 240)       #number of threads used
sizes=(256 512 1024 2048)  #domain sizes

playground=phi_playground  #here the hdf5 files  are stored (global playground)

stdoutFile="benchmark_phi.csv" #stdout output from this script goes here
stderrFile="err_phi.txt"       #stderr output


if [ ! -d "$playground" ]; then
  mkdir $playground
fi


#CSV output header
echo "domainSize;nIterations;nThreads;diskWriteIntensity;airflow;materialFile;\
simulationMode;simulationOutputFile;avgColumnTemperature;totalTime;\
iterationTime"  >> ${stdoutFile}

#thread binding, improves performance
export MIC_ENV_PREFIX=PHI
export PHI_KMP_AFFINITY=granularity=fine,balanced
#export PHI_KMP_PLACE_THREADS=60c,4t  

for size in ${sizes[*]} 
do
  #calculate the "appropriate" number of iterations (by voko) so that 
  #the program runs long enough to measure accurate times
  nIterations=`expr $((10000000/$size))`
    
  #generate input file for the simulation (material properties)
  ../DataGenerator/arc_generator_phi -o ${playground}/tmp_material.h5 -N ${size} -H 100 -C 20 &>/dev/null 2>>${stderrFile}
    
  #run the parallel version for given number of threads and domain sizes
  for thread in ${threads[*]} 
  do
    #mode 1 - non-overlapped no I/O  
    ../Sources/arc_proj01_phi -b -n $nIterations -m 1 -t ${thread} -i ${playground}/tmp_material.h5 >> ${stdoutFile}  2>>${stderrFile}
    
    #cleanup
    rm -f ${playground}/${size}x${size}_${thread}threads_out_par1.h5   
  done
  
  rm -f ${playground}/tmp_material.h5 
done

rm -f -r $playground 
