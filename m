Return-Path: <davem@davemloft.net>
Date: Wed, 11 Apr 2012 10:50:02 -0400 (EDT)
Message-Id: <20120411.105002.537837753033932732.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4F85989F.6030802@gmail.com>
References: <20120411143102.GE19365@ritirata.org>
	<20120411.103933.846397076858317541.davem@davemloft.net>
	<4F85989F.6030802@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-11
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
To: gmazzurco89@gmail.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Wed, 11 Apr 2012 16:43:43 +0200

> It is not like that for a lot of batman-adv users that works with
> embedded devices where even 10KB makes the dfference

Ok, but you also have the option of making it a seperate module
too.

Right now it's an all or nothing choice.  Once you make a Kconfig
decision, later it's harder to rebuild the kernel to fix a mistake
than to simply load the module in question.

