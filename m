Return-Path: <davem@davemloft.net>
Date: Tue, 17 Apr 2012 22:46:30 -0400 (EDT)
Message-Id: <20120417.224630.1104076946118354940.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334663907-22725-6-git-send-email-ordex@autistici.org>
References: <1334663907-22725-1-git-send-email-ordex@autistici.org>
	<1334663907-22725-6-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/11] batman-adv: handle routing code
 initialization properly
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 17 Apr 2012 13:58:21 +0200

> @@ -30,10 +30,11 @@
>  #include "send.h"
>  #include "bat_algo.h"
>  
> -static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
> +static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
>  {
>  	struct batman_ogm_packet *batman_ogm_packet;
>  	unsigned long random_seqno;
> +	int res = -1;
>  
>  	/* randomize initial seqno to avoid collision */
>  	get_random_bytes(&random_seqno, sizeof(unsigned long));

Use real error codes, even as a default, instead of meaningless
values like -1.
