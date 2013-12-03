//---------------------------------------------------------------------------
#ifndef TUpdateStatusEvent
	typedef void UpdateStatusFunc(char *Message, bool *Abort);
	typedef UpdateStatusFunc* TUpdateStatusEvent;
#endif
//---------------------------------------------------------------------------
#ifndef TDeviceInfoStruct
#define TDeviceInfoStruct
struct TDeviceInfo{
 	char PortName[260]; 
};
#endif
//---------------------------------------------------------------------------
#ifndef _BIORADIO_150_DLL_H_
#define _BIORADIO_150_DLL_H_
#include "BioRadioConfig.h"
//---------------------------------------------------------------------------
extern "C" __declspec(dllimport) bool _stdcall FindDevices(TDeviceInfo *DeviceList, int *DeviceCount, int MaxCount, TUpdateStatusEvent UpdateStatusProc);
extern "C" __declspec(dllimport) bool _stdcall FindDevicesSimple(char *DevicePortNameList[], int *DeviceCount, int MaxDeviceCount, int PortNameStrLen);
extern "C" __declspec(dllimport) unsigned int _stdcall CreateBioRadio(bool useBaseStation);
extern "C" __declspec(dllimport) int _stdcall DestroyBioRadio(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall StartCommunication(unsigned int BioRadio150 , char *PortName);
extern "C" __declspec(dllimport) int _stdcall StartAcq(unsigned int BioRadio150, char DisplayProgressDialog);
extern "C" __declspec(dllimport) int _stdcall StopAcq(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall DisableBuffering(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall EnableBuffering(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall StopCommunication(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall LoadConfig(unsigned int BioRadio150, char *Filename);
extern "C" __declspec(dllimport) int _stdcall SaveConfig(unsigned int BioRadio150, char *Filename);
extern "C" __declspec(dllimport) int _stdcall PingConfig(unsigned int BioRadio150, char DisplayProgressDialog);
extern "C" __declspec(dllimport) int _stdcall GetConfig(unsigned int BioRadio150, TBioRadioConfig *ConfigStruct, char PingDevice, char DisplayProgressDialog);
extern "C" __declspec(dllimport) int _stdcall ProgramConfig(unsigned int BioRadio150, char DisplayProgressDialog, const char *Filename);
extern "C" __declspec(dllimport) int _stdcall SetConfig(unsigned int BioRadio150, TBioRadioConfig *ConfigStruct, char ProgramDevice, char DisplayProgressDialog);
extern "C" __declspec(dllimport) long _stdcall GetSampleRate(unsigned int BioRadio150);
extern "C" __declspec(dllimport) long _stdcall GetBitResolution(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetFastSweepsPerPacket(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetSlowSweepsPerPacket(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetNumEnabledInputs(unsigned int BioRadio150, int *FastMainInputs, int *FastAuxInputs, int *SlowAuxInputs);
extern "C" __declspec(dllimport) int _stdcall GetNumEnabledSlowInputs(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetNumEnabledFastInputs(unsigned int BioRadio150);
extern "C" __declspec(dllimport) long _stdcall GetMode(unsigned int BioRadio150, unsigned short &Mode);
extern "C" __declspec(dllimport) long _stdcall GetNumChannels(unsigned int BioRadio150);
extern "C" __declspec(dllimport) unsigned short _stdcall GetEnabledFastInputs(unsigned int BioRadio150);
extern "C" __declspec(dllimport) char _stdcall GetEnabledSlowInputs(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall TransferBuffer(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall ReadScaledData(unsigned int BioRadio150, double *Data, int Size, int *NumRead);
extern "C" __declspec(dllimport) int _stdcall ReadRawData(unsigned int BioRadio150, unsigned short *Data, int Size, int *NumRead);
extern "C" __declspec(dllimport) int _stdcall ReadScaledFastAndSlowData(unsigned int BioRadio150, double *FastInputsData, int FastInputsSize, int *FastInputsNumRead, unsigned short *SlowInputsData, int SlowInputsSize, int *SlowInputsNumRead);
extern "C" __declspec(dllimport) int _stdcall ReadRawFastAndSlowData(unsigned int BioRadio150, unsigned short *FastInputsData, int FastInputsSize, int *FastInputsNumRead, unsigned short *SlowInputsData, int SlowInputsSize, int *SlowInputsNumRead);
extern "C" __declspec(dllimport) int _stdcall SetBadDataValues(unsigned int BioRadio150, double BadDataValueScaled, unsigned short BadDataValueRaw);
extern "C" __declspec(dllimport) int _stdcall SetPadWait(unsigned int BioRadio150, int numMissingPackets);
extern "C" __declspec(dllimport) int _stdcall GetRFChannel(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall SetRFChannel(unsigned int BioRadio150, int RFChannel);
extern "C" __declspec(dllimport) int _stdcall GetUsableRFChannelList(int *UsableRFChannelList, int Size);
extern "C" __declspec(dllimport) int _stdcall GetFreqHoppingMode(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetFreqHoppingModeIndicator();
extern "C" __declspec(dllimport) int _stdcall SetFreqHoppingMode(unsigned int BioRadio150, bool HoppingEnabled);
extern "C" __declspec(dllimport) unsigned int _stdcall GetGoodPackets(unsigned int BioRadio150);
extern "C" __declspec(dllimport) unsigned int _stdcall GetBadPackets(unsigned int BioRadio150);
extern "C" __declspec(dllimport) unsigned int _stdcall GetDroppedPackets(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetUpRSSI(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetDownRSSI(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetLinkBufferSize(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetBitErrCount(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetBitErrRate(unsigned int BioRadio150);
extern "C" __declspec(dllimport) double _stdcall GetBatteryStatus(unsigned int BioRadio150);
extern "C" __declspec(dllimport) int _stdcall GetBioRadioModelString(unsigned int BioRadio150, char *BioRadioModelString, int StrLength);
extern "C" __declspec(dllimport) int _stdcall GetDeviceID(unsigned int BioRadio150, unsigned short *DeviceID);
extern "C" __declspec(dllimport) int _stdcall GetDeviceIDString(unsigned int BioRadio150, char *DeviceIDCStr, int StrLength);
extern "C" __declspec(dllimport) int _stdcall GetFirmwareVersionString(unsigned int BioRadio150, char *VersionString, int StrLength);
extern "C" __declspec(dllimport) void _stdcall GetDLLVersionString(char *VersionString, int StrLength);
//---------------------------------------------------------------------------
#endif 
