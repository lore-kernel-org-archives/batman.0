Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:12:21 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031001221.GF10726@pandem0nium>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <1319964962-5092-6-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Distributed ARP Table -
 add snooping functions for ARP messages
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


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fails checkpatch.pl --strict.

On Sun, Oct 30, 2011 at 09:56:01AM +0100, Antonio Quartulli wrote:
> +bool arp_snoop_outgoing_request(struct bat_priv *bat_priv, struct sk_buf=
f *skb)
> [...]
> +	arp_neigh_update(bat_priv, ip_src, hw_src);
> +
> +	n =3D neigh_lookup(&arp_tbl, &ip_dst, primary_if->soft_iface);
> +	/* check if it is a valid neigh entry */
> +	if (n && (n->nud_state & NUD_CONNECTED)) {
> +		skb_new =3D arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
> +				     primary_if->soft_iface, ip_dst, hw_src, n->ha,
> +				     hw_src);
> +		unicast_send_skb(skb_new, bat_priv);
> +		bat_dbg(DBG_ARP, bat_priv, "ARP request replied locally\n");

This function is hooked up in the tx patch, why do we send the unicast repl=
y to
the mesh? Shouldn't it be sent on the soft interface instead? I don't reall=
y understand this one ...

> +	} else
> +		/* Send the request on the DHT */
> +		ret =3D dht_send_data(bat_priv, skb, ip_dst);
> +	if (n)
> +		neigh_release(n);
> +out:
> +	if (primary_if)
> +		hardif_free_ref(primary_if);
> +	return ret;
> +}
> +
> diff --git a/routing.c b/routing.c
> index ef24a72..4f2b417 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -965,6 +966,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct h=
ard_iface *recv_if)
>  	/* packet for me */
>  	if (is_my_mac(unicast_packet->dest)) {
>  		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
> +
>  		return NET_RX_SUCCESS;
>  	}
> =20

This added newline is useless.

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t5+UACgkQrzg/fFk7axaYggCgjnyniS3n6kiTtUxikb7/Vzk4
EcQAnRCNEF6ajyqV50xjJ92bXJIOSeyF
=MoQv
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
