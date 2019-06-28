Return-Path: <davem@davemloft.net>
Date: Fri, 28 Jun 2019 09:49:05 -0700 (PDT)
Message-Id: <20190628.094905.1673194288384587104.davem@davemloft.net>
Subject: Re: [PATCH 00/10] pull request for net-next: batman-adv 2019-06-27 v2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190628135604.11581-1-sw@simonwunderlich.de>
References: <20190628135604.11581-1-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 28 Jun 2019 15:55:54 +0200

> here is the updated feature/cleanup pull request of batman-adv for net-next
> from yesterday. Your change suggestions have been integrated into Patch 6
> of the series, everything else is unchanged.
> 
> Please pull or let me know of any problem!

Pulled, thanks Simon.

I think that when you have the read_lock held, RCU is not necessary in order
to use __in6_dev_get() but I may be mistaken.  Just FYI...
