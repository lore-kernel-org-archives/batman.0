Return-Path: <davem@davemloft.net>
Date: Wed, 19 Sep 2012 15:50:49 -0400 (EDT)
Message-Id: <20120919.155049.1144637355081576911.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1347619254-22862-1-git-send-email-ordex@autistici.org>
References: <1347619254-22862-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH net] batman-adv: make batadv_test_bit()
 return 0 or 1 only
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
Date: Fri, 14 Sep 2012 12:40:54 +0200

> From: Linus L=FCssing <linus.luessing@web.de>
> =

> On some architectures test_bit() can return other values than 0 or 1:=

> =

> With a generic x86 OpenWrt image in a kvm setup (batadv_)test_bit()
> frequently returns -1 for me, leading to batadv_iv_ogm_update_seqnos(=
)
> wrongly signaling a protected seqno window.
> =

> This patch tries to fix this issue by making batadv_test_bit() return=
 0
> or 1 only.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> Acked-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Indeed, for variable bit testing x86 uses the 'sbb' instruction
to form the result.  So we either get 0 or -1 from test_bit().

Patch applied, thanks a lot.
