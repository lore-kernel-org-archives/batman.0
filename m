Return-Path: <davem@davemloft.net>
Date: Thu, 17 Oct 2013 14:27:40 -0400 (EDT)
Message-Id: <20131017.142740.1144850877979986678.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
References: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2013-10-13
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 13:22:45 +0200

> this is our second pull request intended for net-next/linux-3.13.
> =

> The most important piece in this patchset is the new packet fragmenta=
tion code
> implemented by Martin Hundeb=F8ll during his Google Summer of Code 20=
12[1]. This
> code is entirely substituting the current fragmentation mechanism.
> =

> Other than this you have:
> - the creation of a common BAT ICMP header which makes the ICMP subsy=
stem more
>   flexible and extensible
> - the addition of a dummy rx mode handler for the soft-interface whic=
h allows
>   users to set static multicast listeners
> - some minor improvements and code cleanups
> =

> =

> Please pull or let me know of any problem.

Pulled, thanks Antonio.
