//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
//500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
5::second => saveme.duration;

//start recording 
1 => saveme.record;

//hang out 
1::second => now;

//stop recording 
0 => saveme.record;



//Yippee, we've recorded 1 second of something wave into a buffer. Now let's play it back:
1 => saveme.play;

1::second => now;

// Let's say you don't want it to click:

//gotta go back to the beginning 
0::ms => saveme.playPos

50::ms => saveme.rampUp;

950::ms => now;

50::ms => saveme.rampDown;

50::ms => now;

// Let's say you want to transpose it:

//gotta go back to the beginning, again! 
0::ms => saveme.playPos

50::ms => saveme.rampUp;

2 => saveme.rate;

950::ms => now;

50::ms => saveme.rampDown;

50::ms => now;

