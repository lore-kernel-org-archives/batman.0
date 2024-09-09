Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2616AECE57E
	for <batman@archiver.kernel.org>; Mon,  9 Sep 2024 09:19:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 44BE183BE1
	for <batman@archiver.kernel.org>; Mon,  9 Sep 2024 11:19:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725873571;
 b=w2VxIUFve1C5FyH3kKdAoZNg0jHeYNUNlIpNBimbCEpjynP72qvYzRpcqSV7rb7AIpiu4
 +ENd5wQYvEaCL6KE5EUz/mHlx564UeyogSOduwX4yqgBWy3ojg2Ik0qruL/MocCTwGGIbuk
 WkCTq9lsq963Kc52cMH01n+9RxOdsHg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725873571; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8lZ2ZsmVVNry1r5ww8QOp5Yt/PwcIb9H5f6WgYu879M=;
 b=jMMoylBBFgEDQLTbFfsNNuTxDhfPiGcmNuyyYFjULFEwtwr+wGTYb1H8K43tMEmsX4CMQ
 WPXlWYCT/Pcv6p59Lnx/cHA+/x659/FUEjgST7YKldMQUjt3glFTw/SGqKsSYHr6yH5GxVq
 3gsq+tM9B4jQP47BFdW6uxi6tQuU3Q4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 06A308189D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Sep 2024 11:19:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725873541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8lZ2ZsmVVNry1r5ww8QOp5Yt/PwcIb9H5f6WgYu879M=;
	b=Zkiu+juctOwrLe+0guj49kBmtutxndW6tCuZS0iuhUrbgZgeA0mga8FoG88rbkm2EOlyCd
	LFfyX1FjAm0AKsIVpwUA6njaU2jTLOG2HuY7m5hsXo0N03nU9yEdrbILr8D+K9PiAtZ43i
	4TIjhii0/QmdLJXoe3bAEXzw9dqP/ro=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725873541; a=rsa-sha256;
	cv=none;
	b=tH/sJKrZ7JD/ob7i+46AjOwWCxEST1R7D50QyO5IYzlqGg43lWWLUPDsbiifqaDJOZiF4N
	+3/jcjPg59pca6RYmZZK0DlPOg9VQ2ZOevFG/aq788xCO/mDaP1B0Qr9T9dVgRoTGCAqhy
	pOhAXavT7wAlsuI0Bfg/vmnKDtscC0Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=RlU9Ypt6;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725873540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lZ2ZsmVVNry1r5ww8QOp5Yt/PwcIb9H5f6WgYu879M=;
	b=RlU9Ypt6NPDAAMdKx4UhDLUCFptpnl11nwThRLS/ZgipX2IDDe9s+E/ErSuD1u7lQWmyco
	XkLKSuo/xZDCqOLGWmlAYJFWmTWiXD0cgApiU7Wd9dzwklm+ydH3/Afp4SU6A3UwwYLfW4
	8Svcq0fBCtFCZfGEEWG7UGODaHWL5jY=
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] alfred: add more verbose error message
Date: Mon, 09 Sep 2024 11:18:55 +0200
Message-ID: <4948861.31r3eYUQgx@ripper>
In-Reply-To: <172582836553.965.8382120135752040068@diktynna.open-mesh.org>
References: <172582836553.965.8382120135752040068@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4593754.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BQ4GZ3XMWVUF3PU4EWNLTEMEEYN5WWZ6
X-Message-ID-Hash: BQ4GZ3XMWVUF3PU4EWNLTEMEEYN5WWZ6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQ4GZ3XMWVUF3PU4EWNLTEMEEYN5WWZ6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4593754.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] alfred: add more verbose error message
Date: Mon, 09 Sep 2024 11:18:55 +0200
Message-ID: <4948861.31r3eYUQgx@ripper>
MIME-Version: 1.0

On Sunday, 8 September 2024 22:46:05 CEST noahbpeterson1997@gmail.com wrote:
> diff --git a/netsock.c b/netsock.c
> index feed21d..04f95c7 100644
> --- a/netsock.c
> +++ b/netsock.c
> @@ -322,7 +322,23 @@ static int netsock_open(struct globals *globals, struct interface *interface)
>         enable_raw_bind_capability(0);
>  
>         if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
> -               perror("can't bind");
> +               if (errno == EADDRNOTAVAIL)
> +                       fprintf(stderr, "can't bind to interface %s; "
> +                               "expected ipv6 address not found: "
> +                               "%02x%02x::%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
> +                               interface->interface,
> +                               (int)interface->address.ipv6.s6_addr[0],
> +                               (int)interface->address.ipv6.s6_addr[1],
> +                               (int)interface->address.ipv6.s6_addr[8],
> +                               (int)interface->address.ipv6.s6_addr[9],
> +                               (int)interface->address.ipv6.s6_addr[10],
> +                               (int)interface->address.ipv6.s6_addr[11],
> +                               (int)interface->address.ipv6.s6_addr[12],
> +                               (int)interface->address.ipv6.s6_addr[13],
> +                               (int)interface->address.ipv6.s6_addr[14],
> +                               (int)interface->address.ipv6.s6_addr[15]);
> +               else
> +                       perror("can't bind");
>                 goto err;
>         }

Ehrm, no - this is not a valid way to print IPv6 addresses and it makes to 
many assumptions about the IPv6 address - which will then lead to more 
problems in the future. For creating the ip address string:

    		char ipstr_buf[INET6_ADDRSTRLEN];
    		const char *ipstr;
    		....
    		ipstr = inet_ntop(AF_INET6, &interface->address.ipv6.s6_addr,
    				  ipstr_buf, INET6_ADDRSTRLEN);


Kind regards,
	Sven
--nextPart4593754.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZt69fwAKCRBND3cr0xT1
ywdtAQDNyttkn1fH65bpVw2XAbjBgT+5t8ZV8TegkJTPEvsr2AD/QqMOBZ03Id0w
f9+AFTMND1ZdebdJf/GOnfdwBsO1Bws=
=XQQ5
-----END PGP SIGNATURE-----

--nextPart4593754.LvFx2qVVIh--



