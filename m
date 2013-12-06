Return-Path: <davem@davemloft.net>
Date: Fri, 06 Dec 2013 16:38:06 -0500 (EST)
Message-Id: <20131206.163806.1555069105347405484.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1386364621.31845.32.camel@joe-AO722>
References: <1386317890.31845.26.camel@joe-AO722>
 <20131206.153944.1382127535160341376.davem@davemloft.net>
 <1386364621.31845.32.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH -next] batadv: Slight optimization of
	batadv_compare_eth
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
Date: Fri, 06 Dec 2013 13:17:01 -0800

> On Fri, 2013-12-06 at 15:39 -0500, David Miller wrote:
>> If so, make a function for that in linux/etherdevice.h and invoke it
>> in such places.  You can name it something like
>> "ether_addr_equal_unaligned()" or similar.
> 
> I'll resubmit if/after you apply the
> ether_addr_equal/compare_ether_addr removal.

Done.
