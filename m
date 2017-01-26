Return-Path: <davem@davemloft.net>
Date: Wed, 25 Jan 2017 22:56:24 -0500 (EST)
Message-Id: <20170125.225624.965229145391320056.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170125164303.14268-3-sw@simonwunderlich.de>
References: <20170125164303.14268-1-sw@simonwunderlich.de>
 <20170125164303.14268-3-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Treat NET_XMIT_CN as
 transmit successfully
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sw@simonwunderlich.de
Cc: gfree.wind@gmail.com, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 25 Jan 2017 17:42:58 +0100

> From: Gao Feng <gfree.wind@gmail.com>
> 
> The tc could return NET_XMIT_CN as one congestion notification, but
> it does not mean the packet is lost. Other modules like ipvlan,
> macvlan, and others treat NET_XMIT_CN as success too.
> 
> So batman-adv should add the NET_XMIT_CN check.
> 
> Signed-off-by: Gao Feng <gfree.wind@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Instead of all of this churn, just change the dev_queue_xmit() call in
net/batman-adv/send.c to be:

	return net_xmit_eval(dev_queue_xmit(skb));
