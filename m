Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 May 2012 00:40:30 +0800
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
	<1336781383-15649-9-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205140040.30988.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 09/23] batman-adv: Prefix
	gateway-client non-static functions with batadv_
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

On Saturday, May 12, 2012 08:09:29 Sven Eckelmann wrote:
> batman-adv can be compiled as part of the kernel instead of an module. In
> that case the linker will see all non-static symbols of batman-adv and all
> other non-static symbols of the kernel. This could lead to symbol
> collisions. A prefix for the batman-adv symbols that defines their private
> namespace avoids such a problem.
> 
> Reported-by: David Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_debugfs.c    |    2 +-
>  bat_iv_ogm.c     |    6 +++---
>  bat_sysfs.c      |    4 ++--
>  gateway_client.c |   40 +++++++++++++++++++++-------------------
>  gateway_client.h |   26 ++++++++++++++------------
>  gateway_common.c |    2 +-
>  main.c           |    2 +-
>  originator.c     |    7 ++++---
>  soft-interface.c |    6 +++---
>  unicast.c        |    2 +-
>  10 files changed, 51 insertions(+), 46 deletions(-)

Applied in revision 9db3953.

Thanks,
Marek
