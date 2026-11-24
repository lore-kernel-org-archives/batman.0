Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0A606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=SBs6eMsn
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0831582875
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:19:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795547978;
 b=0RbNiS/T6xI4BKIu6BZZi1TdUDEUUNnPXUFVBEkhP/ZgEJB9PFoX8HwBoDLimpoXY/pMg
 wZYvseistOQBC7+WRjYn8I8imFwSP1BiaPOn8rSEPWxqs7Q7WS/6k3OyvKmeoq+PYdtfqw1
 I2qYpo/1AzSN0Yq1KIOnRkj1LnBldeY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795547978; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hw7hh680LO3BRwF7TnXftJMY5VtS1yVoasYOrI2SQcw=;
 b=B9bux9BJnXV3vGr2dMR6xm1UIJtsznRQIuVj3fQ027ugpDSrQmqnroN+x6PtVxSPHMGOZ
 cyLAkn7r0H+8bu4cOZcCJwusKl9PJLq7JvE2hnfpRcRK67wJ32X1P6YE1zSLAOtgxV+gauU
 eSuaK8zfM7rhFoej9Knh8aIOryts2rM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B41C7801EB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 20:19:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795547970;
	b=Fq9qXKInZWLnRMgQsNRNLEeJyEq964VO0f+0xcFUdvZL6EhTrCaRgx5CpiEdLqCuG0GAVs
	RVNW39n6O/tRIuLUSz8eCc3p7EgF6uwBQhpDEWzteMSTQRSvTuwj5AuuzUdrS8x9pkP/LA
	HBXNLAl3t+vprX1otWrR8IUHpg6ebl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795547970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hw7hh680LO3BRwF7TnXftJMY5VtS1yVoasYOrI2SQcw=;
	b=wrQhWJq1NiQVwSA1/FdEEulYl98lt4AIPhWD5GIzSapP94WEJyzt2dPAQFN21huJWbR8gX
	u7YOMsZDCBlH4kMn3v6A8gIm21rj8rsUV1ndSZWG1bB7QdPoNeC0hGU4MczGQCWByf63e1
	2G+b4fttc/U6YHl27gOksLAe6QyRQPc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SBs6eMsn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E27DA20324;
	Tue, 24 Nov 2026 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795547959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hw7hh680LO3BRwF7TnXftJMY5VtS1yVoasYOrI2SQcw=;
	b=SBs6eMsnRYeDnJLV97wBTsF0fmG5YtG9Pk2AF/IJ28NHU0eeYnFxd3l/9RruchJ/2/+L6R
	0ZCBf3NLuVSWDoKqc4uXTSZa4L0u4qY5zMQWcqI32YNddZjkQjNhk9RwV7TRnxSlWhMclr
	BtZvmH7PVXQU2h48sgpi6S9YDKXF2G8=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 04/15] batman-adv: bla: register own backbone gw
 when
 claiming for local node
Date: Tue, 24 Nov 2026 20:19:15 +0100
Message-ID: <6050900.DvuYhMxLoT@sven-desktop>
In-Reply-To: <179554083850.3135.5611010478427382077@kernel.org>
References: <20261123171827.3294525-5-sw@simonwunderlich.de>
 <179554083850.3135.5611010478427382077@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6327635.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: STVU5LYEBFAVTNVYCM6MPNXK6Z3MBGBQ
X-Message-ID-Hash: STVU5LYEBFAVTNVYCM6MPNXK6Z3MBGBQ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/STVU5LYEBFAVTNVYCM6MPNXK6Z3MBGBQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart6327635.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 20:19:15 +0100
Message-ID: <6050900.DvuYhMxLoT@sven-desktop>
In-Reply-To: <179554083850.3135.5611010478427382077@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:38 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > When no backbone gateway entry for the local node exists yet on this VLAN
> > (for example due to an earlier error), the entry is therefore created like
> > a foreign backbone gateway.
> 
> [Severity: Low]
> Is "for example due to an earlier error" the usual way to reach this state?

I just gave an example. Sorry for not providing a full list of everything 
which ever could happen under any circumstance.... will also not change the 
commit for this.

> 
> Could the commit message say that this is the normal startup path? Stable
> maintainers would then have an accurate picture of how often the bug
> occurs.

No stable maintainer involved here.

> > diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> > index 68ff2f94cf49d..3da070a087da6 100644
> > --- a/net/batman-adv/bridge_loop_avoidance.c
> > +++ b/net/batman-adv/bridge_loop_avoidance.c
> > @@ -986,18 +986,22 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
> >  				unsigned short vid)
> >  {
> >  	struct batadv_bla_backbone_gw *backbone_gw;
> > +	bool own_backbone;
> > +
> > +	own_backbone = batadv_compare_eth(backbone_addr,
> > +					  primary_if->net_dev->dev_addr);
> >  
> >  	/* register the gateway if not yet available, and add the claim. */
> >  
> >  	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
> > -						 false);
> > +						 own_backbone);
> 
> [Severity: Low]
> Should this patch have a Fixes: tag?

No, Fixes: or Cc: stable@ are not allowed for net-next

Regards,
	Sven
--nextPart6327635.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXjMwAKCRBND3cr0xT1
y98KAP0XuAaVVcy3KJlx3P1vW/re2kF6EWJH4QsfagcxkMC4MQD+OZC66ix5Bp/8
DUpt5MhPeXVTj02g6Hc0UqlgNNLlwgY=
=d6XZ
-----END PGP SIGNATURE-----

--nextPart6327635.lOV4Wx5bFT--



