Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 10 Nov 2010 11:17:03 +0100
References: <12893476522148@site>
In-Reply-To: <12893476522148@site>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011101117.03979.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] patch "staging: batman-adv: Use
	linux/etherdevice.h address helper functions" added to staging tree
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.org
Cc: tklauser@distanz.ch, siwu@hrz.tu-chemnitz.de


Greg,

> The patch is only compile-tested.

[..]

> diff --git a/drivers/staging/batman-adv/main.c
> b/drivers/staging/batman-adv/main.c index 0587940..6ea6420 100644
> --- a/drivers/staging/batman-adv/main.c
> +++ b/drivers/staging/batman-adv/main.c
> @@ -149,7 +149,7 @@ void dec_module_count(void)
> 
>  int compare_orig(void *data1, void *data2)
>  {
> -	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
> +	return (compare_ether_addr(data1, data2) == 0 ? 1 : 0);
>  }

I'm wondering why you accepted this patch despite the raised objections 
regarding alignment problems. [1][2]
Is there something you know that we overlooked ? We haven't heard from Thomas 
or you since the alignment question came on the table. 

Cheers,
Marek

[1]https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-November/003640.html
[2]https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-November/003643.html
