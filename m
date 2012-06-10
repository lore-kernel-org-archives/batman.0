Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 19:34:51 +0800
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
	<1338928292-23085-2-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206101934.51577.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Prefix hash struct and
	typedef with batadv_
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

On Wednesday, June 06, 2012 04:31:28 Sven Eckelmann wrote:
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bridge_loop_avoidance.c |   20 ++++++++++----------
>  hash.c                  |   10 +++++-----
>  hash.h                  |   33 ++++++++++++++++++---------------
>  originator.c            |   10 +++++-----
>  originator.h            |    2 +-
>  routing.c               |    2 +-
>  translation-table.c     |   30 +++++++++++++++---------------
>  types.h                 |   12 ++++++------
>  vis.c                   |   12 ++++++------
>  9 files changed, 67 insertions(+), 64 deletions(-)

Applied in revision e3358b6.

Thanks,
Marek
