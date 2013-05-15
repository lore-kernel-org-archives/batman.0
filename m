Return-Path: <ordex@autistici.org>
Date: Wed, 15 May 2013 09:27:35 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130515072735.GC3350@ritirata.org>
References: <1368476582-19220-1-git-send-email-martin@hundeboll.net>
 <1368476582-19220-4-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <1368476582-19220-4-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Fragment and send skbs
 larger than mtu
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi=C2=B3, :)

On Mon, May 13, 2013 at 10:23:02PM +0200, Martin Hundeb=C3=B8ll wrote:

[..]

> +
> +/**
> + * batadv_frag_create - create a fragment from skb.
> + * @skb: skb to create fragment from.
> + * @frag_head: header to use in new fragment.
> + * @mtu: Size of new fragment.
> + *
> + * Split the passed skb into two fragments: A new one with size matching=
 the
> + * passed mtu and the old one with the rest. The new skb contains data f=
rom the
> + * tail of the old skb.
> + *
> + * Returns the new fragment, NULL on error.
> + */
> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
> +					  struct batadv_frag_packet *frag_head,
> +					  unsigned int mtu)
> +{
> +	struct sk_buff *skb_fragment;
> +	unsigned header_size =3D sizeof(*frag_head);
> +	unsigned fragment_size =3D mtu - header_size - ETH_HLEN;
> +
> +	skb_fragment =3D dev_alloc_skb(mtu);

If I am not wrong, the external Ethernet header is not counted in the MTU o=
f an
interface. Therefore if the MTU of eth0 is X, it should mean that eth0 will=
 send
a packet of 1500 of payload + the external Ethernet encapsulation. isn't it?

> +	if (!skb_fragment)
> +		goto err;
> +
> +	/* Eat the last mtu-bytes of the skb */
> +	skb_reserve(skb_fragment, header_size);

why not reserving header_size + ETH_HLEN (ETH_HLEN would be the space for t=
he
external Ethernet header).

> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
> +
> +	/* Add the header */
> +	skb_push(skb_fragment, header_size);
> +	memcpy(skb_fragment->data, frag_head, header_size);
> +
> +err:
> +	return skb_fragment;
> +}
> +

[...]

> @@ -110,7 +109,19 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
>  	/* batadv_find_router() increases neigh_nodes refcount if found. */
>  	neigh_node =3D batadv_find_router(bat_priv, orig_node, recv_if);
>  	if (!neigh_node)
> -		return ret;
> +		goto out;
> +
> +	/* Check if the skb is too large to send in one piece and fragment
> +	 * it if needed.
> +	 */
> +	if (atomic_read(&bat_priv->fragmentation) &&
> +	    skb->len + ETH_HLEN > neigh_node->if_incoming->net_dev->mtu) {

same as before: the external Ethernet header should not be taken into
consideration while checking the MTU (no?).

My suggestion is to do:

"skb->len > neigh_node->if_incoming->net_dev->mtu) {"

> +		/* Fragment and send packet. */
> +		if (batadv_frag_send_packet(skb, orig_node, neigh_node))
> +			ret =3D NET_XMIT_SUCCESS;
> +
> +		goto out;
> +	}
> =20
>  	/* try to network code the packet, if it is received on an interface
>  	 * (i.e. being forwarded). If the packet originates from this node or if

Thank you for your work Martin! :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRkzjnAAoJEADl0hg6qKeOJ6wQAJMp717C4cfE5jesilR/9Nh1
p/UhHgmOOwhoyIO0Ut2vyO4ZmPL+IQb+637dXweTWtNJTt7awcDW1LZkeZh4lU8J
wtRbmrznhznoMNhLl4jMtLDS0/6SH0tKOkxj9HTZ1PEmMF796FLXfzLagI7zDJWa
JuxCrKbcHwfiLEZIBNdxOe/knOYpkHPshRGFIbCz8wqBetJ1HgUOIX56umwmRWMs
nZr4WQEA3kvw7vvd45yAX8zweLCFE9Up0TcoM8X5xccGmuUd7ipX0VLgn1+9IRXx
lQ/m+2H2vTVqNlDP0xgfCHYdmcJktJiYEKIv49+YbWesUGRW9bsCpWs4xOaKksAu
wEtcp45xuYMAJ0AzJgpV8doeJjp2ZyupK1DdcM6JZp5cUehV7Zc7vm7uCXwZlrN1
agANOnnked7l9NQkjbmD2lkTWwhJQYGj4I32F5gLyOlf9ZWxgxZlCCjO+KDNWC7x
cuPldGK93phObxOlFm26dKWspfoYouuM1jCYSpisVEPWtXyWBuo3HUjVDBVY0QIB
bYazQdFXeZTveh5rarBnku0dMaPhqELoYQAa3kcJrJa3LdCLuvEBeqx+nDStqiGK
hzihoD79ep1rfRK5F26h6PrJHG/GtyUP5EEuJ4+c8NdfSoXG9usSDw5j/PgERQdf
wwV0F2Flvg0M4jUZi4Lm
=qnJ/
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
