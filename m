Return-Path: <davem@davemloft.net>
Date: Wed, 11 Apr 2012 09:58:09 -0400 (EDT)
Message-Id: <20120411.095809.861355939666821335.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120411130301.GD19365@ritirata.org>
References: <1334148649-25443-1-git-send-email-ordex@autistici.org>
	<20120411130301.GD19365@ritirata.org>
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
Date: Wed, 11 Apr 2012 15:03:03 +0200

>   git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem
> 
> for you to fetch changes up to 7a5cc24277b57ce38eb0afa6634b71d4d5cc671e:
> 
>   batman-adv: add bridge loop avoidance compile option (2012-04-11 14:29:00 +0200)

Pulled, but I think the way you're doing the bridge loop avoidance stuff
is wrong.

Don't use a Kconfig option, use a sysctl to turn the behavior off or on
at runtime instead.
