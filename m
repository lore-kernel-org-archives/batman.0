Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 16:38:25 +0800
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
	<1338754762-28424-11-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101638.25358.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/16] batman-adv: Prefix main defines
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

On Monday, June 04, 2012 04:19:17 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile                |    2 +-
>  bat_debugfs.c           |    2 +-
>  bat_iv_ogm.c            |  101
> ++++++++++++++++++++++++++++-------------------
> bat_sysfs.c             |    7 ++--
>  bitarray.c              |   20 +++++-----
>  bitarray.h              |    4 +-
>  bridge_loop_avoidance.c |   20 +++++-----
>  gateway_client.c        |   18 ++++-----
>  hard-interface.c        |    2 +-
>  main.c                  |   13 +++---
>  main.h                  |   81 ++++++++++++++++++-------------------
>  originator.c            |   32 ++++++++-------
>  ring_buffer.c           |    4 +-
>  routing.c               |   20 +++++-----
>  soft-interface.c        |   10 ++---
>  translation-table.c     |   84 ++++++++++++++++++++++-----------------
>  types.h                 |   10 ++---
>  unicast.c               |    2 +-
>  vis.c                   |   11 +++---
>  19 files changed, 242 insertions(+), 201 deletions(-)

Applied in revision 76eb272.

Thanks,
Marek
