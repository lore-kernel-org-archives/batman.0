Return-Path: <davem@davemloft.net>
Date: Thu, 28 Mar 2013 14:34:43 -0400 (EDT)
Message-Id: <20130328.143443.1091407364578033264.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1364457031-3194-1-git-send-email-ordex@autistici.org>
References: <1364457031-3194-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-03-28
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Mar 2013 08:50:20 +0100

> here you have another batch of patches intended for net-next/linux-3.10.
> 
> The first one fixes an endianess bug in the new network coding component,
> sent within our last pull request. It was discovered thanks to
> Fengguang Wu's automated daily checks on our tree (we upgraded our daily
> check to look for endianess bugs as well ;-))
> 
> Then you have patches from 2/11 to 8/11 implementing the RTNL API for virtual
> interfaces manipulation: now users can use the "ip" tool to create/delete
> batman-adv interfaces and to enslave real ones below them. However, to avoid
> breaking any user tool, we did not disrupt our sysfs API.
> 
> Patch 11/11 is addressing a new checkpatch complaining by substituting seq_printf
> with seq_puts when possible (however, checkpatch seems to be broken because it
> raises false positives in case of multi-line seq_printf).
> 
> The rest is ordinary house keeping.

Pulled, thanks.
