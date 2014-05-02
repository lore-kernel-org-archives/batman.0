Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 02 May 2014 13:15:52 +0800
Message-ID: <2040685.FpVyDFGQG7@diderot>
In-Reply-To: <2f36d18abb7317500c72ae4acf388e9f@hundeboll.net>
References: <1398254716-22089-1-git-send-email-antonio@meshcoding.com>
 <2f36d18abb7317500c72ae4acf388e9f@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1731820.FIjhaXYUxs";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix reference counting
	imbalance while sending fragment
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
Cc: martin@hundeboll.net, Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1731820.FIjhaXYUxs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 23 April 2014 09:40:05 martin@hundeboll.net wrote:
> On 2014-04-23 05:05, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >
> > In the new fragmentation code the batadv_frag_send_packet()
> > function obtains a reference to the primary_if, but it does
> > not release it upon return.
> >
> > This reference imbalance prevents the primary_if (and then
> > the related netdevice) to be properly released on shut down.
> >
> > Fix this by releasing the primary_if in batadv_frag_send_packet().
> >
> > Introduced by db56e4ecf5c2b179a0101138eacc2ec52b6ef45d
> > ("batman-adv: Fragment and send skbs larger than mtu")
> >
> > Cc: Martin Hundeb=F8ll <martin@hundeboll.net>
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

Applied in revision 113f264.

Thanks,
Marek

--nextPart1731820.FIjhaXYUxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTYyoIAAoJEFNVTo/uthzA2jAH/3SO6o+g/7MxCPW6MTx4nCsG
13NkO6AV6zru3jPAmWS/o0CsFFdHV++ud/tO/8wwN3qIqJvEv+UzbXa/A7wMJrzO
Cu41HHCLpDk+XfwFPBKJ2O76nRWLrvG9gjht5l1UOLWqwmIxh7LiOmzOgmVDTBmW
yVpFCPbRQc05kFiPUNjeK1kvxVxm2ayk65ywSouN+XJDpFtLsL1Z5EDxj9WiSVZh
ToGyWzgZ/W+B3sUxZbtSBoZV9XPROqsDEuMV0L5rNjQ1HNDkvNGlENpqI7u1sLEU
XY4WmSRxPYuUTDgT5TTMMR+6soTR9OhvybBkPHxzXyXZoZ0q0dxv0fZL8+SSnXM=
=bgkY
-----END PGP SIGNATURE-----

--nextPart1731820.FIjhaXYUxs--

