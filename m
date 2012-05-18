Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 May 2012 23:00:01 +0800
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
	<1337192605-8652-10-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205182300.01664.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/13] batman-adv: Prefix remaining
	function like macros with batadv_
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

On Thursday, May 17, 2012 02:23:22 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_debugfs.c           |    4 +--
>  bat_iv_ogm.c            |    6 ++--
>  bat_sysfs.c             |   81
> +++++++++++++++++++++++++---------------------- distributed-arp-table.c
> |    6 ++--
>  gateway_client.c        |    2 +-
>  gateway_common.c        |   26 +++++++--------
>  hard-interface.c        |   38 +++++++++++-----------
>  main.h                  |   22 ++++++-------
>  routing.c               |   12 ++++---
>  send.c                  |    2 +-
>  translation-table.c     |   12 +++----
>  vis.c                   |    4 +--
>  12 files changed, 112 insertions(+), 103 deletions(-)

Applied in revision 52943ab.

Thanks,
Marek
