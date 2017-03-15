# /**
# * @File        Makefile
# * @Author      Jiri Jaros, Vojtech Nikl, Marta Cudova
# * @Affiliation FIT, Brno University of Technology
# * @Email       jarosjir@fit.vutbr.cz, inikl@fit.vutbr.cz, icudova@fit.vutbr.cz
# * @Comments    Linux makefile for Salomon
# * 
# * @Tool        ARC project 2017
# * @Created     15 February  2015, 15:25
# * @LastModif   22 February  2017, 16:00
#
# */

#Load following modules first
# for processor:   module load intel/2016.01 HDF5/1.8.13-intel-2016.01
#            or:   module load intel/2017.00 HDF5/1.8.16-intel-2017.00    
# for Xeon Phi:    module load intel/2017.00
#                  module unload HDF5
#                  export LD_LIBRARY_PATH=/apps/all/icc/2017.0.098-GCC-5.4.0-2.26/\
#                  compilers_and_libraries_2017.0.098/linux/compiler/lib/mic:$LD_LIBRARY_PATH

#SET PATHS 
#HDF5_DIR=/apps/all/HDF5/1.8.13-intel-2016.01#/usr/local/ # hdf5 installation folder

#HDF5_DIR=/apps/all/HDF5/1.8.16-intel-2017.00
HDF5_DIR=/usr/#/apps/all/HDF5/1.8.16-intel-2017.00
HDF5_PHI_DIR = '../HDF5_phi'


#CXX  = icpc
CXX  = g++

CXXFLAGS       = -std=c++11 -O3 -fopenmp -I. 
#CXXFLAGS       = -std=c++11 -O3 -qopenmp -I. 
#CXXFLAGS_NOPHI = -xhost -I$(HDF5_DIR)/include
CXXFLAGS_NOPHI = -mavx -I$(HDF5_DIR)/include
CXXFLAGS_PHI   = -mmic -I$(HDF5_PHI_DIR)/include

TARGET     = arc_generator
TARGET_PHI = arc_generator_phi

LDFLAGS       = -std=c++11 -O3 -fopenmp
#LDFLAGS       = -std=c++11 -O3 -qopenmp
LDFLAGS_NOPHI = -mavx -L$(HDF5_DIR)/lib/ -Wl,-rpath,$(HDF5_DIR)/lib/
#LDFLAGS_NOPHI = -xhost -L$(HDF5_DIR)/lib/ -Wl,-rpath,$(HDF5_DIR)/lib/
LDFLAGS_PHI   = -mmic -L$(HDF5_PHI_DIR)/lib/ -Wl,-rpath,$(HDF5_PHI_DIR)/lib/


all:    $(TARGET) 

#---------------------------------------------------------

$(TARGET):  $(TARGET).o          
	$(CXX) $(LDFLAGS) $(LDFLAGS_NOPHI) $(TARGET).o \
    -lhdf5_hl -lhdf5 \
    -o $@


$(TARGET).o : $(TARGET).cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_NOPHI) -c $(TARGET).cpp

#---------------------------------------------------------

phi:  $(TARGET_PHI).o           
	$(CXX) $(LDFLAGS) $(LDFLAGS_PHI) $(TARGET_PHI).o \
    -lhdf5_hl -lhdf5 \
    -o $(TARGET_PHI)


$(TARGET_PHI).o : $(TARGET).cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_PHI) -c $(TARGET).cpp -o $(TARGET_PHI).o

#---------------------------------------------------------

test:
	./$(TARGET) -o material.h5.original -N 512 -H 100 -C 20


test1:
	./$(TARGET) -o material.h5 -N 2048 -H 100 -C 20

test2:
	./$(TARGET) -o material.h5.4096 -N 4096 -H 100 -C 20

test3:
	./$(TARGET) -o material.h5.1024 -N 1024 -H 100 -C 20
clean:
	rm -f *.o  $(TARGET) $(TARGET_PHI) material.h5

