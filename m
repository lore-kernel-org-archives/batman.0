Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 08 Nov 2013 23:57:11 +0100
Message-ID: <2195225.ZahV9KD01s@flohlap>
In-Reply-To: <201311081051.26384.sw@simonwunderlich.de>
References: <2578313.zUW7Pc5dQb@flohlap> <4645807.Ug7HQD34Gu@flohlap>
 <201311081051.26384.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2188296.hOi2zoikv0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Bad link quality if routers are connected by 2
	interfaces
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2188296.hOi2zoikv0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 8. November 2013, 10:51:26 schrieben Sie:
> However, a2:f3:c1:5b:54:a6 is used as Ethernet source address for sen=
ding in
> both eth0.3 and wlan0-1 dumps. Is it possible that there is a mac add=
ress
> conflict?

Hi Simon,

this seems to be the right hint. I checked this and we really had a mac=
=20
address conflict on the interfaces wlan0-1 and eth0.3 we used for meshi=
ng. This=20
was due to a fix for some mac adress problem in our firmware that seems=
 to be=20
outdated now.

On my router the problem is fixed. We will check our other hardware als=
o but I=20
think we have a good chance that solving the mac adress conflicts will =
also=20
solve this link quality problem. If not, I=B4ll ask again.

Thank you!
Clemens
--=20
#Clemens John <clemens-john@gmx.de>
#GnuPG:
Identifier: 0xD92F6BA5
Fingerprint: 1D6D 3EC6 C80F C1D4 CE1F 1133 6607 476C 0DB6 96A3
   Always encrypt your messages
--nextPart2188296.hOi2zoikv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlJ9bEsACgkQZgdHbA22lqNhxwCdEbBop3pz2DdsNpbYs6ewvUV3
ltUAoKRIbJn7wn75TFkfHqAiygtqDIJM
=3U27
-----END PGP SIGNATURE-----

--nextPart2188296.hOi2zoikv0--

