Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 May 2012 16:19:28 +0800
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
	<1336823339-4095-3-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205151619.28970.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: Prefix hard-interface
	static inline functions with batadv_
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

On Saturday, May 12, 2012 19:48:54 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c            |   14 +++++++-------
>  bat_sysfs.c             |   12 ++++++------
>  bridge_loop_avoidance.c |   28 ++++++++++++++--------------
>  distributed-arp-table.c |   14 ++++++++------
>  gateway_client.c        |    4 ++--
>  hard-interface.c        |   28 ++++++++++++++--------------
>  hard-interface.h        |    7 ++++---
>  icmp_socket.c           |    4 ++--
>  originator.c            |    4 ++--
>  routing.c               |   12 ++++++------
>  send.c                  |    6 +++---
>  soft-interface.c        |    4 ++--
>  translation-table.c     |   28 ++++++++++++++--------------
>  unicast.c               |    8 ++++----
>  vis.c                   |    8 ++++----
>  15 files changed, 92 insertions(+), 89 deletions(-)

Applied in revision 3670993.

Thanks,
Marek
