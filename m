Return-Path: <davem@davemloft.net>
Date: Fri, 24 Sep 2010 13:43:34 -0700 (PDT)
Message-Id: <20100924.134334.28812338.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1284836610-26799-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836610-26799-1-git-send-email-sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] net: Add batman-adv meshing protocol
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
To: sven.eckelmann@gmx.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:03:30 +0200

> B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a routing
> protocol for multi-hop ad-hoc mesh networks. The networks may be wired or
> wireless. See http://www.open-mesh.org/ for more information and user space
> tools.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

The only thing remaining which I really don't like is this hash helper
library thing in here.

It's a terrible abstraction and very inefficient.  Iteration uses
function calls, as does removal.  Key comparisons use callbacks, via
indirection function pointers, also very inefficient.

Just use the "struct hlist_head" and "struct hlist_node" objects we
have generically already.  Inline the list iteration, as well as the
key comparisons and the node linking/unlinking.

Otherwise if you think your hash helpers are so incredibly useful,
propose for their inclusion under lib/ on linux-kernel

But frankly, I wish you a lot of luck with that. :-)
