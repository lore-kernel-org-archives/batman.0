Date: Wed, 23 Apr 2008 17:02:33 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Message-ID: <20080423230233.GA20235@apoderado.ometepe.net>
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<200804221601.57318.axel@open-mesh.net>
	<20080423000418.GA7368@apoderado.ometepe.net>
	<200804230954.37620.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
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


--JP+T4n/bALQSJXh8
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Axel
thanks for being stubborn :-)
On Wed, Apr 23, 2008 at 09:54:37AM +0200, Axel Neumann wrote:
> > > But according to the debug output there is a direct link to x.x.4.165=
/24
> > > (which I guess has broadcast address of x.x.4.255) and therefore the =
two
> > > interfaces should not see each other!!??
> >
> > there are direct links always only in the according /24 netrange,
> > because they are on different channels/ssids, so .3.160 and .4.1 cannot
> > "see" each other.
> > Note, NO .4.x node cannot see ANY .3.x node, even if they
> > would be on the same channel/ssid!
ok, .4.165 can see .3.160
> Are you also specifying the bssid? Because in order to define different=
=20
> cells in an ad-hoc network the ssid is almost useless in most adhoc=20
> implementations. THe BSSID is much more important!=20
> (E.g. use kamikaze-etc/config/wireless style: option bssid 44:ca:ff:ee:ba=
:be=20
> or the command-line-style: iwconfig wlan0 ap 44:ca:ff:ee:ba:be )=20
thanks, did'nt know that                    ^^
>=20
> Anyway, you mean a debug output on 3.16 like the following can not be cor=
rect?
> Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lv=
ld rid sid ) [     viaIF RTQ  RQ  TQ]..
> 172.19.4.165    wlan0:bmx     172.19.4.165  55 (  84  0:00:28:03  9777   =
 1   1   4 ) [ wlan0:bmx  46  76  60] =20
did'nt see that   ^^^^^=20
>=20
> Sorry for being stubborn: what makes you so sure that they cannot see eac=
h=20
> other or that the driver does not mix things up?
>=20
> At least from the madwifi driver (in ad-hoc mode) I know that it tends to=
=20
> ignore its assigned *bssid* and channel and switches back and forth betwe=
en the=20
> assigned one and others.=20
>=20
> Sometimes the driver hangs on a wrong bssid and=20
> channel, forwards the wrong IP packets, and cannot receive any packets fr=
om=20
> its originally assigned bssid/channel.=20
>=20
> One way to verify this would be to run a tcpdump on interface 3.160/wlan0=
 and=20
> see if it ever tracks a batman packet with a src address of e.g. 172.19.4=
=2E165
ok, what happend: .4.165 (i386/prism2.5/hostap(-pci)) switched for some
unknown reason to .3.x/channel/essid (which explains the poor link from
=2E4.165 to ".4.1"(actually .3.160), and i thought it was a fast growing Gu=
ahumo tree :).
So i fixed the bssids on both, .4.1 and .4.165. And it seems to not
switch anymore... thanks for being so stubborn :-)
But that doesn't change the fact, that .4.1 still shows .4.162 as
alternativeNextHop to .3.x, where, in fact, all alternative paths inside
=2E4.x to .3.x lead back to .4.1 !=20

> > i'll make some more logs when .3.137 is back up
still down, anyways, i attach -cbd8 from .4.1, .4.160, .4.162 and .4.165


cheers
 =20
    --Jan

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.1.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF wlan0:bmx 172.19.3.160, LinkWindowSize 50, P=
athWindSize 100, OGI 1000ms, currSeqno 10045, UT 19:20:37:09, CPU 34/1000=
=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.3.1      wlan0:bmx       172.19.3.1  79 ( 100 13:05:47:05 53771    0=
   6   5 ) [ wlan0:bmx  90 100  90] =20
172.19.4.165    wlan1:bmx     172.19.4.165 100 ( 100  0:10:25:17 45516    0=
   1   1 ) [ wlan1:bmx  98  98 100] =20
172.19.4.162    wlan1:bmx     172.19.4.162  97 ( 100  0:10:25:01   471    0=
   1   2 ) [ wlan1:bmx  92  92 100] =20
172.19.4.161    wlan1:bmx     172.19.4.161  96 ( 100  0:10:24:51 14469    1=
   1   3 ) [ wlan1:bmx  92  98  92] =20
172.19.4.160    wlan1:bmx     172.19.4.160  98 ( 100  0:10:24:50 48895    0=
   2   4 ) [ wlan1:bmx  92  96  94] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    wlan0:bmx       172.19.3.1  78 (  97  0:16:56:07 16669    0=
 100 1003  10   2      1 )    172.19.4.162  28=20
172.19.3.134    wlan0:bmx       172.19.3.1  78 (  92  0:02:06:04 30506    0=
 100 1001   7   3      1 )    172.19.4.162  66=20
172.19.3.130    wlan0:bmx       172.19.3.1  68 (  88  1:07:12:16 49397    0=
 100  972   6   2     17 )    172.19.4.162  59=20
172.19.3.133    wlan0:bmx       172.19.3.1  72 (  90  0:07:51:30 48541    0=
 100 1004   1   2      1 )    172.19.4.162  63=20
172.19.4.161    wlan1:bmx     172.19.4.161  96 ( 100  0:10:24:51 14469    1=
 100 1004   5   1      1 )    172.19.4.162  43=20
172.19.4.160    wlan1:bmx     172.19.4.160  98 ( 100  0:10:24:50 48895    0=
 100 1011   7   1     94 )    172.19.4.162  92=20
172.19.3.141    wlan0:bmx       172.19.3.1  72 (  91  0:10:24:04  1018    0=
 100  952  34   3      1 )    172.19.4.162  59=20
172.19.4.162    wlan1:bmx     172.19.4.162  97 ( 100  0:10:25:01   471    0=
 100  996  21   1    855 )    172.19.4.160  90=20
172.19.3.128    wlan0:bmx       172.19.3.1  77 (  90  1:07:12:17   748    1=
 100  974  13   2     13 )    172.19.4.162  56=20
172.19.3.1      wlan0:bmx       172.19.3.1  79 ( 100 13:05:47:05 53771    0=
 100 1023  42   1     37 )    172.19.4.162  65=20
172.19.0.4      wlan0:bmx       172.19.3.1  78 (  96  0:08:27:17 51735    0=
 100 1005  28   3      1 )    172.19.4.162  69=20
172.19.0.2      wlan0:bmx       172.19.3.1  79 (  95  0:07:57:04 14754    0=
 100  996   6   2      1 )    172.19.4.162  65=20
172.19.4.165    wlan1:bmx     172.19.4.165 100 ( 100  0:10:25:17 45516    0=
 100  995  29   1      3 )    172.19.4.162  85=20
172.19.3.136    wlan0:bmx       172.19.3.1  76 (  87  0:10:24:02 41807    0=
 100  992  26   3      1 )    172.19.4.162  30=20
172.19.3.135    wlan0:bmx       172.19.3.1  68 (  85  0:02:36:56 62915    0=
 100  986  36   4      1 )    172.19.4.162  56=20
  15 known Originator(s), averages:         81 (  94                      0=
 100  994  18   2     68 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.160.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF eth1:bmx 172.19.4.160, LinkWindowSize 50, Pa=
thWindSize 100, OGI 1000ms, currSeqno 48894, UT 0:10:24:51, CPU 7/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.4.162    eth1:bmx      172.19.4.162  99 ( 100  0:10:24:49   468    0=
   2   1 ) [  eth1:bmx 100 100 100] =20
172.19.4.1      eth1:bmx        172.19.4.1  99 ( 100  0:10:24:49 10040    0=
   4   2 ) [  eth1:bmx  96 100  96] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    eth1:bmx        172.19.4.1  73 (  76  0:10:24:49 16666    0=
 100  994  10   3      8 )    172.19.4.162  42=20
172.19.3.134    eth1:bmx        172.19.4.1  78 (  80  0:02:06:01 30502    1=
 100  992   0   4      1 )=20
172.19.3.130    eth1:bmx        172.19.4.1  68 (  69  0:10:24:49 49391    4=
 100  985  20   3      2 )    172.19.4.162   0=20
172.19.3.133    eth1:bmx        172.19.4.1  71 (  73  0:07:51:28 48538    0=
 100 1019   3   3     11 )=20
172.19.4.161    eth1:bmx        172.19.4.1  89 (  96  0:10:24:49 14467    0=
 100 1010  15   2     13 )    172.19.4.162  33=20
172.19.3.160    eth1:bmx        172.19.4.1  96 ( 100  0:10:24:49 10040    0=
 100 1003  29   1      3 )=20
172.19.3.141    eth1:bmx        172.19.4.1  70 (  71  0:10:24:03  1016    0=
 100  952  37   4      9 )=20
172.19.4.162    eth1:bmx      172.19.4.162  99 ( 100  0:10:24:49   468    0=
 100 1002  14   1     53 )      172.19.4.1  87=20
172.19.3.128    eth1:bmx        172.19.4.1  75 (  77  0:10:24:49   746    0=
 100  983  13   3      8 )    172.19.4.162  12=20
172.19.3.1      eth1:bmx        172.19.4.1  75 (  79  0:10:24:49 53769    0=
 100 1007  42   2      9 )=20
172.19.0.4      eth1:bmx        172.19.4.1  76 (  77  0:08:27:15 51732    0=
 100 1008  32   4     11 )=20
172.19.0.2      eth1:bmx        172.19.4.1  74 (  79  0:07:57:02 14751    0=
 100 1002  11   3      1 )=20
172.19.4.165    eth1:bmx        172.19.4.1  99 ( 100  0:10:24:48 45513    0=
 100 1001  21   2     15 )=20
172.19.3.136    eth1:bmx        172.19.4.1  73 (  74  0:10:24:01 41804    0=
 100  968  26   4     15 )    172.19.4.162  36=20
172.19.3.135    eth1:bmx        172.19.4.1  64 (  66  0:02:36:53 62912    1=
 100 1003  35   5      3 )=20
  15 known Originator(s), averages:         78 (  81                      0=
 100  995  20   2     10 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.162.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF eth1:bmx 172.19.4.162, LinkWindowSize 50, Pa=
thWindSize 100, OGI 1000ms, currSeqno 470, UT 0:10:25:00, CPU 14/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.4.1      eth1:bmx        172.19.4.1  90 ( 100  0:10:24:56 10040    0=
   2   1 ) [  eth1:bmx  92  98  92] =20
172.19.4.160    eth1:bmx      172.19.4.160 100 ( 100  0:10:24:47 48892    0=
   1   2 ) [  eth1:bmx 100 100 100] =20
172.19.4.165    eth1:bmx      172.19.4.160  98 ( 100  0:10:24:51 45513    0=
   2   3 ) [  eth1:bmx  36  74  48] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    eth1:bmx        172.19.4.1  74 (  76  0:10:24:54 16666    0=
 100  994  10   3    401 )    172.19.4.160  71    172.19.4.165  29=20
172.19.3.134    eth1:bmx      172.19.4.160  76 (  80  0:02:06:00 30502    1=
 100  992   0   5     58 )      172.19.4.1  69    172.19.4.165  41=20
172.19.3.130    eth1:bmx      172.19.4.160  68 (  69  0:10:24:55 49391    3=
 100  984  20   4    428 )      172.19.4.1  58    172.19.4.165  25=20
172.19.3.133    eth1:bmx      172.19.4.160  70 (  73  0:07:51:26 48538    0=
 100 1018   3   4    316 )      172.19.4.1  65    172.19.4.165  27=20
172.19.4.161    eth1:bmx        172.19.4.1  88 (  96  0:10:24:48 14467    0=
 100 1017  15   2    447 )    172.19.4.160  87    172.19.4.165  43=20
172.19.3.160    eth1:bmx      172.19.4.160  95 ( 100  0:10:24:54 10040    0=
 100 1003  29   2    360 )      172.19.4.1  88    172.19.4.165  42=20
172.19.4.160    eth1:bmx      172.19.4.160 100 ( 100  0:10:24:47 48892    0=
 100 1028  10   1     29 )    172.19.4.165  25      172.19.4.1  88=20
172.19.3.141    eth1:bmx      172.19.4.160  70 (  71  0:10:24:00  1016    0=
 100  951  37   5    380 )      172.19.4.1  59    172.19.4.165  28=20
172.19.3.128    eth1:bmx        172.19.4.1  74 (  77  0:10:24:55   746    0=
 100  982  13   3    397 )    172.19.4.160  72    172.19.4.165  29=20
172.19.3.1      eth1:bmx      172.19.4.160  74 (  79  0:10:24:54 53769    0=
 100 1016  42   3    364 )      172.19.4.1  71    172.19.4.165  28=20
172.19.0.4      eth1:bmx      172.19.4.160  74 (  77  0:08:27:12 51732    0=
 100 1008  32   5    254 )      172.19.4.1  71    172.19.4.165  31=20
172.19.0.2      eth1:bmx      172.19.4.160  73 (  79  0:07:57:00 14751    0=
 100  999  11   4    327 )      172.19.4.1  71    172.19.4.165  29=20
172.19.4.165    eth1:bmx      172.19.4.160  98 ( 100  0:10:24:51 45513    0=
 100  991  21   3    384 )      172.19.4.1  96    172.19.4.165  36=20
172.19.3.136    eth1:bmx        172.19.4.1  73 (  74  0:10:23:59 41804    0=
 100  968  26   4    355 )    172.19.4.160  71    172.19.4.165  29=20
172.19.3.135    eth1:bmx      172.19.4.160  61 (  66  0:02:36:51 62912    0=
 100  996  35   6     72 )      172.19.4.1  58    172.19.4.165  33=20
  15 known Originator(s), averages:         77 (  81                      0=
 100  996  20   3    304 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.165.log"
Content-Transfer-Encoding: quoted-printable

WARNING: You are using BatMan-eXp 0.3-alpha rv972 (compatibility version 10=
) !
BatMan-eXp 0.3-alpha rv972, IF wlan0:bmx 172.19.4.165, LinkWindowSize 50, P=
athWindSize 100, OGI 1000ms, currSeqno 45513, UT 0:10:25:14, CPU 21/1000=20
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.4.1      wlan0:bmx       172.19.4.1 100 ( 100  0:10:20:14 10038    0=
   1   1 ) [ wlan0:bmx  98 100  98] =20
172.19.4.162    wlan0:bmx       172.19.4.1  94 (  98  0:10:24:53   466    0=
   3   2 ) [ wlan0:bmx  36  46  78] =20

Originator      outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld=
 pws  ogi cpu hop change ) alternativeNextHops brc ...
172.19.3.131    wlan0:bmx       172.19.4.1  76 (  76  0:10:25:11 16664    0=
 100  997  16   3      2 )    172.19.4.162  36=20
172.19.3.134    wlan0:bmx       172.19.4.1  79 (  80  0:02:05:58 30501    0=
 100  983   0   4      1 )    172.19.4.162  31=20
172.19.3.130    wlan0:bmx       172.19.4.1  68 (  69  0:10:25:11 49391    2=
 100  983  20   3      2 )    172.19.4.162  27=20
172.19.3.133    wlan0:bmx       172.19.4.1  74 (  74  0:07:51:24 48535    1=
 100 1021   3   3      1 )    172.19.4.162  33=20
172.19.4.161    wlan0:bmx       172.19.4.1  96 (  96  0:10:24:42 14465    0=
 100  993  15   2      2 )    172.19.4.162  39=20
172.19.3.160    wlan0:bmx       172.19.4.1 100 ( 100  0:10:25:12 10038    0=
 100  985  29   1      2 )    172.19.4.162  35=20
172.19.4.160    wlan0:bmx       172.19.4.1  97 (  99  0:10:24:43 48890    0=
 100 1019  10   2      2 )    172.19.4.162  36=20
172.19.3.141    wlan0:bmx       172.19.4.1  71 (  72  0:10:23:45  1014    0=
 100  960  37   4      2 )    172.19.4.162  27=20
172.19.4.162    wlan0:bmx       172.19.4.1  94 (  98  0:10:24:53   466    0=
 100  985  14   2      2 )    172.19.4.162  43=20
172.19.3.128    wlan0:bmx       172.19.4.1  77 (  78  0:10:25:09   743    1=
 100  979  13   3      2 )    172.19.4.162  25=20
172.19.3.1      wlan0:bmx       172.19.4.1  80 (  80  0:10:25:11 53766    1=
 100 1018  65   2      2 )    172.19.4.162  29=20
172.19.0.4      wlan0:bmx       172.19.4.1  78 (  78  0:08:27:10 51730    0=
 100  988  32   4      1 )    172.19.4.162  32=20
172.19.0.2      wlan0:bmx       172.19.4.1  78 (  79  0:07:56:57 14749    0=
 100 1029  11   3      1 )    172.19.4.162  33=20
172.19.3.136    wlan0:bmx       172.19.4.1  73 (  74  0:10:23:54 41802    0=
 100  994  40   4      2 )    172.19.4.162  24=20
172.19.3.135    wlan0:bmx       172.19.4.1  68 (  68  0:02:36:49 62909    1=
 100  995  35   5      1 )    172.19.4.162  17=20
  15 known Originator(s), averages:         80 (  81                      0=
 100  995  22   3      1 )=20

Originator      Announced networks HNAs:  moved to debug level 9...

Originator      Announced services ip:port:seqno ... see debug level 7=20

--0OAP2g/MAC+5xKAE--

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFID8AJlTtvZdk47D4RAtSSAKCrUX57fO4NqgnQJiDNFaEZMLmt7QCfSzDz
TQiMc4qK0s/7GBZfy+2RyQY=
=DzEs
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
