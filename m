Return-Path: <davem@davemloft.net>
Date: Sat, 26 Nov 2011 14:41:22 -0500 (EST)
Message-Id: <20111126.144122.775553783672941660.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
References: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-11-26
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
To: lindner_marek@yahoo.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 22:26:42 +0800

> the following 10 patches constitute the first batch I'd like to get the pulled
> into net-next-2.6/3.3. They're mostly uncritical fixes around the recently
> introduced tt code, some code refactoring, the kstrto update and the range
> check fix reported by Thomas Jarosch. 

Pulled, thanks.

Some things to look into:

+			if (unlikely(skb_headlen(skb) <
+					sizeof(struct tt_query_packet) +
+					tt_len))

This isn't formatted correctly, all the leading edges should line
up to the openning parenthesis of the unlikely:

+			if (unlikely(skb_headlen(skb) <
+				     sizeof(struct tt_query_packet) +
+				     tt_len))

Next, there is a lot of linearization done by the stack, but really the
thing to do is to make sure that the part you want to look at is
linear.

You do this using pskb_may_pull() right before you want to look at some
headers. It makes sure that, for the length given, that many bytes are
linear at the head of the skb.

Thanks.

