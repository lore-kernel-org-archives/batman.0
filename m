Return-Path: <davem@davemloft.net>
Date: Tue, 19 Jun 2012 14:28:03 -0700 (PDT)
Message-Id: <20120619.142803.977377594415293854.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1340133999-26838-1-git-send-email-ordex@autistici.org>
References: <1340133999-26838-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH net] batman-adv: fix skb->data assignment
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 19 Jun 2012 21:26:39 +0200

> This patch has already been merged in net-next. I am sorry about that, but we
> were missing some knowledge about sending patches for stable.

You really like making my life miserable.

What is so damn complicated about:

1) BUG FIXES go to 'net'

2) NON BUG FIXES go to 'net-next'

This gets stated repeatedly here.

I do see you guys erroneously submit bug fixes into net-next all
the time but I just assumed you simply didn't give a shit about
bug fixes propagating quickly.

You guys definitely need to get your asses in gear.
