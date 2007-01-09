From: "Lui" <batman@schmudde.com>
Subject: =?utf-8?Q?FW:_=5BFwd:_Re:_=5BB.A.T.M.A.N.=5D_B.A?=
	=?utf-8?Q?.T.M.A.N._l=C3=A4uft_jetzt_auch_perma?=
	=?utf-8?Q?nent_auf_der_Zwingli-Nordost_-_1?=
	=?utf-8?Q?05.130.1.67=5D?=
Date: Tue, 9 Jan 2007 13:58:21 +0100
Message-ID: <004301c733ed$da82f630$0105a8c0@bluebox>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0044_01C733F6.3C4A6B70"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N.-ML" <b.a.t.m.a.n@open-mesh.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0044_01C733F6.3C4A6B70
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hallo Liste ;-)

na dann dies auch gleich hier...

Lui


>-----Original Message-----
>From: Ludger Schmudde [mailto:Lui@Schmudde.com]=20
>Sent: Montag, 8. Januar 2007 22:52
>To: 'elektra'
>Cc: 'Marek Lindner'
>Subject: RE: [Fwd: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. l=C3=A4uft jetzt=20
>auch permanent auf der Zwingli-Nordost - 105.130.1.67]
>
>elektra,
>
>(ahh, Info hast'e ja schon)
>>>> * Beim WLAN-Routing w=C3=A4hlt BATMAN tendenziell den (schlechern?) =

>>>> direkten (1-Hop) Weg.
>>>> [...]
>=20
>>habe Ich das richtig verstanden - BATMAN w=C3=A4hlt von 3 direkten=20
>>Linkstrecken ohne Zwischenhop die schlechtere?
>
>Ja:
>_3.PharusEmmaus
>WLAN-IP:        LAN-IP:         2007.01.08-19:51:25
>105.192.192.66  105.192.192.83
>_______________ _______________ __________________________
>105.0.0.0       0.0.0.0         ---.0.0.0       U    eth1
>105.130.30.1    105.192.192.87  ---.---.---.--- UGH  br0
>105.192.192.1   105.192.192.81  ---.---.---.--- UGH  br0
>105.192.192.133 105.192.192.85  ---.---.---.--- UGH  br0
>105.192.192.166 105.192.192.86  ---.---.---.--- UGH  br0
>105.192.192.199 105.192.192.87  ---.---.---.--- UGH  br0
>105.192.192.225 105.192.192.88  ---.---.---.--- UGH  eth1 [1]
>105.192.192.33  105.192.192.82  ---.---.---.--- UGH  br0
>105.192.192.80  0.0.0.0         ---.---.---.240 U    br0
>105.192.192.81  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.82  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.84  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.85  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.86  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.87  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.88  0.0.0.0         ---.---.---.--- UH   br0
>105.192.192.99  105.192.192.84  ---.---.---.--- UGH  br0
>105.192.99.103  105.192.99.192  ---.---.---.--- UGH  eth1 [3]=20
>105.192.99.150  105.192.99.192  ---.---.---.--- UGH  eth1 [3]
>105.192.99.192  0.0.0.0         ---.---.---.--- UH   eth1 [3]
>105.192.99.50   105.192.99.192  ---.---.---.--- UGH  eth1
>xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx xxx  xxxx [2]
>
>[1] ??? via eth1(/WLAN) auf die LAN-IP des direkt via LAN
>    erreichbaren Nachbarn ???
>[2] hier fehlt noch etwas wie:
>105.192.99.160  105.192.192.84  ---.---.---.--- UH   br0
>105.192.99.60   105.192.192.84  ---.---.---.--- UGH  br0
>
>[3] =3D da w=C3=A4re (s.o.) ein "via 105.192.192.84" (2-Hops) besser...
>siehe - Vergleich 105../104...:
>
>root@_3:~# ping 105.192.99.192
>PING 105.192.99.192 (105.192.99.192): 56 data bytes
>64 bytes from 105.192.99.192: icmp_seq=3D1 ttl=3D63 time=3D32.5 ms
>64 bytes from 105.192.99.192: icmp_seq=3D2 ttl=3D63 time=3D43.4 ms
>64 bytes from 105.192.99.192: icmp_seq=3D3 ttl=3D63 time=3D67.2 ms
>64 bytes from 105.192.99.192: icmp_seq=3D5 ttl=3D63 time=3D22.2 ms
>
>--- 105.192.99.192 ping statistics ---
>8 packets transmitted, 4 packets received, 50% packet loss=20
>round-trip min/avg/max =3D 22.2/41.3/67.2 ms
>
>root@_3:~# ping 104.192.99.192
>PING 104.192.99.192 (104.192.99.192): 56 data bytes
>64 bytes from 104.192.99.192: icmp_seq=3D0 ttl=3D63 time=3D12.2 ms
>64 bytes from 104.192.99.192: icmp_seq=3D1 ttl=3D63 time=3D11.6 ms
>64 bytes from 104.192.99.192: icmp_seq=3D2 ttl=3D63 time=3D7.0 ms
>64 bytes from 104.192.99.192: icmp_seq=3D3 ttl=3D63 time=3D7.6 ms
>64 bytes from 104.192.99.192: icmp_seq=3D4 ttl=3D63 time=3D7.8 ms
>64 bytes from 104.192.99.192: icmp_seq=3D5 ttl=3D63 time=3D11.6 ms
>
>--- 104.192.99.192 ping statistics ---
>6 packets transmitted, 6 packets received, 0% packet loss=20
>round-trip min/avg/max =3D 7.0/9.6/12.2 ms root@_3:~# rt
>
>>Kannst Du mal da Daten dr=C3=BCberjagen und schauen wie sich das mit =
der=20
>>Geschwindigkeit verh=C3=A4lt?
>>Einfach mal n wget von der 105er und der 104er Adresse aus /dev/zero=20
>>vielleicht?
>
>Das probiere ich schon l=C3=A4nger - die Ergebnisse steuen aber=20
>derart, da=C3=9F daraus nichts zu sehen ist au=C3=9Fer, das =
_w=C3=A4hrend_=20
>eines 10Sek.
>Testtransfers die Routen mehrfach wechseln oder wegbrechen (->Anhang)
>
>...gerade auch entdeckt:
>m99_PharusE
>WLAN-IP:        LAN-IP:         2007.01.08-19:54:55
>105.192.99.192  105.192.99.62
>_______________ _______________ __________________________
>105.0.0.0       0.0.0.0         ---.0.0.0       U    eth1
>105.130.30.1    105.192.192.66  ---.---.---.--- UGH  eth1 [1]
>105.192.192.1   105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.133 0.0.0.0         ---.---.---.--- UH   eth1
>105.192.192.166 105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.199 105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.33  105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.81  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.82  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.83  105.192.192.66  ---.---.---.--- UGH  eth1 [1]
>105.192.192.84  105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.85  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.86  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.87  105.192.192.66  ---.---.---.--- UGH  eth1 [1]
>105.192.192.88  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.99  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.0    0.0.0.0         ---.---.---.192 U    br0
>105.192.99.103  105.192.99.160  ---.---.---.--- UGH  eth1
>105.192.99.150  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.160  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.50   0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.60   105.192.99.160  ---.---.---.--- UGH  eth1
>105.192.99.61   0.0.0.0         ---.---.---.--- UH   br0
>
>[1] 3x via 105.192.192.66 aber *dorthin* fehlt die Route!?
>
>[Restart+1h]: m99_PharusE
>WLAN-IP:        LAN-IP:         2007.01.08-21:00:25
>105.192.99.192  105.192.99.62
>_______________ _______________ __________________________
>105.0.0.0       0.0.0.0         ---.0.0.0       U    eth1
>105.192.192.1   105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.133 0.0.0.0         ---.---.---.--- UH   eth1
>105.192.192.166 105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.199 105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.225 105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.66  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.81  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.82  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.83  105.192.192.66  ---.---.---.--- UGH  eth1 [...]
>105.192.192.85  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.86  105.192.192.133 ---.---.---.--- UGH  eth1
>105.192.192.87  105.192.192.66  ---.---.---.--- UGH  eth1 [...]
>105.192.192.88  105.192.192.99  ---.---.---.--- UGH  eth1
>105.192.192.99  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.0    0.0.0.0         ---.---.---.192 U    br0
>105.192.99.103  105.192.99.150  ---.---.---.--- UGH  eth1
>105.192.99.150  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.160  0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.50   0.0.0.0         ---.---.---.--- UH   eth1
>105.192.99.60   105.192.99.160  ---.---.---.--- UGH  eth1
>105.192.99.61   0.0.0.0         ---.---.---.--- UH   br0
>
>Nun fehlt z.B. das WLAN-IF (.33) von _2 (.82) - und so weiter...
>
>Routing- und Last- /Auff=C3=A4lligkeiten/ sind nicht wirklich=20
>reproduzierbar...
>
>Auch Dinge wie diese:
>>>> top/%MEM ist (_1 bis _8): 5.0/6.5/12.1(!)/6.6/6.7/4.8/3.0(!)/5.6
>
>=C3=A4ndern sich z.B. beim Restart eines (beliebigen) Knoten u.U.=20
>komplett...
>
>Das hat offensichtlich nichts mit dem lokalen Code, sondern dem
>Gruppen/Zeit- Verhalten zu tun; sicher sind auch externe=20
>Einfl=C3=BCsse von Bedeutung. Von meiner =C3=9Cberlegung diese mal=20
>auszuschlie=C3=9Fen ("Batman-Only Test") bin ich selbst nicht=20
>wirklich =C3=BCberzeugt (->Falsche Sicherheit...).
>
>Schon bei einer handvoll von Routern sind via Console/WebUI=20
>solcherlei Dynamik nicht mehr auseinander zu dr=C3=B6seln - da=20
>m=C3=BC=C3=9Ften Tools f=C3=BCr her...
>
>...irgendwas, das Routing- & Last-Verhalten eines=20
>Router-Clusters /sichtbar/ machen kann - ohne freilich selbst=20
>Einfluss zu nehmen.
>
>Sonst ist das irgendwie fischen im Tr=C3=BCben...
>
>Gr=C3=BC=C3=9Fe
>Lui
>

------=_NextPart_000_0044_01C733F6.3C4A6B70
Content-Type: text/plain;
	name="xfer.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="xfer.txt"

(Anm.: xfertst - macht 8 Sek. DL aus dev-zero und schreibt dann =
kBit/sek. an die kBytes)

root@m99_PharusE:~# L=3D"104.192.192.66 105.192.192.66 104.192.192.99 =
105.192.192.99 104.192.192.133 105.192.192.133";for R in $L;do tracert =
$R;xfertst $R;done
traceroute to 104.192.192.66 (104.192.192.66), 30 hops max, 40 byte =
packets
 1  _5.PharusEmmaus.olsr (104.192.192.133)  20.646 ms  10.067 ms  3.918 =
ms
 2  _3.PharusEmmaus.olsr (104.192.192.66)  6.024 ms  4.497 ms  8.065 ms
........ - done
Transfered Terminated
 1863 kBit/sek.
traceroute to 105.192.192.66 (105.192.192.66), 30 hops max, 40 byte =
packets
 1  105.192.192.133 (105.192.192.133)  6.492 ms  6.979 ms  19.052 ms
 2  * 105.192.192.66 (105.192.192.66)  17.518 ms  3.883 ms
........ - done
Transfered Terminated
 4276 kBit/sek.
traceroute to 104.192.192.99 (104.192.192.99), 30 hops max, 40 byte =
packets
 1  _4.PharusEmmaus.olsr (104.192.192.99)  1004.15 ms  4.63 ms  126.47 =
ms
........ - done
Transfered Terminated
 1691 kBit/sek.
traceroute to 105.192.192.99 (105.192.192.99), 30 hops max, 40 byte =
packets
 1  105.192.192.99 (105.192.192.99)  1108.87 ms  48.213 ms  3.955 ms
........ - done
Transfered Terminated
 1994 kBit/sek.
traceroute to 104.192.192.133 (104.192.192.133), 30 hops max, 40 byte =
packets
 1  _5.PharusEmmaus.olsr (104.192.192.133)  4.613 ms  5.653 ms  13.37 ms
........ - done
Transfered Terminated
 538 kBit/sek.
traceroute to 105.192.192.133 (105.192.192.133), 30 hops max, 40 byte =
packets
 1  * 105.192.99.62 (105.192.99.62)  1000.56 ms !H *
 2  105.192.99.62 (105.192.99.62)  990.649 ms !H *  1000.62 ms !H
...105.192.192.133[105.192.192.133]80 (105.192.192.133)..... - done
Transfered killall: wget: no process killed
 kBit/sek.
root@m99_PharusE:~# L=3D"104.192.192.66 105.192.192.66 104.192.192.99 =
105.192.192.99 104.192.192.133 105.192.192.133";for R in $L;do tracert =
$R;xfertst $R;done
traceroute to 104.192.192.66 (104.192.192.66), 30 hops max, 40 byte =
packets
 1  _4.PharusEmmaus.olsr (104.192.192.99)  25.353 ms  96.147 ms  31.382 =
ms
 2  _3.PharusEmmaus.olsr (104.192.192.66)  52.573 ms  47.897 ms  33.147 =
ms
........ - done
Transfered Terminated
 2329 kBit/sek.
traceroute to 105.192.192.66 (105.192.192.66), 30 hops max, 40 byte =
packets
 1  105.192.192.84 (105.192.192.84)  51.882 ms  4.282 ms  5.567 ms
 2  * 105.192.192.84 (105.192.192.84)  1013.73 ms !H *
 3  105.192.192.84 (105.192.192.84)  1019.89 ms !H * *
 4  * * *
 5  105.192.192.133 (105.192.192.133)  1093.62 ms !H * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
10  * * *
11  * * *
12  * * *
13  * * *
14  * * 105.192.192.66 (105.192.192.66)  51.21 ms
........ - done
Transfered Terminated
 kBit/sek.
traceroute to 104.192.192.99 (104.192.192.99), 30 hops max, 40 byte =
packets
 1  _4.PharusEmmaus.olsr (104.192.192.99)  1004.49 ms  3.904 ms  5.028 =
ms
........ - done
Transfered Terminated
 864 kBit/sek.
traceroute to 105.192.192.99 (105.192.192.99), 30 hops max, 40 byte =
packets
 1  * 105.192.99.62 (105.192.99.62)  1000.83 ms !H *
 2  105.192.99.62 (105.192.99.62)  1099.67 ms !H *  1000.47 ms !H
...105.192.192.99[105.192.192.99]80 (105.192.192.99)..... - done
Transfered killall: wget: no process killed
 kBit/sek.
traceroute to 104.192.192.133 (104.192.192.133), 30 hops max, 40 byte =
packets
 1  _5.PharusEmmaus.olsr (104.192.192.133)  49.014 ms  9.178 ms  6.556 =
ms
........ - done
Transfered Terminated
 1956 kBit/sek.
traceroute to 105.192.192.133 (105.192.192.133), 30 hops max, 40 byte =
packets
 1  * 105.192.99.62 (105.192.99.62)  999.378 ms !H *
 2  105.192.99.62 (105.192.99.62)  1000.22 ms !H *  1000.42 ms !H
...105.192.192.133[105.192.192.133]80 (105.192.192.133)..... - done
Transfered killall: wget: no process killed
 kBit/sek.

------=_NextPart_000_0044_01C733F6.3C4A6B70--

