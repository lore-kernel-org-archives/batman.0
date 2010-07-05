Return-Path: <sven.eckelmann@gmx.de>
Date: Mon, 5 Jul 2010 14:53:38 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100705125338.GA5916@sven-atom.lazhur.ath.cx>
References: <20100630205846.230b2112@rechenknecht>
	<1277924436-29528-2-git-send-email-an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1277924436-29528-2-git-send-email-an.langer@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
 fragmentation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: b.a.t.m.a.n@lists.open-mesh.net


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2010 at 09:00:36PM +0200, Andreas Langer wrote:
> diff --git a/batman-adv/fragmentation.h b/batman-adv/fragmentation.h
> new file mode 100644
> index 0000000..d0acf73
> --- /dev/null
> +++ b/batman-adv/fragmentation.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
> + *
> + * Andreas Langer
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA
> + *
> + */
> +
> +#define FRAG_TIMEOUT 60000	/* purge frag list entrys after time in ms */
> +#define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
> +#define FRAG_MAX_SEQ 65535
> +
> +extern struct sk_buff *merge_frag_packet(struct list_head *head,
> +	struct frag_packet_list_entry *tfp,
> +	struct sk_buff *skb);
> +
> +extern void create_frag_entry(struct list_head *head, struct sk_buff *sk=
b);
> +extern void create_frag_buffer(struct list_head *head);
> +extern struct frag_packet_list_entry *search_frag_packet(struct list_hea=
d *head,
> +	struct unicast_frag_packet *up);
> +extern void frag_list_free(struct list_head *head);

function declarations shouldn't be marked as extern. Can you please remove =
that.=20

> diff --git a/batman-adv/routing.h b/batman-adv/routing.h
> index 3eac64e..35ca2af 100644
> --- a/batman-adv/routing.h
> +++ b/batman-adv/routing.h
> @@ -34,6 +34,9 @@ void update_routes(struct orig_node *orig_node,
>  				unsigned char *hna_buff, int hna_buff_len);
>  int recv_icmp_packet(struct sk_buff *skb);
>  int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
> +int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_i=
f);
> +int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,

route_unicast_packet is only used locally in routing.c. Please remove this
function declaration and mark route_unicast_packet in routing.c as static.

thanks,
	Sven

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMMdXRAAoJEF2HCgfBJntGQd0P/3OgGLbETApOidbmeR/FbfHR
Urx8NnzGQ2T3jCBp59UudYGmXoHO3S8MtaxTH6cYFnD+G7vfFdFqIegGYij04hnb
2vHoRgifsfRa6AXKbUKZ+42AHBPQh/S46K3BA8NTUFzSgHTjUDadzBW/hmjL0p5i
sPpUms5yn0lEel/lRX/5ZQ/zefsfVbLuro7xv2QJWtDxdRViyT/WT6/rwIo66aWe
qQGh8uN5tTxEoUtck4EJGaCX8QR4ukiFN6qbYWFW4rUNTy2GdWKVaLOogc1HZ617
3DoE8mTr6Ls08FcdZppkBoLJJwSiL0kw5IASaVRCQlaXdvdkr1aH5tOB1UsGXwHg
YfYWjR3GS+k40S5W1f5M62Q5HscKRgdx8RTfmfmqCXvbCumvoCNq0WeaVqyNOe0V
6DMKyPy23KJI83YVCYXKjcqq5okYvw1qHagFTTZr3K5iO33gtCevFT1bnuK2T+lO
MvthHkrBQRK29FIkFkQylsxB6nP2sfAqoxjIcbHKdAIRqdbcqdHhTpQltmooQsSn
yv5cbIk1jf/0o78b5NoK8LtB/qkZWap2UCsPrvpW5iHGHR1b3Uf1MXSl9puILoUm
0K2ZASxT/z4f39zOVpzQlts2rNhmihar1hE4s5Dp+ysFvflNucV7uCHm0Ob4dZ36
sSd9C+W2uqYjzG3J3QfG
=tBbk
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
