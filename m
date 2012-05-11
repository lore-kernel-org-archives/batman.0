Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 May 2012 03:15:19 +0800
References: <1336760987-1523-1-git-send-email-sven@narfation.org>
In-Reply-To: <1336760987-1523-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205120315.19641.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Prefix non-static
	functions with batadv_
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

On Saturday, May 12, 2012 02:29:46 Sven Eckelmann wrote:
> @@ -138,7 +138,8 @@ static uint8_t hop_penalty(uint8_t tq, const struct
> bat_priv *bat_priv) static int bat_iv_ogm_aggr_packet(int buff_pos, int
> packet_len,
>                                   int tt_num_changes)
>  {
> -       int next_buff_pos = buff_pos + BATMAN_OGM_HLEN +
> tt_len(tt_num_changes); +       int next_buff_pos = buff_pos +
> BATMAN_OGM_HLEN +
> +                           batadv_tt_len(tt_num_changes);
>  
>         return (next_buff_pos <= packet_len) &&
>                 (next_buff_pos <= MAX_AGGREGATION_BYTES);
> @@ -189,7 +190,7 @@ static void bat_iv_ogm_send_to_if(struct forw_packet
> *forw_packet, hard_iface->net_dev->dev_addr);
>  
>                 buff_pos += BATMAN_OGM_HLEN +
> -                               tt_len(batman_ogm_packet->tt_num_changes);
> +                           batadv_tt_len(batman_ogm_packet->tt_num_changes
> ); packet_num++;
>                 batman_ogm_packet = (struct batman_ogm_packet *)
>                                         (forw_packet->skb->data +
> buff_pos);

Here we have indentation David does not like (although not problematic for 
checkpatch).


> @@ -1222,7 +1226,7 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
>                                    tt_buff, if_incoming);
>  
>                 buff_pos += BATMAN_OGM_HLEN +
> -                               tt_len(batman_ogm_packet->tt_num_changes);
> +                           batadv_tt_len(batman_ogm_packet-
>tt_num_changes);
>  
>                 batman_ogm_packet = (struct batman_ogm_packet *)
>                                                 (packet_buff + buff_pos);

Same here.

Regards,
Marek
