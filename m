Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 25 Apr 2012 20:11:47 +0800
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120419061026.GC8658@ritirata.org>
	<20120422064426.GU6871@ZenIV.linux.org.uk>
In-Reply-To: <20120422064426.GU6871@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204252011.47834.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: don't bother flipping
	->tt_data
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
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hey,

I was about to merge the patch when I realized checkpatch is complaining. See 
below for details.


> @@ -618,7 +615,7 @@ int recv_tt_query(struct sk_buff *skb, struct
> hard_iface *recv_if) if (skb_linearize(skb) < 0)
>  				goto out;
> 
> -			tt_len = tt_query->tt_data * sizeof(struct tt_change);
> +			tt_len = ntohs(tt_query->tt_data) * sizeof(struct tt_change);

Line is too long.


> @@ -1727,7 +1727,7 @@ void handle_tt_response(struct bat_priv *bat_priv,
> 
>  	bat_dbg(DBG_TT, bat_priv,
>  		"Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
> -		tt_response->src, tt_response->ttvn, tt_response->tt_data,
> +		tt_response->src, tt_response->ttvn, ntohs(tt_response->tt_data),
>  		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
> 
>  	/* we should have never asked a backbone gw */
> @@ -1741,7 +1741,7 @@ void handle_tt_response(struct bat_priv *bat_priv,
>  	if (tt_response->flags & TT_FULL_TABLE)
>  		tt_fill_gtable(bat_priv, tt_response);
>  	else
> -		tt_update_changes(bat_priv, orig_node, tt_response->tt_data,
> +		tt_update_changes(bat_priv, orig_node, ntohs(tt_response->tt_data),
>  				  tt_response->ttvn,
>  				  (struct tt_change *)(tt_response + 1));

Both changes are too long as well.

Regards,
Marek
