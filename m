Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Jun 2015 22:38:20 +0800
Message-ID: <1780825.BpgRJrjhz3@voltaire>
In-Reply-To: <1987884.ZZQIqrk8nR@voltaire>
References: <1434460643-3681-1-git-send-email-linus.luessing@c0d3.blue>
 <1434460643-3681-6-git-send-email-linus.luessing@c0d3.blue>
 <1987884.ZZQIqrk8nR@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2249470.WApmfOa6qx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint 5/5] batman-adv: Fix potential
	synchronization issues in mcast tvlv handler
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
To: b.a.t.m.a.n@lists.open-mesh.org, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>


--nextPart2249470.WApmfOa6qx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 22:12:00 Marek Lindner wrote:
> On Tuesday, June 16, 2015 15:17:23 Linus L=FCssing wrote:
> > +               /* flag checks above + mcast_handler_lock prevents =
this */
> > +               if (unlikely(!hlist_unhashed(node)))
> > +                       BUG();
> > +
>=20
> I don't think this will work because hlist_unhashed() checks for node=
=2D>pprev
> being NULL or not. hlist_del_rcu() sets node->pprev to LIST_POISON2.
>=20
> We could also use BUG_ON() for readability. Something like:
>=20
> BUG_ON(node->pprev =3D=3D LIST_POISON2);
>=20
> Though there are not many code sections working with LIST_POISON2 out=
side
> the list handling code.

Correction: Sven pointed out that we should not depend on LIST_POISON2 =
as it=20
may point to some valid code or something utterly random depending on k=
ernel=20
configs.

I had overlooked that you had switched to hlist_del_init_rcu() already =
which=20
makes your check valid. Still, would you consider using BUG_ON() ?

Cheers,
Marek

--nextPart2249470.WApmfOa6qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgDTgAAoJEFNVTo/uthzAyGAH/0QEKxFtZRyxQT8dJ2nZvvlb
Vt67rT3+BK6GSaiEJRTPgQbQoMnuLZpSVZXA4wTmD1wIz4ooFQEXfQgkR83p8Lac
IwkVCQ1+QwmBctqKD6ZMEE45G1WImc6tW+6TiHXiqzdaF1yh0zVKebd7vAa/owv7
YC2xnWTrWKzMbU93Ci1DQTA5sR4nQZD+U/JLWdrqXQsp6ojLxZvbYPr4S9NPvMrK
myiutNgcx2Wixk7GJPHk7mlSTRBCoH3gnytkYgFaRQDe3LG7yTIXqAMlV3Kbskdq
AF3Ur/wNdLxdukPAwR+A4EyuGSw9smcqzzgaRYljVvzw+WzP3ZtzFbdKNU2UmXA=
=k3C7
-----END PGP SIGNATURE-----

--nextPart2249470.WApmfOa6qx--

