Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 01:32:00 +0800
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <1366474654-26361-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366474654-26361-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304240132.00926.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Remove old fragmentation
	code
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Sunday, April 21, 2013 00:17:32 Martin Hundeb=C3=B8ll wrote:
> @@ -592,9 +591,9 @@ static bool batadv_dat_send_data(struct batadv_priv
> *bat_priv, goto free_orig;
>=20
>  		tmp_skb =3D pskb_copy(skb, GFP_ATOMIC);
> -		if (!batadv_unicast_4addr_prepare_skb(bat_priv, tmp_skb,
> -						      cand[i].orig_node,
> -						      packet_subtype)) {
> +		if (!batadv_send_skb_4addr_prepare_unicast(bat_priv, tmp_skb,
> +							   cand[i].orig_node,
> +							   packet_subtype)) {

I think you mangled the "unicast_4addr" name a little. Afaik "4addr" was me=
ant=20
to follow "unicast" to diffirentiate between "unicast" and "unicast_4addr".=
=20
However, I'd have no problem if you simply dropped the "unicast" part. For=
=20
example: batadv_send_skb_4addr_prepare()


> @@ -977,10 +976,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct
> batadv_priv *bat_priv, * that a node not using the 4addr packet format
> doesn't support it. */
>  	if (hdr_size =3D=3D sizeof(struct batadv_unicast_4addr_packet))
> -		err =3D batadv_unicast_4addr_send_skb(bat_priv, skb_new,
> +		err =3D batadv_send_skb_4addr_unicast(bat_priv, skb_new,
>  						    BATADV_P_DAT_CACHE_REPLY);

If you decide to skip the "unicast" part above feel free to drop it here to=
o.


> +/**
> + * batadv_send_generic_unicast_skb - send an skb as unicast
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: payload to send
> + * @packet_type: the batman unicast packet type to use
> + * @packet_subtype: the batman packet subtype. It is ignored if packet_t=
ype=20
> + *		    not BATADV_UNICAT_4ADDR
> + *
> + * Returns 1 in case of error or 0 otherwise
> + */

Multi-line kernel doc explanations should be indented by one space.=20
If the function returns 0 or 1 only it should be made boolean or the return=
=20
value should use a readable define.

Cheers,
Marek
