Return-Path: <davem@davemloft.net>
Date: Tue, 10 Jun 2014 23:51:23 -0700 (PDT)
Message-Id: <20140610.235123.310487202447168937.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1402158389-13239-1-git-send-email-linus.luessing@web.de>
References: <1402158389-13239-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 net-next 0/4] bridge: multicast
 snooping patches / exports
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
To: linus.luessing@web.de
Cc: b.a.t.m.a.n@lists.open-mesh.org, herbert@gondor.apana.org.au, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Sat,  7 Jun 2014 18:26:25 +0200

> The first patch is simply a cosmetic patch. So far I (and maybe other=
s
> too?) have been regularly confusing these two structs, therefore I'd
> suggest renaming them and therefore making the follow-up patches easi=
er
> to understand and nicer to fit in.
> =

> The second patch fixes a minor issue, but probably not worth for stab=
le.
> =

> On the other hand the first two patches are also preparations for the=

> third and fourth patch:
> =

> These two patches are exporting functionality needed to marry the bri=
dge
> multicast snooping with the batman-adv multicast optimizations recent=
ly
> added for the 3.15 kernel, allowing to use these optimzations in comm=
on
> setups having a bridge on top of e.g. bat0, too. So far these bridged=

> setups would fall back to simple flooding through the batman-adv mesh=

> network for any multicast packet entering bat0.

Series applied, thank you.
