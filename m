Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 Jan 2010 09:20:34 +0800
References: <20091231105246.GI8143@lunn.ch>
	<20100101160502.GA16855@pandem0nium>
In-Reply-To: <20100101160502.GA16855@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201001200920.34384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.]
 =?iso-8859-15?q?=5BPatch_1/1=5D_Staging=3A_batman-?=
 =?iso-8859-15?q?adv=3A_Use=09printk_=28=25pM=29_for_MAC_addresses?=
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hey,

> thank you for the patch, it is committed now in r1526. I've added some
> changes to your patch to allow compatibility for all currently suported
> kernels again. This includes:
> 
>  * removing ipv4/ipv6 printing support in bat_printk
>  * pack_hex_byte() (used in bat_printk()) was missing in older kernels
>  * various stuff in compat.h to avoid regressions from my skb patch
>  * skb->dev->stats was not available in older kernels

it seems you forgot to upload the bat_printk.c file ...  :)

Cheers,
Marek
