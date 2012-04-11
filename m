Return-Path: <davem@davemloft.net>
Date: Wed, 11 Apr 2012 10:39:33 -0400 (EDT)
Message-Id: <20120411.103933.846397076858317541.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120411143102.GE19365@ritirata.org>
References: <20120411130301.GD19365@ritirata.org>
	<20120411.095809.861355939666821335.davem@davemloft.net>
	<20120411143102.GE19365@ritirata.org>
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 11 Apr 2012 16:31:03 +0200

> Actually we have either the Kconfig option (for binary size purposes) AND a
> boolean attribute in our soft_interface sysfs path (to dynamically turn the
> bridge loop avoidance ON and OFF as you were suggesting).

Distributions are just going to turn on everything, so for %99.999 of
users you really aren't saving anything.
