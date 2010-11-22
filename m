Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 22 Nov 2010 02:06:29 +0100
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201011220206.30172.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv for 2.6.38 (1)
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: greg@kroah.com


Hi,

> here are the feature patches which are targeted for 2.6.38.
> 
> Important features include:
>  * Fragmentation of forward packets
>  * reassemble of fragmented packets during transfer
>  * softif bridge loop avoidance
>  * gateway support for dhcp(v6) filtering
>  * hash related optimizations

Sven, thanks for preparing this big list!


>       Staging: batman-adv: ensure that eth_type_trans gets linear memory
>       Staging: batman-adv: Don't remove interface with spinlock held

Wouldn't it be better to push these too into .37 as they prevent the kernel 
from "oopsing" ? Or are we way to late for this ?

Regards,
Marek
