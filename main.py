import os

import lte_sim_wrapper


# Assuming there's a class or function called `LteSimulator` in your pyx file
def simulate_lte_example():
    lte_sim_wrapper.run_single_cell_with_interference(nbCells=1, radius=1, nbUE=100, nbVoIP=1,
                                                      nbVideo=1, nbBE=0, nbCBR=1,
                                                      sched_type=2, frame_struct=1, speed=3, maxDelay=0.1,
                                                      videoBitRate=242, seed=1)


def list_folder_and_cpp_cc_files():
    # Path to your source folder
    base_folder = '/Users/atherashraf/PycharmProjects/PhDStudents/py-lte-sim-dev'
    src_folder = os.path.join(base_folder, 'lte-sim-dev/src')
    # Arrays to hold source files and include directories
    source_array = ["lte_sim_wrapper.pyx"]
    include_dirs = []

    # Walk through the directory
    for root, dirs, files in os.walk(src_folder):
        # Add directories to include_dirs
        include_dirs.append(root)

        # Check each file in the current directory
        for file in files:
            if file.endswith(('.cpp', '.cc')):
                # Append full path to the source_array
                source_array.append(os.path.relpath(os.path.join(root, file), base_folder))

    # Print the results
    print("Source Array:")
    print(source_array)
    print("\nInclude Dirs:")
    print(include_dirs)


if __name__ == "__main__":
    simulate_lte_example()
    # list_folder_and_cpp_cc_files()
