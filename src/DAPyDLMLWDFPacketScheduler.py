from lte_sim_wrapper import PyDLMLWDFPacketScheduler, PyRadioBearer


class DAPyDLMLWDFPacketScheduler(PyDLMLWDFPacketScheduler):
    def compute_scheduling_metric(self,  bearer:PyRadioBearer, spectral_efficiency: float,sub_channel:int):
        print("compute_scheduling_metric")