Return-Path: <a@unstable.cc>
Date: Mon, 1 Feb 2016 08:48:26 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160201004826.GL22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-3-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <1454257280-19649-3-git-send-email-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 3/3] batman-adv: fix misleading
 default throughput warning
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 12:21:20AM +0800, Marek Lindner wrote:
> The default throughput value represents Mbps and not kbps.

Isn't this a bit confusing? The default throughput is expressed in multiple=
s of
100kbps, not Mbps.

the rest looks good:
Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrqtaAAoJENpFlCjNi1MRkukQALbcqNs+rCO2tRnA0J2xd+71
Z/foSek5lFd9XTrFdvcQccZU41sanZfwxnjmSa7iVMtOUaeKPBmyAcDe3eZQBdIy
blwe0Ln2J0Sffi8zLijm0MYPs7NzHULkJt8uZkmf5KOaGy2HfZK/I9KYQFsU7U5T
6tHfNj6qW9njeAA1Tjh4w2IiwPrWULrcrqMvrDejeUT2HvY1B+9+my3rUEu9BdDV
ikups/U/HY0Y5WPLkMpJJQdgWGCZsZ6o5pX/vJ459Alkwn5PHTWCI9/WJXECqzvm
9/J5IqspJohEnY1pnTMbdXrR6iti5Zjt0Iw6LVLswLXCyJ2349zVAzOVdBzH6LVW
DSqKV0uoa4QLnFhvaiQejL8t13A7bbubFLiHtZOFbUGH1HgOC078XF8e0m31am8j
wkQF39hHS4MU6phM6TTo88UCw4Gdz8Qdqwey0kgoYE6/qDLtniN9gKZ7npODqL73
iEBGOsuDdp5yWVtWb/6+O0SRZ4U5GgphUSNbYFp6c+zDZqOOFcTHozEnZRPgFI+8
TIsHcC0bCRtW25KhRIGr3Q/mGdro8Bm2a+yE09oOyuQsfM3NWiDMjfRo3FJMoWBc
DI3z4Z9AXBf4MqTnmOEJFw2hcI3hkAPAW6adY4GT6+1JoV7X547Y6Wd58MQuWgiT
MWgCDFvH0Z9Zrtl5j2x3
=zTpc
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
