Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 May 2012 17:05:12 +0800
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
	<1336781383-15649-23-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-23-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205141705.12784.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 23/23] batman-adv: Reformat multiline
	to consistent style
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

On Saturday, May 12, 2012 08:09:43 Sven Eckelmann wrote:
> batman-adv doesn't follow the style for multiline comments that David S.
> Miller prefers. All comments should be reformatted to follow this
> consistent style to make the code slightly more readable.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_algo.h              |    4 +--
>  bat_debugfs.c           |    4 +--
>  bat_debugfs.h           |    5 +--
>  bat_iv_ogm.c            |   75 ++++++++++++++++++++++++-------------------
>  bat_sysfs.c             |   13 ++++----
>  bat_sysfs.h             |    5 +--
>  bitarray.c              |   17 ++++------
>  bitarray.h              |   10 +++---
>  bridge_loop_avoidance.c |   67 +++++++++++----------------------------
>  bridge_loop_avoidance.h |    4 +--
>  compat.c                |    3 +-
>  compat.h                |    3 +-
>  distributed-arp-table.c |   10 +++---
>  distributed-arp-table.h |    4 +--
>  gateway_client.c        |   41 +++++++++++-------------
>  gateway_client.h        |    4 +--
>  gateway_common.c        |    9 ++----
>  gateway_common.h        |    4 +--
>  hard-interface.c        |   23 ++++++--------
>  hard-interface.h        |    4 +--
>  hash.c                  |    4 +--
>  hash.h                  |   24 +++++++-------
>  icmp_socket.c           |    7 ++--
>  icmp_socket.h           |    4 +--
>  main.c                  |   10 +++---
>  main.h                  |   38 +++++++++++-----------
>  originator.c            |   13 ++++----
>  originator.h            |    9 +++---
>  packet.h                |   21 ++++++------
>  ring_buffer.c           |    4 +--
>  ring_buffer.h           |    4 +--
>  routing.c               |   70 +++++++++++++++++++++++-----------------
>  routing.h               |    4 +--
>  send.c                  |   32 ++++++++-----------
>  send.h                  |    4 +--
>  soft-interface.c        |   27 ++++++++--------
>  soft-interface.h        |    4 +--
>  translation-table.c     |   81
> +++++++++++++++++++++++++++++------------------
> translation-table.h     |    4 +--
>  types.h                 |   29 ++++++++---------
>  unicast.c               |   13 ++++----
>  unicast.h               |    4 +--
>  vis.c                   |   39 ++++++++++++++---------
>  vis.h                   |    8 ++---
>  44 files changed, 363 insertions(+), 403 deletions(-)

Applied in revision a3a6d55.

Thanks,
Marek
