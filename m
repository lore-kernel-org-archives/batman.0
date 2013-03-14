Return-Path: <davem@davemloft.net>
Date: Thu, 14 Mar 2013 11:48:12 -0400 (EDT)
Message-Id: <20130314.114812.1928545478791651343.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1363215399-18875-1-git-send-email-ordex@autistici.org>
References: <1363215399-18875-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-03-13
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
Date: Wed, 13 Mar 2013 23:56:30 +0100

> here you have our first patchset intended for net-next/linux-3.10.
> =

> These patches include a new big component implementing a first versio=
n of
> Network Coding for mesh networks. This code is the result of Martin H=
undeb=F8ll
> and Jeppe Ledet-Pedersen's Master Thesis[1]. The target of Network Co=
ding is to
> increase throughput by fusing multiple packets in one wifi transmissi=
on (thus
> saving airtime).
> This new component also introduced a new Kbuild option which can be u=
sed to
> decide whether to include this feature or not. However, a switch to d=
ynamically
> turn off the behaviour at runtime has been provided too. DebugFS has =
also been
> extended with some knobs to be used in case of debugging only.
> =

> The rest is clean up work.

Pulled, thanks Antonio.
