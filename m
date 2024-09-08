Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF69E6FE49
	for <batman@archiver.kernel.org>; Sun,  8 Sep 2024 18:13:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C062E83BE1
	for <batman@archiver.kernel.org>; Sun,  8 Sep 2024 20:13:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725819196;
 b=rdqn9khPfwH9n1f0exrRC0o39Vne5g1vBWlAEyQ1d0ryFibPWedwRJlroRdm2dwtlrogO
 lp5ZHrGMMWa+CcrZeWCDeCXsupRdZXgWeGWHBkmicKzrzwtLTD7RiguUfs6BT0Ekycc+KyL
 mf5y/NhX9TGvtjVYMoN57+DkUyUvc3I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725819196; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gJ+z/0ok3q5MZcCD3uwAeQ9CJdI2swiMVgUWC/xGy4c=;
 b=mrusyjndY1eoiCUhd3+GFZi77RbR+Tr0prbNdqGi5qVnY0CF9FUe5fFPyt/MFPp6/LBvQ
 5IC3NIQQQ2OuY6dfF1uZb4JEMAO5g0+t+AEOcEtR9VxwlLRWKNFUemGHC2Fy4VmCEbcmABh
 FKxooECKWxXIaD53cqEzb6k2XTLFIRI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B29B881071
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  8 Sep 2024 20:12:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725819163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gJ+z/0ok3q5MZcCD3uwAeQ9CJdI2swiMVgUWC/xGy4c=;
	b=Boc61DMJlKsMSFL357gxGX/GIGfyfr8sRzEpi3oCpVFLGF+Ns6xeFhAOneyTvwtRi553hf
	UmQORxtfuybBpEeJfoh36QtEjTLw78vdqUpygKKDlgqC0Y61twdygMu3QNYo+mC7P5PJSI
	a6IDUpOqwbjb+kHpALjLae7f6Uim34E=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725819163; a=rsa-sha256;
	cv=none;
	b=ntdV8QiN7eLtzeG8RCTXHR6kPjliuarjl6cAt3uBc1WUIv18WE6B2JRhaBBENoySrdhhFV
	pJYyPs7tOQKunWyREdBNDO9OlVczEQ6v9t1UZ3BDgErmgK8NpDM6sixU80JggEDvpzMkXU
	WWwwfg8/D2pOZAms28iPFaIflmqd7m0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=na8BReMy;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725819163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ+z/0ok3q5MZcCD3uwAeQ9CJdI2swiMVgUWC/xGy4c=;
	b=na8BReMydQCFUM46Pjy0K5m+uRXl7JX/WWjwFIGE3gCDzKb6pfbyX783/QD6y2JWTlWBIS
	2sdp43pS9EriK5GraDgpP9mm0BSSQsBMU8fo9fV53wfmBAUfCCgi+0SxgFqvS8ODoa7hjC
	WM1ETA94s8q9L3lMfKoa9RH/Dqg6YFY=
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batctl: neighbor: Fix print neighbors table header
Date: Sun, 08 Sep 2024 20:12:39 +0200
Message-ID: <2343687.ElGaqSPkdT@sven-l14>
In-Reply-To: <172581746841.965.10559798237378220086@diktynna.open-mesh.org>
References: <172581746841.965.10559798237378220086@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4925207.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5NNCTQTDNDMIB4UUBCDCPG3GXJMDZSAH
X-Message-ID-Hash: 5NNCTQTDNDMIB4UUBCDCPG3GXJMDZSAH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5NNCTQTDNDMIB4UUBCDCPG3GXJMDZSAH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4925207.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: noahbpeterson1997@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 08 Sep 2024 20:12:39 +0200
Message-ID: <2343687.ElGaqSPkdT@sven-l14>
MIME-Version: 1.0

On Sunday, 8 September 2024 19:44:28 CEST noahbpeterson1997@gmail.com wrote:
> netlink_print_neighbors() now prints the correct header to match what
> batman-advanced currently outputs.

This is wrong, this is not what it outputs for the default B.A.T.M.A.N. IV:

    $ batctl n
    [B.A.T.M.A.N. adv 2024.0-openwrt-2, MainIF/MAC: primary0/ae:1b:bf:52:25:5b (bat0/52:54:00:ec:00:01 BATMAN_IV)]
    IF             Neighbor              last-seen
            vxlan     16:7b:3c:c2:bf:bc    2.880s
         mesh-vpn     02:12:7b:00:04:01    0.830s

[...]
>  Example::
>  
> -  IF             Neighbor              last-seen
> -         enp0s1     16:7b:3c:c2:bf:b8    4.612s
> -         enp0s1     ae:1b:bf:52:25:58    0.740s
> +           Neighbor   last-seen      speed           IF
> +  16:7b:3c:c2:bf:b8    4.612s (     1000.0) [     enp0s1]
> +  ae:1b:bf:52:25:58    0.740s (     1000.0) [     enp0s1]
>  
>  
>  batctl originators
> diff --git a/neighbors.c b/neighbors.c
> index 3102b0e..9dcdb81 100644
> --- a/neighbors.c
> +++ b/neighbors.c
> @@ -121,7 +121,7 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
>  {
>         return netlink_print_common(state, orig_iface, read_opts,
>                                     orig_timeout, watch_interval,
> -                                   "IF             Neighbor              last-seen\n",
> +                                       "         Neighbor   last-seen      speed           IF\n",
>                                     BATADV_CMD_GET_NEIGHBORS,
>                                     neighbors_callback);
>  }
> 

Kind regards,
	Sven
--nextPart4925207.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZt3pGAAKCRBND3cr0xT1
y21+AP92l2//7CLmKYH08Bq9cOrEEFxfAyzXr6jVdU1JZ18uoQD/Xu/S/Dz/CNFI
L3935/6UkuLI0Ph0TexJLgvFqkNaCAs=
=swUU
-----END PGP SIGNATURE-----

--nextPart4925207.GXAFRqVoOG--



