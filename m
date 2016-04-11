Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:13:09 +0800
Message-ID: <8025409.qnq58rYqdb@voltaire>
In-Reply-To: <1457190564-11419-4-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1644111.5D8QhC0S7o";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Use kref_get for
	hard_iface subfunctions
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

--nextPart1644111.5D8QhC0S7o
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:19 Sven Eckelmann wrote:
> The callers of the functions using batadv_hard_iface objects have to make
> sure that they already hold a valid reference. The subfunctions don't have
> to check whether the reference counter is > 0 because this was already
> checked by the callers.

You say the callers have to make sure that valid references exist but do they 
or is this coming later or .. ?


> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -679,12 +679,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned
> char *packet_buff, unsigned char *skb_buff;
>  	unsigned int skb_size;
> 
> -	if (!kref_get_unless_zero(&if_incoming->refcount))
> -		return;
> -
> -	if (!kref_get_unless_zero(&if_outgoing->refcount))
> -		goto out_free_incoming;
> -
>  	/* own packet should always be scheduled */
>  	if (!own_packet) {
>  		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
> @@ -716,6 +710,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned
> char *packet_buff, forw_packet_aggr->packet_len = packet_len;
>  	memcpy(skb_buff, packet_buff, packet_len);
> 
> +	kref_get(&if_incoming->refcount);
> +	kref_get(&if_outgoing->refcount);
>  	forw_packet_aggr->own = own_packet;
>  	forw_packet_aggr->if_incoming = if_incoming;
>  	forw_packet_aggr->if_outgoing = if_outgoing;
> @@ -747,7 +743,6 @@ out_nomem:
>  		atomic_inc(&bat_priv->batman_queue_left);
>  out_free_outgoing:
>  	batadv_hardif_put(if_outgoing);
> -out_free_incoming:
>  	batadv_hardif_put(if_incoming);
>  }

This introduces a refcount imbalance If I am not mistaken. At the beginning of 
the function we jump to 'out_free_outgoing'.

Cheers,
Marek

--nextPart1644111.5D8QhC0S7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC3i1AAoJEFNVTo/uthzAab4H/ReiSuKa9wP1RCT3uqLpWB4X
yD9ZEg3zMKgtDsX2TrPyjMBJimjFE1YfLsZ41WB3GTLyPKF9IBsI7q3wx0OqW/E5
lB0LPndq1D6LqBOWTAVJyIgDUP4kuQLoHE0faXW6MNj/6I9quY93tqQM1foHqjT3
i0nZD0N/ZV4r7d0LNUmYxx9+UNLTEKiIPwm/E5cG45vVJnKCMVn/1MiwcC2BK3Ri
2I/lynZ5GQbXB8M+Th2fC7FB8UuLfn6D+na1zLLR05ogIOTT8QG9b8OmFnZGhjhC
feG5EB+5+IjmbpQ6O1iFu7+R0HAQjqrk58Y0j6hLlXflMWITNHZbBSU/I3sV9X0=
=d9R7
-----END PGP SIGNATURE-----

--nextPart1644111.5D8QhC0S7o--

