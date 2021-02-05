function [audio,rate] = makeClick(law,envLength,carrierFreq,varargin)
%makeClick Summary of this function goes here
%   Creates a series of 'clicks' by modulating an underlying sine wave with
%   a user-provided envelope shape
%
%   Arguments:
%
%   law :             function handle that maps double -> double
%   envLength:        the length of the click envelope based on the 
%                     function law (zero padded at the end if needed)
%   carrierFrequency: the frequency (in Hz) of the underlying sine wave
%   optionals...

    rate=44100;
    interval=0.5;
    duration=1;
    
    l=length(varargin);
    if l>=3
        rate=varargin{3};
    end
    if l>=2
        interval=varargin{2};
    end
    if l>=1
        duration=varargin{1};
    end
        
    envelope = arrayfun(law,1:envLength);
    sigLen = rate*duration;
    phase = carrierFreq*2*pi/rate;
    sigfun = @(t) sin(t*phase);
    signal = arrayfun(sigfun,1:sigLen);
    
    period = floor(interval*rate);
    env = zeros(1,period);
    env(1:envLength)=envelope;
    
    audio = zeros(1,sigLen);
    points = 1:period:sigLen;
    for point = points
        chunk = point:(point+period-1);
        audio(chunk)=env .* signal(chunk);
    end
    
end

