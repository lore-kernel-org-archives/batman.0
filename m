Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 May 2012 16:43:13 +0800
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
	<1336823339-4095-7-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205151643.13604.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/8] batman-adv: Prefix main static
	inline functions with batadv_
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

On Saturday, May 12, 2012 19:48:58 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c            |  213
> ++++++++++++++++++++++++-----------------------
> bat_sysfs.c             |    8 +-
>  bitarray.c              |   10 +--
>  bridge_loop_avoidance.c |  165 ++++++++++++++++++------------------
>  distributed-arp-table.c |   79 +++++++++---------
>  gateway_client.c        |   54 ++++++------
>  hard-interface.c        |    4 +-
>  icmp_socket.c           |   12 +--
>  main.c                  |    8 +-
>  main.h                  |   25 +++---
>  originator.c            |   61 +++++++-------
>  originator.h            |    2 +-
>  routing.c               |   71 ++++++++--------
>  send.c                  |   12 +--
>  soft-interface.c        |    4 +-
>  translation-table.c     |  149 +++++++++++++++++----------------
>  vis.c                   |   27 +++---
>  17 files changed, 464 insertions(+), 440 deletions(-)

Applied in revision 033ae41.

Thanks,
Marek
