Return-Path: <davem@davemloft.net>
Date: Sat, 11 May 2013 16:24:23 -0700 (PDT)
Message-Id: <20130511.162423.332204083485209564.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1368097007-817-1-git-send-email-ordex@autistici.org>
References: <1368097007-817-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: batman-adv 2013-05-09
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
Date: Thu,  9 May 2013 12:56:43 +0200

> here you have four fixes intended for net.
> 
> 1/4 fixes the parsing of a string sent from userspace in order to avoid random
> memory access in case of string length of 0.
> 
> 2/4 adds a check for the return value of pskb_trim_rcsum() in order to stop
> processing the skb in case of failure.
> 
> 3/4 prevents DAT (the Distributed ARP Table) to send cached ARP replies when
> both the source and the destination of the snooped ARP request are local clients
> (meaning: directly connected to the node). This can confuse a bridge where
> batman-adv is enslaved.
> 
> 4/4 fix a race condition in the main clean up procedure by reordering
> sub-components freeing function invocations.
> 
> Please pull or let me know if there is any problem.

Pulled, thanks Antonio.
