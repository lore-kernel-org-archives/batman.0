Return-Path: <davem@davemloft.net>
Date: Sat, 05 Dec 2015 17:45:13 -0500 (EST)
Message-Id: <20151205.174513.2022539696324982508.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
References: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next 0/4] Allow BATMAN to use
	hdlc-eth interfaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.net, mareklindner@neomailbox.ch, khc@pm.waw.pl

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  3 Dec 2015 21:12:29 +0100

> BATMAN works over Ethernet like interfaces. hdlc-eth provides the need
> requirements. However, hdlc devices are often created as raw hdlc
> devices, which batman cannot use, and are then be transmuted into
> other types using sethdlc(1). Have the HDLC code emit
> NETDEV_*_TYPE_CHANGE events when the type changes, and have BATMAN
> react on these events.

Series applied, thanks.
