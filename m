Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:05:27 +0200
Message-ID: <5373791.iFaFlzxZeC@sven-edge>
In-Reply-To: <20160920121245.593-4-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16220160.lsZvtvrIrO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Evaluate and use
	neighborhood hash TVLV
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

--nextPart16220160.lsZvtvrIrO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:45 CEST Linus L=FCssing wrote:
[...]
> +/**
>   * batadv_v_elp_neigh_update - update an ELP neighbour node
>   * @bat_priv: the bat priv with all the soft interface information
>   * @neigh_addr: the neighbour interface address
> @@ -581,6 +628,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_har=
d_iface *primary_iface)
>   * ELP packet.
>   */
>  static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
> +				      struct sk_buff *skb,
>  				      u8 *neigh_addr,
>  				      struct batadv_hard_iface *if_incoming,
>  				      struct batadv_elp_packet *elp_packet)


skb parameter was added but the kernel-doc header was not added.

Kind regards,
	Sven


--nextPart16220160.lsZvtvrIrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TvHAAoJEF2HCgfBJntGeOMP/3nOzPss2hxMtjdVJNsZOCx1
AynnMrOMpzjM1vO4IF/J4KmFI4/qoSJFTpis0NmvOWPuAWgIJBLfX23OYgafduzn
u+mWsRsxj5vdM3Mu8U3wd0L4bHQ0iQS7E8UREDdndj732j6+VCAFgJsWDRdR3bgC
KZY9GsBjD/cN2KNRrqKNBNMV2TYzp9Slq8DxxWcZI7iV979qx0cnFTkezyBd7zn4
8IYICX3G+NFM61MDzVsu7/LAn/utUf9IR9LrSr6QQJgE9i08p8C97pPBXzYwZy45
BdjM3vezQug4469SgrM54z6jaHrPjxZdm87/1vSKcV07qL8nae2qQUa2RT3L+bNt
Xp71NO1xEMw0H2Fz96aDI5MZzSAv3jqFIbq6c0bP/uPB/D+971Mc180+5YL6ZnLY
LEpMDHrvAW6+buh/2lPxcKplSl/F4RKhg0aZW+flqxRnMg7BTy7NGO9Is+SYOC4Y
wm9BnkzsJBf7RmOZg+PUXpHJJLQRpV6ohr5qh99WFe0nr7D/RJNyfsgqCFmLMhn1
APTHPYMzzoF/HIAA+jvilg3xIJaMQiw9qFixlZ22+6oAK7GpYFyll/me/AuQ7Kcq
4UvxQYkiR3Eh0JuxWNqqxhQKb6mSL8rnMM55VPqqwCbdjuqXWwpqgkx/vgWllfE7
xL2+rz1yd75Z7wpMHvee
=YC0+
-----END PGP SIGNATURE-----

--nextPart16220160.lsZvtvrIrO--

