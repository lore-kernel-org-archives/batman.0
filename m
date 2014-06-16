Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 16 Jun 2014 16:37:48 +0800
Message-ID: <5535648.kavN49PIYQ@diderot>
In-Reply-To: <539E9FF0.1040703@jluehr.de>
References: <539E0DEF.90703@jluehr.de> <1768207.ba35ClYi8x@diderot>
 <539E9FF0.1040703@jluehr.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28643161.KSPhHQCuUy";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] DHCP-Monitoring of Gateways
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


--nextPart28643161.KSPhHQCuUy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 16 June 2014 09:42:40 Jan L=FChr wrote:
> > if you don't wish batman to interfere with your DHCP requests I
> > suggest to disable the gateway mode.
>=20
> thanks for your feedback. I'd like to keep the gateway mode enable fo=
r
> regular clients. It is sufficient to disable the gateway-mode on the
> monitoring-node?

Absolutely. DHCP packets are manipulated by batman-adv only on the node=
 where=20
the packets enters the mesh.

Cheers,
Marek

--nextPart28643161.KSPhHQCuUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTnqzfAAoJEFNVTo/uthzAibcH/1zCCaL+PnAKPj3/okxQgxwN
RERiHDdmX1dLZq5vooInFhHTLn8tI6uZv4jGZspb6fzPTF8N50C0hgG35t6LI/1o
p+UTrLq8Z30jA6M6sIGpOYHLAUydA0Nuhkw9UBACE2olO4PGhL6wiCRQC+8H7leL
6vhLTS5YYRwbV2hLYpZ/5I31/ufc8sAjnf5TkkiiMf0E4rwJRVrh6IvCaSBFBJTq
ez5IXI5S6KPI0R+vYvGp93YAlEJt2uRNJtB4+kxX2/B2t8Cgj0VY6IoGzLNkIvBo
5YwqORkaJS7IwUWBBlotnb2+DS9zx5/CYfqniF2U3Zw2Gu0RKmDkMa1jPM/mOGs=
=lS7O
-----END PGP SIGNATURE-----

--nextPart28643161.KSPhHQCuUy--

