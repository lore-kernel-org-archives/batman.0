Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Oct 2013 18:12:28 +0800
Message-ID: <3097636.PlnBFYxLHF@diderot>
In-Reply-To: <1381323938-26931-6-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-6-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1617585.5AzGK0O0XM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: consider outgoing
	interface in OGM sending
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


--nextPart1617585.5AzGK0O0XM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 October 2013 15:05:36 Simon Wunderlich wrote:
> @@ -573,6 +561,13 @@ batadv_iv_ogm_can_aggregate(const struct
> batadv_ogm_packet *new_bat_ogm_packet, if (!primary_if)
>  			goto out;
> 
> +		/* packet is not leaving on the same interface.
> +		 * TODO: some other parts here could be reworked as the
> +		 * outgoing interface is specified now.
> +		 */
> +		if (forw_packet->if_outgoing != if_outgoing)
> +			goto out;
> +
>  		/* packets without direct link flag and high TTL
>  		 * are flooded through the net
>  		 */

What is the TODO trying tell us ?


> @@ -895,9 +922,31 @@ static void batadv_iv_ogm_schedule(struct
> batadv_hard_iface *hard_iface) atomic_inc(&hard_iface->bat_iv.ogm_seqno);
> 
>  	batadv_iv_ogm_slide_own_bcast_window(hard_iface);
> -	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
> -				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
> -				batadv_iv_ogm_emit_send_time(bat_priv));
> +
> +	send_time = batadv_iv_ogm_emit_send_time(bat_priv);
> +
> +	if (hard_iface == primary_if) {
> +		/* OGMs from primary interfaces are scheduled on all
> +		 * interfaces.
> +		 */
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list,
> +					list) {
> +			if (tmp_hard_iface->soft_iface !=
> +			    hard_iface->soft_iface)
> +				continue;
> +			batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
> +						*ogm_buff_len, hard_iface,
> +						tmp_hard_iface, 1, send_time);
> +		}
> +		rcu_read_unlock();
> +	} else {
> +		/* OGMs from secondary interfaces are only scheduled on their
> +		 * respective interfaces.
> +		 */
> +		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
> +					hard_iface, hard_iface, 1, send_time);
> +	}

The 2 line if-statement certainly won't pass. You could handle the hard_iface 
!= primary_if case and then return. No need to have a big if-else block. That 
should give you enough space to move the if-statement to one line.

Cheers,
Marek

--nextPart1617585.5AzGK0O0XM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSbOcQAAoJEFNVTo/uthzAB6MH/jqql3xLFtrwQwZl7/Di2iOb
ISPlMyk2YJxW6SzIrDbhthblyFiQTF2DWIjl+khw2CEIN5e5vErEUhXdEyRpdcOZ
ux+ywBAE3Tu9AY9AzOAhZGs/DN0S14Z8ucjjhdd2IeN2prOkKcjwAzlS7uj7p9be
VmPjsMo83NuktkAvPxVhbMYGytiueAUMpJ4JEuIPK+WLyjOuWQgD4TF+yV/Yyj81
u70JWVYE2z5TJWR+TqNtXuUf8o17+CW4RL5hq7K13GY8pZVGtDmrN8hTO7SVrAkg
/5UEN4nQryzh9lESqyDTwXreu6Ya5hllAG76rgCR9ddakeoglcrluiRZpO2I9WM=
=LuTK
-----END PGP SIGNATURE-----

--nextPart1617585.5AzGK0O0XM--

