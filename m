Return-Path: <ordex@autistici.org>
Date: Fri, 7 Jun 2013 20:39:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130607183932.GP1789@ritirata.org>
References: <51B0D294.4070809@inti.gob.ar> <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar> <20130606191823.GJ1789@ritirata.org>
 <51B1E4D6.5000900@inti.gob.ar> <20130607135713.GL1789@ritirata.org>
 <51B1F062.3060101@inti.gob.ar> <20130607144019.GM1789@ritirata.org>
 <51B214AE.2090603@inti.gob.ar> <20130607172734.GO1789@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3bc47Eih9dS+biPM"
Content-Disposition: inline
In-Reply-To: <20130607172734.GO1789@ritirata.org>
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


--3bc47Eih9dS+biPM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 07:27:34PM +0200, Antonio Quartulli wrote:
> Thanks for the log.
>=20
> I saw something strange:
>=20
> 16:40:09.533172 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id=
 0, seq
> 2018499, ttl 50, v 15, length 1510
> 16:40:09.533392 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id=
 0, seq
> 2049999, ttl 50, v 15, length 1510
>=20
> These are two packets sent one after the other but the second sequence nu=
mber is
> not equal to the first + 1500 (payload size)

After looking at the log again I think this issue is due to batctl td not b=
eing
able to dump all the packets rather than some strange bw_meter behaviour...

clueless again :(

However, let's see if the Ethernet test gives us some more hints.


Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3bc47Eih9dS+biPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsijkAAoJEADl0hg6qKeO8ukP/j6wLvrcwjSuYSb6Bcugji7G
qFPATiGiy4J8iyZrgKMGoBuIciiJWK99B9Lc5Wp2UUpiJe0cC6xz4h6o8eNepESV
BOos0AoU9BtV4PC+NKEnSovrkGl3H4xVoOfzn15Wgra6chyNEGasNrXxpxI2FM9V
izxZKFFhIN+auNBv4HkUvMPfVvjECpd1Eu+/DpSYgPnQTcrl9Hk2SdSK+IOF6oR7
Ymi7L/9X7qOXwEfMP0hHN1fClPY5gcBz7FOSSgGQR2RNK44YIPiiKTZrlv3ruzA0
nDhhPnLeDTM0jbAxP8/vkGssSnBF96BAEErIzFns1JJRcHp17ACQkuUWwLtHCfs+
BF3KeUZHNpOAW4ObS4RhCkmdSa4Slo9FAoptd0JuHqN5vHuEOhRmHwJlhWkV0zKQ
C7a4OIkVXtPZCJPu91Iy9oFfSHvrII1QHiVLRAJOtW4v7HoGynxuObRQOfS1Un9x
uXT/DJr+Ci43qFi62hBuzEzH5P9jm6VGXv/DC3691xf0BdS83+8JUAhtZdzI3+M+
Te9EsZtUDhqiskVZLbfoAMkJCWPxKuzJTMuIzLL3VPvpW1uTmme39bphL8MG/3Yw
L3tvDc7Y82VHakZ6ey5NoCC8wX7+DjtzpqQVCm1QbvbgCAsaogvJXhZv5ebKeTJA
3WKJnLZy81mrXpCZbWC3
=7o26
-----END PGP SIGNATURE-----

--3bc47Eih9dS+biPM--
