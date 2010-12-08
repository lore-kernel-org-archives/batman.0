Return-Path: <andrew@lunn.ch>
Date: Wed, 8 Dec 2010 10:06:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101208090637.GC11450@lunn.ch>
References: <20101207221351.GA19474@Sellars>
	<1291761150-29818-7-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291761150-29818-7-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/20] batman-adv: Prepare and send own
 multicast tracker packets
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
Cc: Linus L??ssing <linus.luessing@saxnet.de>

> +#define tracker_packet_for_each_dest(mcast_entry, dest_entry, mcast_num, dest_num, tracker_packet) \
> +	for (mcast_num = 0, mcast_entry = (struct mcast_entry *)(tracker_packet + 1), \
> +	     dest_entry = (uint8_t *)(mcast_entry + 1); \
> +	     mcast_num < tracker_packet->num_mcast_entries; mcast_num++, \
> +	     mcast_entry = (struct mcast_entry *)dest_entry, \
> +	     dest_entry = (uint8_t *)(mcast_entry + 1)) \
> +		for (dest_num = 0; dest_num < mcast_entry->num_dest; dest_num++, \
> +		     dest_entry += ETH_ALEN)

It is probably not a good idea to have nested for loops inside a macro
like this. What happens with code like:

     tracker_packet_for_each_dest(mcast_entry, dest_entry, mcast_num, dest_num, tracker_packet) {
         ...         
         ...
         if (foo == bar)
	     break;

         if (foo)
	    continue;
     
These don't do what you would expect.

      Andrew
