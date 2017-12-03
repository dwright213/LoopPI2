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
      20::second => now;
