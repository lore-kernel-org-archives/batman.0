Return-Path: <davem@davemloft.net>
Date: Tue, 19 Jun 2012 02:02:27 -0700 (PDT)
Message-Id: <20120619.020227.393422018169766346.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1371147.SQlum5V1iP@bentobox>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
	<20120619.004140.1665121006123027013.davem@davemloft.net>
	<1371147.SQlum5V1iP@bentobox>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 10:07:12 +0200

> On Tuesday 19 June 2012 00:41:40 David Miller wrote:
> [....]
>> You must only make stable submissions for patches that have
>> made their way into Linus's tree.
> 
> That is correct. These patches were meant to be sent as reply to the patch you 
> pulled today (that contained the initial Cc: stable@...). These were sent to 
> avoid the cherry-pick of feature patches necessary to merge it and still give 
> an idea how these versions could be fixed after the mentioned commit hit 
> Linus' tree.

Patches you want to end up in -stable should be submitted for 'net'
not 'net-next'.

There is no other valid submission scheme.
