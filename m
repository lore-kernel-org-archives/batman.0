Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C93ECE564
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 08:40:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E31683BF6
	for <batman@archiver.kernel.org>; Tue, 10 Sep 2024 10:40:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725957640;
 b=Kamy1P1ZfY8KXOXCilOnSdn0AZiGPVCyurS5fhb6G64s5wcy63CxiNQcxnVCvMeOBTJH5
 duQrJdfmUv24E5yooqSG7wDQ4utf3RcdEJGb+lScWYf+mydChVZxT0jaWma2ew7o2IsaWqx
 0Ob5AGDechtu+K+bHvmjtzjG1eFITOE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725957640; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=57Oy2kFeUq8Uu3B4zgRj23ocGzQdDZYx7dRhcxWxH5w=;
 b=M8KGiwU996mAIMKuv9pFwOtWDoUSS+u3MOr1/QumesRfQVObjmufWU3LFU5cIFEfr3olr
 bIPqiv3Z72dnqK99D4JC/fCDUBeUBN+wblXtYQFuSHiVF/6jagh8BySomplpxLmZAXnkZO9
 umxzmswYXNQTixTj8DaF3qzUIYLywow=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C3F3180F2D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 10:40:00 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725957601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=57Oy2kFeUq8Uu3B4zgRj23ocGzQdDZYx7dRhcxWxH5w=;
	b=oxUCE0MoKFYuDyOg3A0R2PdwozbIRD8GuaKe3KudY1K5ljUeh29oakYwIvlpp6MWr0Omby
	nQl1ID9ueRq3eHpIx/JWreUUBn/J3jcqGatIPoGJfCC2Z7IohQH3GrmuoEUIgTI6k1Etqo
	JbD7V/1nFOn7nOAeyW22KJVBmkOoonM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FSr86BzD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725957601; a=rsa-sha256;
	cv=none;
	b=Im2CoCMefM3RBHLC0+SqVgdpmNoroLXAUhtR1wtDvE92qy1zYF8WfnFf3AZ18cj26fXMkp
	QbAZUpruwBNLKwmykU2Gq9t/L3nwYKORCm9V+OjktgXg1X9OvBi0TnFFeW0MK6/lXgQ6NX
	dpqgRTDBrKMZKNCGPsqYH5TaRRlYH50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725957600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57Oy2kFeUq8Uu3B4zgRj23ocGzQdDZYx7dRhcxWxH5w=;
	b=FSr86BzDlIHqcbG9nYbnkqWsYz8x0CpmQUpdVXyzJKRQZSxuIzmeDwZe71pcpgCT8A41Tx
	LjNOQKbolkxfEZAx0cYSOWsdaqRgHTDNYBOB+UcEIjRP6PCDon2w30lX0Jg5TeQYeGlTD4
	4axC94SI3CQ8ZWsJRAJaWoh57i8IMUA=
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v2] alfred: add more verbose error message
Date: Tue, 10 Sep 2024 10:39:55 +0200
Message-ID: <1998991.usQuhbGJ8B@ripper>
In-Reply-To: <172593980548.1027.7186764909573595247@diktynna.open-mesh.org>
References: <172593980548.1027.7186764909573595247@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3504593.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NRIFCGFUWT7BAY4UGBW5UED72DSHHWHK
X-Message-ID-Hash: NRIFCGFUWT7BAY4UGBW5UED72DSHHWHK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NRIFCGFUWT7BAY4UGBW5UED72DSHHWHK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3504593.QJadu78ljV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v2] alfred: add more verbose error message
Date: Tue, 10 Sep 2024 10:39:55 +0200
Message-ID: <1998991.usQuhbGJ8B@ripper>
MIME-Version: 1.0

On Tuesday, 10 September 2024 05:43:25 CEST noahbpeterson1997@gmail.com wrote:

You must have a proper "From:" in your patch mail - not only your mail 
address. And it should match your Signed-off-by line.

> There is an issue with some Linux distributions where network interfaces are up and
> active, but do not have the correct link-local address. This condition is now checked and
> output to stderr to help better users troubleshoot this issue.

Please don't use overlong lines in the commit message. We normally use the 75 
chars per line limit from Linux's checkpatch.

> 
> Signed-off-by: Noah Peterson noahbpeterson1997@gmail.com

This signed-off-by has an invalid formatted e-mail. I think it should have 
been:

Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>

> ---

Changelog to v1 is missing. You can use tools like b4 [1] to improve your 
patch workflow.

> netsock.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
> diff --git a/netsock.c b/netsock.c
> index feed21d..a3101df 100644
> --- a/netsock.c
> +++ b/netsock.c
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  #include <stdlib.h>
>  #include <sys/epoll.h>
> +#include <arpa/inet.h>
>  #ifdef CONFIG_ALFRED_CAPABILITIES
>  #include <sys/capability.h>
>  #endif
> @@ -321,8 +322,19 @@ static int netsock_open(struct globals *globals, struct interface *interface)
>         }
>         enable_raw_bind_capability(0);
>  
> +

This newline doesn't make any sense.

>         if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
> -               perror("can't bind");
> +               char ipstr_buf[INET6_ADDRSTRLEN];
> +               const char *ipstr;

Missing blank line after declaration

> +               ipstr = inet_ntop(AF_INET6, &interface->address.ipv6.s6_addr,
> +                                       ipstr_buf, INET6_ADDRSTRLEN);

Start of line doesn't match open parenthesis

> +               if (errno == EADDRNOTAVAIL)
> +                       fprintf(stderr, "can't bind to interface %s; "
> +                               "expected ipv6 address not found: %s\n",
> +                               interface->interface,
> +                               ipstr);
> +               else
> +                       perror("can't bind");
>                 goto err;
>         }

You should precheck your patches with the most recent linux-next's checkpatch. 
Something like:

    ~/linux-next/scripts/checkpatch.pl --strict 0001-alfred-add-more-verbose-error-message.patch

Kind regards,
	Sven

[1] https://b4.docs.kernel.org/
--nextPart3504593.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZuAF2wAKCRBND3cr0xT1
y69iAQDxAd9TOeKxR/fO5Hdwk6rqGm8+D+UxJwQmg6bbR/43ZQD/ZvMWtoIhi7Af
p3WUT874gompTrO+eTyweWs5E3EToQI=
=/sAn
-----END PGP SIGNATURE-----

--nextPart3504593.QJadu78ljV--



