Return-Path: <davem@davemloft.net>
Date: Mon, 21 Jul 2014 20:19:37 -0700 (PDT)
Message-Id: <20140721.201937.2036288525192398014.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1405929211-30187-1-git-send-email-antonio@meshcoding.com>
References: <1405929211-30187-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20140721
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
Date: Mon, 21 Jul 2014 09:53:29 +0200

> here you have two fixes that we have been testing for quite some time
> (this is why they arrived a bit late in the rc cycle).
> 
> Patch 1) ensures that BLA packets get dropped and not forwarded to the
> mesh even if they reach batman-adv within QinQ frames. Forwarding them
> into the mesh means messing up with the TT database of other nodes which
> can generate all kind of unexpected behaviours during route computation.
> 
> Patch 2) avoids a couple of race conditions triggered upon fast VLAN
> deletion-addition. Such race conditions are pretty dangerous because
> they not only create inconsistencies in the TT database of the nodes
> in the network, but such scenario is also unrecoverable (unless
> nodes are rebooted).
 ...
>   git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

Pulled, thanks Antonio.
