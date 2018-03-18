Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Mar 2018 09:15:31 +0100
Message-ID: <2516855.xl4cPWQeEn@sven-edge>
In-Reply-To: <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2542043.6XW9LnRIST";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify
 batadv packet header before pulling it
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

--nextPart2542043.6XW9LnRIST
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:11 CET Matthias Schiffer wrote:
> batadv_check_unicast_ttvn() may modify the batadv header, leading to
> checksum errors in the following processing of the packet.
>=20
> Rather than fixing up the checksum, simply pull the batadv header before
> modifying it (and push it back in case the packet is rerouted).
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

This patch is so invasive that it breaks the batadv_dbg_arp check which you=
've=20
just fixed a patch before.

Kind regards,
	Sven

--nextPart2542043.6XW9LnRIST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlquICMACgkQXYcKB8Em
e0ahBRAAhdBb4XI2IA4eXosIok0xK3xrIxD8nWn//MG2/weO9G9kcWgqsjX97JN3
YEE3gLvhZpNZf8YHTycJ3OwaoEmJ52tzv/BM9oU5rUyjTXAqmzHtbqYqCg6rDyCL
8ngpMxJHVzS1yx1TeVusxJCytGmyDqAC5A78eTUnOPGA1jRDyK39sBXav0sY/Wpw
6UJJsig2Dp7E3b+bDRtPzMdgv34ZqFwEw4wFVRYJ/TFpvT+frgshw8mq7hMK2t9A
10QgsCMHe5wCsiucMRMLkHSaIXCHYOQQr7jY0gqgq5VdfNW+OtOSzC8czR70FoE0
i9RdB+jNDolH0BrwiNKgCJNvnHrpdZtN6CJbIdT2E4TGxcGFNH3z453dcn1JAbZo
qAkKkRxDrcoCGElHgM9ilD+Q5gIONEqzNdySqtH2JI8B3WIF7/eiUG2cM1eFmXLz
yz/tkl6ns2cpA/7iRuLEw5lRkHakdmViGd6n+Q8qCuRg+JCWKYhYurM20KVmkQqg
T9OltVpleAAfmpNKJwh/o5ojjJsISWjHZ2IBwd7mkhM3rRLxuzwpWnFNt3OlZMJZ
TwN4bcAB4r6acQzNJXRI8IdLM44hOIgOL3EgQ7slYaXi2OuucHx7j/6xkERrQpBW
/q4N31YCoSXa/uLIP8z5wmxGg7NeyohozCLVUPcyQOocmpmrk0s=
=mpfo
-----END PGP SIGNATURE-----

--nextPart2542043.6XW9LnRIST--

