# cython: language_level=3
# lte_sim_wrapper.pyx


# Import the .pxd definitions
cimport lte_sim_wrapper
from lte_sim_wrapper cimport  NetworkNode, Packet, Simulator, Application
from lte_sim_wrapper cimport  RadioBearer, DL_MLWDF_PacketScheduler

from lte_sim_wrapper cimport TransportProtocol, ClassifierParameters

# Define a Python class that wraps the C++ ClassifierParameters class
cdef class PyClassifierParameters:
    cdef ClassifierParameters * _classifier_params  # C++ class instance

    # Constructor to initialize the C++ ClassifierParameters object
    def __cinit__(self, int sourceID, int destinationID, int sourcePort, int destinationPort,
                  TransportProtocol.TransportProtocolType protocol):
        self._classifier_params = new ClassifierParameters(sourceID, destinationID, sourcePort, destinationPort,
                                                           protocol)

    # Destructor to free the C++ object memory
    def __dealloc__(self):
        if self._classifier_params is not NULL:
            del self._classifier_params

    # Method to set the source ID
    def set_source_id(self, int source_id):
        self._classifier_params.SetSourceID(source_id)

    # Method to get the source ID
    def get_source_id(self):
        return self._classifier_params.GetSourceID()

    # Method to set the destination ID
    def set_destination_id(self, int destination_id):
        self._classifier_params.SetDestinationID(destination_id)

    # Method to get the destination ID
    def get_destination_id(self):
        return self._classifier_params.GetDestinationID()

    # Method to set the source port
    def set_source_port(self, int source_port):
        self._classifier_params.SetSourcePort(source_port)

    # Method to get the source port
    def get_source_port(self):
        return self._classifier_params.GetSourcePort()

    # Method to set the destination port
    def set_destination_port(self, int destination_port):
        self._classifier_params.SetDestinationPort(destination_port)

    # Method to get the destination port
    def get_destination_port(self):
        return self._classifier_params.GetDestinationPort()

    # Method to set the transport protocol
    def set_transport_protocol(self, TransportProtocol.TransportProtocolType protocol):
        self._classifier_params.SetTransportProtocol(protocol)

    # Method to get the transport protocol
    def get_transport_protocol(self):
        return self._classifier_params.GetTransportProtocol()

    # Method to print the parameters
    def print_params(self):
        self._classifier_params.Print()

# Wrapping NetworkNode
cdef class PyNetworkNode:
    """ A Python wrapper class for the C++ NetworkNode class """

    # This is the C++ object that will be wrapped
    cdef NetworkNode * c_node

    def __cinit__(self):
        """ Constructor: Initialize the C++ object """
        self.c_node = new NetworkNode()

    def __dealloc__(self):
        """ Destructor: Clean up the C++ object """
        if self.c_node is not NULL:
            del self.c_node

    def set_id(self, int id):
        """ Set the ID of the network node """
        self.c_node.SetIDNetworkNode(id)

    def get_id(self):
        """ Get the ID of the network node """
        return self.c_node.GetIDNetworkNode()

    # Uncomment if you implement position methods
    # def set_position(self, double x, double y):
    #     """ Set the position of the network node """
    #     self.c_node.SetPosition(x, y)

    # def get_x(self):
    #     """ Get the X position of the network node """
    #     return self.c_node.GetX()

    # def get_y(self):
    #     """ Get the Y position of the network node """
    #     return self.c_node.GetY()

# Wrapping Application
cdef class PyApplication:
    cdef Application * thisptr  # Pointer to the C++ Application object

    def __cinit__(self, type="voip"):
        if type == "voip":
            self.thisptr = new VoIP()  # Instantiate a VoIP object
        elif type == "cbr":
            self.thisptr = new CBR()  # Instantiate a CBR object
        else:
            raise ValueError("Unsupported application type")

    def __dealloc__(self):
        if self.thisptr:
            self.thisptr.Destroy()  # Call the C++ Destroy method
            del self.thisptr  # Free the memory

    def do_start(self):
        if self.thisptr:
            self.thisptr.DoStart()
        else:
            raise ValueError("Application pointer is NULL")

    def do_stop(self):
        if self.thisptr:
            self.thisptr.DoStop()
        else:
            raise ValueError("Application pointer is NULL")

# Wrapping Packet
# Exposing the Packet class to Python
cdef class PyPacket:
    cdef Packet * c_packet  # Pointer to the underlying C++ Packet object

    def __cinit__(self, int bytes=0):
        self.c_packet = new Packet()  # Create a new Packet using the default constructor

        if bytes > 0:
            self.set_size(bytes)  # Set the packet size if provided

    def __dealloc__(self):
        if self.c_packet:
            del self.c_packet  # Properly clean up the C++ Packet object

    def set_timestamp(self, double time):
        if self.c_packet:
            self.c_packet.SetTimeStamp(time)
        else:
            raise ValueError("Packet object is NULL")

    def get_timestamp(self):
        if self.c_packet:
            return self.c_packet.GetTimeStamp()
        else:
            raise ValueError("Packet object is NULL")

    def set_size(self, int size):
        if self.c_packet:
            self.c_packet.SetSize(size)
        else:
            raise ValueError("Packet object is NULL")

    def add_header_size(self, int size):
        if self.c_packet:
            self.c_packet.AddHeaderSize(size)
        else:
            raise ValueError("Packet object is NULL")

    def get_size(self):
        if self.c_packet:
            return self.c_packet.GetSize()
        else:
            raise ValueError("Packet object is NULL")

    def update_packet_size(self):
        if self.c_packet:
            self.c_packet.UpdatePacketSize()
        else:
            raise ValueError("Packet object is NULL")

    def get_source_id(self):
        if self.c_packet:
            return self.c_packet.GetSourceID()
        else:
            raise ValueError("Packet object is NULL")

    def get_destination_id(self):
        if self.c_packet:
            return self.c_packet.GetDestinationID()
        else:
            raise ValueError("Packet object is NULL")

    def get_source_port(self):
        if self.c_packet:
            return self.c_packet.GetSourcePort()
        else:
            raise ValueError("Packet object is NULL")

    def get_destination_port(self):
        if self.c_packet:
            return self.c_packet.GetDestinationPort()
        else:
            raise ValueError("Packet object is NULL")

    def get_source_mac(self):
        if self.c_packet:
            return self.c_packet.GetSourceMAC()
        else:
            raise ValueError("Packet object is NULL")

    def get_destination_mac(self):
        if self.c_packet:
            return self.c_packet.GetDestinationMAC()
        else:
            raise ValueError("Packet object is NULL")

    def set_id(self, int uid):
        if self.c_packet:
            self.c_packet.SetID(uid)
        else:
            raise ValueError("Packet object is NULL")

    def get_id(self):
        if self.c_packet:
            return self.c_packet.GetID()
        else:
            raise ValueError("Packet object is NULL")

    def print_packet(self):
        if self.c_packet:
            self.c_packet.Print()
        else:
            raise ValueError("Packet object is NULL")

# Wrapping RadioBearer
# Python wrapper for the RadioBearer class
cdef class PyRadioBearer:
    cdef RadioBearer* thisptr  # Pointer to the C++ RadioBearer object

    def __cinit__(self):
        self.thisptr = new RadioBearer()  # Create a new RadioBearer instance

    def __dealloc__(self):
        if self.thisptr:
            del self.thisptr  # Clean up the C++ object

    # Set the Application for the RadioBearer
    def set_application(self, PyApplication app):
        self.thisptr.SetApplication(app.thisptr)

    # Get the Application from the RadioBearer
    def get_application(self):
        cdef Application * app = self.thisptr.GetApplication()

        if app is NULL:
            return None  # Return None if no Application is associated

        # Use dynamic_cast to check if the Application is a VoIP object
        cdef VoIP * voip_app = <VoIP *> app
        if voip_app != NULL:  # If dynamic_cast succeeds
            return PyApplication("voip")  # Wrap it as a PyVoIP object

        # Use dynamic_cast to check if the Application is a CBR object
        cdef CBR * cbr_app = <CBR *> app
        if cbr_app != NULL:  # If dynamic_cast succeeds
            return PyApplication("cbr")  # Wrap it as a PyCBR object

        raise ValueError("Unknown Application type")

    # Update transmitted bytes
    def update_transmitted_bytes(self, int bytes):
        self.thisptr.UpdateTransmittedBytes(bytes)

    # Get transmitted bytes
    def get_transmitted_bytes(self):
        return self.thisptr.GetTransmittedBytes()

    # Reset transmitted bytes
    def reset_transmitted_bytes(self):
        self.thisptr.ResetTransmittedBytes()

    # Update the average transmission rate
    def update_average_transmission_rate(self):
        self.thisptr.UpdateAverageTransmissionRate()

    # Get the average transmission rate
    def get_average_transmission_rate(self):
        return self.thisptr.GetAverageTransmissionRate()

    # Set the last update time
    def set_last_update(self):
        self.thisptr.SetLastUpdate()

    # Get the last update time
    def get_last_update(self):
        return self.thisptr.GetLastUpdate()

    # Enqueue a packet into the RadioBearer
    def enqueue(self, PyPacket packet):
        self.thisptr.Enqueue(packet.c_packet)  # Use c_packet to access the C++ Packet*

    # Check if the RadioBearer has packets
    def has_packets(self):
        return self.thisptr.HasPackets()

    # Create a packet with a specific byte size
    def create_packet(self, int bytes):
        # cdef Packet * packet = self.thisptr.CreatePacket(bytes)
        return PyPacket(bytes=bytes)  # Wrap the Packet* in PyPacket using c_packet

    # Check for dropped packets
    def check_for_drop_packets(self):
        self.thisptr.CheckForDropPackets()

    # Get the queue size
    def get_queue_size(self):
        return self.thisptr.GetQueueSize()

    # Get the delay of the head-of-line packet
    def get_head_of_line_packet_delay(self):
        return self.thisptr.GetHeadOfLinePacketDelay()

    # Get the size of the head-of-line packet
    def get_head_of_line_packet_size(self):
        return self.thisptr.GetHeadOfLinePacketSize()

    # Get a specific byte from the RadioBearer
    def get_byte(self, int byte):
        return self.thisptr.GetByte(byte)


# Wrapping DL_MLWDF_PacketScheduler
# In your lte_sim_wrapper.pyx

cdef class PyDLMLWDFPacketScheduler:
    cdef DL_MLWDF_PacketScheduler* thisptr  # Pointer to the C++ DL_MLWDF_PacketScheduler object

    def __cinit__(self):
        self.thisptr = new DL_MLWDF_PacketScheduler()  # Create a new C++ DL_MLWDF_PacketScheduler

    def __dealloc__(self):
        if self.thisptr:
            del self.thisptr  # Properly clean up the C++ object

    def do_schedule(self):
        if self.thisptr:
            self.thisptr.DoSchedule()  # Call the C++ DoSchedule method

    def compute_scheduling_metric(self, PyRadioBearer bearer, double spectral_efficiency, int sub_channel):
        print("Calling overridden compute_scheduling_metric in Python")
        if self.thisptr and bearer.thisptr:
            return self.thisptr.ComputeSchedulingMetric(bearer.thisptr, spectral_efficiency, sub_channel)
        else:
            raise ValueError("Scheduler or RadioBearer object is NULL")

# Wrapping Simulator
cdef class PySimulator:
    cdef Simulator * c_simulator  # Pointer to the C++ Simulator object

    def __cinit__(self, bool use_singleton=False):
        """
        Constructor for PySimulator.
        If use_singleton is True, use the singleton instance; otherwise, instantiate a new object.
        """

        self.c_simulator = new Simulator(True)

    def now(self):
        """
        Return the current time in the simulation.
        """
        return self.c_simulator.Now()

    def run(self):
        """
        Start or resume the simulation.
        """
        self.c_simulator.Run()
        # pass

    def stop(self):
        """
        Stop the simulation.
        """
        self.c_simulator.Stop()

    def set_stop(self, double time):
        """
        Set the simulation to stop at a specific time.
        """
        self.c_simulator.SetStop(time)

    def get_uid(self):
        """
        Return the unique identifier for the simulator instance.
        """
        return self.c_simulator.GetUID()



def run_single_cell_with_interference(int nbCells, double radius, int nbUE, int nbVoIP, int nbVideo, int nbBE, int nbCBR,
                                      int sched_type, int frame_struct, int speed, double maxDelay, int videoBitRate, int seed):
    """
    Wrapper for the SingleCellWithInterference function from the C++ library.
    Exposes the functionality to Python.
    """
    print("Working on single cell with interference")
    lte_sim_wrapper.SingleCellWithInterference(nbCells, radius, nbUE, nbVoIP, nbVideo, nbBE, nbCBR,
                                               sched_type, frame_struct, speed, maxDelay, videoBitRate, seed)