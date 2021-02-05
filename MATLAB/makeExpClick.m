function [sound,Fs] = makeExpClick(n,carrier,varargin)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
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
    
    if n>0 
        p = @(x) (x-100)/10;
        f = @(x) exp(-(p(x)^n));
    else
        f = @(x) exp(-x/50);
    end
    [sound,Fs] = makeClick(f,200,carrier,duration,interval,rate);
    
    scale = max(abs(sound));
    sound = sound ./ scale;
end

