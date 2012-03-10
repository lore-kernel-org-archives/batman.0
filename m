Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 05:37:34 +0800
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203110537.34370.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8-next] batman-adv: Ignore 80-chars per
	line limits for strings
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

On Wednesday, March 07, 2012 16:07:45 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_iv_ogm.c        |   54 ++++++++++++------------------
>  bat_sysfs.c         |   16 ++++----
>  gateway_client.c    |   31 +++++++----------
>  gateway_common.c    |    8 ++--
>  hard-interface.c    |   36 +++++++--------------
>  icmp_socket.c       |   12 ++----
>  main.c              |    8 ++--
>  originator.c        |   14 +++----
>  routing.c           |   27 +++++++--------
>  send.c              |    4 +-
>  soft-interface.c    |   15 ++++----
>  translation-table.c |   89
> ++++++++++++++++++++++++-------------------------- 12 files changed, 137
> insertions(+), 177 deletions(-)

Applied in revision a112eaa.

Thanks,
Marek
