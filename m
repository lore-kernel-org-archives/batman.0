Return-Path: <davem@davemloft.net>
Date: Sun, 22 Dec 2013 19:16:22 -0500 (EST)
Message-Id: <20131222.191622.118900475665948342.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <52B77F9E.8040201@meshcoding.com>
References: <1387412132-889-2-git-send-email-antonio@meshcoding.com>
 <20131222.185027.572777902017063381.davem@davemloft.net>
 <52B77F9E.8040201@meshcoding.com>
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
Date: Mon, 23 Dec 2013 01:11:10 +0100

> Do you think it is safe to use nf_reset() directly?

If you do not know, you probably should not be making these
changes at all :-)

There is zero reason for your protocol layer to have an ad-hoc private
SKB netfilter state reset function that touches internals in this way.

At least with the generic helpers, we know the side effects and the
function is well known to other developers.
