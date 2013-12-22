Return-Path: <davem@davemloft.net>
Date: Sun, 22 Dec 2013 18:50:27 -0500 (EST)
Message-Id: <20131222.185027.572777902017063381.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1387412132-889-2-git-send-email-antonio@meshcoding.com>
References: <1387412132-889-1-git-send-email-antonio@meshcoding.com>
 <1387412132-889-2-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: free nf_bridge member on
 locally delivered skb
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 19 Dec 2013 01:15:27 +0100

> If an interface enslaved into batman-adv is a bridge (or a
> virtual interface built on top of a bridge) the nf_bridge
> member of the skbs reaching the soft-interface is filled
> with the state about "netfilter bridge" operations.
> 
> Then, if one of such skbs is locally delivered, the nf_bridge
> member should be cleaned up to avoid that the old state
> could mess up with other "netfilter bridge" operations when
> entering a second bridge.
> This is needed because batman-adv is an encapsulation
> protocol.
> 
> However at the moment skb->nf_bridge is not released at all
> leading to bogus "netfilter bridge" behaviours.
> Fix this by releasing skb->nf_bridge before an skb gets
> delivered to the upper layer in interface_rx().
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

See nf_reset() and skb_scrub_packet().  Do not reinvent the
wheel.

Thank you.
