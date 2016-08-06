Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 22:48:56 +0200
Message-ID: <7972495.i0KZyMIKbN@sven-edge>
In-Reply-To: <1470514996-32044-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470514996-32044-1-git-send-email-linus.luessing@c0d3.blue>
 <1470514996-32044-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1677881.lployVgnpN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: Use own timer for
	multicast TT and TVLV updates
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

--nextPart1677881.lployVgnpN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 22:23:16 CEST Linus L=FCssing wrote:
> Instead of latching onto the OGM period, this patch introduces a worker
> dedicated to multicast TT and TVLV updates.
>=20
> The reasoning is, that upon roaming especially the translation table
> should be updated timely to minimize connectivity issues.
>=20
> With BATMAN V, the idea is to greatly increase the OGM interval to
> reduce overhead. Unfortunately, right now this could lead to
> a bad user experience if multicast traffic is involved.
>=20
> Therefore this patch introduces a fixed 500ms update interval for
> multicast TT entries and the multicast TVLV.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v3:
> * added missing #includes
> * fixed parameter kerneldoc of batadv_mcast_mla_update()
>=20
> Changes in v2:
> * updated kerneldoc regarding bat_priv->mcast.mla_list "locking"

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart1677881.lployVgnpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpk04AAoJEF2HCgfBJntGlpUP/11ZNFWKK5FUhKhXYBdc1j64
B47X88b8KL/v+MKAyfPs5A+3qjaYL1aTUWq4gzpNfQrfkdQipMZMagCy4ecErwmv
PWsVn1KcRJnZ0eUL5lVArhFg2L9aVgBaf1GIy1vL8l2+e8o3nY1QbLGugQ6L5t0z
N6CrPGUbV4N9IA5d+KmCqhJGIXuzBU9h3yCpzKl42FrhYh/tZ7r9kTZAKrBNVayf
089sOt3CGKiK19ApMMESWQxs0MYDbCNfZVahWS2Z4VJbxgJz/iM5SXSmSjm+bWtf
l3y9svqoWEBQ3+izOmOCZ0FA7kmTTtOwdUHYSAnHYZC3wLiCgZLOzHhzEDfr1rP2
W11V4tqRq8QcFN8ePx2VBLjA/IgAPibVLsgJ7Jck8mxdyvCz2iYk196MaveWOYTY
UYSiYIQZJEXuJQnrFuJ8m4ivBA1wvbjKjYiCydzWYU6J/Nz39/j8rwRttTqOOuml
19eFilec1WRMKPkjI15H/PrcKJPPmXnex1I0QZhWoo0ur0NTthb0wnyazjGyp+zF
JznxfC/neX94kpCNqf7NUqyudbazs9IlfpUktcufaEbK6tGFUhrL80DbIpKCkeQE
SvqNj+eHVPy0j2YmAHnhVHaTAugz80aDghmvCuO4I8STARjnNJ7zDj38CanR+BjV
32FLMWTAJFXIfTqcD4dz
=qm/w
-----END PGP SIGNATURE-----

--nextPart1677881.lployVgnpN--

