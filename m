Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Mar 2012 18:59:53 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120303175953.GA15413@pandem0nium>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
	<1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: register batman ogm
 receive function during protocol init
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2012 at 03:35:18PM +0800, Marek Lindner wrote:
> -static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
> -			       struct sk_buff *skb)
> +static void _bat_iv_ogm_receive(struct sk_buff *skb,
> +				struct hard_iface *if_incoming)

<rant>
Personally, I don't like underscore functions. They are usually created
because of a lack of creativity, but are later called from different places,
do different jobs and in the end everyone is confused. :) Is it possibble to
change the name, e.g. to bat_iv_ogm_handle()?
</rant>


>  {
>  	struct batman_ogm_packet *batman_ogm_packet;
>  	struct ethhdr *ethhdr;
> @@ -1200,6 +1200,39 @@ static void bat_iv_ogm_receive(struct hard_iface *=
if_incoming,
>  					batman_ogm_packet->tt_num_changes));
>  }
> =20
> +static int bat_iv_ogm_receive(struct sk_buff *skb,
> +			      struct hard_iface *hard_iface)
> +{
> +	struct ethhdr *ethhdr;
> +
> +	/* drop packet if it has not necessary minimum size */
> +	if (unlikely(!pskb_may_pull(skb, BATMAN_OGM_HLEN)))
> +		return NET_RX_DROP;
> +
> +	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> +
> +	/* packet with broadcast indication but unicast recipient */
> +	if (!is_broadcast_ether_addr(ethhdr->h_dest))
> +		return NET_RX_DROP;
> +
> +	/* packet with broadcast sender address */
> +	if (is_broadcast_ether_addr(ethhdr->h_source))
> +		return NET_RX_DROP;
> +
> +	/* create a copy of the skb, if needed, to modify it. */
> +	if (skb_cow(skb, 0) < 0)
> +		return NET_RX_DROP;
> +
> +	/* keep skb linear */
> +	if (skb_linearize(skb) < 0)
> +		return NET_RX_DROP;
> +
> +	_bat_iv_ogm_receive(skb, hard_iface);
> +
> +	kfree_skb(skb);
> +	return NET_RX_SUCCESS;
> +}
> +

We should somewhere add a check whether the hard_iface is actually assigned=
 to
a mesh using the BATMAN IV algorithm. When more algorithms are added, we on=
ly want
the assigned protocol to be handled, others should be ignored.

Cheers,
	Simon

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9SXBkACgkQrzg/fFk7axbm7wCgqGcwiYdWidobXHpVhsAeJSN+
M6YAn19HIm7CbMvXhQvivfgBCpJ6jm6H
=G54k
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
