//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
//500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
5::second => saveme.duration;

//start recording 
1 => saveme.record;

//hang out 
5::second => now;

//stop recording 
0 => saveme.record;



0::ms => saveme.playPos;


//also tell it where the loop endpoint is 
1::second => saveme.loopStart;
4::second => saveme.loopEnd;

//tell it to loop through what we've sampled 
1 => saveme.loop;
