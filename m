Return-Path: <an.langer@gmx.de>
Date: Thu, 27 May 2010 16:23:50 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100527162350.75bef379@rechenknecht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Layer 2 fragmentation
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,
i looked into the problem of fragmenting packets on layer2 to solve the mtu issue. I found a
unforeseen problem : oversized packets will be dropped by the bridge module ( if bat0 is in a
bridge ). I think the reason can be found here net/bridge/br_forward.c on line 44

43         /* drop mtu oversized packets except gso */
44         if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb))
45                 kfree_skb(skb);

Possible solution: make a patch for the bridge module

if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb) && !(skb->dev->priv_flags &
IFF_CAN_FRAG))

IFF_CAN_FRAG must be added to include/linux/if.h and batman-adv has to set this flag on bat0

I can make a patch for mainline inclusion, do you believe it is going to be accepted ?

regards, 
andreas
