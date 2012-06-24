Return-Path: <davem@davemloft.net>
Date: Sat, 23 Jun 2012 23:24:38 -0700 (PDT)
Message-Id: <20120623.232438.525314692277944525.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1340465459-2949-1-git-send-email-ordex@autistici.org>
References: <1340465459-2949-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/2 net] Bug fixes for batman-adv
	2012-06-23
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
Date: Sat, 23 Jun 2012 17:30:57 +0200

> Patch 1 is a fix for the AP-Isolation feature. A wrong check made all the
> broadcast packets coming from any client be dropped before delivery to the
> interface.
> Patch 2 instead fixes a "real" race condition in the TranslationTable code.
 ...
>   git://git.open-mesh.org/linux-merge.git batman-adv/maint

Pulled, thanks.
