Return-Path: <davem@davemloft.net>
Date: Sun, 08 May 2011 15:40:06 -0700 (PDT)
Message-Id: <20110508.154006.70211034.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1304868284-9364-1-git-send-email-sven@narfation.org>
References: <1304868284-9364-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-05-08
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
Date: Sun,  8 May 2011 17:24:36 +0200

> Hi,
> 
> I would like to propose following patches for net-next-2.6/2.6.40. They
> include minor cleanups of comments, a big rename patch s/hna/tt/, but
> also a remove some duplicated code. The spinlock which protected the
> list of possible interfaces for batman-adv was completely replaced by
> rtnl_lock because we want to be in sync with the rest of the network
> stack and the extra spinlock made everything more complex without giving
> any additional feature (and rtnl_lock was already used everywhere).
> Related to this patch is also a fix which should prevent a deadlock
> between the sysfs code and the event listener. Also the reference
> counting in find_router was fixed when an error was detected after the
> refcounter was already increased. The only feature is the support for
> multiple vlans in the bridge loop detection code.
> 
> I will submit a patch to remove the atomic_dec_not_zero from main.h
> after Linus accepted the patch you already saw.

Pulled, thanks Sven.
