Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 Jun 2011 20:56:17 +0200
References: <1308067299-2282-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1308067299-2282-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106152056.18072.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: skbs have to be freed using
	kfree_skb()
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

On Tuesday, June 14, 2011 06:01:39 PM Antonio Quartulli wrote:
> @@ -1299,7 +1299,7 @@ int recv_roam_adv(struct sk_buff *skb, struct
> hard_iface *recv_if) orig_node_free_ref(orig_node);
>         ret = NET_RX_SUCCESS;
>  out:
> -       kfree(skb);
> +       kfree_skb(skb);
>         return ret;
>  }
>  

I'd say recv_roam_adv() suffers from the same problem you fixed in 
recv_tt_query() with your previous patch. Wouldn't you say so ?

Cheers,
Marek
