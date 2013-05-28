Return-Path: <ordex@autistici.org>
Date: Tue, 28 May 2013 18:42:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130528164234.GI3333@ritirata.org>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <1369382549-8787-4-git-send-email-linus.luessing@web.de>
 <20130528154054.GC14466@pandem0nium>
 <201305290039.34391.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <201305290039.34391.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
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


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:39:33AM +0800, Marek Lindner wrote:
> On Tuesday, May 28, 2013 23:40:54 Simon Wunderlich wrote:
> > You can safe an indendation below if you return -1 immediately here
> > if the statement above is false. Also multiple statements might be bett=
er
> > for readability and later changes, e.g.
> >=20
> > if (!atomic_read(&bat_priv->mcast_group_awareness))
> >         return 1;
> >=20
> > if (atomic_read(&bat_priv->mcast.num_non_aware))
> >         return 1;
> >=20
> > if (ntohs(ethhdr->h_proto) !=3D ETH_P_IPV6)
> >         return 1;
>=20
> A quick hint from my end: The kernel maintainer don't like code that retu=
rns=20
> "random" values like 1/0/-1. Either use bool or meaningful defines instea=
d of=20
> raw numbers.

Very good suggestion.
I think you can define an enum for this. It will make the code much easier =
to
understand.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpN56AAoJEADl0hg6qKeOJWsP/jjfIVif3CffbUE6jn3vZWyO
Ga6+ptA97zcwV80IUk1Bh5DJtYJcrozeQEnyTXnEdWbQswbD9MByOoy1RjPtTf+W
faPBBUvD8KIg9iKFVD5H9nzwmnm6vXN5rFiriOLZDhFR0Gn/OOmG7S9TPJAvETyN
MZu7MAh77tOEmwxjNrvqq7+UwSWZTh5hU2VuTPfbiN6Ujxh8NSVGxzL8mnXzOsGa
/9Rln7Vcx5SmctLFpBrY3gvw+vcmbEKySTfpIbzhSZzdd4fPKrx4b6PzFdOaBTzD
1CESph2Upvbae0wN/e5KCRrtTtikeHFpZ3+bs8TTmsm4sY57EDJ5wF/BuaMTewfY
x8S7kEAH0tp/Z0zCmzI7g2UVkH466vzzVeqRfT9+ED930ikSN3Bu826EKEh4GD89
qyUjVBeS2OqIQ2mGvhbYCcZsauDSTFdYF6MnrtbLf9Z4X8+TQUxlq8yAn9kIlJyx
icJ+Epsh2fc9A4yAnHQ4eai65cFGuOPVX5BKYHLH2fGQlIk/Hq2NFuvdmG89hdNb
gXvaISLUFq28PJiALrY7jluuDGtrszL0s8P2q90UpFif+1Z1kKu8nHPcPfOcN9pK
Kmd9UjPJZdmolFzde01m29mQS5VM43h7kY/fryMbolOwPw2D0yjdREL0sHyH9U6s
exLXqyyAWA/KsSGmdlgZ
=DVAi
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
