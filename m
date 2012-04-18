Return-Path: <davem@davemloft.net>
Date: Wed, 18 Apr 2012 13:22:48 -0400 (EDT)
Message-Id: <20120418.132248.2265308681920218130.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334743210-12338-1-git-send-email-ordex@autistici.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-18
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
Date: Wed, 18 Apr 2012 11:59:57 +0200

> this is the fixed version of my previous pull request (issued on 2012-04-17).
> In this patchset the issues you reported have been fixed; moreover I'm
> also including two new patches (1/13 and 2/13) which are respectively:
> 
> 1/13) a fix for Al Viro's report about the missing htons()
> 2/13) a fix for a wrongly duplicated line in a comment
> 
> The following changes since commit ecffe75f934b4e3c5301fe5db278068e0efb0d6b:
> 
>   hippi: fix printk format in rrunner.c (2012-04-16 23:48:38 -0400)
> 
> are available in the git repository at:
> 
>   git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

This looks a lot better, pulled, thanks!
