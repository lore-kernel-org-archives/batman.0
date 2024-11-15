Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A3D6DDDA
	for <batman@archiver.kernel.org>; Fri, 15 Nov 2024 07:14:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 77BDA83B04
	for <batman@archiver.kernel.org>; Fri, 15 Nov 2024 08:14:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731654896;
 b=s0KPk7OMbkrSPOIRqGShmdJlW1RTiNQ144DwXX/lMlA9x49R/03rIjnLidkOlMsZO6/Nf
 ixnm2z3WNtzh0KQPqY8oH/wkDFZ+eU7loI+fDyvONQsZihQhUna8Q9vSOxq9IueExVRht2/
 xI8taHiiv2hNJx3QcjSAn5ph6R00DRs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731654896; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9pgoHLWj9VbX/NrQJnb29ZRcPNXEydueCcQO0bd/UTE=;
 b=do2zjh6RPcsS98O2LhkgvOERhRsLB+zyKEu+HAPIhIZ7K2OQG+wPQrsRlQ+VzUFNmZ5dY
 TWSQMfC9IN2bxD/g2DSgvlOsgXe/7YeIgSiySnJwGm4SwBjQ7yV46Td0QvMFRVqAhUYfHrU
 EKBn4dDzNVYiEczvUcrnjBzJUaWpZPo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5FD6B817BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Nov 2024 08:14:47 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731654887; a=rsa-sha256;
	cv=none;
	b=bgYawRC6PelW0DYasmuhRwmprRGWROUpCbBqpINSAh8pL9YAu90LKS1fy6BD0UhCF/dzFY
	kP49wrlPBvfRmdJCGi05+kMsUgEwYEVlfvkPVN0XNGFGbTxJKjeyiZOAay12bnt8wV0cSA
	Ey4dPwAzaLQQLfqDKuABldDFyVi1BYM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SG0WR2Up;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731654887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9pgoHLWj9VbX/NrQJnb29ZRcPNXEydueCcQO0bd/UTE=;
	b=axVQpsBk1sgSCBh0M9a2I6XMwQUkkl5iBXpCwFqBCszNdW27eiZWXkBFhHP9gRTrFYu3Pq
	cgJyvz2vV+3zQGPhXEUenKZIqK7S3+UZD9BRn5as+1SP35U0ZlY5AtjsrTKc9K/qcTdAwP
	us86dvxD9iqKyS3prYXtnrZv4lHQuCQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1731654886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pgoHLWj9VbX/NrQJnb29ZRcPNXEydueCcQO0bd/UTE=;
	b=SG0WR2UpAqHzUaQRKm+gP7+Zc8GGYDTVxn3e5ZVXw36iLlm4UsX9RrwAHnkBpr2F1c0ZTC
	31GUNdD/c1Ct33/szlga0McFaQZ9l0O/0s6SEIzccdw0qi0dI73e4aUX3awT8DZlY3WyjG
	15ULoyZV9cz6NXchMMgftYzkSM2Xdls=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH-net] batman-adv: Fix "Arguments in wrong order" issue
Date: Fri, 15 Nov 2024 08:14:40 +0100
Message-ID: <2963697.e9J7NaK4W3@ripper>
In-Reply-To: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
References: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3320950.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KIGNPAMC55L63TYN7DUFUBLWZNOFZNQW
X-Message-ID-Hash: KIGNPAMC55L63TYN7DUFUBLWZNOFZNQW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KIGNPAMC55L63TYN7DUFUBLWZNOFZNQW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3320950.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Nov 2024 08:14:40 +0100
Message-ID: <2963697.e9J7NaK4W3@ripper>
In-Reply-To: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
References: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
MIME-Version: 1.0

On Friday, 15 November 2024 05:56:37 CET Dheeraj Reddy Jonnalagadda wrote:
> This commit fixes an "Arguments in wrong order" issue detected by
> Coverity (CID 1376875).
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/
distributed-arp-table.c
> index 801eff8a40e5..781a5118d441 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -1195,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct 
batadv_priv *bat_priv,
>  			goto out;
>  		}
>  
> -		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, 
ip_src,
> +		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_src, 
ip_dst,
>  						      
dat_entry->mac_addr,
>  						      
hw_src, vid);
>  		if (!skb_new)
> 

Sorry, but this is wrong. We send an answer here ("ARP request 
replied locally") and of course we must then switch src and destination. 
Otherwise we would send the ARP response to the entity which didn't requested 
it.

This was already marked as false positive in Coverity a long time ago.

Kind regards,
	Sven
--nextPart3320950.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzb04AAKCRBND3cr0xT1
yzM0AQCBQ1es0wPjpvjM/8+1H+eeP4x7a8mHMiUCI0cuKxT8yQEAmrAsexf+nPGA
Z1QV0TNZe100S6Fib9mpVuTh3xXCjAU=
=Orm4
-----END PGP SIGNATURE-----

--nextPart3320950.aeNJFYEL58--



