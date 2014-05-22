Return-Path: <davem@davemloft.net>
Date: Thu, 22 May 2014 15:37:42 -0400 (EDT)
Message-Id: <20140522.153742.1822151259317153775.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1400662742-31999-1-git-send-email-linus.luessing@web.de>
References: <1400662742-31999-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] bridge: multicast snooping patches / exports
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
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Wed, 21 May 2014 10:58:58 +0200

> These two patches are exporting functionality needed to marry the bri=
dge
> multicast snooping with the batman-adv multicast optimizations recent=
ly
> added for the 3.15 kernel, allowing to use these optimzations in comm=
on
> setups having a bridge on top of e.g. bat0, too. So far these bridged=

> setups would fall back to simple flooding through the batman-adv mesh=

> network for any multicast packet entering bat0.
> =

> More information about the batman-adv multicast optimizations current=
ly
> implemented can be found here:
> =

> http://www.open-mesh.org/projects/batman-adv/wiki/Basic-multicast-opt=
imizations
> =

> The integration on the batman-adv side could afterwards look like thi=
s,
> for instance:
> =

> http://git.open-mesh.org/batman-adv.git/commitdiff/576b59dd3e34737c70=
2e548b21fa72059262f796?hp=3Df95ce7131746c65fbcdffcf2089cab59e2c2f7ac

I'd really like to see some feedback from bridge folks before applying
this, thanks.
