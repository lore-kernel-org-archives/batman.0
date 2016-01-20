Return-Path: <a@unstable.cc>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
 <569F9AF1.5080403@unstable.cc> <6579684.ngYt9xsEyU@prime>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <569FA717.5090108@unstable.cc>
Date: Wed, 20 Jan 2016 23:26:15 +0800
MIME-Version: 1.0
In-Reply-To: <6579684.ngYt9xsEyU@prime>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dbolMC3HjfA5pdnAOr4VNqrJgO7KIfa3t"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
 batadv_v_ogm_forward
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dbolMC3HjfA5pdnAOr4VNqrJgO7KIfa3t
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/01/16 23:18, Simon Wunderlich wrote:
>> this is changing the behaviour.
>> here now we get a router which potentially was elected during the
>> previous update_route() call while processing this very OGM. We are
>> still discussing if we want to do this or not, but this patch should b=
e
>> just a style change, while this is not.
>=20
> No, this is already in the code which is merged into master - we alread=
y=20
> acquire the updated router (see bat_v_ogm.c:547, function=20
> batadv_v_ogm_route_update()).

uhuhuh?! Actually you are right!
This means we currently send one OGM every time we make an election,
thus we might send multiple OGMs with the sequence numnber, despite this
is still under debate.

As far as I remember did not want to follow this approach at the moment?
Am I missing something?


Cheers,

--=20
Antonio Quartulli


--dbolMC3HjfA5pdnAOr4VNqrJgO7KIfa3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWn6caAAoJENpFlCjNi1MR3OYP/3eO9Zksz8VNCu9UG2nNO5JG
3uFUH8htDEsJVaR72Ex3hYXoCxLJykRyBgsCr3SmcqMCZHRss7LyZmPcs3emOTON
QGadfYHz3mcrBUs+6nr8dWmmUjBZG8hsD+P3OfZVRKkHX2PdzcvqavUP0lCp+8wp
B82Ddc9HnsQTSxZZJ2A9M+0MSPR4XUWX2nTT4xz5Nm+O3QHZS2q1K34cpyfQJTKT
3Yzt3FxFvBrdmiB/CxoI9sv50gFChqphLFpdmBCWTsO/TD3dqLng/cuEpGIJH/Cm
GhZbGoKK/lWF6I87hi1YJlMhyXaFnUyPjy0dfsAXwfdsXqsGW6MpAen+Ub/nIj41
NKARPvhicr0we389JdjKAoNhJapR9QhzTXioESTInY7QtoLZiziE4/WeVUz7CRii
KivTgMGnB1MEJbs+vw6KOTefeNZywUIRTEI4dFi5NVvhYWqEuPq9TF32Qz/7Okgu
JadKRcgP1KuRGnfkO1UbMqQh5WUNHOXYepwUDCWRom+D8ZSPWhgRVYbJYHp+tDYN
d8vfIGLwyRq/fdFC8M+0GoD9WC07pKQYaQ3+iI5mWO4ZH26fH8XoGHDb4mGvjC1a
pTTnUxx0bMqLIR4bYywi4dBOP5U0uzNvpJoClL54OvtVwGKTVL8DBmoYsmBf8sSr
WVj2X9r7oTtLTDBFqIzO
=dtYy
-----END PGP SIGNATURE-----

--dbolMC3HjfA5pdnAOr4VNqrJgO7KIfa3t--
