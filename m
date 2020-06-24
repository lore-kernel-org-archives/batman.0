Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batadv gw_mode client 0?
Date: Wed, 24 Jun 2020 22:13:47 +0200
Message-ID: <2094569.NUmnuQNPM9@sven-edge>
In-Reply-To: <E3FD8A72-966A-4CBB-A036-8C0A4152983D@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com> <8393812.UZvHzlbVaM@sven-edge> <E3FD8A72-966A-4CBB-A036-8C0A4152983D@xecoenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1643328.Fcg3oQSA6E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Rob Cowart <rob.cowart@xecoenergy.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart1643328.Fcg3oQSA6E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 June 2020 22:02:38 CEST Rob Cowart wrote:
[....]
> Is anything wrong with these?

Most likely not, but someone on the mailing list with deeper knowledge on 
B.A.T.M.A.N. V's echo location protocol could actually check whether non-
symmetric settings on different nodes could create problems or not. Or if 
having both ELP and OGM2 interval set to the same value could have negative 
side effects.


> Our gateway:
> 
> pi@raspberrypi:~/xeco-master/enola-daemon $ cat /sys/class/net/wlan0/batman_adv/elp_interval 
> 500
> pi@raspberrypi:~/xeco-master/enola-daemon $ cat /sys/class/net/bat0/mesh/orig_interval
> 1000
> 
> nodes:
> pi@raspberrypi:~ $ cat /sys/class/net/wlan0/batman_adv/elp_interval
> 30000
> pi@raspberrypi:~ $ cat /sys/class/net/bat0/mesh/orig_interval
> 30000
[...]

On Wednesday, 24 June 2020 21:23:09 CEST Rob Cowart wrote:
> IF             Neighbor              last-seen
> b8:27:eb:4e:73:6d   25.330s (        1.0) [     wlan0]
> b8:27:eb:ff:0e:b6   23.320s (        1.0) [     wlan0]
> b8:27:eb:08:13:37   18.850s (        1.0) [     wlan0]
> b8:27:eb:aa:1e:6d   37.010s (        1.0) [     wlan0]
> b8:27:eb:35:c6:77   63.590s (        1.0) [     wlan0]
> b8:27:eb:e9:34:41   18.280s (        1.0) [     wlan0]
> b8:27:eb:84:ca:90   30.560s (        1.0) [     wlan0]
> b8:27:eb:1e:eb:cd   27.410s (        1.0) [     wlan0]
> b8:27:eb:cb:80:34   23.100s (        1.0) [     wlan0]

Btw. it looks to me like B.A.T.M.A.N. V is a really bad choice for your setup. 
All links have the throughput value 1.0 Mbit/s. This sounds to me like the 
wifi driver doesn't provide the required expected_throughput. And so you have 
a REALLY, REALLY, REALLY bad metric when you are using 1.0 everywhere. So if 
you want to continue experimenting with B.A.T.M.A.N. V then you should try to 
get this fixed in your wifi driver or just switch to B.A.T.M.A.N. IV with 
increased multicast rate.


> Lots of stuff I don't understand here, looks like loopback is very busy?
 
Not sure what you mean here with loopback. I will just leave the whole output 
here in case somebody else on the mailing list wants to figure it out.
 
> pi@raspberrypi:~/xeco-master/enola-daemon $ sudo batctl td wlan0
> 15:01:52.075412 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 704843962, v 15, interval 500ms, length 20
> 15:01:52.076036 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.076507 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.076854 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.077456 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.077937 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.078028 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.078657 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.079155 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.079246 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.079894 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.080480 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.080965 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.081435 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.081904 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.081995 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.082435 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.082539 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.082957 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> 15:01:52.415359 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:fb:4e:58, seq 500807384, throughput MAX, ttl 50, v 15, length 60, tvlv_len 40
> 	TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> 		VLAN ID -1, crc 0xf0cfd284
> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> 	TVLV DATv1: enabled
> 15:01:52.423153 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:aa:1e:6d, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, length 60, tvlv_len 40
> 	TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> 		VLAN ID -1, crc 0xf0cfd284
> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> 	TVLV DATv1: enabled
> 15:01:52.424280 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:cb:80:34, seq 500807384, throughput 14.9Mbps, ttl 49, v 15, length 60, tvlv_len 40
> 	TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> 		VLAN ID -1, crc 0xf0cfd284
> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> 	TVLV DATv1: enabled
> 15:01:52.428556 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:84:ca:90, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, length 60, tvlv_len 40
> 	TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> 		VLAN ID -1, crc 0xf0cfd284
> 	TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> 	TVLV DATv1: enabled
> 15:01:52.575301 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 704843963, v 15, interval 500ms, length 20
> 15:01:52.575486 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200

Kind regards,
	Sven
--nextPart1643328.Fcg3oQSA6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7zs/sACgkQXYcKB8Em
e0ajLw/9ET4LI0mrT0ojnIVKTwQW+lj9wZ94sOV2x7bHiLO8Rtiq3JBZ/YXAlsrV
I5kDtdLBuOmI7/dkELDECvLdN60pWMAA7o/dKCeedJJdEkmJj/IHul+wWW63hY4K
md7EkzXcSpOj6I3hDjMhPcnZM41HX+t8PYcMG/DWrHcvs1Le9HGe1vsc6I0c7bEQ
CswxFWLqy5+j14qoa9Lrr8GBsQGsevmJpr2nONUACdOmBHlPJ6f1cr64DJ8tQxVm
pyhYRjw2woWT/5yqlWqIN1TNo3+e6oA+OCODaqTSOZlElvvKrAZRZACL7hhtlTM+
fI56gQIv9KPNiPP+m//2djEM5gUD85qLA/Hg9N7LqZabStPdkRDdivbdcJJ+Dmi6
Ob3csjjDvzSW2RQ7sk/WLdllorMQzEbPVj5g3ykNy+/fEcHdPIxdYwZoSJvsj/5P
hBczFJ3Nq6U+wc+2mnPKGaMUxu2GceBQilKS4O6ABspQODV2lKLNnwhjrLrR771C
daLBtl+iVCgiN+7mXyzA7azpqrx5Ng+PPOCnDdkpSbVxb8G4CzAdnfeJ0Q/N5XrL
X+ajFQq9lmTm/JcLGJ07Ovr8gRMgKZnSRgn75RnBuee38z9qKGBa/n5hQ1BuhsAK
Kd2CUXb27XDhZ0RMZQa7mF+g7QLbOk2T+R+NPPDRDIgTl7+jP7g=
=Iysi
-----END PGP SIGNATURE-----

--nextPart1643328.Fcg3oQSA6E--


