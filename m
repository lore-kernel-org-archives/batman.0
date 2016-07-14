Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 14 Jul 2016 18:06:51 +0800
Message-ID: <4035822.YIsW9Fcbba@voltaire>
In-Reply-To: <20160628021441.GT4407@otheros>
References: <1467008142-3797-1-git-send-email-sven@narfation.org>
 <20160628021441.GT4407@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2897938.ntjAqnSnSN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Remove orig_node
	reference handling from send_skb_unicast
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

--nextPart2897938.ntjAqnSnSN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 28, 2016 04:14:41 Linus L=FCssing wrote:
> On Mon, Jun 27, 2016 at 08:15:42AM +0200, Sven Eckelmann wrote:
> > The function batadv_send_skb_unicast is not acquiring a reference f=
or an
> > orig_node nor removing it from any datastructure. It still reduces =
the
> > reference counter for an object which is still in the hands of the =
caller.
> >
> > This is confusing and can lead in the future to problems in the ref=
erence
> > handling of the caller function.
> >
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> >
> > v3:
> >  - adjust commit message to sound less like an fix (thanks Linus)
> >  - Remove " and release a reference to this orig_node" from kerneld=
oc of
> >    batadv_send_skb_unicast (thanks Linus)
> >
> > v2:
> >  - remove bogus multicast example
> >
> >  - remove Fixes:
> > ---
>=20
> Acked-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied in revision d7d5613.

Thanks,
Marek


--nextPart2897938.ntjAqnSnSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXh2Q7AAoJEFNVTo/uthzAR34IAIXq+Lnkwkxr5laSTK302CBN
g/7hHGVKYOP6PUYat8VWdJCbYHWeXLDlf7kqYEQyB0hFay1cciUuUexUl+b1WvWs
SqL1B2DdiYiGdtvV0GgiRFlIBrmLURDCEIp+qj2Q590HkAaVf91KfeoPo0qfYOu9
I9cY07R9HWlqc3D/hIg+FJJBxR6u93ifpA/hALebPKMcV7kXKeUqtznqLCJf1Gz0
l8SpOUpjcALgc7vO8pf5FN1KWcz7z3GLP/5A9ESnplOeKcHrB5JjPVnaS6qhWieC
SIrqWNHICdBCypjiUIvG2YItMfOR1YsHcNWA+x1h1nS5JQbMXpGmTxs8X65hWW8=
=oyCF
-----END PGP SIGNATURE-----

--nextPart2897938.ntjAqnSnSN--

