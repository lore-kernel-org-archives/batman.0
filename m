Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8DDCA5FDD
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 16:05:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5225883C43
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 18:05:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790957156;
 b=Gei7gEt7o/YGPZz1G6AHhxthzyp5g4ftElmPdquHnEyat1p8ECHwgFNdYUk7Zw65UytS7
 Zu7wLJdY/2SdOmcsOzZQPbfjNcMUXtO50EC+US4Lerdn6TDkWPqNynV5ogfxIbjKxtyRb6M
 OLPDj75rBq05wRUSdRJAsEfVfXeula4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790957156; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=y2M+CgAOhsYFxG3telNT9hjb3vQ0aLrOXWVPVdgAqOA=;
 b=qzf8dxp24Rk+n2iDmwaEUBtHFuPPHhFPWKsbyINj/HM6Pk8bKlfDclYKPpiPx4oNGu7Tm
 Ydayg/6KI5CyNUJJsSu6DIvfhrps9zX9wMk6npE6metl9YC4Gim+7A5fAgnuUHjlk2p9IBy
 Sh8ilDGac8lgdOzjKk1E1tgfqyuKm+I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 691718067F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 18:05:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790957147;
	b=D584JkuS3sgdUGTtyjsxWQUrOSlugzZvo7Ka4rWSLqWnDSRR0tjlai+O4y2bKngdx5oTRu
	0JvWzlpo+bvStTf+AJpuRgpmqsciLUD3IPoD3bXqRwaXnFecIJ08uJua+DgbqS2IZ0nrMC
	/kPwNOmCnGlUcnVJ6b9acsqOuKGcA18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790957147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y2M+CgAOhsYFxG3telNT9hjb3vQ0aLrOXWVPVdgAqOA=;
	b=QJrXaUG+d/WEwbrjExEUr/rIZf1rt116Q8UaAGdLyEGdSDJdZuleNkP+QGo0n2kaxpXq0E
	M1AxIy/8GWm2FeDK/1WrxhP40E50vfBNJ/58WsQsUbTDpOsmGYAc4oIgXSB2eAzS4N3iae
	BWhgceYINneYzlDS+JX7ryZf/SRrG3U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Okubelef;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A0F2520030;
	Fri, 02 Oct 2026 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790957136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2M+CgAOhsYFxG3telNT9hjb3vQ0aLrOXWVPVdgAqOA=;
	b=OkubelefR/DLv6krpM13axsn+L3CgYSOCxZfjzOFnZJMGQRtTvxH9sCumg1b6eD8sS3AGK
	I7KQiLjiDZFoAofPVlklqpCJzKEyHkj9Ar1F0FNCRIpiMwW0+qF81R8wyQ4MzhLLWrvBJ/
	kMapbfuOlsu9pmu9W7gmgJV10OY7vAA=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for
 roam flag
 during removal
Date: Fri, 02 Oct 2026 18:05:34 +0200
Message-ID: <14106471.uLZWGnKmhe@sven-desktop>
In-Reply-To: <179084942724.434549.1630601702570339695@kernel.org>
References: <20260930094558.3723766-4-sw@simonwunderlich.de>
 <179084942724.434549.1630601702570339695@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3065912.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: P6MQPQ3KJ6APYMFORRNWVE3XGRQU53TS
X-Message-ID-Hash: P6MQPQ3KJ6APYMFORRNWVE3XGRQU53TS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P6MQPQ3KJ6APYMFORRNWVE3XGRQU53TS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3065912.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 18:05:34 +0200
Message-ID: <14106471.uLZWGnKmhe@sven-desktop>
In-Reply-To: <179084942724.434549.1630601702570339695@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:27 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> 
> This isn't a bug, but is the "prepared by batadv_tt_local_mark_removed()"
> wording accurate at this commit?
> 
> In this commit, batadv_tt_local_mark_removed() doesn't build any event. It
> only saves *curr_flags and sets BATADV_TT_CLIENT_ROAM and
> BATADV_TT_CLIENT_PENDING on common->flags. The DEL and ROAM event flags are
> built right after this comment and then passed to
> batadv_tt_local_set_pending_event().

This is just an intermediate move

> The other two points are small wording nits. Both come from code that was
> already there before this patch.
> 
> The comment moved into batadv_tt_local_mark_removed() starts with "if this
> global entry addition is due to a roaming". The helper's kernel-doc
> describes @roaming as "true if the deletion is due to a roaming event".
> 
> The only caller passing roaming=true is batadv_tt_global_add(), so the
> wording is correct in context. Would it read more naturally in terms of
> the deletion, to match the kernel-doc?

No, it would be wrong. The global one is added and the local one is removed.

Regards,
	Sven
--nextPart3065912.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/WTgAKCRBND3cr0xT1
y9UkAQDcIxML8Hb0EASps7ASDrNCw5N4ZOBfQEP7j2owvIQRmwEA6+J7sxOe1VNy
xzxHdPyB/TIbiibjC7cFcEGbmcZeSg0=
=EC+u
-----END PGP SIGNATURE-----

--nextPart3065912.e9J7NaK4W3--



