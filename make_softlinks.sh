for lib in $(ls *.so.4.1.2)
do
    # lib could be libopencv_aruco.so.4.1.2, libopencv_objdetect.so.4.1.2 or libopencv_bgsegm.so.4.1.2, ...
    len=${#lib}
    ln -s ${lib} ${lib:0:`expr ${len} - 2`} #create softlink libopencv_aruco.so.4.1
    ln -s ${lib} ${lib:0:`expr ${len} - 4`} #create softlink libopencv_aruco.so.4
    ln -s ${lib} ${lib:0:`expr ${len} - 6`} #create softlink libopencv_aruco.so
done
