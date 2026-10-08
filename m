Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69EECA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:03:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0DC9783C4D
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:03:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791471801;
 b=XC7heIwCE9ovFOLPRpKs8CutuNkx/cmldfxG3lgU7B5Zg4/hv2/n2OHGFNwRfv/7/wdEa
 DDyIf8yaYQb3qazGsiyStXh16sylpU56v1POrfQD1jAW8eTMEfv2mqQs52IpracGlu7sPC9
 1HwONHIiqOBsEqblwWGGSH4Eea4Mu9Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791471801; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SILCkbtizl+1dIUDMgYel266LwW7VTv/Av9ol3+4Shc=;
 b=25bT2lE7n92faZmxiouYZTBfRnIanAAtTz1v+VLSyWJqeWSI7pcuyfC6IulDf7BCNIHIq
 6Fz+eQXgYqOYEtoR5L1g+K6QrD4aa4xMUDqZmnfYgVTIbZ3wsMAIf1nrf9OIhNfqhpVg5Eo
 dlraeHrspYFipl/BH+SxNWXEei/HKGY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E126F814CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:02:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791471784;
	b=zOYgQEU8yygWE0nAnuLDg8Z+/ykczgUiLSz0qFj0UkNZfIYzxxmM1LItVvR6O87Hdmgcja
	SJ5lmCzkUbwXel0+IKrD7dD1Bn76aJ1FPZV5f7IHxssYFPNh+3/qpEGbJbE19Ju7GvxpbK
	iOrMHgikLxAz9ogsQY+OpnEktTiSE2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791471783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SILCkbtizl+1dIUDMgYel266LwW7VTv/Av9ol3+4Shc=;
	b=e7h2uTM1B7ANn291nYV93dtiKW5Pnf8+4BY2PxGQ1w5if9nWC/x7bcg2NchPUf8GLbsipX
	M9heqpL05p/T2BiO6TAqGeuN+uG2uv4aUF9amT6Vx/mMB/B3clw2fVnvt+5QdgcDFtVgF7
	m4fWE5XjfyZidjKCqqjnbScvMEJcPRw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wy0poUvv;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 96F09202AD;
	Thu, 08 Oct 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791471767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SILCkbtizl+1dIUDMgYel266LwW7VTv/Av9ol3+4Shc=;
	b=wy0poUvvaegemyZRDdeKiGUvxfapaulrv8K6/0mCUTusjTKtLzlCsSEr4sbUB1EnGlVUHf
	Fer5oVvon6L9beZ66+HTDARZkkbWy9RS5WE6TJZTpfQ/dYbTSRaW9gl1Xoa+p441KIUxTi
	jVYigfJzUqL92rvDaDzWNBtG4dtBzXM=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, antonio@mandelbit.com, sw@simonwunderlich.de,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv v2 5/8] batman-adv: tt: only update flags for TT
 events
Date: Thu, 08 Oct 2026 17:02:35 +0200
Message-ID: <13182561.O9o76ZdvQC@sven-desktop>
In-Reply-To: <sashiko-outbox-164321@kernel.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
 <20261008-tt-avoid-unhashed-event-v2-5-7c4eed81606d@narfation.org>
 <sashiko-outbox-164321@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6232773.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VKAFDRPKQHQ7B6PA53CQTQLNTVMBAGPP
X-Message-ID-Hash: VKAFDRPKQHQ7B6PA53CQTQLNTVMBAGPP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VKAFDRPKQHQ7B6PA53CQTQLNTVMBAGPP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6232773.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Thu, 08 Oct 2026 17:02:35 +0200
Message-ID: <13182561.O9o76ZdvQC@sven-desktop>
In-Reply-To: <sashiko-outbox-164321@kernel.org>
MIME-Version: 1.0

On Thursday, 8 October 2026 16:43:32 CEST sashiko-bot@kernel.org wrote:
[...]
> [Severity: High]
> Does this code introduce a permanent loss of concurrent TT events due to a
> TOCTOU race in batadv_tt_tvlv_container_update()?
> 
> Looking at batadv_tt_tvlv_container_update(), it reads
> bat_priv->tt.local_changes locklessly to determine tt_diff_entries_num and
> allocates memory for the TT diff payload:
> 
> net/batman-adv/translation-table.c:batadv_tt_tvlv_container_update() {
>     ...
> 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
>     ...
> }
> 
> Between this read and acquiring bat_priv->tt.changes_list_lock, a concurrent
> call to __batadv_tt_local_event() can add a new TT event to
> bat_priv->tt.changes_list and increment local_changes.

Pre-existing issue and not introduced by this change.
https://www.open-mesh.org/issues/483

Regards,
	Sven

--nextPart6232773.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasewiwAKCRBND3cr0xT1
y4WKAQDHy/2SPPlYXNTMRUsG251Uwv6yxxzqUR2SDrDPIhg3RwEAlSsYERN9JX9L
iug1cJL0DVhbSzLmcMRFrxle5Ti5GAQ=
=/X2Q
-----END PGP SIGNATURE-----

--nextPart6232773.DvuYhMxLoT--



