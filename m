Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Jun 2012 23:10:16 +0800
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
	<1338754762-28424-7-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206092310.16380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/16] batman-adv: Prefix packet defines
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

On Monday, June 04, 2012 04:19:13 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c        |   20 ++++++++++----------
>  hard-interface.c    |    3 ++-
>  icmp_socket.c       |    4 ++--
>  main.c              |    4 ++--
>  packet.h            |   12 ++++++------
>  routing.c           |    4 ++--
>  send.c              |    4 ++--
>  soft-interface.c    |   12 +++++++-----
>  translation-table.c |    8 ++++----
>  unicast.c           |    4 ++--
>  vis.c               |    2 +-
>  11 files changed, 40 insertions(+), 37 deletions(-)

Applied in revision 2bff7e2.

Thanks,
Marek
