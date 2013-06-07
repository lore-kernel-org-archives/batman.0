Return-Path: <ordex@autistici.org>
Date: Fri, 7 Jun 2013 19:27:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130607172734.GO1789@ritirata.org>
References: <20130606055102.GH1789@ritirata.org> <51B0D294.4070809@inti.gob.ar>
 <20130606182954.GI1789@ritirata.org> <51B0DD43.6090500@inti.gob.ar>
 <20130606191823.GJ1789@ritirata.org> <51B1E4D6.5000900@inti.gob.ar>
 <20130607135713.GL1789@ritirata.org> <51B1F062.3060101@inti.gob.ar>
 <20130607144019.GM1789@ritirata.org> <51B214AE.2090603@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zvl510+jvRFHh8wJ"
Content-Disposition: inline
In-Reply-To: <51B214AE.2090603@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Zvl510+jvRFHh8wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gabriel,

On Fri, Jun 07, 2013 at 02:13:18PM -0300, Gabriel Tol=C3=B3n wrote:
>=20
> This time, I logged just from Equipo 1, to generate less traffic.
>=20
> I noticed something weird. When I run batctl bw I get this time=20
> something like 12 Mbps. If I wait for about 10 seconds and repeat the=20
> command, I get something similar, but, if I run the command inmediatly=20
> after the bw test finishes, the result improves a lot, here you can see=
=20
> the commands with the seconds between them:
>=20
>=20
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:09 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 3064500 Bytes.
> Throughput: 1.46 MB/s (12.26 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:15 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 3201000 Bytes.
> Throughput: 1.53 MB/s (12.80 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:18 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 14545500 Bytes.
> Throughput: 6.94 MB/s (58.18 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:20 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 18729000 Bytes.
> Throughput: 8.93 MB/s (74.91 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:23 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 21067500 Bytes.
> Throughput: 10.05 MB/s (84.26 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:26 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 22351500 Bytes.
> Throughput: 10.66 MB/s (89.40 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:37 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 13281000 Bytes.
> Throughput: 6.33 MB/s (53.12 Mbps)
> root@Equipo 1:~#
> root@Equipo 1:~#
> root@Equipo 1:~#
> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
> Fri Jun  7 16:40:49 UTC 2013
> Bandwidth meter called towards 64:70:02:4e:d9:d7
> Test over in 2000ms.
> Sent 3204000 Bytes.
> Throughput: 1.53 MB/s (12.82 Mbps)
> root@Equipo 1:~#
>=20
>=20
> Maybe something in the time calculation is wrong?
>=20

This strange. The point is that the receiver takes at least 1 second to shu=
tdown
the session. Theoretically (and this is what happened during my tests) the
receiver should refuse any "second new" connection and the sender should th=
en
get 0 throughput. Can I ask you what wifi driver is your device using?
Anyway, there must be something wrong in the bw meter given that you see th=
is
behaviour only with it and not with iperf.

Did you try a short run over Ethernet? I'm curious to see if the behaviour =
will
be the same.

> The logs aretoo heavy for pastebin, so here it's just the part=20
> corresponding to the first batctl bw in Equipo1:
>=20
> http://pastebin.com/THEr2Cq3
>=20

Thanks for the log.

I saw something strange:

16:40:09.533172 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id 0=
, seq
2018499, ttl 50, v 15, length 1510
16:40:09.533392 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id 0=
, seq
2049999, ttl 50, v 15, length 1510

These are two packets sent one after the other but the second sequence numb=
er is
not equal to the first + 1500 (payload size)

> If you want to watch the whole log I can send you, or paste it in parts.
>=20

This gave me already some hints. I'll dig into the code to try to spot what=
's
wrong. But strange that I did not see any problem during my tests..maybe
something introduced later by accident.


Thank you so far. I'm still curious about the Ethernet test, then I'll try =
to
upload some more code to test :)


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Zvl510+jvRFHh8wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRshgFAAoJEADl0hg6qKeOzloP/3X9vmTKO5gld0sMJSdQmREG
XCqLBRT5bIzGuxCpytHa8HnbnE50VlksIGEift+bBcM9q/H5k88pstX0i0aa/vdl
ZVbq1WYK0/0r4qbJRNEKh5Vq1mKEp1xJ0XHmWK8eMc+OBnWkAwZKjXCcS5SIRtqJ
P45OOB/gxgV2mYZy9LGFOh+tFozT7LmUawA4qT9GUcZXYIiVZ4woECkzUcGYV9YS
lJwfbriDNrigkZrPE9IhdhVStRIH0eoLhrF3AY5uT1CZcY9cl/k930X3ZQtvxqjw
atgklXDGIasKaPEZdylJ4YHaaY28TD5hxg+TbTMtKPQtudwvLSdDEFwUkFF30T2J
Qz8nVSArF8yxvx7mkg0FFFhvAGVG4m8V/9IXLqFLRQoHSPs6UbXLbX3LPZFtnxmL
uNxxIEyq2kDAbOHEq7ye+NN/FSyUP97ojvFjP5kFseN0YX6Ojdz9kfW6jac+0KQT
KtrxPBTeBCwysPjIwVTzB80KZwIeRr6FbDSm5p/6jH7zH/3BX/0fHViaFvL/7LBf
ET7lLK/c8wxn3avPpGebjiqMa5sPwQIT5QMKYHufXokzCMto6lW6V9ST/zq5vSqm
OP97QmPx1AFqr1mX9n5VSVqpCK4MmbflNBl0PP1bxDhxHggA3E+QHFMeFcVZjG1G
FQGFJEffl4X12adWKYId
=oVpe
-----END PGP SIGNATURE-----

--Zvl510+jvRFHh8wJ--
