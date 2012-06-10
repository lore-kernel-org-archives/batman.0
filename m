Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 16:58:32 +0800
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
	<1338754762-28424-16-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-16-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101658.32601.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: Prefix main enum with
	BATADV_
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

On Monday, June 04, 2012 04:19:22 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c            |   48
> +++++++++++++++++++++++------------------------
> bat_sysfs.c             |   12 ++++++------
>  bat_sysfs.h             |    4 ++--
>  bitarray.c              |    4 ++--
>  bridge_loop_avoidance.c |   46
> ++++++++++++++++++++++-----------------------
> gateway_client.c        |   25 +++++++++++++-----------
>  icmp_socket.c           |    8 ++++----
>  main.c                  |   10 +++++-----
>  main.h                  |   36 +++++++++++++++++------------------
>  originator.c            |   12 ++++++------
>  routing.c               |   18 +++++++++---------
>  send.c                  |   11 ++++++-----
>  soft-interface.c        |    6 +++---
>  translation-table.c     |   35 +++++++++++++++++-----------------
>  14 files changed, 140 insertions(+), 135 deletions(-)

Applied in revision 48860a4.

Thanks,
Marek
