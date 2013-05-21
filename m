Return-Path: <ordex@autistici.org>
Date: Tue, 21 May 2013 21:19:26 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130521191926.GB3435@ritirata.org>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-4-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1369133299-8325-4-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: Fragment and send skbs
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


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2013 at 12:48:19PM +0200, Martin Hundeb=C3=B8ll wrote:
> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
> +					  struct batadv_frag_packet *frag_head,
> +					  unsigned int mtu)
> +{
> +	struct sk_buff *skb_fragment;
> +	unsigned header_size =3D sizeof(*frag_head);
> +	unsigned fragment_size =3D mtu - header_size;
> +
> +	skb_fragment =3D dev_alloc_skb(mtu + ETH_HLEN);
> +	if (!skb_fragment)
> +		goto err;
> +
> +	/* Eat the last mtu-bytes of the skb */
> +	skb_reserve(skb_fragment, header_size + ETH_HLEN);
> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
> +
> +	/* Add the header */
> +	skb_push(skb_fragment, header_size);
> +	memcpy(skb_fragment->data, frag_head, header_size);

here we are copying the data right after the Fragment header. However I am =
not
sure we are accessing aligned memory because:

ETH_HLEN + header_size =3D 14 + 20 =3D 34

To speed up the copy, wouldn't it be better to allocate ETH_HLEN +
header_size + IP_ALIGN bytes like we do for other packets? (you can use
netdev_alloc_skb_ip_align() like we do somewhere else).

In this way the memcpy will access a 4bytes aligned memory (if I am not wro=
ng).

Can somebody else comment on this?


> +bool batadv_frag_send_packet(struct sk_buff *skb,
> +			     struct batadv_orig_node *orig_node,
> +			     struct batadv_neigh_node *neigh_node)
> +{
> +	struct batadv_priv *bat_priv;
> +	struct batadv_hard_iface *primary_if;
> +	struct batadv_frag_packet frag_header;
> +	struct sk_buff *skb_fragment;
> +	unsigned mtu =3D neigh_node->if_incoming->net_dev->mtu;
> +	unsigned header_size =3D sizeof(frag_header);
> +	unsigned max_fragment_size, max_packet_size;
> +
> +	/* To avoid merge and refragmentation at next-hops we never send
> +	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
> +	 */
> +	mtu =3D min_t(int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);

if mtu is unsigned (int), why not using unsigned (int) inside the min_t
function?

> +
> +	/* Send the last fragment */
> +	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
> +	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
> +			   skb->len + ETH_HLEN);

Like int he previous patch: do we really need to count ETH_HLEN? (I'm not s=
ure
about this)

Thanks again :)

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRm8i+AAoJEADl0hg6qKeO1esP/jglV2z6jGjd2FWLdeiXyyJW
eILncCcsmGPGAOhz/PPqoKKrikF1PvO17Et47Vb/aVRD4KHCDii3nvfRZWSJfpeg
nvpA+K7ZLoV/bUXriv0c404FfEqjGy3nJAHEBdwXhfVn2BTR01icTMzsJelxEYtY
mWMvuOwVbjwjnGZBACM8nJc6Xfh2xtySi7Ci5cfl2Ncbj6olJTbzME6Uo2z5xQO1
hcHcEv2tR1p8QwhOdVxWvhj9bnY40MqE9sgrrksNibY2LLqQQufVp+E4xpw23idj
nkwCfjle3y8hjRioAhzO4uohD0LfdyuEqyTFRsdVEpZ3GrUTEK3bx1vQI27BzNCI
WsceN091FEq0UursGnB3E3SmE863t0hNl0d15s7lORGWbHgBda/er+xI0kw2YteQ
fEn9XBPUv6AqBcP/1anE+LUBMatw18jdiUQj86NDwE3/mbvlwKpFye89cSF2Yx5f
SS9660EnEhFSZE7LpDOYEwkWp/P9qEK+7TCNcUWhllJ7Zff1pIej1j3ho+5UpAT4
PjrvWRTYRaTj0ZNdATZ1PzEtgV9Xwu8NUKNj3VcfGIF/FsyjnPN2pEc9SftMEO16
Hq21ohf0fThoTdElg2u8WDbGNWREcoVNa7QPx/AhNwH4JYx/JYhP/CX8TRaA0SoZ
iIl8rSGNc7MINX0k8eHR
=QLa4
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
