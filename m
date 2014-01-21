Return-Path: <antonio@meshcoding.com>
Message-ID: <52DEC3CF.4020608@meshcoding.com>
Date: Tue, 21 Jan 2014 20:00:31 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com>
In-Reply-To: <86mwipch0u.fsf@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VIR0nEqIp2V4JpJnErJCbjsCA0ELKfBaG"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
 computation
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
To: Russell Senior <russell@personaltelco.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VIR0nEqIp2V4JpJnErJCbjsCA0ELKfBaG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/01/14 19:43, Russell Senior wrote:
>>>>>> "Antonio" =3D=3D Antonio Quartulli <antonio@meshcoding.com> writes=
:
>=20
> Antonio> The current MTU computation always returns a value smaller
> Antonio> than 1500bytes even if the real interfaces have an MTU large
> Antonio> enough to compensate the batman-adv overhead.
>=20
> Antonio> Fix the computation by properly returning the highest
> Antonio> admitted value.
>=20
> Antonio> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com> ---
>=20
> This seems to fix the bat0-MTU-unnecessarily-small problem I observed
> last night and reported on the IRC channel.  I haven't actually passed
> any traffic over it yet, but the interface is up with the expected MTU
> value with the patch.

Just to be sure the fix is not introducing any misbehaviour: have you
tried setting smaller MTUs to your hard interface? In that case have you
seen the bat0 reducing its MTU?

>=20
> Antonio> This patch is missing a Reported-by clause because I did not
> Antonio> have "russell"'s email address at hand.
>=20
> Antonio> Will be added later before being merged.
>=20
> Reported-by: Russell Senior <russell@personaltelco.net>

I'd also add Tested-by ;)

Thanks a lot!

--=20
Antonio Quartulli


--VIR0nEqIp2V4JpJnErJCbjsCA0ELKfBaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3sPTAAoJEEKTMo6mOh1VrQwP/3FtYOzg/oYANZRS/3wb0WDK
UZLZVPz+aTspGmK1H7iAw54u1vJ/x9nkqn93ycqxL6GXFkdqBoBCh+ymWhmQ4pYg
uOZhkhqWKLPgf5dkWMrnS0ZsMFUHaI57kFmaFYSFU/R964wotyBTv/vAZJEZgStP
igDokmQEJlMMwqIh93hn9qAkB7fs0JdVWrWsAZR/n7a1W2U8DgHOyUgfIs2P9OVR
EWXexaSjCUM2VucRvMhaS9XWr5V/SWrVt5spJbWuc5ILUXWL3XPf6VK6CZme+FKL
ptmjTONvBlcVVuiUwbS/7mpDgF3adYgzeNYvaMyRixpui34VPoGywMsIienb7GEO
GHpljxKzEISMlyHwMkKZfHzOrTTpo61uZluzoePgUYV7gqJD1vFzH9XM9SAKQok4
ctpDd0yBLvdugfUC9qAEAayXaGumzvwVE6i/oieobz2D5fUmZnDHtjaUFV62FZLy
G2xnrbB9JrkxbYmugNruJRgsLKQmTW/xBdJqw9MOGLeqQcvrFtk8ez24anSidkN9
x5k4mEnL/pMH6rn9hf7e6tJi7PUVpIwBfQIn1m9jMPxfIrQOR+BmrUcecDiMvlMe
0qokfsOfOanq2j97Xn6c4ZowKTEv2XYvxy033Pn8zYWjH8AKX/XJfxivjrPqFJOI
lF+iLPz4RDzgqHFHChMC
=Nb+g
-----END PGP SIGNATURE-----

--VIR0nEqIp2V4JpJnErJCbjsCA0ELKfBaG--
