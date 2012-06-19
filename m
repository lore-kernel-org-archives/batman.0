Return-Path: <davem@davemloft.net>
Date: Tue, 19 Jun 2012 00:41:40 -0700 (PDT)
Message-Id: <20120619.004140.1665121006123027013.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1340090430-356-1-git-send-email-ordex@autistici.org>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
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
To: ordex@autistici.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 19 Jun 2012 09:20:30 +0200

> commit d2b6cc8e460494251442a877fcbc150faa175b4f upstream.

That commit does not exist in Linus's tree.

It exists in the net-next tree.

You must only make stable submissions for patches that have
made their way into Linus's tree.
