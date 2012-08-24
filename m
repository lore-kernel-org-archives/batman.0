Return-Path: <davem@davemloft.net>
Date: Fri, 24 Aug 2012 11:46:01 -0400 (EDT)
Message-Id: <20120824.114601.1698041558649925346.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1345727427-20805-1-git-send-email-ordex@autistici.org>
References: <1345727427-20805-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-08-23
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 Aug 2012 15:10:09 +0200

> this is our set of changes intended for net-next/linux-3.7.
> It is mostly composed by style fixes and cleanups. Other than that you have a
> patch introducing a new table in debugfs (backbone gateways table for the Bridge
> Loop Avoidance) and a new mechanism for the TranslationTable component. The
> latter allows mesh nodes to immediately detect new clients joining the network,
> without waiting for any periodic advertisement.

Pulled, thanks Antonio.
