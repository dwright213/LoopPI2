//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
5::second => saveme.duration;

//start recording 
1 => saveme.record;

//hang out 
1::second => now;

//stop recording 
0 => saveme.record;



//Yippee, we've recorded 1 second of a sine wave into a buffer. Now let's play it back:
1 => saveme.play;

1::second => now;


