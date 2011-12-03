Return-Path: <davem@davemloft.net>
Date: Fri, 02 Dec 2011 20:59:55 -0500 (EST)
Message-Id: <20111202.205955.840690319685535229.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20111203015528.GB3148@ritirata.org>
References: <20111202171216.GA4561@ritirata.org>
	<20111202.125725.896787381527077500.davem@davemloft.net>
	<20111203015528.GB3148@ritirata.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-11-26
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 3 Dec 2011 02:55:29 +0100

> We first call pskb_may_pull() to pull the header only and then, under certain
> conditions, we linearise the whole skb to access it all. Should I use
> pskb_may_pull() even in this case?

Why would you need to access the whole thing?

There are only two types of possible accesses:

1) Header parsing --> use pskb_may_pull() as needed.

2) Copying the data to some other location, such as a user
   buffer.  Use skb_copy_datagram_iovec or similar which handle
   fragmented SKBs just fine.

You should handle fragmented SKBs as much as possible, because
linearization is expensive and often amounts to a memory allocation
plus a copy if you linearize the whole thing.
