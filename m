Return-Path: <andrew@lunn.ch>
Date: Sat, 15 Jan 2011 15:14:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110115141407.GR23716@lunn.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
	<1294966794-17780-5-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294966794-17780-5-git-send-email-linus.luessing@ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/11] batman-adv: Creating neighbor
 structures, updating LQs
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
Cc: Linus L??ssing <linus.luessing@ascom.ch>

>  
> +	neigh_entry = (struct neigh_entry *)(ndp_packet + 1);
> +	spin_lock_bh(&batman_if->neigh_list_lock);
> +	hlist_for_each_entry(neigh_node, node, &batman_if->neigh_list, list) {
> +		if (entries_len + sizeof(struct neigh_entry) >
> +		    skb_tailroom(skb))
> +			break;
> +
> +		memcpy(neigh_entry->addr, neigh_node->addr, ETH_ALEN);
> +		neigh_entry->rq = neigh_node->rq;
> +		ndp_packet->num_neighbors++;
> +		neigh_entry++;
> +		entries_len += sizeof(struct neigh_entry);
> +	}
> +	spin_unlock_bh(&batman_if->neigh_list_lock);
> +	skb_put(skb, entries_len);

Hi Linus

It might be worth while putting in a rate limited warning message if
there is not enough space to put all the neighbors into the ndp
message. A lot depends on how big your ndp packet is. If you are
sending a 64 byte packet, you only have space for 4 neighbors.  When
the 5th neighbor appears, you are going to see problems, OGM will
work, but ndp won't etc. If you are sending MTU size packets, then it
is less of a problem, you can have over 180 neighbors, which should
not be a problem...

    Andrew
