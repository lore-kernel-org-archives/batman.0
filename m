Return-Path: <davem@davemloft.net>
Date: Tue, 19 Jun 2012 14:49:41 -0700 (PDT)
Message-Id: <20120619.144941.1042145718266158529.davem@davemloft.net>
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

> skb_linearize(skb) possibly rearranges the skb internal data and then changes
> the skb->data pointer value. For this reason any other pointer in the code that
> was assigned skb->data before invoking skb_linearise(skb) must be re-assigned.
> 
> In the current tt_query message handling code this is not done and therefore, in
> case of skb linearization, the pointer used to handle the packet header ends up
> in pointing to free'd memory.
> 
> This bug was introduced by a73105b8d4c765d9ebfb664d0a66802127d8e4c7
> (batman-adv: improved client announcement mechanism)
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Cc: <stable@vger.kernel.org>

Applied.

Submit things properly in the future so you don't give me unnecessary
merge hassles like this again.
