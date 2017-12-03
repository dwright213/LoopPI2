// water bill 
// 503 823 7770


//// connect sine oscillator to D/A convertor (sound card)
	SinOsc s => dac;

// in javascript (roughly):
//	var s = function() { 
/*		(code that generates sound)		*/
//		return sounds
//	},
//	dac.s = s;

// chuck people call this a patch. I guess it's like any 
//of the patch cables in a modular synth.

//// allow 2 seconds to pass
  //2::second => now;
   
// loops look like js
  //while ( true ) {
    //2::second => now;
  //}

// time-loop, in which the osc's frequency is changed every 100 ms
	while( true ) {
		100::ms => now;
		Std.rand2f(30.0, 1000.0) => s.freq;
	}
