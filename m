Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jan 2014 16:06:21 +0800
Message-ID: <1592156.nZED7h3Aej@diderot>
In-Reply-To: <1384410369-7437-5-git-send-email-linus.luessing@web.de>
References: <1384410369-7437-1-git-send-email-linus.luessing@web.de>
 <1384410369-7437-5-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3976911.6rUbM8leIx";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 4/6] batman-adv: Modified forwarding
	behaviour for multicast packets
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


--nextPart3976911.6rUbM8leIx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 14 November 2013 07:26:07 Linus L=FCssing wrote:
> +/**
> + * batadv_mcast_forw_mode_check - check for optimized forwarding pot=
ential
> + * @skb: the multicast frame to check
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Check whether the given multicast ethernet frame has the potentia=
l to
> + * be forwarded with a mode more optimal than classic flooding.
> + *
> + * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if =
we are
> + * out of memory.
> + */
> +static int batadv_mcast_forw_mode_check(struct sk_buff *skb,
> +=09=09=09=09=09struct batadv_priv *bat_priv)
> +{
> +=09struct ethhdr *ethhdr =3D (struct ethhdr *)(skb->data);

Please check if calling eth_hdr() is an option.
Another minor nitpick: When bat_priv and skb are arguments to the same=20=

function please keep bat_priv the first argument and skb the second for=
=20
consistency purposes. You can check routing.c for other examples.=20


> +/**
> + * batadv_mcast_forw_mode - check on how to forward a multicast pack=
et
> + * @skb: The multicast packet to check
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Return the forwarding mode as enum batadv_forw_mode.
> + */
> +enum batadv_forw_mode
> +batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_=
priv)
> +{
> +=09struct ethhdr *ethhdr =3D (struct ethhdr *)(skb->data);

Same as above.


> +/**
> + * batadv_forw_mode - the way a packet should be forwarded as
> + * @BATADV_FORW_ALL: forward the packet to all nodes
> + *  (currently via classic flooding)
> + * @BATADV_FORW_SINGLE: forward the packet to a single node
> + *  (currently via the BATMAN_IV unicast routing protocol)

Can we scratch the 'BATMAN_IV routing protocol ? How about:
(currently via BATMAN unicast routing) ?


>  send:
> +=09=09if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
> +=09=09=09forw_mode =3D batadv_mcast_forw_mode(skb, bat_priv);
> +=09=09=09if (forw_mode =3D=3D BATADV_FORW_NONE)
> +=09=09=09=09goto dropped;
> +
> +=09=09=09if (forw_mode =3D=3D BATADV_FORW_SINGLE)
> +=09=09=09=09do_bcast =3D false;
> +=09=09}
> +=09}

Has this been tested with gateway mode (IPv4 and IPv6) ? I can't come u=
p with=20
a case where it breaks but it also does not give me the feeling of bein=
g 100%=20
safe. One option would be to add an additional dhcp_rcp variable check.=



> diff --git a/types.h b/types.h
> index 39b9bbe..badbdf9 100644
> --- a/types.h
> +++ b/types.h
> @@ -712,6 +712,9 @@ struct batadv_priv {
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  =09atomic_t distributed_arp_table;
>  #endif
> +#ifdef CONFIG_BATMAN_ADV_MCAST
> +=09atomic_t multicast_mode;
> +#endif

Kernel doc ?

Cheers,
Marek

--nextPart3976911.6rUbM8leIx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSymQBAAoJEFNVTo/uthzAheMH/jQXI/C8akAOEhmE60LO2PN/
0k0keW2ZDAHGxCIgkzfmX2TmiI0lo1297wDCIuOiLr+LaOZev2Tg+UIRO+nnWzAy
jKhQoTXIXR0ofLwxCqFjX1GoSf8OKR7ptKHXxIYfWYQXayquNsOdVi41aRdfYtO4
4kPhGXnceds/OqCaQ29L6b56EEgzlIYDXkqAd+nR8nkqjR4QnagCmH+GC/xfpIcG
AUG4piPhTtHzqocEDsVz73feFKU3LOcPjYz7tYx84r9528eeC6B7jvLPcGesBBfs
E3dOfLrGpbD9K7biKiGI7kkGvwVsMVVnzdHS2oqRRwYEVFjGDH/IkYyAuIoGuV8=
=NzEb
-----END PGP SIGNATURE-----

--nextPart3976911.6rUbM8leIx--

