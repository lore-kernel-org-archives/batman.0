Return-Path: <sven@narfation.org>
Date: Thu, 26 Jul 2012 00:04:53 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20120725220453.GA19817@sven-atom.home.narfation.org>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
 <20120725203425.GB11999@pandem0nium>
 <50106102.1080406@eigenlab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <50106102.1080406@eigenlab.org>
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2012 at 11:11:30PM +0200, Gioacchino Mazzurco wrote:
> I have not followed the whole thread but i got scared from this reply
>=20
> I hope I misunderstood
>=20
> if i do on newer version of batman
>=20
> $batctl if add eth0
>=20
> what happen batman will use this interface to do "mesh" or will simply
> ignore it because it is ethernet?

It will be used by batman-adv as mesh interface because you explicitly said
that you want to use it. This is what Gui wrote. Simon only said that this =
is
the expected behaviour.

Kind regards,
	Sven

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJQEG2EAAoJEF2HCgfBJntGF/cP/irwO6WbHkhnewJ4yahixDnd
XXtnyaZW1Dl7mF8sGNAGCNFSplJG5eRsg4UHLxGJHHPWZu7A2KE7404r6ESe3x66
26eYLJOW4OdTMyDf4kGa2qcmAiAZoyWJmLEZyDatGkeVKfVquSAzALfedtJkQ2mE
pIWgzQqhFyqtYdiHPb05WUc5UK2KGJHxsDdmeV15inS5FaNqYFRlxdQRAtCshRHw
rPAk7a1AwOQNy1Um4/ZfgFo7x5jsGINpSf4LhSRko4wF35t+r25vH6YZPcgau7WS
pcskSJGPbwweeBvSjp8OZ1ykud0bEMz4EaZ8Yf4OZeEWjo9/6F6J8uv5c1lkp4kV
eCn4WTW49N/3kdGuur+UGOl7MgB9342uIPu5Umi3SZt6Ng1Os4SjC2imAZzmvKsB
B0KD9aR6nk2/lE2jffMaxpOFx7h9WVH7qCXNu6sOXL0JkckQupyoVp9ySBQw50tb
sp+l0VCXZCBvgfBxca8Ym8EHP5nDzboWNLl1Nw17qXufRqwCkC4f6wzoUeNXIDiF
bxB9qH9hi4uy0CUa/NVeTwOtOQtWOrksvgtxe2pBABEXxWgy8NSPXTTd2936L0ma
d0oGoSt6PViNDIxveFXWJcKuN0sQ9kQ7JnVKPmYsOuZLQmOJ04vq1F5UFOgJ4LlM
5vKq4zH4F5BHLWOFQeoN
=C8Vx
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
