Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 May 2012 00:24:34 +0800
References: <1336781383-15649-6-git-send-email-sven@narfation.org>
	<1336822727-3456-1-git-send-email-sven@narfation.org>
In-Reply-To: <1336822727-3456-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205140024.34378.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 06/23] batman-adv: Prefix
	bridge_loop_avoidance non-static functions with batadv_
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

On Saturday, May 12, 2012 19:38:47 Sven Eckelmann wrote:
> batman-adv can be compiled as part of the kernel instead of an module. In
> that case the linker will see all non-static symbols of batman-adv and all
> other non-static symbols of the kernel. This could lead to symbol
> collisions. A prefix for the batman-adv symbols that defines their private
> namespace avoids such a problem.
> 
> Reported-by: David Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Fixed alignment of arguments in batadv_bla_tx
> 
>  bat_debugfs.c           |    3 ++-
>  bridge_loop_avoidance.c |   28 ++++++++++----------
>  bridge_loop_avoidance.h |   67
> +++++++++++++++++++++++++----------------------
> hard-interface.c        |    2 +-
>  main.c                  |    4 +--
>  routing.c               |    6 ++---
>  soft-interface.c        |    4 +--
>  translation-table.c     |    6 ++---
>  8 files changed, 62 insertions(+), 58 deletions(-)

Applied in revision 017e28b.

Thanks,
Marek
