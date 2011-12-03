Return-Path: <sven@narfation.org>
Date: Sat, 3 Dec 2011 09:55:52 +0100
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20111203085552.GA8944@sven-atom.home.narfation.org>
References: <20111202171216.GA4561@ritirata.org>
	<20111202.125725.896787381527077500.davem@davemloft.net>
	<20111203015528.GB3148@ritirata.org>
	<20111202.205955.840690319685535229.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20111202.205955.840690319685535229.davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-11-26
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: davem@davemloft.net


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2011 at 08:59:55PM -0500, David Miller wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> Date: Sat, 3 Dec 2011 02:55:29 +0100
>=20
> > We first call pskb_may_pull() to pull the header only and then, under c=
ertain
> > conditions, we linearise the whole skb to access it all. Should I use
> > pskb_may_pull() even in this case?
>=20
> Why would you need to access the whole thing?

It contains only information for the routing/pathfinding to client nodes (n=
odes
which do not directly participate in this mesh).

> There are only two types of possible accesses:
>=20
> 1) Header parsing --> use pskb_may_pull() as needed.
>=20
> 2) Copying the data to some other location, such as a user
>    buffer.  Use skb_copy_datagram_iovec or similar which handle
>    fragmented SKBs just fine.

I think a "copy" using skb_header_pointer/skb_copy_bits would be the right
thing to do. batman-adv needs the data for kernel data structures and don't
send it to a userspace program (at least not as primary functionality). I d=
on't
have benchmarks which compare both solutions (with a heavily fragmented skb)
when accessing small, packed structures in a skb.

Thanks,
	Sven

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJO2eQXAAoJEF2HCgfBJntGVz8P/38+/7MhN9RwIxMl3cWSpS/J
2c/dkIzjU2kyLjGgZk3Pv3CLpQtcQXU7TMkAa6+2oIcGe5Ou5AFYZGpvjYPLo15W
tvPagD81MraTBu0n/2dcRPtE4JevKMoETB2LbCp55ODwTiXfTrWWHrJk1Gbfr6ng
NTR1YB2rft5f7wxMepmQTtONpVJfpUbT7CJx7uCQ8MusI7mVLH2Ye+8Ut0VeSvqK
MzVZEcglbbf4jTWLd7Sm5odiHJjA1lvZfGeyGpPf5MNMWUnuUKcLVO+0GypfLdCk
ytHRJ0dWTG1OZrYYPx6qAHKajQajDhIRvNrdTSkOTGDiZgMeuSBD/7uRZJFgZtHn
hXMGGXvRtuwauNt2JYWMtI6HS/cI6nYCyTbMUkh9evWRwLczk+NwT7fOf4QHWVJv
XuG8yXP1Uwp5/s3IXLi9eSngTZbetLQUavgBrZiOueXHhtBZnS0eqmbEbV4rHN0W
58eUBaTPUOs39z7UmCMmEdDURANUT2ENQ2KnG0jQJYJYmm+b94l1d7L6YJ/d/VDK
IroQ5QFweBPNQpS9dLbfcUwKGSGwb60WJEr2iwqa8EmUWRu/xo3aAiww3Ufndff4
CXLdT1saYNRGf0rK9GgEmUBZLTQoFtiWhqKXNHGygizU0sM1sP1yhsnKVKv1AP7Y
uekZ3lOHKCiTxu3FGKGI
=63eD
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
