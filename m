Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE512CD4F39
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 21:11:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 46384840E8
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 23:11:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778793109;
 b=Mj6UVfQRgxelTMeWGBj4OuQ60U/HzywgREDV3hK+lUE4jlyJv4Ogxm6tmA1GgPn7emMeO
 GVG0lu4FZ5SZXg8NJVNt6GpcGOklhEaq/ypMkZuDaiRnupO/mPdIxZJi9IiboYUJbde3EEY
 7hfIzS9T1sctEBSGhdJT2QfFMmxgdW4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778793109; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IQrVr7QF8CnElXcFob4nlMdaB20hy7kqewImOHtHHh0=;
 b=mw4aDAxonkD0yLOG7fKuHLge9id13gR+8K7qXEPDdpJ/oRiYGCPht5vqLQLBQsAYAktg1
 k+GSShnA2Za/i/LzAkVYCjhlII4VPhH0AFgmOChiMDvfuJSRlswdoPZ9tTD1oKCjR8p6Cfe
 HgJQ153dpdEi/sJtXM2Uvs1iNfTKdck=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B67A283DBD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 23:11:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778793082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IQrVr7QF8CnElXcFob4nlMdaB20hy7kqewImOHtHHh0=;
	b=J4mBB94Kgf0SKH4TKdv2xD0aAEigmJsVIt/P9vcHfdXb9vNBrxSaxupArJZLkw6dBzf8nm
	yoqHpuN8ISghX63j0XiAEGMGHVlrhxwJXjQcNQHChQAWRCR+0zicNVjAMlOZLTViI5JWJJ
	JAkCJvk3gxxvk4FecUFzSQJN27NabnA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nuCv0YG8;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778793082;
	b=KBvfK7Tu25NbY56n1L5G/MZzB3iqWJ6CFeoNud608+FD6IdyWKw/mt+w8pq+CJQAr+iugr
	0G0PVFE1VeQiPDjZYa6rIeuWsKslhZJ5O7TqnOo4f09XXHPlsKHDb7RsvBbs2n6CLQNUwX
	an/IB2ChDo/lcsFi2toR7YRPdZlK6rQ=
Received: by dvalin.narfation.org (Postfix) id 63C6A218A8;
	Thu, 14 May 2026 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778793070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQrVr7QF8CnElXcFob4nlMdaB20hy7kqewImOHtHHh0=;
	b=nuCv0YG8bVMqklalxKCm5pt8VxDWxMUnHQw/Wo/7PnImGsg9tg46WzLAcW0OKXgzFXYhh3
	70vMoVHXOS7hXNLpi9swc12iLDbY3FF2iDnypbgl5pihres9f3i6LrDwlfO3ZicVO6aHXT
	62UKJw8RtLyMGhiTzBgGTNUXwPyIDHs=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de
Cc: antonio@mandelbit.com, marek.lindner@mailbox.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH batadv v3 2/2] batman-adv: bla: avoid double decrement of
 bla.num_requests
Date: Thu, 14 May 2026 23:11:04 +0200
Message-ID: <5105124.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260514210047.08C2BC2BCB3@smtp.kernel.org>
References: <20260514-bla-cancel-work-v3-2-dc65d3485e11@narfation.org>
 <20260514210047.08C2BC2BCB3@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4739128.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: THAAIGXQFSFO2FBCKGCS2AV3X4IMWRDL
X-Message-ID-Hash: THAAIGXQFSFO2FBCKGCS2AV3X4IMWRDL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/THAAIGXQFSFO2FBCKGCS2AV3X4IMWRDL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4739128.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de
Date: Thu, 14 May 2026 23:11:04 +0200
Message-ID: <5105124.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260514210047.08C2BC2BCB3@smtp.kernel.org>
MIME-Version: 1.0

On Thursday, 14 May 2026 23:00:45 CEST sashiko-bot@kernel.org wrote:
> [ ... ]
> 
> > @@ -1517,14 +1529,21 @@ static void batadv_bla_periodic_work(struct work_struct *work)
> >  			 * some grace time.
> >  			 */
> >  
> > -			if (atomic_read(&backbone_gw->request_sent) == 0)
> > -				continue;
> > +			spin_lock_bh(&bat_priv->bla.num_requests_lock);
> > +			if (backbone_gw->state != BATADV_BLA_BACKBONE_GW_UNSYNCED)
> > +				goto unlock_next;
> >  
> > -			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
> > -				continue;
> > +			if (backbone_gw->wait_periods > 0)
> > +				backbone_gw->wait_periods--;
> > +
> > +			if (backbone_gw->wait_periods > 0)
> > +				goto unlock_next;
> >  
> > +			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
> >  			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
> > -			atomic_set(&backbone_gw->request_sent, 0);
> > +
> > +unlock_next:
> > +			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
> 
> Will this prematurely reset the bridge loop avoidance sync state when a request
> is sent?
> 
> In the previous implementation, batadv_bla_send_request() set request_sent to 1
> but left wait_periods at 0. When batadv_bla_periodic_work() ran,
> atomic_dec_and_test() on wait_periods would decrement it to -1 (returning
> false), which correctly kept the gateway in the out-of-sync state until a valid
> ANNOUNCE frame arrived.
> 
> With wait_periods now being a u8, if batadv_bla_send_request() sets the state
> to BATADV_BLA_BACKBONE_GW_UNSYNCED but leaves wait_periods at 0, the next run
> of batadv_bla_periodic_work() will evaluate if (backbone_gw->wait_periods > 0)
> as false.
> 
> Because the code falls through when wait_periods is 0, it appears to
> unconditionally transition back to BATADV_BLA_BACKBONE_GW_SYNCED.
> 
> Could this spontaneously drop the out-of-sync block without receiving a valid
> ANNOUNCE frame, potentially allowing broadcast loops?

@Simon, can you double check this? My understanding is that this code is only 
relevant for own_backbone (see batadv_bla_get_backbone_gw()). And for
own_backbone, we are always setting wait_periods to BATADV_BLA_WAIT_PERIODS.

An underflow was never expected and this code should not run for 
batadv_handle_announce() with CRC error (see batadv_bla_send_request()). Only
in this codepath, we don't set wait_periods to anything.

Regards,
	Sven
--nextPart4739128.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagY6aAAKCRBND3cr0xT1
y9QHAP9H81QkqhvptMrvk5FQMi1BFFa5NetSBjry3A8yB9+bfwEAn4xPCV7MOOB8
PXVudWO0UrI60g97tiw3tSooZ3ibRwo=
=x+NR
-----END PGP SIGNATURE-----

--nextPart4739128.LvFx2qVVIh--



