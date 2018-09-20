Return-Path: <davem@davemloft.net>
Date: Wed, 19 Sep 2018 20:34:34 -0700 (PDT)
Message-Id: <20180919.203434.1784595444537176012.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180919122213.23108-1-sw@simonwunderlich.de>
References: <20180919122213.23108-1-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/11] pull request for net: batman-adv
 2018-09-19
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
Date: Wed, 19 Sep 2018 14:22:02 +0200

> here are some bugfixes which we would like to see integrated into net.
> 
> We forgot to bump the version number in the last round for net-next, so
> the belated patch to do that is included - we hope you can adopt it.
> This will most likely create a merge conflict later when merging into
> net-next with this rounds net-next patchset, but net-next should keep
> the 2018.4 version[1].
> 
> Please pull or let me know of any problem!

Pulled, thanks Simon.

In the future, you can put that merge resolution guidance into the
merge commit message.

When people give annotations like this, I refer to them when I do
merges and it helps me a lot.  If it's in the actual GIT history,
that is tons easier than if it just appeared in your pull request
email.

I manually included it in the merge commit message this time.

Thanks!
