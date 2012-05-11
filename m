Return-Path: <davem@davemloft.net>
Date: Fri, 11 May 2012 18:01:44 -0400 (EDT)
Message-Id: <20120511.180144.174337959525316777.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1336738892-7401-1-git-send-email-ordex@autistici.org>
References: <1336738892-7401-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-05-11
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
Date: Fri, 11 May 2012 14:21:17 +0200

> this is a fixed version of the pull request issued on 2012-05-09.
> 
> Comments introduced in this patchset are not following the net-tree
> guidelines. Another patch changing all the already existing comments will follow
> later. 
> 
> New exported functions follow the new name convention we discussed so far.
> A patch renaming all the existing exported functions will follow.

Pulled, but you have to cleanup the namespace on lots of other
functions too.

For example, the packet receive handle register/unregister routines
you added in this series as well.

Go through the entire batman-adv stack, and if the function or data
object is not static, make sure it has a batadv_*() prefix.
