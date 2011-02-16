Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Feb 2011 07:16:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110216061649.GC11570@lunn.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
	<1297789948-16948-4-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297789948-16948-4-git-send-email-linus.luessing@ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/13] batman-adv: Unify TTL handling
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

On Tue, Feb 15, 2011 at 06:12:18PM +0100, Linus L??ssing wrote:
> All our packets have a TTL and with the last batman header patch also at
> the same place in a batman encapsulated packet. We can therefore savely
> do one single TTL check before sending any batman packet type.
 
> +static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
> +				  struct sk_buff *skb)
> +{
> +	struct orig_node *orig_node = NULL;
> +	struct neigh_node *neigh_node = NULL;
> +	struct icmp_packet *icmp_packet;
> +	int ret = NET_RX_DROP;
> +

This is in the middle of the send path, so calling it
recv_icmp_ttl_exceeded() seems a bit strange. I would say either
send_icmp_ttl_exceeded() or recvd_icmp_ttl_exceeded() are better.

	 Andrew
