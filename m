Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 19:53:50 +0800
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
	<1338928292-23085-4-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101953.50908.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Prefix packet structs
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

On Wednesday, June 06, 2012 04:31:30 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c            |  258
> +++++++++++++++++++++++------------------------ bridge_loop_avoidance.c
> |   12 +--
>  bridge_loop_avoidance.h |    4 +-
>  hard-interface.c        |    4 +-
>  icmp_socket.c           |   22 ++--
>  icmp_socket.h           |    2 +-
>  main.c                  |   10 +-
>  packet.h                |   44 ++++----
>  routing.c               |   86 ++++++++--------
>  routing.h               |    2 +-
>  send.c                  |    4 +-
>  soft-interface.c        |    4 +-
>  translation-table.c     |  119 ++++++++++++----------
>  translation-table.h     |    4 +-
>  types.h                 |   10 +-
>  unicast.c               |   38 +++----
>  unicast.h               |    6 +-
>  vis.c                   |   81 ++++++++-------
>  vis.h                   |    4 +-
>  19 files changed, 368 insertions(+), 346 deletions(-)

Applied in revision d7ee9e7.

Thanks,
Marek
