Return-Path: <davem@davemloft.net>
Date: Wed, 13 Jan 2016 14:58:13 -0500 (EST)
Message-Id: <20160113.145813.44327435000640737.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1452707514-5091-1-git-send-email-a@unstable.cc>
References: <1452707514-5091-1-git-send-email-a@unstable.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160114
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Jan 2016 01:51:52 +0800

> these are two small fixes intended for your net tree.
> 
> Patch 1 prevents a lockdep splat from appearing along the
> shutdown path due to a missing lock in mcast_free(), by Simon Wunderlich.
> 
> Patch 2 fixes a new feature introduced in 4.5 by ensuring that a
> batadv_hardif_neigh_node object is free'd only when it is no
> longer used in any context, by Sven Eckelmann.
> 
> Please pull or let me know of any issue.

Pulled, thanks!
