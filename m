Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 May 2018 00:08:57 +0200
Message-ID: <1526683397.ZIjaEm5zIv@sven-edge>
In-Reply-To: <20180515155908.23839-1-linus.luessing@c0d3.blue>
References: <20180515155908.23839-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1687138.rFc9t0Q1ol";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart1687138.rFc9t0Q1ol
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 15. Mai 2018 17:59:08 CEST Linus L=FCssing wrote:
> +       magic =3D skb_header_pointer(skb, offset, sizeof(_magic), &_magic=
);
> +       if (!magic || *magic !=3D htonl(BATADV_DHCP_MAGIC))
> +               return -EINVAL;

I just hear a neoraider cry [1] in the background because you've added a ne=
w=20
potentially unaligned 4 byte access in the network packet parsing code.=20


[...]
> +static __be32 *batadv_dat_dhcp_get_yiaddr(struct sk_buff *skb, __be32 *b=
uffer)
> +{
> +       unsigned int offset =3D skb_transport_offset(skb) + sizeof(struct=
 udphdr);
> +       unsigned int len =3D sizeof(((struct batadv_dhcp_packet *)0)->yia=
ddr);
> +
> +       offset +=3D offsetof(struct batadv_dhcp_packet, yiaddr);
> +
> +       return skb_header_pointer(skb, offset, len, buffer);
> +}

Same here

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17253/
--nextPart1687138.rFc9t0Q1ol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr/TvkACgkQXYcKB8Em
e0YhcA//VAv5XY2aFiQRvjMgcluVs6b1KBvzbBMrO0bTVtHOQYHz6LjyaQ5ed4Ag
RrwJhkxw/h60XPPUF735ZJGPYZ3KCTY6DNEmTa+oYmQgz1WlZqo22t0umD89SF8h
1RAY+ArPz4BuNIsMAumT76CO1Wx+RBJRxfrmRLjMbAEKt/U9G3M6L2Tk8YO+beYr
HpP/4jM6oRjq6baz8WQaN3BDrYoldVsLDGE6XmKFdkXd6yrV3OFcWiRTFY+jgD6S
qBp9DBiT4AW4i887YVvwg7bAr8spMdbgczlv6XsUaVxiZvy24ns0rTdQIYPTO1HX
ruZTy+yo4gJTTevtJ7gDHmBPHtxvy4EeM0/XJsj4Z/8MSSltQOJWO3dwdjI4RcEW
huz09NU432yaSX+OE2bQ/pZO7LOr9CSJEJFLrGAloKN8WjiVOhqg3/mefAEuMn+f
d/KK8rkhypitzGQ+ZPv7mmEBpP/Chx/B2SpCSRj59icscLfUlTqvA11lmglQWIot
Peagi8pfocxiV2DpNqq7m1mwHjJof52rWLfVXXXbF0uKGilY3IEuzc5iWtTrK6e1
5FAhBvtP+EL9hBbSTAovp3zJmq4NjNYc1AtKDPvRSCs2FcENthc9hIuprz/BlX78
4Jjn7tZaREd0HHUxKbH/DK7pcYXgKvragPtAGh2ExzwJU06RVuk=
=OyLW
-----END PGP SIGNATURE-----

--nextPart1687138.rFc9t0Q1ol--



