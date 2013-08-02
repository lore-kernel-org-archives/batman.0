Return-Path: <ordex@autistici.org>
Date: Fri, 2 Aug 2013 09:18:06 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130802071806.GE3936@ritirata.org>
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
 <1374888285-20775-2-git-send-email-linus.luessing@web.de>
 <cec8de3ff4ea6c6853536d1b32dc7352@autistici.org>
 <201308021205.28767.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <201308021205.28767.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix potential
 kernel paging error for unicast transmissions
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


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2013 at 12:05:28PM +0800, Marek Lindner wrote:
> On Monday, July 29, 2013 04:17:57 Antonio Quartulli wrote:
> > Il 27.07.2013 03:24 Linus L=C3=BCssing ha scritto:
> > > batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> > > data. If it does then our ethhdr pointer is not valid anymore in
> > > batadv_send_skb_unicast(), resulting in a kernel paging error.
> > >=20
> > > This patch fixes this issue by storing the few bytes we are interested
> > > in on the stack before modifying the skb.
> >=20
> > Good fix! thanks!
> >=20
> >=20
> > However, I think it would be nice to send another patch aiming master
> > which could polish this situation a bit better: e.g. by calling
> > skb_reset_mac_header() in the batadv_send_skb_prepare_unicast_*
> > functions and then get the Ethernet header with eth_hdr() right after
> > having changed the skb.
>=20
> I like that approach because it seems cleaner that way. Is there a reason=
 not=20
> do it right away ?

I thought the second approach would consist in a bigger patch and so I pref=
erred
to send this to net and the bigger patch to net-next later.

But you may be right. The change I suggested is not really big.
Linus, would you like to provide "the next" patch so that we can clearly
understand if it is worth sending to net or not?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR+10uAAoJEADl0hg6qKeOtmYQALZryYlTa6OZ5z7wdkdrTY/e
dYiTmTtja1mMYt568KXcZUFHt/JoJBV6uNOBjDQujL2HrN/kHl9Rt5jcZ9xPt25L
XF94bQ70oFRlFmY+/qMYdpb8L/6jswjHV9tveWKSzXaPfNCoIoe6jyJ/Ab8moQfc
XjgBX59oFIHZtGEi6dVUZyNaRgqDlA4q4vGkpuAFQDNtb+pWV2iIs9xWCfYQbdVR
FVEYD7AYQ9VlYxN7+dAKNexOsNxybRHJEaJoJ8bb4V0e2t5HyfxpssgANnBzQhol
WhH+Y0QE/Gw0hfV98Wv3vJtLZmykdxWjL82NSDszxhXdNOPB16a0bbWp3nGcn718
DrTcKZ6/dCWjLO405fKWAzAhb/5yTH0/+Px8aDAUH9jE6fFFnxz281g1BQORlvps
3/QQDxrAQiJ5hSlPu0b+iB24yNPZI45DmXMwA/JdsifevfOXFgu/0wb36xK+jTOX
I3tFvN5DmONg9CGdlFvJkno7O0RYeLL2kvl9DQAfQNIrMyWk8ytUyoPABvz20AK/
yYDepbfJguJPtsE6dbK86U7yHoDJrmVMKKAmLJP6p29shTmPxSNL/B792r4m3pyd
gPjCAX9L/0hTi4u0ph+V4fK+EVkIDQkfqFI/wyoIm6iQFtOoUZ1FtW5gFlUkHqHt
L6Jtci5w4lJH0AwM2npB
=kcd+
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
