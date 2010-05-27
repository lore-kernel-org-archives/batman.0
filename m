Return-Path: <andrew@lunn.ch>
Date: Thu, 27 May 2010 17:07:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100527150700.GA29869@lunn.ch>
References: <20100527162350.75bef379@rechenknecht>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100527162350.75bef379@rechenknecht>
Subject: Re: [B.A.T.M.A.N.] Layer 2 fragmentation
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

On Thu, May 27, 2010 at 04:23:50PM +0200, Andreas Langer wrote:
> Hello,
> i looked into the problem of fragmenting packets on layer2 to solve the mtu issue. I found a
> unforeseen problem : oversized packets will be dropped by the bridge module ( if bat0 is in a
> bridge ). I think the reason can be found here net/bridge/br_forward.c on line 44
> 
> 43         /* drop mtu oversized packets except gso */
> 44         if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
> 45                 kfree_skb(skb);


I don't quite understand the problem. If you have implemented
fragmentation, you will naturally increase the MTU on bat0 so that it
is the standard for Ethernet. So this statement will not trigger.

   Andrew
