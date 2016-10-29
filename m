Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 08:55:44 +0200
Message-ID: <1546440.hnPT5BvDlZ@sven-edge>
In-Reply-To: <20161029024646.GE7448@otheros>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <2315506.rV8PSJo6DZ@bentobox> <20161029024646.GE7448@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5223959.7Wq8x1LZao";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions
	on interface removal
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

--nextPart5223959.7Wq8x1LZao
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 29. Oktober 2016 04:46:46 CEST Linus L=FCssing wrote:
[...]
> > [...]
> > > +bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
> > > +			      spinlock_t *lock)
> > > +{
> > > +	struct hlist_head head =3D HLIST_HEAD_INIT;
[...]
> > > +	/* Just to spot misuse of this function */
> > > +	hlist_add_head(&forw_packet->bm_list, &head);
> > > +	hlist_add_fake(&forw_packet->bm_list);
> >=20
> > Sorry, I don't get how this should spot misuse via this extra hlist_add=
_head.
> > You first add the packet to the list (on the stack) and then setting pp=
rev
> > pointer to itself. So you basically have a fake hashed node with next p=
ointer
> > set to NULL. Wouldn't it be better here to use INIT_HLIST_NODE instead =
of
> > hlist_add_head? I would even say that INIT_HLIST_NODE isn't needed here
> > because you already did this during batadv_forw_packet_alloc.
> >=20
> > But I would assume that you actually only wanted hlist_add_fake for the
> > WARN_ONCE in batadv_forw_packet_queue, right?
>=20
> Right :). I'm only using the _fake() variant for this WARN_ONCE.
> (So I'll leave that as is? Or too confusing? Do you want me to
> reword / clarify something better in the code?)

I think the _fake stuff + comment is ok. But the add to the hlist_head
on the stack is confusing and maybe should be removed.

Kind regards,
	Sven

--nextPart5223959.7Wq8x1LZao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYFEfwAAoJEF2HCgfBJntGrCAP/j1OHOObrkyRtOYGL+ZqataH
TDjPI1+7m7pe1aOIGE+nNIjdkFww5mZ3CHA/BivKeESH8luOaB+L6koc9kkbHWr2
SyzSNajDi4Iq7mrlP4HNmw1EhODd7sZ5BcMplfMOBBGMiKAwI1jDUCrTtCEJzcqx
ChHz8YsZR61uRHEWL8wFrdJdKHcwgwb4e0YKURlrIEbJXe1XWsvm2SEOYGeNj7sg
QcxF4WMFY5gF/QYREvoHGTrI7p5/jAEhHetmqZNXC3gQ8jW82jydKzlFQ3SspXaM
w5zBP//UnNnFOli8LUchpgdq1QmxONy/VmAwlCsCwcrFwsXe1Id+fDXPW6N+k0vM
7i61HgZrGOD3juVGMNfGHoZUoliWnXujSgJ2CCRm/jfuCwvi+vQrOMbv8nCWx1Fx
AoRwxDg16wQ7jKJE3b4R9n0yU/bD7Lsl3+y4TcaEGkKX4kLSV4uWvGQJ9R3olg1y
5iSDtRi4kMyyhqj/nPgS6zJUqNgmNoVF131MbbGwwcQ7STlCOvyhiiS08T+sITeR
E/XU0fEFgK0HsiuG9DpBYlhnJgwBMR5k7NMcx0TUuZciZ0bFr5qS6vYJddpp2B8i
7PuKgavIuyZlVN7dX3ioMIZSq2bAVQqIzB4ErNh3Xi7RJs+p0IfSvAhFIKbNbsJt
Tbr7L3Dp250K9y01/2/U
=Z3Cc
-----END PGP SIGNATURE-----

--nextPart5223959.7Wq8x1LZao--

