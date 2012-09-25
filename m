Return-Path: <davem@davemloft.net>
Date: Tue, 25 Sep 2012 13:25:25 -0400 (EDT)
Message-Id: <20120925.132525.2198280699907795077.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1348588637-18441-1-git-send-email-ordex@autistici.org>
References: <1348588637-18441-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-09-25
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
Date: Tue, 25 Sep 2012 17:57:15 +0200

> here are two fixes (the last set) we would to propose for net/linux-3=
.6.
> =

> The one from Def fixes a wrong behaviour of batman-adv in case of vir=
tual
> interface mac address change, while the other from Lin=FCs fixes a pr=
oblem in the
> route selection which can lead to a continuous route flapping under c=
ertain
> conditions.
> =

> We would also like to enqueue both patches for sending to stable-3.5.=

> =

> During merge with net/master you will hit a conflict. I'm going to se=
nd some
> instructions on how to solve it.
 ...
>   git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-dav=
em

Pulled, thanks.
