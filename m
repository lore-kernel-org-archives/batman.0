Return-Path: <Markus.Elfring@web.de>
Subject: Re: [PATCH] batman-adv: Fix refcnt leak in
 batadv_store_throughput_override
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <afea6694-36c6-bbae-dcfd-f6f6efedb05a@web.de>
Date: Wed, 15 Apr 2020 13:10:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Kangjie Lu <kjlu@umn.edu>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, Yuan Zhang <yuanxzhang@fudan.edu.cn>

> The issue happens in one error path of
> batadv_store_throughput_override(). When batadv_parse_throughput()
> returns NULL, the refcnt increased by batadv_hardif_get_by_netdev() is
> not decreased, causing a refcnt leak.

How do you think about to mention the terms =E2=80=9Cexception handling=E2=
=80=9D
and =E2=80=9Creference counting=E2=80=9D in the commit message?

Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change descri=
ption?

Regards,
Markus
