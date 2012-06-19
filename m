Return-Path: <davem@davemloft.net>
Date: Mon, 18 Jun 2012 20:28:55 -0700 (PDT)
Message-Id: <20120618.202855.272613444878909098.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-06-18
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
Date: Mon, 18 Jun 2012 22:39:04 +0200

> Hello David,
> 	here is our first set of changes intended for next-next/linux-3.6.
> =

> Patch 2 fixes a major bug in the TranslationTable code where the old =
value of
> skb->data is used for memory access even if the data was relocated.
> Patches 4, 10, 11, 13, 14 are endianess-related cleanups that we wrot=
e thanks
> to Al Viro's advice and help.
> Thanks to Martin Hundeb=F8ll batman-adv now supports the ethtool API =
and can
> export several counters that are specific to our module (patch 5).
> Then patch 16 improves the routing protocol API by making part of the=

> TranslationTable code routing agnostic.
> The rest are minor fixes and other cleanups.

Pulled, thanks.
