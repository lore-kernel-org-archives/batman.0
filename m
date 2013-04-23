Return-Path: <ordex@autistici.org>
Date: Tue, 23 Apr 2013 21:30:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130423193004.GA16603@ritirata.org>
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <1366474654-26361-3-git-send-email-martin@hundeboll.net>
 <201304240317.27196.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <201304240317.27196.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Receive fragmented
 packets and merge
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


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 03:17:26AM +0800, Marek Lindner wrote:
> On Sunday, April 21, 2013 00:17:33 Martin Hundeb=C3=B8ll wrote:
>=20
>=20
> > +	/* Make room for the rest of the fragments. */
> > +	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
> > +		kfree_skb(skb_out);
> > +		goto free;
> > +	}
>=20
> If pskb_expand_head() really fails this function will lead to a crash bec=
ause=20
> skb_out points to undefined memory.


I'm not sure about this. pskb_expand_head() can only fail in the early phas=
e and
in that case it seems to return the original skb as it was.

>=20
> Btw, is pskb_expand_head() enough to handle all cases ? Did you try this =
with=20
> a large (4000 bytes or more) packet ?=20
>=20

I don't personally see any problem with this. But maybe I am overlooking
something..however, proper testing will make everybody happy :P

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRduE8AAoJEADl0hg6qKeORl8P/j2xWzHNBcd1nRniIfNOaX3S
7KfUWKfuv0KVrVOlFm7NFD44GWZaen0Pa/3FtQkoP9XYpopb7yY0k0tf1WobtXmE
AYWPOGGYbaIPKIDKbQGhMjlRpwgMoW7A8KzUBWL1z6PQHuWf7IlioKr/zG5VKr+e
N+K13f0aYQ70lD6vOOflhWIWeVLajASX2At9aL40sn1z9K6CDRLpuVxDkp+DQLXO
2dU7pW1nqtV3OXbrdAyT18SnUvohz5PrVqQ4mSWRa60oXP8iexStMU9F+eOHYYxv
DkLotb05S0cHNxCqcYqkIdIE3JnXr4e1dAwQBfb4dzMBXEGc60h+lmUne61MyaLM
fag/eBKbosdNMkcWYBknH7+kGFItVbQ96syDzQcOjG71ZY0htK8fwtJ69S2fJd5v
bAbRlo5aw4ifFSY28bMJssVsQVv66ZFvgjUJVp/ofISlNGuD12qoL6sv7aHI5+41
ZjdjA64VRpZtZBdN4fhUt2cycInmY6NFUn98hJ8JIG2L/k1pn6v5o047pvf37GZt
jbNpk4pIObw7XrEyIOTy1PBvscCvKwSPcXlFqLyG6SqyQQLfqeMPuxhWEB9Cnz4S
S2Ku4+0jzKnDobeTcR9U8Tl4uczNr3Se9oNLN1mm3va0+g9dwFuWp+M4+3vnEf6R
R+MNUJD26BwuIgzdvWSW
=idZd
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
