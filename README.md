rm -rf build && cmake -S . -B build -DSOC=microsoc/default -DDEVICE=microsoc_sim &&  make -C build example-uart
