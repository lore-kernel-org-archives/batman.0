Date: Wed, 23 Apr 2008 21:55:53 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Message-ID: <20080424035553.GA22613@apoderado.ometepe.net>
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<200804221601.57318.axel@open-mesh.net>
	<20080423000418.GA7368@apoderado.ometepe.net>
	<200804230954.37620.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <200804230954.37620.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2008 at 09:54:37AM +0200, Axel Neumann wrote:
[..snip..]=20
> > i'll make some more logs when .3.137 is back up
> ok.
there you go (to make the confusion complete, i named them=20
like before ;-) .
and something completely different: i think, .4.1 should choose the
direkt link to .4.162 instead of going through .4.160 (and vice versa)

cheers

  --Jan

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.1.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF wlan0:bmx 172.19.3.1, LinkWindowSize 50, Pat=
hWindSize 100, OGI 1000ms, currSeqno 4887, UT 13:10:24:11, CPU 43/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.3.160    wlan0:bmx     172.19.3.160  94 (  98 13:10:24:10 26708    0=
   5   6 ) [ wlan0:bmx  74  94  78] =20
172.19.3.130    wlan0:bmx     172.19.3.130  88 ( 100  1:11:50:46   525    0=
   3   5 ) [ wlan0:bmx  78  80  96] =20
172.19.3.128    wlan0:bmx     172.19.3.128  92 (  98  1:11:50:48 17407    0=
   4   8 ) [ wlan0:bmx  72  80  90] =20
172.19.3.131    wlan0:bmx     172.19.3.131  91 ( 100  0:21:34:38 33336    0=
   1   3 ) [ wlan0:bmx  80  94  84] =20
172.19.3.136    wlan0:bmx     172.19.3.131  87 ( 100  0:15:02:33 58460    0=
   3   2 ) [ wlan0:bmx  50  50 100] =20
172.19.3.133    wlan0:bmx     172.19.3.133  96 (  96  0:12:30:01 65198    0=
   1   9 ) [ wlan0:bmx  76  78  96] =20
172.19.3.135    wlan0:bmx     172.19.3.131  86 ( 100  0:07:15:27 14037    0=
   2   4 ) [ wlan0:bmx  40  36 100] =20
172.19.3.137    wlan0:bmx     172.19.3.160  83 (  91  0:01:03:44  3969    0=
   1   1 ) [ wlan0:bmx   0   4   0] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    wlan0:bmx     172.19.3.131  91 ( 100  0:21:34:38 33336    0=
 100 1004   8   1      7 )    172.19.3.136  60    172.19.3.135  46    172.1=
9.3.137   1=20
172.19.3.134    wlan0:bmx     172.19.3.131  74 (  88  0:06:44:35 47266    0=
 100 1013   0   2      1 )    172.19.3.135  46    172.19.3.136  51    172.1=
9.3.137   0=20
172.19.3.130    wlan0:bmx     172.19.3.130  88 ( 100  1:11:50:46   525    0=
 100 1021  14   1   3107 )    172.19.3.136  50    172.19.3.135  43    172.1=
9.3.128  77    172.19.3.137   1=20
172.19.3.133    wlan0:bmx     172.19.3.133  96 (  96  0:12:30:01 65198    0=
 100  995   5   1      1 )    172.19.3.135  38    172.19.3.136  52    172.1=
9.3.137   0=20
172.19.4.161    wlan0:bmx     172.19.3.160  86 (  93  0:15:03:22 31126    0=
 100 1003   0   2      1 )    172.19.3.135  40    172.19.3.137   2    172.1=
9.3.136  45    172.19.3.130   5=20
172.19.3.160    wlan0:bmx     172.19.3.160  94 (  98 13:10:24:10 26708    0=
 100  992  19   1     15 )    172.19.3.136  52    172.19.3.135  47    172.1=
9.3.137   0=20
172.19.4.160    wlan0:bmx     172.19.3.160  91 (  94  0:15:03:21    23    0=
 100 1000  25   2      1 )    172.19.3.136  50    172.19.3.135  38    172.1=
9.3.137   2=20
172.19.3.141    wlan0:bmx     172.19.3.128  87 (  92  0:15:02:35 17669    0=
 100 1043  14   2     99 )    172.19.3.136  47    172.19.3.130  73    172.1=
9.3.135  42    172.19.3.137   0=20
172.19.3.137    wlan0:bmx     172.19.3.160  83 (  91  0:01:03:44  3969    0=
 100  998   1   2      5 )    172.19.3.136  42    172.19.3.135  34    172.1=
9.3.137   1    172.19.3.128  12=20
172.19.4.162    wlan0:bmx     172.19.3.160  86 (  90  0:15:03:32 17134    0=
 100  978  10   3      1 )    172.19.3.136  46    172.19.3.135  34    172.1=
9.3.137   0=20
172.19.3.128    wlan0:bmx     172.19.3.128  92 (  98  1:11:50:48 17407    0=
 100  991  26   1    185 )    172.19.3.136  38    172.19.3.130  65    172.1=
9.3.135  29    172.19.3.137   2=20
172.19.4.165    wlan0:bmx     172.19.3.160  90 (  96  0:15:03:48 62168    0=
 100  982  19   2      1 )    172.19.3.136  50    172.19.3.135  42    172.1=
9.3.137   1=20
172.19.3.136    wlan0:bmx     172.19.3.131  87 ( 100  0:15:02:33 58460    0=
 100 1003  24   2    422 )    172.19.3.136  63    172.19.3.135  55    172.1=
9.3.137   0=20
172.19.3.135    wlan0:bmx     172.19.3.131  86 ( 100  0:07:15:27 14037    0=
 100 1014  33   3    252 )    172.19.3.135  68    172.19.3.136  64    172.1=
9.3.137   0    172.19.3.130   2    172.19.3.128   1=20
  14 known Originator(s), averages:         87 (  95                      0=
 100 1003  14   1    292 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.128.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF eth1:bmx 172.19.3.128, LinkWindowSize 50, Pa=
thWindSize 100, OGI 1000ms, currSeqno 17406, UT 6:08:28:30, CPU 26/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.3.130    eth1:bmx      172.19.3.130  88 ( 100  1:11:50:49   522    0=
   1   1 ) [  eth1:bmx  82  84  96] =20
172.19.3.1      eth1:bmx      172.19.3.130  71 ( 100  1:11:50:50  4882    0=
   8   4 ) [  eth1:bmx  78  94  82] =20
172.19.3.141    eth1:bmx      172.19.3.141  92 (  99  0:15:02:35 17666    0=
   1   2 ) [  eth1:bmx  88  92  94] =20
172.19.3.137    eth1:bmx        172.19.3.1  60 (  95  0:01:03:42  3966    0=
   2   3 ) [  eth1:bmx  24  44  54] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    eth1:bmx        172.19.3.1  72 (  91  0:21:34:38 33333    0=
 100  994  10   2    117 )    172.19.3.130  64    172.19.3.137  35=20
172.19.3.134    eth1:bmx        172.19.3.1  60 (  75  0:06:44:34 47263    0=
 100  971   0   3     60 )    172.19.3.137  30    172.19.3.130  51=20
172.19.3.130    eth1:bmx      172.19.3.130  88 ( 100  1:11:50:49   522    0=
 100 1031  14   1   1443 )      172.19.3.1  66    172.19.3.137  34=20
172.19.3.133    eth1:bmx        172.19.3.1  76 (  96  0:12:30:00 65195    1=
 100 1011   5   2     51 )    172.19.3.130  64    172.19.3.137  29=20
172.19.4.161    eth1:bmx        172.19.3.1  69 (  95  0:15:03:22 31123    0=
 100 1036   1   3     43 )    172.19.3.130  49    172.19.3.137  41=20
172.19.3.160    eth1:bmx        172.19.3.1  80 (  99  1:11:50:50 26705    0=
 100  979  19   2     79 )    172.19.3.130  68    172.19.3.137  34=20
172.19.4.160    eth1:bmx        172.19.3.1  71 (  95  0:15:03:21    20    0=
 100 1005  25   3     75 )    172.19.3.130  66    172.19.3.137  41=20
172.19.3.141    eth1:bmx      172.19.3.141  92 (  99  0:15:02:35 17666    0=
 100 1002  14   1      1 )    172.19.3.137  29    172.19.3.130   0=20
172.19.3.137    eth1:bmx        172.19.3.1  60 (  95  0:01:03:42  3966    0=
 100  999   0   3     63 )    172.19.3.137  55    172.19.3.130  46=20
172.19.4.162    eth1:bmx        172.19.3.1  65 (  92  0:15:03:32 17131    0=
 100 1009  10   4     43 )    172.19.3.130  64    172.19.3.137  41=20
172.19.3.1      eth1:bmx      172.19.3.130  71 ( 100  1:11:50:50  4882    0=
 100 1022  43   2     98 )      172.19.3.1  69    172.19.3.137  31=20
172.19.4.165    eth1:bmx        172.19.3.1  60 (  99  0:15:03:48 62164    0=
 100  980  19   3     84 )    172.19.3.130  56    172.19.3.137  44=20
172.19.3.136    eth1:bmx        172.19.3.1  66 (  88  0:15:02:33 58457    0=
 100 1002  17   3     77 )    172.19.3.130  63    172.19.3.137  30=20
172.19.3.135    eth1:bmx      172.19.3.130  65 (  87  0:07:15:25 14034    0=
 100 1010  35   5     50 )      172.19.3.1  64    172.19.3.137  32=20
  14 known Originator(s), averages:         71 (  93                      0=
 100 1003  15   2    163 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.137.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF ath0:bmx 172.19.3.137, LinkWindowSize 50, Pa=
thWindSize 100, OGI 1000ms, currSeqno 3970, UT 0:01:03:45, CPU 1/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.3.1      ath0:bmx      172.19.3.160  66 (  94  0:01:03:43  4884    0=
   1   1 ) [  ath0:bmx   0  22   0] =20
172.19.3.128    ath0:bmx      172.19.3.160  68 (  93  0:01:03:44 17405    1=
   3   2 ) [  ath0:bmx  28  54  50] =20
172.19.3.160    ath0:bmx      172.19.3.160  81 ( 100  0:01:03:43 26707    0=
   6   3 ) [  ath0:bmx  82 100  82] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    ath0:bmx      172.19.3.160  76 (  90  0:01:03:42 33335    0=
 100 1024   8   3      1 )    172.19.3.128  24      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.134    ath0:bmx      172.19.3.160  55 (  71  0:01:03:43 47263    2=
 100  991   0   4      2 )    172.19.3.128  18      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.130    ath0:bmx      172.19.3.160  68 (  94  0:01:03:43   522    1=
 100 1022  14   3      1 )    172.19.3.128  36      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.133    ath0:bmx      172.19.3.160  70 (  95  0:01:03:43 65198    0=
 100 1006   5   3      2 )    172.19.3.128  29      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.4.161    ath0:bmx      172.19.3.160  84 (  97  0:01:03:42 31124    1=
 100 1033   0   2      2 )    172.19.3.128  20      172.19.3.1   0=20
172.19.4.160    ath0:bmx      172.19.3.160  78 (  96  0:01:03:43    22    0=
 100 1007  25   2      1 )    172.19.3.128  15      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.160    ath0:bmx      172.19.3.160  81 ( 100  0:01:03:43 26707    0=
 100  988  19   1      1 )    172.19.3.128  22      172.19.3.1   0=20
172.19.3.141    ath0:bmx      172.19.3.160  66 (  89  0:01:03:42 17668    0=
 100  980  14   4      3 )    172.19.3.128  33      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.4.162    ath0:bmx      172.19.3.160  84 (  94  0:01:03:43 17132    1=
 100 1017  10   3      2 )    172.19.3.128  26      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.128    ath0:bmx      172.19.3.160  68 (  93  0:01:03:44 17405    1=
 100  998  26   3      4 )    172.19.3.128  35      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.1      ath0:bmx      172.19.3.160  66 (  94  0:01:03:43  4884    0=
 100 1013  43   2      2 )      172.19.3.1   0    172.19.3.128  27    172.1=
9.3.131   0=20
172.19.4.165    ath0:bmx      172.19.3.160  85 ( 100  0:01:03:43 62166    0=
 100 1024  19   2      1 )    172.19.3.128  29      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.136    ath0:bmx      172.19.3.160  70 (  86  0:01:03:43 58458    1=
 100 1014  17   4      2 )    172.19.3.128  31      172.19.3.1   0    172.1=
9.3.131   0=20
172.19.3.135    ath0:bmx      172.19.3.160  64 (  82  0:01:03:42 14034    1=
 100 1012  35   5      1 )    172.19.3.128  20      172.19.3.1   0    172.1=
9.3.131   0=20
  14 known Originator(s), averages:         72 (  91                      0=
 100 1009  16   2      1 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.1.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF wlan0:bmx 172.19.3.160, LinkWindowSize 50, P=
athWindSize 100, OGI 1000ms, currSeqno 26711, UT 20:01:15:43, CPU 24/1000=
=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.3.1      wlan0:bmx       172.19.3.1  85 ( 100 13:10:25:39  4886    0=
   6   5 ) [ wlan0:bmx  96  98  96] =20
172.19.4.165    wlan1:bmx     172.19.4.165 100 ( 100  0:15:03:51 62169    0=
   1   1 ) [ wlan1:bmx  96  98  96] =20
172.19.4.162    wlan1:bmx     172.19.4.160  98 ( 100  0:15:03:35 17136    0=
   1   2 ) [ wlan1:bmx  80  76 100] =20
172.19.4.161    wlan1:bmx     172.19.4.161  97 ( 100  0:15:03:25 31128    0=
   1   3 ) [ wlan1:bmx  92  96  94] =20
172.19.4.160    wlan1:bmx     172.19.4.160  97 ( 100  0:15:03:24    25    0=
   2   4 ) [ wlan1:bmx  96  96 100] =20
172.19.3.137    wlan0:bmx     172.19.3.137  91 (  97  0:01:03:46  3971    0=
   3   6 ) [ wlan0:bmx  86  86 100] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    wlan0:bmx       172.19.3.1  85 (  91  0:21:34:41 33338    0=
 100 1005   8   2      1 )    172.19.4.162  74=20
172.19.3.134    wlan0:bmx       172.19.3.1  61 (  74  0:06:44:38 47267    0=
 100 1019   0   3      1 )    172.19.4.162  27=20
172.19.3.130    wlan0:bmx       172.19.3.1  78 (  88  1:11:50:50   525    0=
 100 1023  14   2     17 )    172.19.4.162  71=20
172.19.3.133    wlan0:bmx       172.19.3.1  85 (  95  0:12:30:04 65200    0=
 100  995   9   2      1 )    172.19.4.162  79=20
172.19.4.161    wlan1:bmx     172.19.4.161  97 ( 100  0:15:03:25 31128    0=
 100 1023   0   1      1 )    172.19.4.162  83=20
172.19.4.160    wlan1:bmx     172.19.4.160  97 ( 100  0:15:03:24    25    0=
 100  998  14   1    166 )    172.19.4.162  91=20
172.19.3.141    wlan0:bmx       172.19.3.1  83 (  89  0:15:02:38 17667    3=
 100 1007  14   3      1 )    172.19.4.162  69=20
172.19.3.137    wlan0:bmx     172.19.3.137  91 (  97  0:01:03:46  3971    0=
 100 1010   1   1      1 )    172.19.4.162  41=20
172.19.4.162    wlan1:bmx     172.19.4.160  98 ( 100  0:15:03:35 17136    0=
 100 1002  30   2   1254 )    172.19.4.162  90=20
172.19.3.128    wlan0:bmx       172.19.3.1  79 (  92  1:11:50:51 17408    0=
 100  999  18   2     13 )    172.19.4.162  64=20
172.19.3.1      wlan0:bmx       172.19.3.1  85 ( 100 13:10:25:39  4886    0=
 100 1028  43   1     37 )    172.19.4.162  70=20
172.19.4.165    wlan1:bmx     172.19.4.165 100 ( 100  0:15:03:51 62169    0=
 100 1007  19   1      3 )    172.19.4.162  86=20
172.19.3.136    wlan0:bmx       172.19.3.1  76 (  87  0:15:02:36 58461    0=
 100 1013  24   3      1 )    172.19.4.162  65=20
172.19.3.135    wlan0:bmx       172.19.3.1  75 (  86  0:07:15:30 14037    1=
 100 1032  33   4      1 )    172.19.4.162  61=20
  14 known Originator(s), averages:         85 (  92                      0=
 100 1012  16   2    107 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.162.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF eth1:bmx 172.19.4.162, LinkWindowSize 50, Pa=
thWindSize 100, OGI 1000ms, currSeqno 17132, UT 0:15:03:31, CPU 10/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.4.1      eth1:bmx        172.19.4.1  88 ( 100  0:15:03:27 26702    1=
   2   1 ) [  eth1:bmx  76  98  76] =20
172.19.4.160    eth1:bmx      172.19.4.160 100 ( 100  0:15:03:18    19    0=
   1   2 ) [  eth1:bmx  96 100  96] =20
172.19.4.165    eth1:bmx      172.19.4.160  97 ( 100  0:15:03:22 62163    0=
   2   3 ) [  eth1:bmx  10  76  12] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    eth1:bmx      172.19.4.160  81 (  85  0:15:03:25 33332    0=
 100  995  10   4    588 )      172.19.4.1  75    172.19.4.165   4=20
172.19.3.134    eth1:bmx      172.19.4.160  58 (  63  0:06:44:31 47261    0=
 100 1014   3   5    282 )      172.19.4.1  57    172.19.4.165   4=20
172.19.3.130    eth1:bmx      172.19.4.160  76 (  78  0:15:03:26   519    1=
 100 1008   8   4    634 )      172.19.4.1  70    172.19.4.165   5=20
172.19.3.133    eth1:bmx      172.19.4.160  84 (  86  0:12:29:57 65194    0=
 100 1029   1   4    536 )      172.19.4.1  73    172.19.4.165   9=20
172.19.4.161    eth1:bmx      172.19.4.160  93 (  97  0:15:03:19 31122    0=
 100  993   1   3    662 )      172.19.4.1  88    172.19.4.165   8=20
172.19.3.160    eth1:bmx      172.19.4.160  96 ( 100  0:15:03:25 26703    0=
 100  991  14   2    580 )      172.19.4.1  81    172.19.4.165   6=20
172.19.4.160    eth1:bmx      172.19.4.160 100 ( 100  0:15:03:18    19    0=
 100 1009  25   1     47 )    172.19.4.165   7      172.19.4.1  61=20
172.19.3.141    eth1:bmx      172.19.4.160  81 (  83  0:15:02:31 17664    1=
 100 1003  14   5    618 )      172.19.4.1  74    172.19.4.165   9=20
172.19.3.137    eth1:bmx      172.19.4.160  85 (  91  0:01:03:40  3965    0=
 100 1036   0   3     48 )      172.19.4.1  76    172.19.4.165   7=20
172.19.3.128    eth1:bmx      172.19.4.160  77 (  80  0:15:03:26 17402    0=
 100  994  17   4    568 )      172.19.4.1  67    172.19.4.165   3=20
172.19.3.1      eth1:bmx      172.19.4.160  79 (  85  0:15:03:25  4881    0=
 100  997  44   3    542 )      172.19.4.1  74    172.19.4.165   5=20
172.19.4.165    eth1:bmx      172.19.4.160  97 ( 100  0:15:03:22 62163    0=
 100  977  19   3    584 )      172.19.4.1  81    172.19.4.165   9=20
172.19.3.136    eth1:bmx      172.19.4.160  74 (  77  0:15:02:30 58455    0=
 100 1057  17   5    530 )      172.19.4.1  66    172.19.4.165   3=20
172.19.3.135    eth1:bmx      172.19.4.160  73 (  75  0:07:15:22 14032    0=
 100 1025  35   6    264 )      172.19.4.1  64    172.19.4.165   5=20
  14 known Originator(s), averages:         82 (  85                      0=
 100 1009  14   3    463 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIEATIlTtvZdk47D4RAmPMAJwMhNmXAeJ4pj62hzUuvNIAEdKtrwCfXRnC
8npsv/se4ZfqyF+0ovWeSo4=
=tJO+
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
