Return-Path: <davem@davemloft.net>
Date: Mon, 12 Dec 2011 19:28:21 -0500 (EST)
Message-Id: <20111212.192821.886469661461010981.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
References: <1323689516-24427-1-git-send-email-lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-12-12
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
Date: Mon, 12 Dec 2011 19:31:44 +0800

> here comes the next batch I'd like to get the pulled into net-next-2.6/3.3.
> We have a couple of minor fixes for unregister_netdevice(), compat flags,
> return value checks and a readme update. Plus the regression fix from Dan
> that addresses a bug introduced with the previous batch. Security 
> researcher Paul Kot checked our kernelland / user space communication and
> found a subtle bug which would make batman-adv write to memory locations
> it should not write to. However, he did not find a way to exploit this
> bug, therefore we classified it as "non-critical". Please let us know if
> that is not ok with you.

All pulled into net-next, thanks.
