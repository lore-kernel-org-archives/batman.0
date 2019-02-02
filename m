Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 02 Feb 2019 06:14:41 +0100
Message-ID: <2472562.MHgaaGEVWG@sven-edge>
In-Reply-To: <20190111210208.29139-1-linus.luessing@c0d3.blue>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3498737.TloBn7NiVF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, mareklindner@neomailbox.ch

--nextPart3498737.TloBn7NiVF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 11 January 2019 22.02.08 CET Linus L=FCssing wrote:
> Currently, the DHT_GET messages of the DAT will likely be left
> unanswered due to the following issues:
[...]
> With this patch the purge timeout for local DAT cache entries and
> entries submitted via a DHT_PUT message is differentiated:
>=20
> While the former stays at 5min. the latter is increased to 30min. Which
> decreases the rate of broadcasted ARP Requests.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

@Marek, if I remember correctly, you had some issues [1] with this approach=
=2E=20
Could you please check again

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-June/017881.html
--nextPart3498737.TloBn7NiVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxVJ0EACgkQXYcKB8Em
e0ZxSBAAhzaL5v4n1T8Zi5dyuRgdQ61uHPRmTiXq0EvcVwZKLEJYiv0TOEmL72PB
OL8Ssuyz5TREGCGblfkT2ZpSL+Eo6CwDvbioO2bb1+X60PqG0hHkFqzkJXK9Ol4W
QpGXlc9jVOaC/BobaN9I4wSyXlPx51/FqvPWjeVDp7uFXLSQHjN/NNhthFj96Cg3
wDAygNtI1EGhbTxoN80Z9oi/41QhY1ujm7MyMT78+foifJQG+DjorbIhJzkxWk9x
CAzbpxTPD5PSOcuMe2BjyU+DoNbKZnmvNTJbCalYpjPFEytFrU71YMaouAdhf7QJ
/VEV/BuamcZT+0sgOYeDyMGRHbB+o0+gs/iQCshxkD6KMG7N86yyXqdTWRrut5qk
dtKVDWO3tLA6kVhIXXDOdXjJBGEIN+Py8dG4IppzzSL2MREBEVDDYpqkadJRhEVK
bkrfO2kz5vqs5K/p+xG6pnxmyW1aeva5dztM0FOvC2pemo1/ZIjlZEbOZXV6TzKt
Wg/heYlyojJ6YWodmUfv5XMNi7KgjtQsytnA8vE7zCSD2MwtgkqYuy95Uc3oZRPq
f0cuMRCHXyeBPP+QuKtDZXjNxV+vNgfepAfPH80OJACdzf1CHDFBR1XnnQGyGTwK
3jtQuWtL+77lPpOeh+Xm/o1f9BPSN2u78C9UYzGdJ/P7Nl1/4Zw=
=0J/i
-----END PGP SIGNATURE-----

--nextPart3498737.TloBn7NiVF--



