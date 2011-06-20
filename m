Return-Path: <davem@davemloft.net>
Date: Mon, 20 Jun 2011 13:01:19 -0700 (PDT)
Message-Id: <20110620.130119.2092406320851066318.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1308565025-21293-1-git-send-email-sven@narfation.org>
References: <1308565025-21293-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-06-20
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2011 12:16:53 +0200

> I would like to propose following changes for net-next-2.6/3.1. The
> first part (1-4) are only only small cleanup patches. The last 8 patches
> are related to Antonio Quartulli's research "Client announcement and
> Fast roaming in a Layer-2 mesh network". The technical report isn't
> published yet, but will hopefully follow soon. He tried to document all
> important parts in some (unofficial) documents [1,2,3].

Pulled, but you should seriously consider locking down the on-the-wire
protocol at some point and only make backward compatible changes to it
from that point forward.
