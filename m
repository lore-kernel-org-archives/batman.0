Return-Path: <davem@davemloft.net>
Date: Tue, 05 Aug 2014 16:40:09 -0700 (PDT)
Message-Id: <20140805.164009.1703458407190401181.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407224188-28626-1-git-send-email-antonio@meshcoding.com>
References: <1407224188-28626-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2014-08-05
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  5 Aug 2014 09:36:24 +0200

> this is a pull request intended for net-next/linux-3.17 (yeah..it's really
> late).
> 
> Patches 1, 2 and 4 are really minor changes:
> - kmalloc_array is substituted to kmalloc when possible (as suggested by
>   checkpatch);
> - net_ratelimited() is now used properly and the "suppressed" message is not
>   printed anymore if not needed;
> - the internal version number has been increased to reflect our current version.
> 
> Patch 3 instead is introducing a change in the metric computation function
> by changing the penalty applied at each mesh hop from 15/255 (~6%) to
> 30/255 (~11%). This change is introduced by Simon Wunderlich after having
> observed a performance improvement in several networks when using the new value.

Pulled, thanks Antonio.
