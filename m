Return-Path: <davem@davemloft.net>
Date: Mon, 02 May 2011 15:06:20 -0700 (PDT)
Message-Id: <20110502.150620.39172573.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1304284234-27338-1-git-send-email-sven@narfation.org>
References: <1304284234-27338-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-05-01
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
Date: Sun,  1 May 2011 23:10:30 +0200

> I would like to propose following patches for net-next-2.6/2.6.40. Marek
> Lindner continued to convert different datastructures to use RCU. Antonio
> Quartulli fixed an important bug introduced in the last patchset related to the
> update of the current gateway. He also did some minor cleanup work.
> 
> I've removed the patch "net: batman-adv: remove rx_csum ethtool_ops" again
> because you already applied it in your branch.

I'll pull this, but I really want you to resolve atomic_dec_not_zero()
properly.

It does not belong in any batman-adv header file.

Instead it belongs in all of arch/${ARCH}/include/asm/atomic.h and
include/asm-generic/atomic.h

Please submit a patch which puts it in the proper place to linux-kernel

Don't worry about build problems resulting from this, I'll make sure
to deal with it properly when the change shows up in Linus's tree.

Thanks.
