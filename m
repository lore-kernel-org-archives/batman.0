Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Mar 2018 12:31:56 +0100
Message-ID: <1575600.30KXpZVktj@bentobox>
In-Reply-To: <3cc8fb9bb6b983a5b7972af2fd803041095d8c90.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <3cc8fb9bb6b983a5b7972af2fd803041095d8c90.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2471968.jtsNytXB6p";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: fix header size
 check in batadv_dbg_arp()
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

--nextPart2471968.jtsNytXB6p
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:10 CET Matthias Schiffer wrote:
> Checking for 0 is insufficient: when an SKB without a batadv header, but
> with a VLAN header is received, hdr_size will be 4, making the following
> code interpret the Ethernet header as a batadv header.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

=46ixes: 0591c25abca9 ("batman-adv: Distributed ARP Table - add ARP parsing=
 functions")

Kind regards,
	Sven
--nextPart2471968.jtsNytXB6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqrqywACgkQXYcKB8Em
e0Z6Kw//UTWrsepa+LF01LPQRmwhDL+heD73QUEZ9PRwqo6d5INF55pNxU2oFViK
rCvgqOoZywcPSVnvNk/vUchok6W1OJlf2uQOB2QIWbarJHwHOc7yD835YYdJo3WG
tVhbRWarv1JOXH0EqCpHlP/TRykuNaibgsXG5eDyX5ZJJYXIwcrLWJ53z74fN/U/
4muIHSgOZUv4omFizd5aN8Rr++HJ+wlTj2PGre8ypHr8z+puR9yj3vg8xxzzrrxe
J99FksPRT8n5ms/Ycvw53zQGUyM3LxSdH4nnrkaeVLk1IqCX0OZ86YWdwE5+s67P
5YibEB+uMHge0yGabGo7CyB6vq4789TsUsYasOtkm/4/NjxmiJRugVAtQIjReD+O
sJaCmZ70+KfbboB1BjPRDlrCi6LvxDOP54up5QcG0dtprXHx1tkFtyCw4kwbEYlZ
ZI9K91AkBvE7RAYxqfJZdsaeQin/Xvfx8vYyR/KBFhMoUfXlJHwawxntYx0qGzUi
YXdpCGsBkYntRz/5eOn3Fj9fSnIjVxNDZfUU6AJsiJSCBvhBFVFbj8BU9YOOQOFC
pT9cMqPjtlJ7uufpAWTpbVHt8LKAvl5/QOrY/BWZXmc4BkLpPVcEB/kdtfuPMIYz
Z7PMTCA9fV/iEuWnzrSNMUBA8v8kkKhAetGSGhQmJIt4wmgfOkE=
=+EVf
-----END PGP SIGNATURE-----

--nextPart2471968.jtsNytXB6p--

