Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 22 Jun 2012 21:12:32 +0200
References: <1340130390-4518-1-git-send-email-sven@narfation.org>
In-Reply-To: <1340130390-4518-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206222112.32357.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix alignment after opened
	parentheses
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

On Tuesday, June 19, 2012 20:26:30 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> ordex: This one is important for you. Please check whether patches in
> batman-adv/next touch these code parts. They may be the reason that these
> problems were introduced and must be fixed. Therefore, I would suggest to
> put this patch directly (after reviewing of course) in next.
> 
>  bat_iv_ogm.c     |    2 +-
>  compat.h         |    4 ++--
>  debugfs.c        |   18 +++++++++++-------
>  gateway_client.c |    4 ++--
>  hard-interface.c |   10 +++++-----
>  originator.c     |    9 +++++----
>  routing.c        |    3 +--
>  sysfs.c          |    2 +-
>  unicast.c        |    5 +++--
>  9 files changed, 31 insertions(+), 26 deletions(-)

Applied in revision f80413a.

Thanks,
Marek
