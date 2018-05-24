Return-Path: <davem@davemloft.net>
Date: Thu, 24 May 2018 11:03:00 -0400 (EDT)
Message-Id: <20180524.110300.1894112492399057393.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/8] pull request for net-next:
 batman-adv 2017-05-24
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:52 +0200

> here is a our feature/cleanup pull request of batman-adv to go into net-next.
> 
> Please pull or let me know of any problem!

Pulled.

You should really remove the EXPERIMENTAL tag from the V
protocol support if you want it to be on by default.  Maybe
even remove the Kconfig knob entirely.
