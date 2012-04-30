Return-Path: <davem@davemloft.net>
Date: Mon, 30 Apr 2012 13:05:55 -0400 (EDT)
Message-Id: <20120430.130555.48557916635285475.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1335689867-8017-7-git-send-email-ordex@autistici.org>
References: <1335689867-8017-1-git-send-email-ordex@autistici.org>
	<1335689867-8017-7-git-send-email-ordex@autistici.org>
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
Date: Sun, 29 Apr 2012 10:57:38 +0200

> In case of an ARP message going in or out the soft_iface, it is intercepted and
> a special action is performed. In particular the DHT helper functions previously
> implemented are used to store all the ARP entries belonging to the network in
> order to provide a fast and unicast lookup instead of the classic broadcast
> flooding mechanism.
> Each node stores the entries it is responsible for (following the DHT rules) in
> its soft_iface ARP table. This makes it possible to reuse the kernel data
> structures and functions for ARP management.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Sorry, I'm not letting subsystems outside of net/ipv4/arp.c and related
code make changes to the ARP table.

I plan to make major surgery to the way neighbour table entries are
handled and therefore the less people who get their grubby paws
directly in there, the better.

Find a way to propagate the ARP packet into the properl ARP receive
path to cause the state update to occur, I'm not letting you trigger
it by hand in the batman-adv code.

Sorry.
