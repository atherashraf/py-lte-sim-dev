# py-lte-sim-dev
After cloning this repository 
clone lte-sim-dev from https://github.com/atherashraf/lte-sim-dev.git 

```angular2html
git clone https://github.com/atherashraf/lte-sim-dev.git 
```
### Build the C Project
Once the repository is cloned, navigate to the project directory and build the C project:
```angular2html
cd lte-sim-dev
make clean (if required to clean)
make
```

### Testing the Project
To verify that the project was built successfully, run the following command:
```angular2html
./LTE-Sim SingleCellWithI 1 1 10 1 1 0 1 2 1 3 0.1 242 1
```

### Building the Python Project
After building the C project, you can now build the Python project. Navigate back to the parent directory and run:
```angular2html
cd ..
python setup.py build_ext --inplace
```
