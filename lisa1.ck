//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
//500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
5::second => saveme.duration;

//start recording 
5 => saveme.record;

//hang out 
1::second => now;

//stop recording 
0 => saveme.record;



0::ms => saveme.playPos;

//tell it to loop through what we've sampled 
1 => saveme.loop;

//also tell it where the loop endpoint is 
4::second => saveme.loopEnd;

50::ms => saveme.rampUp;

2 => saveme.rate;

950::ms => now;

50::ms => saveme.rampDown;

50::ms => now;