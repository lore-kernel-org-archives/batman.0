Return-Path: <antonio@meshcoding.com>
Message-ID: <52E98B7E.4000400@meshcoding.com>
Date: Thu, 30 Jan 2014 00:15:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1391037144-2448-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1391037144-2448-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p3wgSxbwp9S3oHT8oAOmI56StOUTkPAhf"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: properly check
 pskb_may_pull return value
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p3wgSxbwp9S3oHT8oAOmI56StOUTkPAhf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/01/14 00:12, Antonio Quartulli wrote:
> pskb_may_pull() returns 1 on success and 0 in case of failure,
> therefore checking for the return value being negative does
> not make sense at all.
>=20

I should have added:

This way if the function fails we will probably read beyond the current
skb data buffer.

> Fix this by doing the proper check.
>=20
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--p3wgSxbwp9S3oHT8oAOmI56StOUTkPAhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS6YuCAAoJEEKTMo6mOh1V/icQAJhUn0W5cta/KoseMfkx7qZg
dmj6WJ4/a2L+EoLNPOao7wyW5ty2ChNHuf/IHo6ArzndsJFwcCVtCnJMBdPl6Efv
0SbYITgo6RDTsYXeGb3eQ1Zq23Tt73ByFPxGpHaLrQi58yQwSaZyIaAudUJGen05
sEE4piqAj28prrG/s6B9O3T4HmGXv+JTRCoqw6bEvtgEd58BpJggKYgNP7xZH0Va
LJ3o0CClX4Iec0tYETNyCMXECjS1bKGt+CNMzAr2CDUlzNTCCsGqdiKTxOU7+R1Y
1GdCtMOcQNLaA/N71tWPSx6JUaP3z8vIbEW6P/wuGjk2IInkbgD/2+3XP1d/96U3
Pp6IhzxUcenJ1hRVxY3DC7/DTEXkrLPypZCMzE4CWZoILPngXS6sBbwyWM996Kot
RIQvduSiE4/Ly9/1Tc5cBfmr6zMtxZef4+SMntAqimLI+39BVJME6rjcA7a2YHjH
8Ba3/iVlZ9B37/1hbXkKPUZ6m33ByYRuISnYZVuVYlYy5iV1qFTMaRj6cYBPGkyi
z6c5AoWK/b3J7FstwBpxfZRMXR6uLYX2PzBwg3b26Qmb4Uo3K5Xeq+MHnsj6xiBm
I4XBfMPGkUz4LB6LWzDZwSy9s9+UNQLHL7LLCG/glWHW7sI2ABTnM/lomwKsSXpE
YzYtWjskYczmbYSz3DPz
=4d9k
-----END PGP SIGNATURE-----

--p3wgSxbwp9S3oHT8oAOmI56StOUTkPAhf--
