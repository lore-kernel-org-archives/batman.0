Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA563A.8080309@meshcoding.com>
Date: Tue, 11 Feb 2014 17:56:26 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I8C0X2MWuJA4KP8UqVpCkgBNbNoCUlWrM"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix TT CRC
 computation by ensuring byte order
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I8C0X2MWuJA4KP8UqVpCkgBNbNoCUlWrM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 17:05, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> When computing the CRC on a 2byte variable the order of
> the bytes obviously alters the final result. This means
> that computing the CRC over the same value on two archs
> having different endianess leads to different numbers.
>=20
> The global and local translation table CRC computation
> routine makes this mistake while processing the clients
> VIDs. The result is a continuous CRC mismatching between
> nodes having different endianess.
>=20
> Fix this by converting the VID to Network Order before
> processing it. This guarantees that every node uses the same
> byte order.
>=20
> Introduced by 21a57f6e7a3b4455dfe68ee07a7b901d9e7f200b
> ("batman-adv: make the TT CRC logic VLAN specific")
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

Both the patch are:

Reported-by: Russel Senior <russell@personaltelco.net>


--=20
Antonio Quartulli


--I8C0X2MWuJA4KP8UqVpCkgBNbNoCUlWrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+lY9AAoJEEKTMo6mOh1VL0MP/jmkRzJkKHXFR0WcLJ+oxhhD
J4nt2nRBhiT/e1W3OqPFh/jyFWnOwxfxPETJquXm8YO/XsbU7SXWVUpzyGtn5u89
4gm4C0rNP6eENhcyi9l2lp8g0W9udRjX+X1iJQWK3pEK/2krD7MxlIY98VEOkec1
hmeT1eh9X0SH2pSMYq54f4m+4W/B2BoU+74t6T7HWHP87rd3j458H38xmrNICfiM
AZeNRKxZq0KL5OTmCORzVjpp/8SdMdgXguIKrUDZFbYE1uRBfanODy2j7/4mAuGh
6gXvLTDsmtSNMrRk2jeP6AiqSDykIYHWHfPnvljWIvikEeE4SO37O6LUzqLbbkUY
1oGShe/ft0iijk1vzC9zF2IQ+aa74EanIWEa/wnj+f2wGi/RRLYlOQ4v0U4qWCZt
grjWJ9r3H3A+jfzSPNAw9EA3Z7i3R40gdRnAtwdlHKRiFtT8LKMPmJ9k0hXI+uaG
ARotpiP6YyCgqdfsjca9RLzYKqxUw8LYFM3cUYwHlbIWXGPfYkBjFHz2mGCG6rxD
nOmByxuSkbW79bDPutCA9itmOEMW3eBB79aBTpUgzYp292lWkkkmCIz8iuWT+8Z/
sP/kXWxoL0NPb/gH5QIR/g+u8Gl3Poc6j1rh+TVA0r/qID8DFoVSix63IOObzJFK
pnJWdY7umf5aAiHqg8GK
=6T+T
-----END PGP SIGNATURE-----

--I8C0X2MWuJA4KP8UqVpCkgBNbNoCUlWrM--
