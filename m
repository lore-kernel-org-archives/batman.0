Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 17 Jun 2012 03:00:14 +0800
References: <1339709917-15971-1-git-send-email-ordex@autistici.org>
	<1339828061-15884-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1339828061-15884-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206170300.14767.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: don't try to re-route
	tt_request for me
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

On Saturday, June 16, 2012 14:27:41 Antonio Quartulli wrote:
> -static bool
> +static void
>  batadv_send_my_tt_response(struct batadv_priv *bat_priv,
>                            struct batadv_tt_query_packet *tt_request)
>  {
> @@ -1656,7 +1656,6 @@ batadv_send_my_tt_response(struct batadv_priv
> *bat_priv, struct batadv_neigh_node *neigh_node = NULL;
>         struct batadv_hard_iface *primary_if = NULL;
>         uint8_t my_ttvn, req_ttvn, ttvn;
> -       int ret = false;
>         unsigned char *tt_buff;
>         bool full_table;
>         uint16_t tt_len, tt_tot;
> @@ -1751,7 +1750,6 @@ batadv_send_my_tt_response(struct batadv_priv
> *bat_priv, batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
>  
>         batadv_send_skb_packet(skb, neigh_node->if_incoming,
> neigh_node->addr); -       ret = true;
>         goto out;
>  
>  unlock:
> @@ -1763,10 +1761,6 @@ out:
>                 batadv_neigh_node_free_ref(neigh_node);
>         if (primary_if)
>                 batadv_hardif_free_ref(primary_if);
> -       if (!ret)
> -               kfree_skb(skb);
> -       /* This packet was for me, so it doesn't need to be re-routed */
> -       return true;
>  }

Unless I am mistake you are adding a beautiful memory leak here.

Regards,
Marek
