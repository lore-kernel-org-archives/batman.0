Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 Jul 2016 13:42:32 +0200
Message-ID: <2069472.CH1chEaXG0@sven-edge>
In-Reply-To: <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3088913.jtWtbJ0sC3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart3088913.jtWtbJ0sC3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 5. Juli 2016 20:01:37 CEST Linus L=FCssing wrote:
>  /**
> + * batadv_dat_check_dhcp_ipudp - check skb for IP+UDP headers valid for
> DHCP + * @skb: the packet to check
> + * @proto: ethernet protocol hint (behind a potential vlan)
> + *
> + * Checks whether the given skb has an IP and UDP header valid for a DHCP
> + * message from a DHCP server.
> + *
> + * Return: True if valid, false otherwise.
> + */
> +static bool batadv_dat_check_dhcp_ipudp(struct sk_buff *skb)
> +{


Looks like this function doesn't have the parameter proto which you've=20
described in the kerneldoc.

It sounds like the patch didn't help. So I will postpone my review.

Kind regards,
	Sven
--nextPart3088913.jtWtbJ0sC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXgjSoAAoJEF2HCgfBJntGHEgQALeR3lx88Cn1/hqS7Kb1yHUe
XFLFnLQAxQkkuAefD8rKUJkzqa1VRRG1iVy5zUwRKLSEVEGJ9tnul2f7W+VauS5N
/HsArqi68odwISVT4xKYXUEO+fNqgf6gOpz0USJMzdpEglwZjTdxYx44+GwU1r98
VTSNZTwP9ylaDFnLCJqvNTXsKoQdSePOryF4jagAZ8ve6goBPKOHkXw/1PE381/F
FjPgkYCum8zWY+1rGvSq4IJlFg0iCdx7J598mv/WHkKZDBvRQLLDHLRYS+YYLc/v
S52RBd0H9eK0zlBYO8fn5BKT6EWYnESds79nKQHjgWCiZERehfLD6EAilwWWgcdS
mDhGSKZwCDSHkN1Quyyf4PSs/aEAlr0VCmeQXmIZulTXz4uNgdscVr8ZLAKWt79w
T9zVge41dh+8URTkxCI9bX9DedceN4otqPS7czYhIgiwEAzAdbycOctIZLTc1xrQ
Ae/sAf/KQq61Nn4xlRJ1Kx9r61eplCfz3O21fF6e2OPKYbk73pi18otQp2/jBzTA
ZtEqGz7UfQz53GYcUxENQxJ+j/E8g7p0qnBzeTxskvCeY170a/sHxs7KJd0aGIbl
IQugq23oBgZuaWRRxs3uYs+tkNsO8mkor83Gxl0BG8LtZUyMApceZtE6geLQ5mot
aqm+mk7xgzbHK6jnJXA5
=iM+J
-----END PGP SIGNATURE-----

--nextPart3088913.jtWtbJ0sC3--

