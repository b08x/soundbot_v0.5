/*
 This Processing program converts from the MusicXML file to the Sonic Pi code.
 Programmed by Hiroshi TACHIBANA, 2016.8, CC-BY Modified by Robin Newman Aug 2016
 
 NB SET INPUT MUSICXML FILE NAME IN LINE 77
 AND pn value IN LINE 78 before running the script
 ALSO ADJUST GRACE NOTE RATIO IN LINE 79 gn =1.0/16, or 1.0/8,....1,0/5 if required for each part
 THE MUSICXML FILE(S) SHOULD BE PLACED IN THE SCRIPT DATA FOLDER

 A part one of the top score is converted.
  Please set the MusicXML file name to the line 77.
  data0=loadStrings("???.xml");
 Sonic Pi code is printed out to the standard output. (n the black window below this one)
 Output files "data??.txt" are generated and used by the script internally.
 Grace note is 1/16 beat. (adjustable)
 Chords are available.
 Ties are available.
 Chords with ties are unavailable.
 
 RBN has translated comments from Japanses to English using Google Earth. Some may be helpful. "Thailand" should perhaps be "tie type"
 other mods: increase array sizes used in temp data files  and tieS and tieN arrays to accommodate longer files
 add suffix number (variable pn set manually in line xx to give different variable names for different part runs
 add sustain: and release: settings to output code to give 90% sustained notes
 
 For multi-runs accommodating different parts the code produced for each part can be concatenated to give
 one longer file. This will run "as is" You can add use_synth settings as desired
*/


// (notes from the original script used to process the Spring of Sea piece)
// If the spring of sea, shakuhachi of xml, koto of the right hand of xml, to convert the 3 files of the harp of the left hand of the xml export separately.
// Left hand right hand, select and delete the only specific voice, to create from the rest. (1 and may exchange of 2 is also use of voice)
// Note: part to two, speed specification is not.
// Note in MuseScore: If you created a Parts is, even if there is a speed sign at the beginning of the part, the location does not have a note (or rest) in the same position of the part marks side, Parts side because it is not taken over, there is a need to add a speed sign in the part marks side.
// Thailand in the code is not allowed without corresponding

/* Sonic Pi at use_bpm and a, and b in the following manner, to run concurrently in the thread in every part
 in_thread do
 use_bpm 60
 a=[ ]
 b=[ ]
 i=0
 a.length.times do
 play a[i]
 sleep b[i]
 i=i+1
 end
*/



String[] XMLtag1= {
  "part", "divisions"
};//, "score-part","part-list", "part-name"};
String[] XMLtag2= {
  "per-minute", "measure", "<note", "rest", "step", "alter", "octave", "duration", "tie type", "grace", "chord", "arpeggiate", "voice"
};
String[] data0=new String[900000];
String[] data1= {}, data2= {}, data3= {};
String[][] data4=new String[9][20000];
String[][] data5=new String[9][20000];
String[][] data6=new String[9][20000];
String[][] data7=new String[9][20000];
String[][] data7c=new String[9][20000];
int[] partStartLine=new int[9], partEndLine=new int[9], partLength=new int[9]; // position of the data for each part
int[] partLength5=new int[9]; 
float[] partDivisions=new float[9]; // speed of each part division value
int Npart;

void setup() {
  readData();
  //  readData2();
  //  readData3();
}

void readData() {
    data0=loadStrings("Test_for_Sonic_Pi-Piano-1.xml");  // <<<<<<<<<<<<<< INPUT Music XML file <<<<<<<<<<<
    int pn=2; //<<<<<<<<<<<<<< set part suffix number here <<<<<<<<<<<
    float gn = 1.0/2; //<<<<<<<<<<<<<<<<<<< set grace note fraction eg 1.0/16, 1.0/8,.....1.0/2  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  //  println("overall structure");
  for (int i=0; i<data0.length; i++) {
    for (int j=0; j<XMLtag1.length; j++) {       if (data0[i].indexOf(XMLtag1[j])>=0) {
         //      println(data0[i]);
        data1=(String[])append(data1, trim(data0[i]));
      }
    }
  }
  saveStrings("data1.txt", data1); //       SAVE1

  //  println("the entire structure - up to here");
  for (int i=0; i<data0.length; i++) {
    data0[i]=trim(data0[i]);  // the beginning of removing the blank
  }
  for (int i=0; i<data0.length; i++) {
    for (int j=0; j<XMLtag2.length; j++) {       if (data0[i].indexOf(XMLtag2[j])>=0) {
        // println(data0[i]);
        data2=(String[])append(data2, data0[i]);
      }
    }
  }
  saveStrings("data2.txt", data2);  //          SAVE2
  for (int i=0; i<data0.length; i++) {
    for (int j=0; j<XMLtag1.length; j++) if (data0[i].indexOf(XMLtag1[j])>=0) data3=(String[])append(data3, data0[i]);
    for (int j=0; j<XMLtag2.length; j++) if (data0[i].indexOf(XMLtag2[j])>=0) data3=(String[])append(data3, data0[i]);
  }
  saveStrings("data3.txt", data3); //           SAVE3
  //  println(data0.length); // whole
  //  println(data1.length); // header
  //  println(data2.length); // music part
  //  println(data3.length); // header + music part
  Npart=0;
  for (int i=0; i<data1.length; i++) {
    if (data1[i].indexOf("=0) Npart++;
  }
  //println("パート数: "+Npart);
  int j=0;
  for (int i=0; i<data3.length; i++) {
    if (data3[i].indexOf("=0) {
      partStartLine[j++]=i; // int(data3[i].substring(11, 12));
      //      println(data3[i].substring(11, 12)+" "+i);
    }
  }
  for (int i=0; i<Npart-1; i++) partEndLine[i]=partStartLine[i+1]-1;
  partEndLine[Npart-1]=data3.length;
  //for (int i=0; i<Npart; i++) println("Part Line"+(i+1)+": "+partStartLine[i]+" "+partEndLine[i]);
  for (j=0; j<Npart; j++) {
    int k=0;
    for (int i=partStartLine[j]; i<partEndLine[j]; i++) {
      if (data3[i].indexOf("")>=0) {
        data4[j][k++]="divisions "+data3[i].substring(data3[i].indexOf("")+11, data3[i].indexOf(""));
        partDivisions[j]=float(data3[i].substring(data3[i].indexOf("")+11, data3[i].indexOf("")));
      }
      if (data3[i].indexOf("")>=0) data4[j][k++]="per-minute "+data3[i].substring(data3[i].indexOf("")+12, data3[i].indexOf(""));
      if (data3[i].indexOf("")>=0) data4[j][k++]="r";
      if (data3[i].indexOf("<grace")>=0) data4[j][k++]="grace";
      if (data3[i].indexOf("")>=0) data4[j][k++]="step "+data3[i].substring(data3[i].indexOf("")+6, data3[i].indexOf(""));
      if (data3[i].indexOf("")>=0) data4[j][k++]="alter "+data3[i].substring(data3[i].indexOf("")+7, data3[i].indexOf(""));
      if (data3[i].indexOf("")>=0) data4[j][k++]="octave "+data3[i].substring(data3[i].indexOf("")+8, data3[i].indexOf(""));
      if (data3[i].indexOf("")>=0) data4[j][k++]="duration "+data3[i].substring(data3[i].indexOf("")+10, data3[i].indexOf(""));
      if (data3[i].indexOf("=0) data4[j][k++]="tie start";
      if (data3[i].indexOf("=0) data4[j][k++]="tie stop";
      if (data3[i].indexOf("")>=0) data4[j][k++]="chord"; // previous step
      if (data3[i].indexOf("")>=0) data4[j][k++]="voice "+data3[i].substring(7, 8); // If there is a voice
    }
    partLength[j]=k;
  }
  for (j=0; j<Npart; j++) saveStrings("data4"+j+".txt", data4[j]); //     SAVE4

  for (j=0; j<Npart; j++) {
    //println("########## PART= "+(j+1));
    int k=0;
    for (int i=0; i<partLength[j]; i++) {       if (data4[j][i].indexOf("chord")>=0) data5[j][k++]="chord"; // chord
      if (data4[j][i].indexOf("per-minute")>=0) data5[j][k++]="use_bpm "+data4[j][i].substring(11, data4[j][i].length()); // bps display
      if (data4[j][i].equals("r")) {  //Display of rest and time
        data5[j][k++]="play :r "+str(float(data4[j][i+1].substring(9, data4[j][i+1].length()))/partDivisions[j]);
        //        println(data5[j][k-1]);
      }
      if (data4[j][i].equals("grace")) {
        data5[j][k++]="grace";  // octave is not attached to the note at the back of the grace.
      }
      if (data4[j][i].indexOf("step")>=0) {
        data5[j][k++]="play :"+data4[j][i].substring(5, 6); // Display notes when step there is

        if (data4[j][i+1].indexOf("alter")>=0) {// step there is a alter to the next line in the case of ♯ ♭
          if (data4[j][i+1].substring(6, data4[j][i+1].length()).equals("1")) data5[j][k-1]+="s";  // in the case of sharp
          else if (data4[j][i+1].substring(6, data4[j][i+1].length()).equals("-1")) data5[j][k-1]+="f";  // in the case of flat
          data5[j][k-1]+=data4[j][i+2].substring(7, data4[j][i+2].length());     // octave
          //            println(i+"："+j+"： "+data4[j][i+2]+"： "+data4[j][i+3]);
          if (data4[j][i+3].indexOf("duration")>=0) data5[j][k-1]+=" "+str(float(data4[j][i+3].substring(9, data4[j][i+3].length()))/partDivisions[j]); // length
        } else if (data4[j][i+1].indexOf("octave")>=0 & data4[j][i+2].indexOf("duration")>=0) {// step If the line is not a there is octave ♯ ♭
          data5[j][k-1]+=data4[j][i+1].substring(7, data4[j][i+1].length());  // octave not appear at the time of grace? ? ? ? ?
          //            println("$$$$$"+data4[j][i+2]);
          if (data4[j][i+2].indexOf("duration")>=0) data5[j][k-1]+=" "+str(float(data4[j][i+2].substring(9, data4[j][i+2].length()))/partDivisions[j]); // length
        } else  if (data4[j][i+1].indexOf("octave")>=0) {
          data5[j][k-1]+=data4[j][i+1].substring(7, data4[j][i+1].length()); // for when the octave grace
        }
      }
      if (data4[j][i].indexOf("tie")>=0) data5[j][k++]=data4[j][i];
    }
    saveStrings("data5"+j+".txt", data5[j]); //        SAVE5
    //    println("k="+k);
    partLength5[j]=k;
  }

  //  println(data5[0][100]);
  int[][] tieS=new int[9][2000], tieE=new int[9][2000];
  //String tmp;
  //  for (j=0; j<Npart; j++) {
  j=0;
  int k1=0, k2=0; // Thailand start, the number of end k1 and k2 is necessary equal
  for (int i=0; i<partLength5[j]; i++) {     //      tmp=data5[j][i];     if (data5[j][i].indexOf("tie start")>=0) {
      tieS[j][k1]=i;   // to record the start of the line of Thailand
      //println(k1+" tie start="+i);
      k1++;
    }
    if (data5[j][i].indexOf("tie stop")>=0) { 
      tieE[j][k2]=i; //  to record the end of the line of Thailand
      //println(k2+" tie stop="+i);
      k2++;
      if (tieS[j][k1-1] != tieE[j][k2-1]-2) println("#### warning there is a tie not a single note ###");
      if (k1 != k2) println("#### warning not fit to start and the number of the end of Thailand ###");
    }
  }
  //println("Thailand number ="+k1);

 // The length of the front of the line (start note of Thailand) of the tie start to the length of the entire Thailand.
 // Note of in Thailand of up to tie stop is left intact.
  float sum=0;
  j=0; // part (corresponding part is not used only by 0)
  for (int i=0; i<k1; i++) { // Thailand number minute of the loop
    //println("tie= "+(tieS[j][i]+1)+" 〜 "+tieE[j][i]);
    int nseq=0; // number of consecutive Thailand
    for (int iseq=i; iseq<k1-1; iseq++) {
      if ( tieE[j][iseq] != tieS[j][iseq+1]-1) break;
      else nseq++;
    }
    //println("consolidated the number of Thailand nseq =" +nseq);
    if (nseq==0) { // if Thailand is one
      String[] t1=splitTokens(data5[j][tieS[j][i]-1 ], " "); // front of Thailand. If Thailand is followed, the error becomes a tie stop
      String[] t2=splitTokens(data5[j][tieS[j][i]+1], " ");  // back side of Thailand
      //println(i+" "+j+" "+tieS[j][i]+" "+data5[j][tieS[j][i]-1]);
      data5[j][tieS[j][i]-1]=t1[0]+" "+t1[1]+" "+str(float(t1[2])+float(t2[2])); // three or more notes does not correspond to the tie linked
      //println("New data5:"+data5[j][tieS[j][i]-1]);
    } else { // If Thailand is linked
      //println("Thailand is consolidated i ="+i);
      String[] t1=splitTokens(data5[j][tieS[j][i]-1 ], " "); // front of Thailand
      String[] t2=splitTokens(data5[j][tieE[j][i]-1 ], " "); // back side of the first Thailand
      //println("t1="+t1[0]+" "+t1[1]+" "+t1[2]);
      //println("t2="+t2[0]+" "+t2[1]+" "+t2[2]);
      sum=float(t1[2])+float(t2[2]); // the sum of the note of the length of the at until the first one in Thailand
      // println("sum="+sum);
      for (int iseq=0; iseq<nseq; iseq++) {
        String[] t3=splitTokens(data5[j][ tieE[j][i]+(iseq+1)*3-1 ], " ");  // back side of Thailand
        sum+=float(t3[2]);
      }
      data5[j][tieS[j][i]-1]=t1[0]+" "+t1[1]+" "+str(sum); // to Thailand three or more notes have been consolidated It does not correspond
      i+=nseq;
    }
  }

  // Add time 0.0625 to the note of the line of the back of the grace (when gn = 1.0/16)
  // If the grace continues, as well as adding a time 0.0625 to the note of the end of the line
  // Draw the length of the grace amount from the notes of the two after the last grace.
  j=0;
  for (int i=0; i<partLength5[j]; i++) {     //    println("i="+i+" "+partLength5[j]);     int NNgrace=0;     //    println("data5[j][i]="+data5[j][i]);     if (data5[j][i].indexOf("grace")>=0) { // the current position is grace whether
      data5[j][i+1]+=" "+str(gn);// grace gives the length of the note 0.125 = 32 minutes note set by gn variable
      NNgrace=1;
      while (data5[j][i+NNgrace*2].indexOf("grace")>=0) {//the current position is grace whether
        data5[j][i+NNgrace*2+1]+=str(gn);//  grace gives the length of the note as set by gn
        NNgrace++;
      }
      //      println("NNgrace="+NNgrace);
      //      println(data5[j][i+NNgrace*2]);
      String[] t1=splitTokens(data5[j][i+NNgrace*2], " ");
      data5[j][i+NNgrace*2]=t1[0]+" "+t1[1]+" "+str(float(t1[2])-NNgrace*gn);// pull the length of the grace worth from notes behind
      i+=NNgrace*2+2;
    }
  }
  saveStrings("data6"+j+".txt", data5[j]);

 // Remove the from the tie start to tie stop
 // Remove only the rows of the grace
  j=0;
  int k=0;
  for (int i=0; i<partLength5[j]; i++) {     data6[j][k]=data5[j][i];     //    int tie_s;     int tieLines=0;     if (data5[j][i].indexOf("tie start")>=0) {
      //      println("tie start "+i+" "+data5[j][i]);
      //      tie_s=i;
      while (data5[j][i+tieLines].indexOf("tie stop")<0) {
        tieLines++;
      }
      //      println("tieLines="+tieLines);
      //      println("tie stop "+(i+tieLines)+" "+data5[j][i+tieLines]);
      k--;
    }
    i+=tieLines;
    k++;
  }

  int k3=0;
  for (int i=0; i<k; i++) {
    if (data6[j][i].indexOf("grace")<0) { // to delete rows of grace
      data7[j][k3]=data6[j][i];
      k3++;
    }
  }

  int kc=0; // Of new notation array element
  String tmpTime="";
  for (int i=0; i<k3; i++) {     String tmpC=data7[j][i];     if (data7[j][i].indexOf("chord")>=0) { // when chord (2 sound eye)
      int ic=1; // when the two sound code = 1
      while ((i+ic*2)=0) { // count the number of notes of a chord. (3 sound more)
        //        println(i+" "+ic+" "+data7[j][i+ic*2]);  // last error in the case of a chord
        ic++;
      }
      tmpC="play ["; // case of the code, the head of the notation is, "["
      for (int ic2=0; ic2<ic+1; ic2++) {
        String[] t1=splitTokens(data7[j][i-1+ic2*2], " ");
        tmpC+=t1[1]+","; // extract the notation of chord
        tmpTime=t1[2]; // length of the chord
      }
      tmpC=tmpC.substring(0, tmpC.length()-1)+"]"+" "+tmpTime; // of the end "," to remove the "]"
      //      println("tmpC="+tmpC);
      i+=ic*2; // promote the original array only chord minute
      data7c[j][kc-1]=tmpC;  // put the chord to the sequence of the new notation
      data7c[j][kc]=data7[j][i];
    } else data7c[j][kc]=tmpC; // if not a chord, put the original notation into a new array.
    kc++;
  }
  //  for (int i=0; i<kc; i++) println("data7c= "+data7c[j][i]);

  //  println("============data7=======");
  //  for (int i=0; i<partLength5[j]; i++) println(data7c[j][i]);
  int len7=0;
  for (int i=0; i<partLength5[j]; i++) if (data7c[j][i] != null) len7++;
  //  println("data7_len="+len7);
  String[] data8;
  data8=new String[len7];  // make data8 of the sequence of the data length from data7.
  for (int i=0; i<len7; i++) data8[i]=data7c[j][i]; // from data8 deals with only part 1
  saveStrings("data8"+j+".txt", data8); //                      SAVE8
  //  println("============data8=======");
  //  for (int i=0; i<data8.length; i++) println(data8[i]);

  println("#=========== Sonic Pi program ================================");
  //  String data9[] =new String[len7];
  String tmpS1;
  String tmpS2;
  String tmpS3="c"+pn+"=[";  // insert pn to distinguish runs of script for different parts
  int ibpm=0;
  println("a"+pn+"=[]"); // add pn
  println("b"+pn+"=[]"); // add pn
  for (int i=0; i<data8.length; i++) {     // Every use_bpm put a note in the array     //int playLines=0;     tmpS1="a"+pn+"["+ibpm+"]=["; // add pn     tmpS2="b"+pn+"["+ibpm+"]=["; // add pn     if (data8[i].indexOf("use_bpm")>=0) {
      //      println(data8[i]);
      tmpS3+=data8[i].substring(8, data8[i].length())+",";
      if (i==0)i++;
    }
    while (i=0) {
      tmpS3+=data8[i].substring(8, data8[i].length())+",";
      ibpm++;
    }
  }
  tmpS3=tmpS3.substring(0, tmpS3.length()-1)+"]";
  if(!tmpS3.equals("c"+pn+"=]")) println(tmpS3);
  println("in_thread do");
  //  println("i=0");
  println("for i in 0..a"+pn+".length-1");
  if(!tmpS3.equals("c"+pn+"=]")) println("use_bpm c"+pn+"[i]");
  //  println("j=0");
  println("for j in 0..a"+pn+"[i].length-1");
  println("play a"+pn+"[i][j],sustain: b"+pn+"[i][j]*0.9,release: b"+pn+"[i][j]*0.1");
  println("sleep b"+pn+"[i][j]");
  //  println("j+=1");
  println("end");
  //  println("i+=1");
  println("end");
  println("end");
}
