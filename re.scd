(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=4;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*64;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
s.recChannels = 4;
s.boot;
)


Buffer.freeAll
(
//~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/sakelariou2.wav",channels:0 );
//~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/sakelariou2.wav",channels:1 );
~c1 = Buffer.readChannel(s,"/Users/amimid/Desktop/1.wav",channels:0 );
//~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/444444.wav",channels:1 );
)

////speaker setup
(
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);

(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		13.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(14,(azx.degrad),(elx.degrad))).x.round(0.000000001);

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(14,(azy.degrad),(ely.degrad))).y.round(0.000000001);

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(14,(azz.degrad),(elz.degrad))).z.round(0.000000001);

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))).phi.round(0.00001);

	};

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad)));

	 mag_x=((Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));


};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));
	///Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_y=((Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));
///Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

if(
m_z.even,
mag_z=(Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread),
mag_z=(Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
	);
////z axis   ambi..  sin for odd numbers, cos for even

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
{
var nn=1.neg;
~array=156.collect{nn=nn+1
}}.value;
~array=~array.scramble;
);
)



(
SynthDef.new(\o_reverb, {
    var in1,in2,in3,in4,chaina,chainb,chainc,chaind,b=0;
	var chainxx,chainyy,pl=0,amp,magg,lfo,per;
	var chainaa,chainbb,chaincc,chaindd,chainee,chainff;
	var ph,frames=512,sig1,sig2,sig3,sig4,spread=1;
	var delay,decay,sph,mod_angle,mod_angle1,m=3,mq=2;
	var magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;

     in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:0);
	//in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:0);
	// in3 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum), loop: 0, doneAction:0);
	// in4 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum), loop: 0, doneAction:0);
	/* in1 = SoundIn.ar(0);in2 = SoundIn.ar(1);
	 in3 = SoundIn.ar(2) in4 = SoundIn.ar(3);*/

	chaina = FFT(LocalBuf(frames), in1);
	//chainb = FFT(LocalBuf(frames), in2);
	//chainc = FFT(LocalBuf(frames), in3);chaind = FFT(LocalBuf(frames), in4);

	lfo=MouseX.kr(0.1,100);
	mod_angle=SinOsc.ar(lfo,0.degrad).range(90.neg.degrad,90.degrad);
	mod_angle1=SinOsc.ar(lfo,90.degrad).range(90.neg.degrad,90.degrad);

	156.do{

		sph=Spherical(1,~az.[~array.[pl]],~el.[~array.[pl]]);
		(
		magx=((Complex(cos(((sph.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magy=((Complex(sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magz=((Complex(cos(((sph.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

magqx=((((Complex(cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi)),
cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

 magqy=((((Complex(sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi)),
sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

				mag_x=magx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);

magg=(Cartesian(mag_x,mag_y,mag_z).rho/2.sqrt)+(Cartesian(mag_qx,mag_qy,0).rho/2.sqrt);
		per=Spherical(360.degrad,sph.theta,sph.phi);
			ph=(per.x+per.y+per.z).wrap(2pi.neg,2pi);

chainaa = chaina.pvcollect(frames, {|mag, phase, index| [mag*magg, phase+ph]; }, frombin: b, tobin: b, zeroothers: 1);
//chainbb = chainb.pvcollect(frames, {|mag, phase, index| [mag, phase+ph]; }, frombin: b, tobin: b, zeroothers: 1);
//chaincc = chainc.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
//chaindd = chaind.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
b=b+1;

		/////for use in case of simple mono inputs
/*chainaa = chaina.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainbb = chainb.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chaincc = chainc.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chaindd = chaind.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainee = chaine.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainff = chainf.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+phase1)).theta]; },
frombin: b, tobin: b, zeroothers: 1);*/

//delay=magg/100;
//decay=0.1;

//sig1=CombC.ar(IFFT(chainaa),maxdelaytime:1,delaytime:delay,decaytime:decay);///echo
//sig2=CombC.ar(IFFT(chainbb),maxdelaytime:1,delaytime:delay,decaytime:decay);
//sig1=Greyhole.ar(IFFT(chainaa),delayTime:delay,damp:0.1);
//sig2=Greyhole.ar(IFFT(chainbb),delayTime:delay,damp:0.1);
//sig3=CombC.ar(IFFT(chaincc),maxdelaytime:delay,delaytime:delay,decaytime:decay);
//sig4=CombC.ar(IFFT(chaindd),maxdelaytime:delay,delaytime:delay,decaytime:decay);

//Out.ar(0,LeakDC.ar(sig1));
//Out.ar(1,LeakDC.ar(sig2));
//Out.ar(2,LeakDC.ar(sig3));
//Out.ar(3,LeakDC.ar(sig4));

Out.ar(0,VBAP.ar(4,LeakDC.ar(IFFT(chainaa)),~b.bufnum,sph.theta.raddeg,sph.phi.raddeg));			//Out.ar(0,VBAP.ar(4,LeakDC.ar(IFFT(chainbb)),~b.bufnum,sph.theta.raddeg,sph.phi.raddeg));


//pl1=pl1+1;
	pl=pl+1;
	};
}).add;
)




(
Synth(\o_reverb);
s.record(numChannels:4,duration:(54+(4*60)));
)
