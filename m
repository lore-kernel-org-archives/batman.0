Return-Path: <davem@davemloft.net>
Date: Thu, 11 Feb 2016 03:50:33 -0500 (EST)
Message-Id: <20160211.035033.2047139693612194678.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1455119847-5862-1-git-send-email-a@unstable.cc>
References: <1455119847-5862-1-git-send-email-a@unstable.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net-next]: batman-adv 20160210
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
Date: Wed, 10 Feb 2016 23:57:06 +0800

> this is another pull request intended for net-next.
> 
> Here you have a batch of patches by Sven Eckelmann that
> drops our private reference counting implementation and
> substitutes it with the kref objects/functions.
> 
> Then you have a patch, by Simon Wunderlich, that
> makes the broadcast protection window code more generic so
> that it can be re-used in the future by other components
> with different requirements.
> 
> Lastly, Sven is also introducing two lockdep asserts in
> functions operating on our TVLV container list, to make
> sure that the proper lock is always acquired by the users.

Pulled, thanks Antonio.
