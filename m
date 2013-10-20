Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Oct 2013 18:26:41 +0800
Message-ID: <1989798.ZHJlJXvcrz@diderot>
In-Reply-To: <20131020082506.GC13550@Linus-Debian>
References: <20131020082506.GC13550@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1429730.uhjTrqhjtF";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] A few questions on TVLV
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


--nextPart1429730.uhjTrqhjtF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 20 October 2013 10:25:07 Linus L=FCssing wrote:
> I think I had posted some thoughts on the TVLV feature on the IRC
> channel before with some suggestions for changes (e.g. moving the
> TVLV feature from the individual packet types down to the common
> batman header). And had tried to come up with examples for
> features where TVLVs for batman broadcast packets could be useful
> - which might have been potential, but not the most convincing,
> not the most awesome features.
>=20
> So now I have a feature which I would like to have / would like to
> work on in the future [0], and I would like to know:

Before we discuss how we get TVLVs 'down to the common batman header' w=
e=20
should talk about why that would be useful. What are the advantages and=
=20
disadvantages ? Adding tvlvs everywhere for the mere sake of having the=
m=20
around isn't good enough as they increase code complexity, network traf=
fic=20
overhead and encapsulation speed penalties.

Cheers,
Marek

--nextPart1429730.uhjTrqhjtF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSY6/hAAoJEFNVTo/uthzAE3oH/2Bh4mSrbkeShbVYDX6kibgv
vTaB2nXN7PbAoQY4YAVBHvUWISWWmj3Z/ZwFHsGejokzGbzWwZ2X5JQLBVSr5zSV
aH3Mh26pibUJCgfklcPkvd7wBA509w1vcGNDRa4N70aq3f8KContgtis4/WU5Izn
wkujXu+ocRvPYM0KdsqvzaRgimLTgeTFHsCI34MrU4LAjHs5KeUL7VNBaZu3nZn5
NauQBpqArZ6eMz/5029c25d8s+xYUP1soU+nhcb5Qzx6i6sCeAyUk2yL2/oe5Mc5
5dNPSfsHlO0dDwqpCoOsxRxNrzOgsLLlQnODMVDJWTXyamDC3N5dpUajhdAaVcE=
=WKGm
-----END PGP SIGNATURE-----

--nextPart1429730.uhjTrqhjtF--

