Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Apr 2010 16:59:19 +0800
References: <1272237853-26242-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1272237853-26242-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004261659.20055.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update pointer to ethhdr
	after skb_copy
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

On Monday 26 April 2010 07:24:13 Sven Eckelmann wrote:
> We must ensure that all pointer to a socket buffer are updated when we
> copy a socket buffer and free our reference to the old one.
> Another part of the kernel could also free its reference which maybe
> removes the buffer completely. In that situation we would would feed
> wrong information to the routing algorithm after the memory area is
> written again by someone else.

Good catch !


> @@ -960,6 +963,7 @@ int recv_icmp_packet(struct sk_buff *skb)
>  			if (!skb)
>  				return NET_RX_DROP;
>  			icmp_packet = (struct icmp_packet_rr *)skb->data;
> +			ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  			kfree_skb(skb_old);
>  		}
> 
> @@ -1106,6 +1110,7 @@ int recv_unicast_packet(struct sk_buff *skb)
>  		if (!skb)
>  			return NET_RX_DROP;
>  		unicast_packet = (struct unicast_packet *) skb->data;
> +		ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  		kfree_skb(skb_old);
>  	}

I was about to commit your patch when I fell over these last 2 changes. I 
can't see why we need them. What did I miss ?

Regards,
Marek

