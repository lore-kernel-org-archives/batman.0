Return-Path: <linus.luessing@web.de>
Date: Sun, 13 Dec 2009 21:31:56 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091213203156.GA5016@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] wireshark-batman-adv: Displaying issue with
	vis-packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


--RIYY1s2vRbPFwWeW
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The second originator field of a vis client update packet looks a
bit odd in wireshark. Sven :)? (have a look at the attached
cap-file for an example)

I was also wondering about renaming this field maybe, in the
beginning I got quite confused by seeing two identical originator
fields in most vis packets. Maybe it should be renamed to previous
sender or forwarding originator instead?

Cheers, Linus

--5I6of5zJg18YgZEa
Content-Type: application/cap
Content-Disposition: attachment; filename="batman-adv-vis.cap"
Content-Transfer-Encoding: base64

1MOyoQIABAAAAAAAAAAAAP//AAB/AAAArT8lSy9MBQCrAAAAqwAAAAAAGABuSAAAAGxsCcAA
2IEDAAAAAAAAAAgALAAGJAG3atkGJAG3YRkCIrBElF0QTqqqAwAAAEMFBQgB+gcwBiQBt2qz
ACQBt2EcBiQBt2EZBiQBt2qzBiQBt2nB/wYkAbdqswYkAbdq0f8GJAG3arMGJAG3YRn/BiQB
t2qzBiQBt2r9/QYkAbdqswYkAbdhSf8AAAAAAAC66Up0nXQAAAAAAAAAACQBt2qzAA==

--5I6of5zJg18YgZEa--

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLJU88AAoJEBKw7u43QNpf2HAP/jbeqXtGMMukjw+47AhQW88L
L2RTjPhm3wRCpLEJEFS3AnKIp8/5B3eddlokxREJBI8sEj0DvU9Ru7aCtDZ8gZ/z
Jg7m2gROd9Hi09pG+4bxiHNbYsy5y1zM9Tu2bcXGtaZYGh0MqMPCYwBWBcs7yQRX
P+g6GAkcWfSVgNZjEnHofwU7aY+AnHdZgh5OpC/kfBzcpc5V6/U7jcZQsZG/8Xyx
rix0gByj3b4gnufbTgP0wLERyPrmp8ZeZarZI9Rkc2CXonpGYZK8ENyV1QaJR0ph
cZvHoPHzQ78Vd6p2PirOFgFCfBsGJ4PnDIbyos0CFidXi4bvoShOn0F4uevKmbp9
zgXfb0CIa2k20/l6rPBCyuZNlTZsUUtDHM1uOe5U34aBOSlNYvwsnnsEt/Gy1/mM
jDldSDP97OAqhCcPsk1u+FLPLgcapqcT16nbfk4cx5M9+n9aT93evHVlBrRMAFXX
MRDPXTKvc4/2ljvpRCqUjxvNB3K7aF0+hRdMZ4cvLq2dicNDcIs9N/HG30F0FJ9J
iEdrbPGxXYP5a3bD2sxa9Jm1qzLMkZbe98OZcWIceFJcSjJa80raUOgv2qPM7wZ1
I4b0A7K6FV1MYwg/lufkLr7s3vU/X8BnNS0drDYrlOoDSD39G2E9uW/z+WUrjnim
lWvDOMLw+fs0UYYZcGEZ
=V+vw
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
