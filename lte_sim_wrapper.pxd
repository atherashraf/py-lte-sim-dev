# cython: language_level=3
# lte_sim_wrapper.pxd
from libc.stdlib cimport malloc, free

# Enum declaration for TransportProtocolType (outside the class)
# Import the TransportProtocolType enum from TransportProtocol
cdef extern from "lte-sim-dev/src/protocolStack/protocols/TransportProtocol.h":
    cdef cppclass TransportProtocol:
        enum TransportProtocolType:
            TRANSPORT_PROTOCOL_TYPE_TCP
            TRANSPORT_PROTOCOL_TYPE_UDP




# Include ClassifierParameters class from ClassifierParameters.h
cdef extern from "lte-sim-dev/src/device/IPClassifier/ClassifierParameters.h":
    cdef cppclass ClassifierParameters:
        ClassifierParameters()
        ClassifierParameters(int sourceID, int destinationID, int sourcePort, int destinationPort,
                             TransportProtocol.TransportProtocolType protocol)
        void SetSourceID(int id)
        int GetSourceID()
        void SetDestinationID(int id)
        int GetDestinationID()
        void SetSourcePort(int port)
        int GetSourcePort()
        void SetDestinationPort(int port)
        int GetDestinationPort()
        void SetTransportProtocol(TransportProtocol.TransportProtocolType protocol)
        TransportProtocol.TransportProtocolType GetTransportProtocol()
        void Print()

# Include TransportProtocol class from TransportProtocol.h
cdef extern from "lte-sim-dev/src/protocolStack/protocols/TransportProtocol.h":
    cdef cppclass TransportProtocol:
        TransportProtocol()  # Constructor

# Include NetworkNode class from NetworkNode.h
cdef extern from "lte-sim-dev/src/device/NetworkNode.h":
    cdef cppclass NetworkNode:
        NetworkNode()
        void SetIDNetworkNode(int id)  # Use the existing method
        int GetIDNetworkNode() const  # Use the existing method
        # Add the following if you want to implement position methods
        # void SetPosition(double x, double y)
        # double GetX() const
        # double GetY() const

# Include QoSParameters class from QoSParameters.h
cdef extern from "lte-sim-dev/src/flows/QoS/QoSParameters.h":
    cdef cppclass QoSParameters:
        QoSParameters()
        QoSParameters(int qci, double gbr, double mbr)
        QoSParameters(int qci, bint arpPreEmptionCapability, bint arpPreEmptionVulnerability, double gbr,
                      double mbr)  # Replace bool with bint
        void SetQCI(int qci)
        int GetQCI() const
        void SetArpPreEmptionCapability(bint flag)  # Replace bool with bint
        bint GetArpPreEmptionCapability() const  # Replace bool with bint
        void SetArpPreEmptionVulnerability(bint flag)  # Replace bool with bint
        bint GetArpPreEmptionVulnerability() const  # Replace bool with bint
        void SetGBR(double gbr)
        double GetGBR() const
        void SetMBR(double mbr)
        double GetMBR() const
        void SetMaxDelay(double targetDelay)
        double GetMaxDelay() const

# Include Packet class from Packet.h
cdef extern from "lte-sim-dev/src/protocolStack/packet/Packet.h":
    cdef cppclass Packet:
        Packet()
        void SetTimeStamp(double time)
        double GetTimeStamp() const
        void SetSize(int size)
        void AddHeaderSize(int size)
        int GetSize() const
        void UpdatePacketSize()

        int GetSourceID()
        int GetDestinationID()
        int GetSourcePort()
        int GetDestinationPort()
        int GetSourceMAC()
        int GetDestinationMAC()
        void SetID(int uid)
        int GetID() const
        void Print()

# Include Application class from Application.h
cdef extern from "lte-sim-dev/src/flows/application/Application.h":
    cdef cppclass Application:
        enum ApplicationType:  # Declare the enum inside the cppclass
            APPLICATION_TYPE_VOIP
            APPLICATION_TYPE_TRACE_BASED
            APPLICATION_TYPE_INFINITE_BUFFER
            APPLICATION_TYPE_CBR
            APPLICATION_TYPE_WEB

        Application()  # Constructor
        Application(Application.ApplicationType applicationType)  # Constructor with type
        void Destroy()

        void SetApplicationType(Application.ApplicationType applicationType)
        Application.ApplicationType GetApplicationType() const

        void SetClassifierParameters(ClassifierParameters * cp)
        ClassifierParameters * GetClassifierParameters()

        void SetQoSParameters(QoSParameters * qos)
        QoSParameters * GetQoSParameters()

        NetworkNode * GetSource()
        void SetSource(NetworkNode * source)
        NetworkNode * GetDestination()
        void SetDestination(NetworkNode * destination)

        int GetSourcePort() const
        void SetSourcePort(int port)
        int GetDestinationPort() const
        void SetDestinationPort(int port)

        void SetStartTime(double time)
        double GetStartTime() const
        void SetStopTime(double time)
        double GetStopTime() const

        void Start()
        void Stop()
        void DoStart()  # Pure virtual method
        void DoStop()  # Pure virtual method

        void SetApplicationID(int id)
        int GetApplicationID()

        RadioBearer * GetRadioBearer()
        void Trace(Packet * packet)

cdef extern from "lte-sim-dev/src/flows/application/VoIP.h":
    cdef cppclass VoIP(Application):
        VoIP()
        void DoStart()
        void DoStop()

cdef extern from "lte-sim-dev/src/flows/application/CBR.h":
    cdef cppclass CBR(Application):
        CBR()
        void DoStart()
        void DoStop()

# Include RadioBearer class from radio-bearer.h
cdef extern from "lte-sim-dev/src/flows/radio-bearer.h":
    cdef cppclass RadioBearer:
        RadioBearer()
        void SetApplication(Application * a)
        Application * GetApplication()
        void UpdateTransmittedBytes(int bytes)
        int GetTransmittedBytes() const
        void ResetTransmittedBytes()
        void UpdateAverageTransmissionRate()
        double GetAverageTransmissionRate() const
        void SetLastUpdate()
        double GetLastUpdate() const
        void Enqueue(Packet * packet)
        bint HasPackets()  # Replace bool with bint
        Packet * CreatePacket(int bytes)
        void CheckForDropPackets()
        int GetQueueSize()
        double GetHeadOfLinePacketDelay()
        int GetHeadOfLinePacketSize()
        int GetByte(int byte)

# Include DL_MLWDF_PacketScheduler class from dl-mlwdf-packet-scheduler.h
cdef extern from "lte-sim-dev/src/protocolStack/mac/packet-scheduler/dl-mlwdf-packet-scheduler.h":
    cdef cppclass DL_MLWDF_PacketScheduler:
        DL_MLWDF_PacketScheduler()
        void DoSchedule()
        double ComputeSchedulingMetric(RadioBearer * bearer, double spectralEfficiency, int subChannel)

# Include C/C++ bool type
cdef extern from "stdbool.h":
    ctypedef bint bool  # Define Cython bool as C++ bool

# Corrected path to the Simulator class in the header file
cdef extern from "lte-sim-dev/src/core/eventScheduler/simulator.h":
    cdef cppclass Simulator:
        # Two constructors: one for singleton and one for direct instantiation
        Simulator()  # This is for singleton access
        Simulator(bool bypassSingleton)  # This is for direct instantiation

        # Methods from the Simulator class
        double Now()
        void Run()
        void Stop()
        void SetStop(double time)
        int GetUID()

        Simulator * get_instance()
