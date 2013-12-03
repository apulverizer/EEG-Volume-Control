function [bioRadioHandle] = connectBioRadio(pathToDllDirectory,pathToConfigFile,portName)

    % Load the library
    %bioRadioHandle = BioRadio150_Load(pathToDllDirectory,1);
    bioRadioHandle = BioRadio150_Load(pathToDllDirectory,0); % FOR NEW DLLS

    % Start Communication and Program the Device
    BioRadio150_Start(bioRadioHandle, portName, 1, pathToConfigFile);

    display('BioRadio Connected!')


