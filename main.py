import os

import lte_sim_wrapper

# Assuming there's a class or function called `LteSimulator` in your pyx file
def simulate_lte_example():
    # Instantiate the LTE simulator
    simulator = lte_sim_wrapper.LteSimulator()

    # Set up parameters for the LTE simulation, assuming the pyx file has methods to configure the simulation
    simulator.set_parameters(frequency_band=1800, bandwidth=20, num_users=100)

    # Run the simulation
    simulator.run_simulation()

    # Retrieve results
    throughput = simulator.get_throughput()
    latency = simulator.get_latency()

    # Display the results
    print(f"Simulation Results:\nThroughput: {throughput} Mbps\nLatency: {latency} ms")

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