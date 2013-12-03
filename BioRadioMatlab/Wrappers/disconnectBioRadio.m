function disconnectBioRadio(bioRadioHandle)

   % Stop Communication
   BioRadio150_Stop(bioRadioHandle);
   
   % Remove BioRadio Info. from MATLAB memory
   BioRadio150_Unload(bioRadioHandle);