function SetMatlabVolume(volume,mute)
%Volume should be between 0 and 1, corresponding to what Windows calls 0 to 100%

if ~exist('volume','var')
    volume=1;
end;
if ~exist('mute','var')
    mute=false;
end;

sound(0); %just to make sure that everything is initialised: not sure if this is necessary

import javax.sound.sampled.*
mixerInfos = AudioSystem.getMixerInfo;

for mixerIdx = 1 : length(mixerInfos)
    % ports = AudioSystem.getMixer(mixerInfos(mixerIdx)).getTargetLineInfo;  % => not allowed in Matlab for some reason (bug)
    ports = getTargetLineInfo(AudioSystem.getMixer(mixerInfos(mixerIdx)));
    
    %clc
    %length(ports)
    
    for portIdx = 1 : length(ports)
        port = ports(portIdx);
        try
            portName = port.getName;  % better
        catch   %#ok
            portName = port.toString; % not optimal
        end
        %portName; %xxx
        if ~isempty(lower(char(portName)))
            %we have something!
            %pause; %xxx
            % Get and open the speaker port's Line object
            line = AudioSystem.getLine(port);
            try
                line.open(); %normally for uninteresting ports, this line crashes EXCEPT the first loop, the first time Matlab runs!?

                % Loop over all the Line's controls to find the Volume control
                % Note: we should have used ctrl=.getControl(FloatControl.Type.VOLUME) directly, as in http://forums.sun.com/thread.jspa?messageID=10736264#10736264
                % ^^^^  but unfortunately Matlab prevents using Java Interfaces and/or classnames containing a period
                ctrls = line.getControls;
                volumefoundFlag = 0;
                for ctrlIdx = 1 : length(ctrls)
                    ctrl = ctrls(ctrlIdx);
                    if ~isempty(strfind(lower(char(ctrls(ctrlIdx).getType)),'volume'))
                        volumefoundFlag = 1;
                        break;
                    end
                end
                mutefoundFlag = 0;
                for ctrlIdx = 1 : length(ctrls)
                    mutectrl = ctrls(ctrlIdx);
                    if ~isempty(strfind(lower(char(ctrls(ctrlIdx).getType)),'mute'))
                        mutefoundFlag = 1;
                        break;
                    end
                end
                if ~volumefoundFlag
                    %if you see this warning, see the comment about line.open above!
                    %warning('YMA:SoundVolume:noVolumeControl','Speaker volume control not found');
                else

                    % Get or set the volume value according to the user request
                    oldValue = ctrl.getValue;
                    if exist('volume','var')
                        ctrl.setValue(volume);
                    end
                    if nargout
                        volume = oldValue;
                    end
                end;
                if ~mutefoundFlag
                    %if you see this warning, see the comment about line.open above!
                    %warning('YMA:SoundVolume:noMuteControl','Mute volume control not found');
                else

                    % Get or set the volume value according to the user request
                    oldValue = mutectrl.getValue;
                    if exist('mute','var')
                        mutectrl.setValue(mute);
                    end
                    if nargout
                        mute = oldValue;
                    end
                end;
            catch
                %warning('Nope, it didn''t work')
            end;
        end
    end
    %pause;
end;