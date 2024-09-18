python setup.py build_ext --inplace
./LTE-Sim SingleCellWithI 1 1 10 1 1 0 1 2 1 3 0.1 242 1
grep -rnw '/Users/atherashraf/PycharmProjects/PhDStudents/py-lte-sim-dev/lte-sim-dev/src' -e 'GetCartesianCoordinatesForCell' --include=\*.{h,cpp}
