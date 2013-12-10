Return-Path: <davem@davemloft.net>
Date: Mon, 09 Dec 2013 20:58:22 -0500 (EST)
Message-Id: <20131209.205822.126859687683341998.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1386368461.31845.38.camel@joe-AO722>
References: <1386364621.31845.32.camel@joe-AO722>
 <20131206.163806.1555069105347405484.davem@davemloft.net>
 <1386368461.31845.38.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH -next] etherdevice: Add
	ether_addr_equal_unaligned
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
To: joe@perches.com
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com

From: Joe Perches <joe@perches.com>
Date: Fri, 06 Dec 2013 14:21:01 -0800

> Add a generic routine to test if possibly unaligned
> to u16 Ethernet addresses are equal.
> 
> If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set,
> this uses the slightly faster generic routine
> ether_addr_equal, otherwise this uses memcmp.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
