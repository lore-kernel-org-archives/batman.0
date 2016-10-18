Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 23:28:23 +0200
Message-ID: <1555062.TzeBilqSPn@sven-edge>
In-Reply-To: <20161018212125.32010-1-linus.luessing@c0d3.blue>
References: <20161018212125.32010-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9718104.fGP9MP5nNY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat
	code for netlink constification
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

--nextPart9718104.fGP9MP5nNY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 18. Oktober 2016 23:21:25 CEST Linus L=FCssing wrote:
> Substitutes the compat-patches approach for the netlink const changes to
> the prefered way of using compat-includes.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  compat-include/net/genetlink.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlin=
k.h
> index 72a8991..b195b47 100644
> --- a/compat-include/net/genetlink.h
> +++ b/compat-include/net/genetlink.h
> @@ -28,6 +28,15 @@
> =20
>  #include <linux/export.h>
> =20
> +/* multicast groups */
> +enum __batadv_netlink_multicast_groups {
> +	__BATADV_NL_MCGRP_TPMETER,
> +};
> +
> +static struct genl_multicast_group __batadv_netlink_mcgrps[] =3D {
> +	[__BATADV_NL_MCGRP_TPMETER] =3D { .name =3D BATADV_NL_MCAST_GROUP_TPMET=
ER },
> +};
> +

Doesn't seem to scale. Especially when we think about batadv_netlink_ops
which should also be const. It is currently not const because of the
Linux <=3D 3.13 workaround.

Kind regards,
	Sven

--nextPart9718104.fGP9MP5nNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBpP3AAoJEF2HCgfBJntGGwsP/1BOtHVt4XppuMxMW0+pw+9j
YLybKOuMS6B6YD7/E2j+5MNPASTveZ8QWytyNyGPxc/269nruQvYZIHUDW2Oijld
skXbrJVT3lJNSu1qfcARmEiaR+71nYsQANFwHIkk7xISdaSMJ6GjKdpjWnPqKyXj
JtnR99lXbSnmXWeyOokVYHVpl6h67zRnspvDhxBvu4ZcST68qnH0KdEjdqMuj/KB
hkpN1fOLegtqXLAOJ/4qwOdp7vfKYuDvshmbc4X9t0fHu5AmAXHaD6vn5s/habos
Ul3k0yrFpIeQTzUNMK7VGG4YGBUM5lWZsEVyccUZOQZyUMDgMLpl9wS6qs8M/Ol/
fJ+5Asa+DiG9X1eyHvW/IrrITa/OlLWRSN4S90uWutTNe4Zdsg07sW8+3jW1N5jm
bDgk0Yac/Cd8K0rZn99B/nfInRBn6MtcDqcO35hIzWN/YrLfmR1HGZo7tW1l6aC3
JiRRjWppqQ8QnF8A7iIWNhcB6ELgQqDrpEm8PKYk7osFpbzUQv4bFV6jASPkbUB3
BzpmcAD5AKvXkaF9hKNAu6+axwoTVgKqjHnNLGXKyuMD7Ee5LcK+7yRuiT+djgv8
z2j1VZ6TARmlKgBC7R4r2kcrC0N0Xv/GYPsrhFFKd5woLE0B9m7pe0fSoCHdXvRz
at9gtiVclmJaSNcWAXwA
=ORlR
-----END PGP SIGNATURE-----

--nextPart9718104.fGP9MP5nNY--

