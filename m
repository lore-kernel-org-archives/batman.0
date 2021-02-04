Return-Path: <kuba@kernel.org>
Date: Wed, 3 Feb 2021 16:35:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] batman-adv: Update copyright years for 2021
Message-ID: <20210203163506.4b4dbff0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210202174037.7081-3-sw@simonwunderlich.de>
References: <20210202174037.7081-1-sw@simonwunderlich.de>
	<20210202174037.7081-3-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

On Tue,  2 Feb 2021 18:40:34 +0100 Simon Wunderlich wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batadv_packet.h     | 2 +-
>  include/uapi/linux/batman_adv.h        | 2 +-
>  net/batman-adv/Kconfig                 | 2 +-
>  net/batman-adv/Makefile                | 2 +-
>  net/batman-adv/bat_algo.c              | 2 +-
>  net/batman-adv/bat_algo.h              | 2 +-
>  net/batman-adv/bat_iv_ogm.c            | 2 +-
>  net/batman-adv/bat_iv_ogm.h            | 2 +-
>  net/batman-adv/bat_v.c                 | 2 +-
>  net/batman-adv/bat_v.h                 | 2 +-
>  net/batman-adv/bat_v_elp.c             | 2 +-
>  net/batman-adv/bat_v_elp.h             | 2 +-
>  net/batman-adv/bat_v_ogm.c             | 2 +-
>  net/batman-adv/bat_v_ogm.h             | 2 +-
>  net/batman-adv/bitarray.c              | 2 +-
>  net/batman-adv/bitarray.h              | 2 +-
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  net/batman-adv/bridge_loop_avoidance.h | 2 +-
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/distributed-arp-table.h | 2 +-
>  net/batman-adv/fragmentation.c         | 2 +-
>  net/batman-adv/fragmentation.h         | 2 +-
>  net/batman-adv/gateway_client.c        | 2 +-
>  net/batman-adv/gateway_client.h        | 2 +-
>  net/batman-adv/gateway_common.c        | 2 +-
>  net/batman-adv/gateway_common.h        | 2 +-
>  net/batman-adv/hard-interface.c        | 2 +-
>  net/batman-adv/hard-interface.h        | 2 +-
>  net/batman-adv/hash.c                  | 2 +-
>  net/batman-adv/hash.h                  | 2 +-
>  net/batman-adv/log.c                   | 2 +-
>  net/batman-adv/log.h                   | 2 +-
>  net/batman-adv/main.c                  | 2 +-
>  net/batman-adv/main.h                  | 2 +-
>  net/batman-adv/multicast.c             | 2 +-
>  net/batman-adv/multicast.h             | 2 +-
>  net/batman-adv/netlink.c               | 2 +-
>  net/batman-adv/netlink.h               | 2 +-
>  net/batman-adv/network-coding.c        | 2 +-
>  net/batman-adv/network-coding.h        | 2 +-
>  net/batman-adv/originator.c            | 2 +-
>  net/batman-adv/originator.h            | 2 +-
>  net/batman-adv/routing.c               | 2 +-
>  net/batman-adv/routing.h               | 2 +-
>  net/batman-adv/send.c                  | 2 +-
>  net/batman-adv/send.h                  | 2 +-
>  net/batman-adv/soft-interface.c        | 2 +-
>  net/batman-adv/soft-interface.h        | 2 +-
>  net/batman-adv/tp_meter.c              | 2 +-
>  net/batman-adv/tp_meter.h              | 2 +-
>  net/batman-adv/trace.c                 | 2 +-
>  net/batman-adv/trace.h                 | 2 +-
>  net/batman-adv/translation-table.c     | 2 +-
>  net/batman-adv/translation-table.h     | 2 +-
>  net/batman-adv/tvlv.c                  | 2 +-
>  net/batman-adv/tvlv.h                  | 2 +-
>  net/batman-adv/types.h                 | 2 +-
>  57 files changed, 57 insertions(+), 57 deletions(-)
> 
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 9c8604c5b5f6..67b773ea0ec3 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
> -/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
> +/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
>   *
>   * Marek Lindner, Simon Wunderlich
>   */

Is this how copyright works? I'm not a layer, but I thought it was
supposed to reflect changes done to given file in a given year.
