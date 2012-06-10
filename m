Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 19:55:32 +0800
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
	<1338928292-23085-5-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101955.32329.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Prefix types structs
	with batadv_
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

On Wednesday, June 06, 2012 04:31:31 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_debugfs.c           |   27 +--
>  bat_iv_ogm.c            |  125 ++++++-------
>  bat_sysfs.c             |   45 ++---
>  bat_sysfs.h             |    2 +-
>  bitarray.c              |    2 +-
>  bridge_loop_avoidance.c |  188 ++++++++++----------
>  bridge_loop_avoidance.h |   44 ++---
>  compat.c                |   22 +--
>  gateway_client.c        |   90 +++++-----
>  gateway_client.h        |   24 +--
>  gateway_common.c        |    2 +-
>  hard-interface.c        |   71 ++++----
>  hard-interface.h        |   14 +-
>  icmp_socket.c           |   41 ++---
>  icmp_socket.h           |    2 +-
>  main.c                  |   40 +++--
>  main.h                  |   24 +--
>  originator.c            |  102 ++++++-----
>  originator.h            |   35 ++--
>  routing.c               |  144 +++++++--------
>  routing.h               |   50 +++---
>  send.c                  |   50 +++---
>  send.h                  |   12 +-
>  soft-interface.c        |   18 +-
>  soft-interface.h        |    2 +-
>  translation-table.c     |  446
> ++++++++++++++++++++++++-----------------------
> translation-table.h     |   39 +++--
>  types.h                 |  104 +++++------
>  unicast.c               |   32 ++--
>  unicast.h               |    9 +-
>  vis.c                   |  173 +++++++++---------
>  vis.h                   |    8 +-
>  32 files changed, 1038 insertions(+), 949 deletions(-)

Applied in revision 0272a5a.

Thanks,
Marek
