//a simple signal path
adc => LiSa saveme => dac;

//give the oscillator a frequency 
//500 => sin.freq;

//gotta tell LiSa how much memory to allocate 
3::second => saveme.duration;

//start recording 
true => saveme.record;

//hang out 
3::second => now;

//stop recording 
false => saveme.record;



//also tell it where the loop endpoint is 
0::second => saveme.loopStart;
3::second => saveme.loopEnd;

//tell it to loop through what we've sampled 
true => saveme.loop;


loopitnow(3)

//loopitnow(1);
fun void loopitnow(int length)	{

	<<< "in our 'loop' function." >>>;

	while (true)	{
		<<< "This can be useful for looping audio indefinitely." >>>;
		true => saveme.play;

		length::second => now;

		false => saveme.play;
	}



  
}
