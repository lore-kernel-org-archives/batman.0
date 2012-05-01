Return-Path: <davem@davemloft.net>
Date: Mon, 30 Apr 2012 20:59:04 -0400 (EDT)
Message-Id: <20120430.205904.288157818941040253.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120430222226.GB21977@ritirata.org>
References: <1335689867-8017-7-git-send-email-ordex@autistici.org>
	<20120430.130555.48557916635285475.davem@davemloft.net>
	<20120430222226.GB21977@ritirata.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/15] batman-adv: Distributed ARP Table
 - add snooping functions for ARP messages
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 1 May 2012 00:22:30 +0200

> However this patch also contains a procedure which queries the neigh table in
> order to understand whether a given host is known or not.
> Would it be possible to do that in another way (Without manually touching the
> table)?
> 
> Instead, in the next patch (patch 06/15) batman-adv manually increase the neigh
> timeouts. Do you think we should avoid doing that as well? If we are allowed to
> do that, how can we perform the same operation in a cleaner way?
> 
> Last question: why can't other modules use exported functions? Are you going to
> change them as well?

I really don't have time to discuss your neigh issues right now as I'm
busy speaking at conferences and dealing with the backlog of other
patches.

You'll need to find someone else to discuss it with you, sorry.
