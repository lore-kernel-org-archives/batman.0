Return-Path: <davem@davemloft.net>
Date: Thu, 28 Apr 2016 16:43:51 -0400 (EDT)
Message-Id: <20160428.164351.907536352207317310.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1461641239-7097-1-git-send-email-a@unstable.cc>
References: <1461641239-7097-1-git-send-email-a@unstable.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv-0160426
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
Date: Tue, 26 Apr 2016 11:27:14 +0800

> In this patchset you can find the following fixes:

Pulled, even though there were some typos in the commit messages.

> Patch 2 and 3 have no "Fixes:" tag because the offending commits date
> back to when batman-adv was not yet officially in the net tree.

This is not correct.  Instead, in the future, you should provide a
Fixes: tag that indicates the commit that merged batman-adv into the
upstream tree initially.

Thanks.
