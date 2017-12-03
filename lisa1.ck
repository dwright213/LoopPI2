//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
//500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
3::second => saveme.duration;

//start recording 
1 => saveme.record;

//hang out 
3::second => now;

//stop recording 
0 => saveme.record;




//also tell it where the loop endpoint is 
0::second => saveme.loopStart;
3::second => saveme.loopEnd;

//tell it to loop through what we've sampled 
1 => saveme.loop;

1 => saveme.play;

3::second => now;

0 => saveme.play;


