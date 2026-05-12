Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497DCD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 12:44:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80970857AE
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 14:44:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778589852;
 b=mZTPxfjMFCWbfuKhn0617N3DpKbSawTkrWCko1+b857VGxtA28OHk8Zq9bLXMd32zUotu
 /RKgzz4zJaGtsP0gDfm83tmAHi79+LFWgfWYBuStpzALWqbbpUchNC54YUIxPUviC7wPLuy
 K4aLdkcxG/oPdMXc2SOxFiNcmrLPTCM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778589852; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vrb1cMFoUatQfFfjnwrIH8sv9qvDZVQTyWnl8M1ji1I=;
 b=Exf9e/n2awSCpXeXUCGBoT+17T0CTHqqMr3Bv5zzL2+GN53nZ2wfYHDpdXnb3UjQ+5IpY
 QMlnTIV4V3oFLFWe8keYeslR2/UPEF1BGG5efIM0r1/3TkvF49i6KopSjGjEq1jSIt88Ifp
 yNnulDB9Yr/E1s4fjVFlPRFIHEievwo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 99B0481067
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 14:43:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778589828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vrb1cMFoUatQfFfjnwrIH8sv9qvDZVQTyWnl8M1ji1I=;
	b=DXyrthweI7k17davUg5RiYq6H2msRZp0kL03xqUTZRldVDW7yqqqIUdYXbmrZIuDhQLW2z
	eFk19pNAhMiC172hJdvlUOQ54D8u8A6ESnfcyY+gzbxEktjbmuEaTycF78qrWLhMD+vzVt
	HNj7faQilT1XhWJeIA4fHu1zKBvh1Vc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=FsXqV6X2;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778589828;
	b=Ni7zmdXUYBOm2XdgLfg7xebQGIcY48k1N8H0EQxQG3CCNqLhI8IBjePXRZdgn7MmxSNkPU
	iUEFHMwIZrTWSJ9ydbTrS9UTxMaTZuC7KGm/wwJXEOQRBusvQyz4/eUHXBC8RafGtkrDob
	iVGiJvp43fcWEkSvcne/6qvYN7xbNJA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778589817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrb1cMFoUatQfFfjnwrIH8sv9qvDZVQTyWnl8M1ji1I=;
	b=FsXqV6X28MPsnUgaxAMwte8k1L9wowwQta7vkZm7+d788EgfvRNcoZrASpYcy+U02Bk58K
	bJULKYjbpaVRyInf7j5vRyzVo28za3UXAAQA3CRpevIf6E6WpkDZ6ecKS1mDcZPc+oRA+d
	5E+dODSbcEgTl7/MrRATJ0rNUS1AEFy+JuWieL8XiAzLAA++3MeHXl7R9V0wbn5p4OwGu9
	+IELOvGt5HmJWSZy8P0YeSKQ0uIcVNrMBM+iOKZHTwxSx4k3SiXoFF2eDJAjGdE7ONfDtB
	IjreF3p54AMtVWFgXOj8HhUwGbqclWc57sQA6fs+Pgt1IphbffAJUjWJ+rReyg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>
Cc: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH RFC batadv] batman-adv: bla: avoid double decrement of
 bla.num_requests
Date: Tue, 12 May 2026 14:43:37 +0200
Message-ID: <2302187.1BCLMh4Saa@prime>
In-Reply-To: 
 <20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org>
References: <20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: EQWNK5QORWIDALCNLOKBB7VYTJEL3BKL
X-Message-ID-Hash: EQWNK5QORWIDALCNLOKBB7VYTJEL3BKL
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EQWNK5QORWIDALCNLOKBB7VYTJEL3BKL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tuesday, May 12, 2026 9:28:52=E2=80=AFAM Central European Summer Time Sv=
en=20
Eckelmann wrote:
> The bla.num_requests is increased when a no request_sent was in progress.
> And it is decremented in various places (announcemnt was received, backbo=
ne
> is purged, periodic work). But the check if the request_sent is actually
> set to a specific state and the atomic_dec/_inc are not safe because they
> are not atomic (TOCTOU) and multiple such code portions can run
> concurrently.
>=20
> This can be avoided by atomically replacing the request_sent state while
> checking the previous value. Only if the previous value was not actually =
in
> the correct state then the atomic_dec/_inc can be performed on
> bla.num_requests.
>=20
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Looks good to me. Please double check the first sentence of the commit mess=
age=20
("... when a no request_sent was in progress").

> ---
> Please consider this as a note what might have to be done. This is
> completely untested.
>=20
> Especially think about batadv_bla_purge_backbone_gw - the old code confus=
ed
> me a lot and the new one might therefore be wrong.

[...]

> @@ -1249,7 +1246,7 @@ static void batadv_bla_purge_backbone_gw(struct
> batadv_priv *bat_priv, int now)
>=20
>  purge_now:
>  			/* don't wait for the pending request=20
anymore */
> -			if (atomic_read(&backbone_gw-
>request_sent))
> +			if (atomic_xchg(&backbone_gw-
>request_sent, 0) !=3D 0)
>  				atomic_dec(&bat_priv-
>bla.num_requests);

I think this change is correct. The idea was to supress broadcasts while=20
requests are pending, because the claim database may be out of sync and loo=
ps=20
may happen in this time otherwise. Multiple requests could be in flight to=
=20
different backbone gateways, so this num_request counter was used to track =
the=20
number of requests. If a backbone_gw is purged, the associated request is n=
o=20
longer interesting, and the counter can be decreased.

backbone gateways are removed on tear down or on timeout, so this is the ri=
ght=20
place to decrease the counter.

Your change is consistent with the rest of the patch to decrease it with a=
=20
"real" atomic operation.

I've not tested this patch, but feel free to add:

Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>

Thank you,
      Simon


