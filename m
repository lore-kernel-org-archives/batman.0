Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA406E77199
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 07:47:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 443B482482
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 08:47:16 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736408836;
 b=JIT9tuwzErT7rSN2p+yCfMhn4ALXFlLurWJHHu3E8meL/IlseDVO26b0p/ywrrOvRW9eK
 GJFJyDW1lFCfIzbc66VrBq799pY/BRS9tQQIx9ga7LJB785MzZ9CUDw0vtZCejBf1//7CGi
 g6fv5NM01cXQsp8VW+0oUdnR1/iA5gY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736408836; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OKV5Qsd+MStOJO6IkgCvyiA36TxcGUhdONUeNCIZkQE=;
 b=Y41I53nuPqnoQqXYVHTQi6aaRYWZLZTc9Hp22Yj+g9d7FyY9IEPlbMTB94QuSfIKZ4XBt
 hHjkl6r7zJlMj5JEMQTYcnqpRjz+5wUbpfbTS22TP/QR0NKnueOgMTcTyMS1yRy2gTPgWxb
 PMxeqlQ0pvL73l/yInuQfImIUEv3rls=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E8AE682004
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 08:46:54 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736408815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OKV5Qsd+MStOJO6IkgCvyiA36TxcGUhdONUeNCIZkQE=;
	b=vqTuyxKmGNAYwBxHz67AcNBogN3hXQhWIum41m/p7q6QdntSuy+dS1aj4Czucggu3lc6Vw
	Tm7URMNwkmU6gbibqA1RzFBAyz/OOlcqY+P/2W/+VAq4cfsvlxuxv3Pj9KweCEYgs+5Cve
	aXKFazLZ0uInnso7UiuS9Vh/KQdLi+M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oXyZqln4;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736408815; a=rsa-sha256;
	cv=none;
	b=AmK1ozevhwUhSLgB3SXwbAFiW3S/5ERg1G8gepJZ3IdRbLyQaS3X8fxa4cveKzRgdgezod
	Tnh8Lps+/19y0nh0b7VTgcSHCLJMlj3z6Y20J+0hcZ9Zh2Fg4Qmsd3Jjvtqj1uaX5wAbc4
	FR3+f0O/v2XlC4DkFCctECQaBgPC+co=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736408814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKV5Qsd+MStOJO6IkgCvyiA36TxcGUhdONUeNCIZkQE=;
	b=oXyZqln4GHfCDCFzmE/lPOoN3ecN/sLRX1qT1u1gHXyNJUaD7XAboeX+wm62wwD0s736sz
	brLcECqYfpZS1BFw3kl1KxMub3itzyks4SLjXnyNU+APsKgc/+3drXhAz1oZupvXoPe9+U
	2U+k0Y57GcAXVpAY7BQY0gY/L2idpIw=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Andy Strohman <andrew@andrewstrohman.com>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
Date: Thu, 09 Jan 2025 08:46:48 +0100
Message-ID: <1882889.atdPhlSkOF@ripper>
In-Reply-To: <20250109022756.1138030-1-andrew@andrewstrohman.com>
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart46933626.fMDQidcC6G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SAFST6F4CJRLWDUE6D77UCNODOMYXT5N
X-Message-ID-Hash: SAFST6F4CJRLWDUE6D77UCNODOMYXT5N
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SAFST6F4CJRLWDUE6D77UCNODOMYXT5N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart46933626.fMDQidcC6G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
Date: Thu, 09 Jan 2025 08:46:48 +0100
Message-ID: <1882889.atdPhlSkOF@ripper>
In-Reply-To: <20250109022756.1138030-1-andrew@andrewstrohman.com>
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
MIME-Version: 1.0

On Thursday, 9 January 2025 03:27:56 CET Andy Strohman wrote:
> Reference counting is used to ensure that
> batadv_hardif_neigh_node and batadv_hard_iface
> are not freed before/during
> batadv_v_elp_throughput_metric_update work is
> finished.
> 
> But there isn't a guarantee that the hard if will
> remain associated with a soft interface up until
> the work is finished.
> 
> This fixes a crash triggered by reboot that looks
> like this:
> 
> Call trace:
>  batadv_v_mesh_free+0xd0/0x4dc [batman_adv]
>  batadv_v_elp_throughput_metric_update+0x1c/0xa4
>  process_one_work+0x178/0x398
>  worker_thread+0x2e8/0x4d0
>  kthread+0xd8/0xdc
>  ret_from_fork+0x10/0x20
> 
> (the batadv_v_mesh_free call is misleading,
> and does not actually happen)

I am not 100% sure how you build batman-adv but when you've used the external 
kernel module then you can use [1,2]:

    make EXTRA_CFLAGS="-fno-inline -Og -fno-optimize-sibling-calls -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining" KERNELPATH=...

to get actually useful backtraces. Unfortunately, compile time checks 
sometimes need inlining and compilations fails or some kernel configurations 
with '-fno-inline'. If this happens to you then you can at least try to use 
the rest of the extra flags.


[1] https://www.open-mesh.org/projects/devtools/wiki/Kernel_hacking_Debian_image#Building-the-batman-adv-module
[2] https://www.open-mesh.org/projects/devtools/wiki/Kernel_debugging_with_kgdb#Connecting-gdb

> I was able to make the issue happen more reliably
> by changing hardif_neigh->bat_v.metric_work work
> to be delayed work. This allowed me to track down
> and confirm the fix.
> 
> Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>

Please add before your Signed-off-by line following extra line:

Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")

> ---
>  net/batman-adv/bat_v_elp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index 1d704574..7daaad9c 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -140,7 +140,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
>  	}
>  
>  default_throughput:
> -	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
> +	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT) && hard_iface->soft_iface) {
>  		batadv_info(hard_iface->soft_iface,
>  			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
>  			    hard_iface->net_dev->name,
> 

I would prefer something more explanatory instead of adding more conditions at 
the end of actually interesting checks. Something more like:

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574..185b063f 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -66,12 +66,19 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct net_device *soft_iface = hard_iface->soft_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
 
+	/* don't query throughput when no longer associated with any
+	 * batman-adv interface
+	 */
+	if (!soft_iface)
+		return BATADV_THROUGHPUT_DEFAULT_VALUE;
+
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
@@ -141,7 +148,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,

--nextPart46933626.fMDQidcC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ39+6QAKCRBND3cr0xT1
y9w/AP9s7Y+DhEIOPfOMLyzjZk8AYfuLaOyRUygQYso8Hic8QQD/SuE3nvAOZdPa
bvEvdPtMktjeLWXl5Hm7IJF+0TUtWA4=
=rO5c
-----END PGP SIGNATURE-----

--nextPart46933626.fMDQidcC6G--



