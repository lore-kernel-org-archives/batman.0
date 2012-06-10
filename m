Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 16:56:08 +0800
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
	<1338754762-28424-15-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-15-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101656.09179.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: Prefix packet enum
	with BATADV_
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, June 04, 2012 04:19:21 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c            |   48 +++++++------
>  bat_sysfs.c             |   24 ++++---
>  bridge_loop_avoidance.c |   34 ++++-----
>  icmp_socket.c           |    8 +--
>  main.c                  |   14 ++--
>  packet.h                |   86 +++++++++++------------
>  routing.c               |   35 ++++++----
>  soft-interface.c        |    4 +-
>  translation-table.c     |  177
> ++++++++++++++++++++++++-----------------------
> unicast.c               |   18 ++---
>  unicast.h               |    4 +-
>  vis.c                   |   18 ++---
>  12 files changed, 246 insertions(+), 224 deletions(-)

Applied in revision e85015c.

Thanks,
Marek
