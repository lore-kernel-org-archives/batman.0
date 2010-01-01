Return-Path: <andrew@lunn.ch>
Date: Fri, 1 Jan 2010 18:52:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100101175259.GB31328@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Missing unlocks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Simon

I just built batman-adv with make C=1 so that sparse it used to check
the code. It found a few missing unlocks...

drivers/staging/batman-adv/routing.c:585:12: warning: context imbalance in 'recv_my_icmp_packet' - different lock contexts for basic block

This is the return if the skb_copy() fails.

drivers/staging/batman-adv/routing.c:640:12: warning: context imbalance in 'recv_icmp_ttl_exceeded' - different lock contexts for basic block

Same again.

drivers/staging/batman-adv/routing.c:695:5: warning: context imbalance in 'recv_icmp_packet' - different lock contexts for basic block

and same again...

in each case you are missing a 

spin_unlock_irqrestore(&orig_hash_lock, flags);

before the 

return NET_RX_DROP;

    Andrew
