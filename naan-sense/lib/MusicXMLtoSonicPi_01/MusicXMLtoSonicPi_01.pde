/*
 This Processing program converts from the MusicXML file to the Sonic Pi code.
 Programmed by Hiroshi TACHIBANA, 2016.8, CC-BY

 A part one of the top score is converted.
  Please set the MusicXML file name to the line 64.
  data0=loadStrings("???.xml");
 Sonic Pi code is printed out to the standard output.
 Output files "data??.txt" are useless.
 Grace note is 1/16 beat.
 Chords are available.
 Ties are available.
 Chords with ties are unavailable. heyoa
*/



// 春の海の場合、尺八のxml、琴の右手のxml、琴の左手のxmlの３ファイルを書き出し別々に変換する。
//                      左手右手は、特定の声部だけを選択して削除し、残りから作成する。（声部の１と２の交換も使うとよい）
// 注意:   part 2には、速度指定はされない。
// MuseScoreでの注意：　パート譜を作成した場合には、先頭のパートに速度記号があっても、パート符側の同じ位置に音符(または休符)がない場所には、パート譜側に引き継がれないので、パート符側に速度記号を追加する必要がある。
// コードにタイは対応せず　不可

/* Sinic Piにて   use_bpmとa,bを下記のようにして、パート毎にスレッドにして並行実行する
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
String[][] data4=new String[9][9000];
String[][] data5=new String[9][9000];
String[][] data6=new String[9][9000];
String[][] data7=new String[9][9000];
String[][] data7c=new String[9][9000];
int[] partStartLine=new int[9], partEndLine=new int[9], partLength=new int[9]; //パート毎のデータの位置
int[] partLength5=new int[9]; 
float[] partDivisions=new float[9]; // パート毎の速度の分割値
int Npart;

void setup() {
  readData();
  //  readData2();
  //  readData3();
}

void readData() {
    data0=loadStrings("harunoumi_v2_2-Koto_Right.xml");  // <<<<<<<<<<<<<< INPUT Music XML file <<<<<<<<<<<

  //  println("全体の構成");
  for (int i=0; i<data0.length; i++) {
    for (int j=0; j<XMLtag1.length; j++) {
      if (data0[i].indexOf(XMLtag1[j])>=0) {
        //        println(data0[i]);
        data1=(String[])append(data1, trim(data0[i]));
      }
    }
  }
  saveStrings("data1.txt", data1); //       SAVE1

  //  println("全体の構成--ここまで");
  for (int i=0; i<data0.length; i++) {
    data0[i]=trim(data0[i]);  // 先頭の空白を取り除く
  }
  for (int i=0; i<data0.length; i++) {
    for (int j=0; j<XMLtag2.length; j++) {
      if (data0[i].indexOf(XMLtag2[j])>=0) {
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
  //  println(data0.length); // 全体
  //  println(data1.length); // ヘッダ
  //  println(data2.length); // 楽譜部分
  //  println(data3.length); // ヘッダ＋楽譜部分
  Npart=0;
  for (int i=0; i<data1.length; i++) {
    if (data1[i].indexOf("<score-part id=")>=0) Npart++;
  }
  //println("パート数: "+Npart);
  int j=0;
  for (int i=0; i<data3.length; i++) {
    if (data3[i].indexOf("<part id=")>=0) {
      partStartLine[j++]=i; // int(data3[i].substring(11, 12));
      //      println(data3[i].substring(11, 12)+" "+i);
    }
  }
  for (int i=0; i<Npart-1; i++) partEndLine[i]=partStartLine[i+1]-1;
  partEndLine[Npart-1]=data3.length;
  //for (int i=0; i<Npart; i++) println("パート行"+(i+1)+": "+partStartLine[i]+" "+partEndLine[i]);
  for (j=0; j<Npart; j++) {
    int k=0;
    for (int i=partStartLine[j]; i<partEndLine[j]; i++) {
      if (data3[i].indexOf("<divisions>")>=0) {
        data4[j][k++]="divisions "+data3[i].substring(data3[i].indexOf("<divisions>")+11, data3[i].indexOf("</divisions>"));
        partDivisions[j]=float(data3[i].substring(data3[i].indexOf("<divisions>")+11, data3[i].indexOf("</divisions>")));
      }
      if (data3[i].indexOf("<per-minute>")>=0) data4[j][k++]="per-minute "+data3[i].substring(data3[i].indexOf("<per-minute>")+12, data3[i].indexOf("</per-minute>"));
      if (data3[i].indexOf("<rest/>")>=0) data4[j][k++]="r";
      if (data3[i].indexOf("<grace")>=0) data4[j][k++]="grace";
      if (data3[i].indexOf("<step>")>=0) data4[j][k++]="step "+data3[i].substring(data3[i].indexOf("<step>")+6, data3[i].indexOf("</step>"));
      if (data3[i].indexOf("<alter>")>=0) data4[j][k++]="alter "+data3[i].substring(data3[i].indexOf("<alter>")+7, data3[i].indexOf("</alter>"));
      if (data3[i].indexOf("<octave>")>=0) data4[j][k++]="octave "+data3[i].substring(data3[i].indexOf("<octave>")+8, data3[i].indexOf("</octave>"));
      if (data3[i].indexOf("<duration>")>=0) data4[j][k++]="duration "+data3[i].substring(data3[i].indexOf("<duration>")+10, data3[i].indexOf("</duration>"));
      if (data3[i].indexOf("<tie type=\"start")>=0) data4[j][k++]="tie start";
      if (data3[i].indexOf("<tie type=\"stop")>=0) data4[j][k++]="tie stop";
      if (data3[i].indexOf("<chord/>")>=0) data4[j][k++]="chord"; // stepの前
      if (data3[i].indexOf("<voice>")>=0) data4[j][k++]="voice "+data3[i].substring(7, 8); // 　　　　　　声部がある場合
    }
    partLength[j]=k;
  }
  for (j=0; j<Npart; j++) saveStrings("data4"+j+".txt", data4[j]); //     SAVE4

  for (j=0; j<Npart; j++) {
    //println("########## PART= "+(j+1));
    int k=0;
    for (int i=0; i<partLength[j]; i++) {
      if (data4[j][i].indexOf("chord")>=0) data5[j][k++]="chord"; // chord
      if (data4[j][i].indexOf("per-minute")>=0) data5[j][k++]="use_bpm "+data4[j][i].substring(11, data4[j][i].length()); // bps表示
      if (data4[j][i].equals("r")) { // 休符と時間の表示
        data5[j][k++]="play :r "+str(float(data4[j][i+1].substring(9, data4[j][i+1].length()))/partDivisions[j]);
        //        println(data5[j][k-1]);
      }
      if (data4[j][i].equals("grace")) {
        data5[j][k++]="grace";  //  graceの後ろの音符にオクターブが付かない。
      }
      if (data4[j][i].indexOf("step")>=0) {
        data5[j][k++]="play :"+data4[j][i].substring(5, 6); // stepがあったときには音符表示

        if (data4[j][i+1].indexOf("alter")>=0) {// stepの次の行にalterがあり♯♭の場合
          if (data4[j][i+1].substring(6, data4[j][i+1].length()).equals("1")) data5[j][k-1]+="s";  // シャープ の場合
          else if (data4[j][i+1].substring(6, data4[j][i+1].length()).equals("-1")) data5[j][k-1]+="f";  // フラットの場合
          data5[j][k-1]+=data4[j][i+2].substring(7, data4[j][i+2].length());     // オクターブ
          //            println(i+"："+j+"： "+data4[j][i+2]+"： "+data4[j][i+3]);
          if (data4[j][i+3].indexOf("duration")>=0) data5[j][k-1]+=" "+str(float(data4[j][i+3].substring(9, data4[j][i+3].length()))/partDivisions[j]); // 長さ
        } else if (data4[j][i+1].indexOf("octave")>=0 & data4[j][i+2].indexOf("duration")>=0) {// stepの次の行にoctaveがあり♯♭でない場合
          data5[j][k-1]+=data4[j][i+1].substring(7, data4[j][i+1].length()); // オクターブ        graceのときに表示されない？？？？？
          //            println("$$$$$"+data4[j][i+2]);
          if (data4[j][i+2].indexOf("duration")>=0) data5[j][k-1]+=" "+str(float(data4[j][i+2].substring(9, data4[j][i+2].length()))/partDivisions[j]); // 長さ
        } else  if (data4[j][i+1].indexOf("octave")>=0) {
          data5[j][k-1]+=data4[j][i+1].substring(7, data4[j][i+1].length()); // オクターブ        graceのとき用
        }
      }
      if (data4[j][i].indexOf("tie")>=0) data5[j][k++]=data4[j][i];
    }
    saveStrings("data5"+j+".txt", data5[j]); //        SAVE5
    //    println("k="+k);
    partLength5[j]=k;
  }

  //  println(data5[0][100]);
  int[][] tieS=new int[9][99], tieE=new int[9][99];
  String tmp;
  //  for (j=0; j<Npart; j++) {
  j=0;
  int k1=0, k2=0; // タイstart,endの個数.　k1とk2は等しい必要あり
  for (int i=0; i<partLength5[j]; i++) {
    //      tmp=data5[j][i];
    if (data5[j][i].indexOf("tie start")>=0) {
      tieS[j][k1]=i;                           // タイの開始の行を記録する
      //println(k1+" tie start="+i);
      k1++;
    }
    if (data5[j][i].indexOf("tie stop")>=0) { 
      tieE[j][k2]=i;                           // タイの終了の行を記録する
      //println(k2+" tie stop="+i);
      k2++;
      if (tieS[j][k1-1] != tieE[j][k2-1]-2) println("#### 警告 単音でないタイがあり ###");
      if (k1 != k2) println("#### 警告 タイの開始と終了の数が合わない ###");
    }
  }
  //println("タイの個数="+k1);

  // tie startの前の行（タイのスタート音符）の長さをタイ全体の長さにする。
  // tie stopまでのタイの中の音符はそのまま残す。
  float sum=0;
  j=0; // パート (対応パートは0のみで使用せず)
  for (int i=0; i<k1; i++) { // タイの個数分のループ
    //println("tie= "+(tieS[j][i]+1)+" 〜 "+tieE[j][i]);
    int nseq=0; // 連続したタイの数
    for (int iseq=i; iseq<k1-1; iseq++) {
      if ( tieE[j][iseq] != tieS[j][iseq+1]-1) break;
      else nseq++;
    }
    //println("タイの連結数nseq=" +nseq);
    if (nseq==0) { // タイが一つの場合
      String[] t1=splitTokens(data5[j][tieS[j][i]-1 ], " "); // タイの前側．タイが続いた場合は、tie stopとなってしまいエラーする
      String[] t2=splitTokens(data5[j][tieS[j][i]+1], " ");  //　タイの後ろ側
      //println(i+" "+j+" "+tieS[j][i]+" "+data5[j][tieS[j][i]-1]);
      data5[j][tieS[j][i]-1]=t1[0]+" "+t1[1]+" "+str(float(t1[2])+float(t2[2])); // ３つ以上の音符が連結されたタイに対応していない
      //println("New data5:"+data5[j][tieS[j][i]-1]);
    } else { //タイが連結している場合
      //println("タイが連結 i="+i);
      String[] t1=splitTokens(data5[j][tieS[j][i]-1 ], " "); // タイの前側
      String[] t2=splitTokens(data5[j][tieE[j][i]-1 ], " "); //　最初のタイの後ろ側
      //println("t1="+t1[0]+" "+t1[1]+" "+t1[2]);
      //println("t2="+t2[0]+" "+t2[1]+" "+t2[2]);
      sum=float(t1[2])+float(t2[2]); // 一つ目のタイまででの音符の長さの和
      // println("sum="+sum);
      for (int iseq=0; iseq<nseq; iseq++) {
        String[] t3=splitTokens(data5[j][ tieE[j][i]+(iseq+1)*3-1 ], " ");  //　タイの後ろ側
        sum+=float(t3[2]);
      }
      data5[j][tieS[j][i]-1]=t1[0]+" "+t1[1]+" "+str(sum); // ３つ以上の音符が連結されたタイに対応していない
      i+=nseq;
    }
  }

  //  graceの後ろの行の音符に時間 0.0625を加える
  //  graceが続く場合には、同様に    後ろの行の音符に時間 0.0625を加える
  //  最後のgraceの２つ後ろの音符からgrace分の長さを引く。
  j=0;
  for (int i=0; i<partLength5[j]; i++) {
    //    println("i="+i+" "+partLength5[j]);
    int NNgrace=0;
    //    println("data5[j][i]="+data5[j][i]);
    if (data5[j][i].indexOf("grace")>=0) { // 現在位置がgraceかどうか調べる
      data5[j][i+1]+=" 0.0625";//125"; // grace noteの長さを与える　0.125 = 32分音符
      NNgrace=1;
      while (data5[j][i+NNgrace*2].indexOf("grace")>=0) {//graceが続いているかどうか調べる
        data5[j][i+NNgrace*2+1]+=" 0.0625";//125"; // grace noteの長さを与える　0.125 = 32分音符
        NNgrace++;
      }
      //      println("NNgrace="+NNgrace);
      //      println(data5[j][i+NNgrace*2]);
      String[] t1=splitTokens(data5[j][i+NNgrace*2], " ");
      data5[j][i+NNgrace*2]=t1[0]+" "+t1[1]+" "+str(float(t1[2])-NNgrace*0.0625);//0.125);// 後ろの音符からgrace分の長さを引く
      i+=NNgrace*2+2;
    }
  }
  saveStrings("data6"+j+".txt", data5[j]);

  // tie startからtie stopまでを削除する
  // grace の行のみを削除する
  j=0;
  int k=0;
  for (int i=0; i<partLength5[j]; i++) {
    data6[j][k]=data5[j][i];
    //    int tie_s;
    int tieLines=0;
    if (data5[j][i].indexOf("tie start")>=0) {
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
    if (data6[j][i].indexOf("grace")<0) {  // graceの行を削除する
      data7[j][k3]=data6[j][i];
      k3++;
    }
  }

  int kc=0;// 新しい音譜配列の要素
  String tmpTime="";
  for (int i=0; i<k3; i++) {
    String tmpC=data7[j][i];
    if (data7[j][i].indexOf("chord")>=0) { // 和音のとき(２音目)
      int ic=1; // ２音のコードのとき=１
      while ((i+ic*2)<k3 &&  data7[j][i+ic*2].indexOf("chord")>=0) { // 和音の音数を数える。（３音以上）
        //        println(i+" "+ic+" "+data7[j][i+ic*2]);  //    最後が和音の場合にエラーする
        ic++;
      }
      tmpC="play ["; // コードの場合、音譜の先頭は、"["
      for (int ic2=0; ic2<ic+1; ic2++) {
        String[] t1=splitTokens(data7[j][i-1+ic2*2], " ");
        tmpC+=t1[1]+","; // 和音の音譜を抽出
        tmpTime=t1[2]; // 和音の長さ
      }
      tmpC=tmpC.substring(0, tmpC.length()-1)+"]"+" "+tmpTime; // 末尾の","を削除し”]"を加える
      //      println("tmpC="+tmpC);
      i+=ic*2; // 元の配列を和音分だけ進める
      data7c[j][kc-1]=tmpC; // 新しい音譜の配列に和音を入れる
      data7c[j][kc]=data7[j][i];
    } else data7c[j][kc]=tmpC; // 和音でない場合に、元の音譜を新しい配列に入れる。
    kc++;
  }
  //  for (int i=0; i<kc; i++) println("data7c= "+data7c[j][i]);

  //  println("============data7=======");
  //  for (int i=0; i<partLength5[j]; i++) println(data7c[j][i]);
  int len7=0;
  for (int i=0; i<partLength5[j]; i++) if (data7c[j][i] != null) len7++;
  //  println("data7_len="+len7);
  String[] data8;
  data8=new String[len7]; // 　　　　　　　　data7からデータ長の配列のdata8を作る。
  for (int i=0; i<len7; i++) data8[i]=data7c[j][i];  // data８からは、パート１のみを扱う
  saveStrings("data8"+j+".txt", data8); //                      SAVE8
  //  println("============data8=======");
  //  for (int i=0; i<data8.length; i++) println(data8[i]);

  println("=========== Sonic Pi program ================================");
  //  String data9[] =new String[len7];
  String tmpS1;
  String tmpS2;
  String tmpS3="c=[";
  int ibpm=0;
  println("a=[]");
  println("b=[]");
  for (int i=0; i<data8.length; i++) {
    //  use_bpm毎に配列に音符を入れる
    int playLines=0;
    tmpS1="a["+ibpm+"]=[";
    tmpS2="b["+ibpm+"]=[";
    if (data8[i].indexOf("use_bpm")>=0) {
      //      println(data8[i]);
      tmpS3+=data8[i].substring(8, data8[i].length())+",";
      if (i==0)i++;
    }
    while (i<data8.length && data8[i].indexOf("use_bpm")<0 ) {
      //      playLines++;
      String[] t1=splitTokens(data8[i], " ");
      tmpS1+=t1[1]+",";
      tmpS2+=t1[2]+",";
      i=i+1;
    }
    tmpS1=tmpS1.substring(0, tmpS1.length()-1)+"]";
    tmpS2=tmpS2.substring(0, tmpS2.length()-1)+"]";
    println(tmpS1);
    println(tmpS2);
    if (i<data8.length && data8[i].indexOf("use_bpm")>=0) {
      tmpS3+=data8[i].substring(8, data8[i].length())+",";
      ibpm++;
    }
  }
  tmpS3=tmpS3.substring(0, tmpS3.length()-1)+"]";
  if(!tmpS3.equals("c=]")) println(tmpS3);
  println("in_thread do");
  //  println("i=0");
  println("for i in 0..a.length-1");
  if(!tmpS3.equals("c=]")) println("use_bpm c[i]");
  //  println("j=0");
  println("for j in 0..a[i].length-1");
  println("play a[i][j]");
  println("sleep b[i][j]");
  //  println("j+=1");
  println("end");
  //  println("i+=1");
  println("end");
  println("end");
}
