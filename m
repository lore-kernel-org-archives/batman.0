Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Jun 2012 15:10:33 +0800
References: <1339365531-22386-1-git-send-email-sven@narfation.org>
In-Reply-To: <1339365531-22386-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206121510.34058.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove bat_ prefix from
	bat_{debugfs, sysfs}.{c, h}
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

On Monday, June 11, 2012 05:58:51 Sven Eckelmann wrote:
> The "bat_" prefix in the source files implementing the batman-adv sysfs and
> debugfs interface doesn't have a special meaning and are only used by these
> files and files that implement the actual B.A.T.M.A.N. path finding
> algorithm.
> 
> The prefix is better suited to mark files that are used to implement the
> main part of the path finding. All other files should not use it and
> therefore gets renamed.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile.kbuild            |    4 ++--
>  bat_debugfs.c => debugfs.c |    2 +-
>  bat_debugfs.h => debugfs.h |    0
>  gateway_client.c           |    2 +-
>  hard-interface.c           |    2 +-
>  main.c                     |    4 ++--
>  soft-interface.c           |    4 ++--
>  bat_sysfs.c => sysfs.c     |    2 +-
>  bat_sysfs.h => sysfs.h     |    0
>  9 files changed, 10 insertions(+), 10 deletions(-)
>  rename bat_debugfs.c => debugfs.c (99%)
>  rename bat_debugfs.h => debugfs.h (100%)
>  rename bat_sysfs.c => sysfs.c (99%)
>  rename bat_sysfs.h => sysfs.h (100%)

Applied in revision 80135a8.

Thanks,
Marek
