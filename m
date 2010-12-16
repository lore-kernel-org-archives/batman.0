Return-Path: <davem@davemloft.net>
Date: Thu, 16 Dec 2010 14:31:36 -0800 (PST)
Message-Id: <20101216.143136.258102148.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1292538497-13604-1-git-send-email-sven@narfation.org>
References: <20101216.140153.232733922.davem@davemloft.net>
	<1292538497-13604-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: Remove batman-adv
	from staging
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
Date: Thu, 16 Dec 2010 23:28:17 +0100

> batman-adv is now moved to net/batman-adv/ and can be removed from
> staging.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: David S. Miller <davem@davemloft.net>

As discussed in a previous email, please submit this to Greg KH for
the staging tree, not to me for net-next-2.6.

Otherwise there will be all kinds of unnecessary merge conflicts.
