Return-Path: <davem@davemloft.net>
Date: Sat, 07 Oct 2017 20:59:52 +0100 (WEST)
Message-Id: <20171007.205952.775593212999479324.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171007122122.6470-1-sven@narfation.org>
References: <20171007121853.6278-1-sven@narfation.org>
 <20171007122122.6470-1-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add missing kerneldoc
 for extack
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, dsahern@gmail.com

From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Oct 2017 14:21:22 +0200

> The parameter extack was added to batadv_softif_slave_add without adding
> the kernel-doc for it. This caused kernel-doc warnings.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: David Ahern <dsahern@gmail.com>

I'm happy to apply this but where are the other two patches of this
series and the series header posting?
