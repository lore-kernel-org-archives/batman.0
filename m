Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 00:58:41 +0800
References: <1369320783-1165-1-git-send-email-martin@hundeboll.net>
 <1369320783-1165-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1369320783-1165-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305240058.41545.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/3] batman-adv: Remove old
	fragmentation code
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Thursday, May 23, 2013 22:53:01 Martin Hundeb=C3=B8ll wrote:
> Remove the existing fragmentation code before adding the new version
> and delete unicast.{h,c}.
>=20
> batadv_unicast_send_skb() is moved to send.c and renamed to
> batadv_send_skb_unicast().
>=20
> fragmentation entry in sysfs (bat_priv->fragmentation) is kept for use in
> the new fragmentation code.
>=20
> BATADV_UNICAST_FRAG packet type is renamed to BATADV_FRAG for use in the
> new fragmentation code.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>=20
> v2:
>  unmangle function names with 4addr_unicast
>  correctly indent kernel doc
>=20
> v3:
>  add line before return statement in batadv_send_skb_prepare_unicast()
>=20
>  Makefile.kbuild         |   1 -
>  distributed-arp-table.c |  11 +-
>  hard-interface.c        |   1 -
>  main.c                  |   4 -
>  originator.c            |   9 -
>  packet.h                |  16 --
>  routing.c               |  86 +--------
>  routing.h               |   2 -
>  send.c                  | 174 ++++++++++++++++++
>  send.h                  |  36 ++++
>  soft-interface.c        |   4 +-
>  types.h                 |  19 --
>  unicast.c               | 478
> ------------------------------------------------
> unicast.h               |  92 ----------
>  14 files changed, 217 insertions(+), 716 deletions(-)
>  delete mode 100644 unicast.c
>  delete mode 100644 unicast.h

Applied in revision 8980aad.

Thanks,
Marek
