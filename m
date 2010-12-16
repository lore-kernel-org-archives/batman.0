Return-Path: <davem@davemloft.net>
Date: Thu, 16 Dec 2010 14:01:53 -0800 (PST)
Message-Id: <20101216.140153.232733922.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1292275168-19882-1-git-send-email-sven@narfation.org>
References: <1292275168-19882-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv8] net: Add batman-adv meshing protocol
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, greg@kroah.com

From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Dec 2010 22:19:28 +0100

> B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a routing
> protocol for multi-hop ad-hoc mesh networks. The networks may be wired or
> wireless. See http://www.open-mesh.org/ for more information and user space
> tools.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied, thanks Sven.

How do you want to take care of the copy that still lives under
staging?

Greg, any preferences on your end?

I'm more than happy to do the removal from my net-next-2.6 tree
since the bonafide copy of net/batman-adv is now there.

