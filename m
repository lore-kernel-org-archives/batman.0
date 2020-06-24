Return-Path: <rob.cowart@xecoenergy.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: batadv gw_mode client 0?
From: Rob Cowart <rob.cowart@xecoenergy.com>
In-Reply-To: <2094569.NUmnuQNPM9@sven-edge>
Date: Wed, 24 Jun 2020 15:37:29 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE41926B-5684-45D8-B9AE-17D46DA1C8C7@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com>
 <8393812.UZvHzlbVaM@sven-edge>
 <E3FD8A72-966A-4CBB-A036-8C0A4152983D@xecoenergy.com>
 <2094569.NUmnuQNPM9@sven-edge>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org



> On Jun 24, 2020, at 3:13 PM, Sven Eckelmann <sven@narfation.org> =
wrote:
>=20
> On Wednesday, 24 June 2020 22:02:38 CEST Rob Cowart wrote:
> [....]
>> Is anything wrong with these?
>=20
> Most likely not, but someone on the mailing list with deeper knowledge =
on=20
> B.A.T.M.A.N. V's echo location protocol could actually check whether =
non-
> symmetric settings on different nodes could create problems or not. Or =
if=20
> having both ELP and OGM2 interval set to the same value could have =
negative=20
> side effects.
>=20
>=20
>> Our gateway:
>>=20
>> pi@raspberrypi:~/xeco-master/enola-daemon $ cat =
/sys/class/net/wlan0/batman_adv/elp_interval=20
>> 500
>> pi@raspberrypi:~/xeco-master/enola-daemon $ cat =
/sys/class/net/bat0/mesh/orig_interval
>> 1000
>>=20
>> nodes:
>> pi@raspberrypi:~ $ cat /sys/class/net/wlan0/batman_adv/elp_interval
>> 30000
>> pi@raspberrypi:~ $ cat /sys/class/net/bat0/mesh/orig_interval
>> 30000
> [...]
>=20
> On Wednesday, 24 June 2020 21:23:09 CEST Rob Cowart wrote:
>> IF             Neighbor              last-seen
>> b8:27:eb:4e:73:6d   25.330s (        1.0) [     wlan0]
>> b8:27:eb:ff:0e:b6   23.320s (        1.0) [     wlan0]
>> b8:27:eb:08:13:37   18.850s (        1.0) [     wlan0]
>> b8:27:eb:aa:1e:6d   37.010s (        1.0) [     wlan0]
>> b8:27:eb:35:c6:77   63.590s (        1.0) [     wlan0]
>> b8:27:eb:e9:34:41   18.280s (        1.0) [     wlan0]
>> b8:27:eb:84:ca:90   30.560s (        1.0) [     wlan0]
>> b8:27:eb:1e:eb:cd   27.410s (        1.0) [     wlan0]
>> b8:27:eb:cb:80:34   23.100s (        1.0) [     wlan0]
>=20
> Btw. it looks to me like B.A.T.M.A.N. V is a really bad choice for =
your setup.=20
> All links have the throughput value 1.0 Mbit/s. This sounds to me like =
the=20
> wifi driver doesn't provide the required expected_throughput. And so =
you have=20
> a REALLY, REALLY, REALLY bad metric when you are using 1.0 everywhere. =
So if=20
> you want to continue experimenting with B.A.T.M.A.N. V then you should =
try to=20
> get this fixed in your wifi driver or just switch to B.A.T.M.A.N. IV =
with=20
> increased multicast rate.
Are there any docs that talk about what B.A.T.M.A.N. V vs B.A.T.M.A.N. =
IV is good for?  The decision to upgrade was made before I got here, I'm =
not sure anyone understood that IV would still be supported/expected to =
be used.=20
>=20
>=20
>> Lots of stuff I don't understand here, looks like loopback is very =
busy?
>=20
> Not sure what you mean here with loopback. I will just leave the whole =
output=20
> here in case somebody else on the mailing list wants to figure it out.
>=20
>> pi@raspberrypi:~/xeco-master/enola-daemon $ sudo batctl td wlan0
>> 15:01:52.075412 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 704843962, v 15, interval 500ms, length 20
>> 15:01:52.076036 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.076507 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.076854 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.077456 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.077937 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.078028 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.078657 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.079155 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.079246 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.079894 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.080480 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.080965 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.081435 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.081904 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.081995 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.082435 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.082539 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.082957 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>> 15:01:52.415359 BAT b8:27:eb:fb:4e:58: OGM2 via neigh =
b8:27:eb:fb:4e:58, seq 500807384, throughput MAX, ttl 50, v 15, length =
60, tvlv_len 40
>> 	TVLV TTv1: OGM DIFF [.] ttvn=3D1 vlan_num=3D1 entry_num=3D0
>> 		VLAN ID -1, crc 0xf0cfd284
>> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
>> 	TVLV DATv1: enabled
>> 15:01:52.423153 BAT b8:27:eb:fb:4e:58: OGM2 via neigh =
b8:27:eb:aa:1e:6d, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, =
length 60, tvlv_len 40
>> 	TVLV TTv1: OGM DIFF [.] ttvn=3D1 vlan_num=3D1 entry_num=3D0
>> 		VLAN ID -1, crc 0xf0cfd284
>> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
>> 	TVLV DATv1: enabled
>> 15:01:52.424280 BAT b8:27:eb:fb:4e:58: OGM2 via neigh =
b8:27:eb:cb:80:34, seq 500807384, throughput 14.9Mbps, ttl 49, v 15, =
length 60, tvlv_len 40
>> 	TVLV TTv1: OGM DIFF [.] ttvn=3D1 vlan_num=3D1 entry_num=3D0
>> 		VLAN ID -1, crc 0xf0cfd284
>> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
>> 	TVLV DATv1: enabled
>> 15:01:52.428556 BAT b8:27:eb:fb:4e:58: OGM2 via neigh =
b8:27:eb:84:ca:90, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, =
length 60, tvlv_len 40
>> 	TVLV TTv1: OGM DIFF [.] ttvn=3D1 vlan_num=3D1 entry_num=3D0
>> 		VLAN ID -1, crc 0xf0cfd284
>> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
>> 	TVLV DATv1: enabled
>> 15:01:52.575301 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 704843963, v 15, interval 500ms, length 20
>> 15:01:52.575486 BAT b8:27:eb:fb:4e:58: ELP via iface =
b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
>=20
> Kind regards,
> 	Sven


