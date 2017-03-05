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
HDF5_DIR=/apps/all/HDF5/1.8.16-intel-2017.00#/usr/local/
HDF5_PHI_DIR = '../HDF5_phi'


CXX  = icpc

CXXFLAGS       = -W -Wall -Wextra -pedantic -std=c++11 -O3 -qopenmp -I.
CXXFLAGS_NOPHI = -xhost -I$(HDF5_DIR)/include
CXXFLAGS_PHI   = -mmic -I$(HDF5_PHI_DIR)/include

TARGET     = arc_proj01
TARGET_PHI = arc_proj01_phi

LDFLAGS       = -std=c++11 -O3 -qopenmp
LDFLAGS_NOPHI = -xhost -L$(HDF5_DIR)/lib/ -Wl,-rpath,$(HDF5_DIR)/lib/
LDFLAGS_PHI   = -mmic -L$(HDF5_PHI_DIR)/lib/ -Wl,-rpath,$(HDF5_PHI_DIR)/lib/


all:    $(TARGET)

#---------------------------------------------------------

$(TARGET):  $(TARGET).o MaterialProperties.o BasicRoutines.o
	$(CXX) $(LDFLAGS) $(LDFLAGS_NOPHI) \
  $(TARGET).o MaterialProperties.o BasicRoutines.o \
    -lhdf5_hl -lhdf5 \
    -o $@


$(TARGET).o : proj01.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_NOPHI) -c proj01.cpp -o $(TARGET).o

MaterialProperties.o: MaterialProperties.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_NOPHI) -c MaterialProperties.cpp

BasicRoutines.o: BasicRoutines.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_NOPHI) -c BasicRoutines.cpp

#---------------------------------------------------------

phi:  $(TARGET_PHI).o MaterialProperties_phi.o BasicRoutines_phi.o
	$(CXX) $(LDFLAGS) $(LDFLAGS_PHI) \
  $(TARGET_PHI).o MaterialProperties_phi.o BasicRoutines_phi.o \
    -lhdf5_hl -lhdf5 \
    -o $(TARGET_PHI)


$(TARGET_PHI).o : proj01.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_PHI) -c proj01.cpp -o $(TARGET_PHI).o

MaterialProperties_phi.o: MaterialProperties.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_PHI) -c MaterialProperties.cpp -o MaterialProperties_phi.o

BasicRoutines_phi.o: BasicRoutines.cpp
	$(CXX) $(CXXFLAGS) $(CXXFLAGS_PHI) -c BasicRoutines.cpp -o BasicRoutines_phi.o

#---------------------------------------------------------

test:
	./$(TARGET) -n 100 -m 0 -w 1 -t 1 -i ../DataGenerator/material.h5 -o result.h5

seq:	$(TARGET)
	./$(TARGET) -n 10000 -m 0 -w 100 -t 4 -i ../DataGenerator/material.h5 -o result.h5

par1:	$(TARGET)
	./$(TARGET) -n 10000 -m 1 -w 100 -t 4 -i ../DataGenerator/material.h5 -o result.h5

ver1:	$(TARGET)
	./$(TARGET) -n 10000 -m 1 -w 100 -t 4 -i ../DataGenerator/material.h5 -o result.h5 -v

par2:	$(TARGET)
	./$(TARGET) -n 10000 -m 2 -w 100 -t 4 -i ../DataGenerator/material.h5 -o result.h5

ver2:	$(TARGET)
	./$(TARGET) -n 10000 -m 2 -w 100 -t 4 -i ../DataGenerator/material.h5 -o result.h5 -v

clean:
	rm -f *.o  $(TARGET) $(TARGET_PHI) result_seq.h5


