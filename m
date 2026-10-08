Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73179CA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:14:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C022D8425E
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:13:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791472438;
 b=lW3rcD26W/YWs7/r25HINmgb1VLYi3NcJ1uBWZ/cqNc1zpH2D+O8wGmK1rgZtQyPMeUz1
 vWBVLUMirMIZJsA4JVMazf2s0yCXLQb2+zgrJk44YbUyNyFourzkOUw3eG6ucojEYlFfTaH
 ZTYkXCC+Wa3h++H4epBl9IrlbB10ELQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791472438; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9zqyAUXTCmHML//7dA6W07y4wqyOLiR+6T722Jgzub0=;
 b=iHZhU/RAYxWRKwtmNfzKR9pWlHBEcKVuTqJEQsQKw945DwfPlth8cbWkA9KF6gsyMNGbt
 JrVBrqvq0tjrfCu51ueSDlB04hrbkrwbcm/V8kjkMm/ziuXJkA7ns0sabZLtmbvIYHLMVXr
 Qaqr/liDf5rRQKcr+1/CWdKDfMmBjnU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 76CAD8132F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:13:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791472429;
	b=ofhGGrcBeehm6FcnnnMR15rfci6GXcaNPTll7OTUIQWb2leGWufDl+i4SDzh601/H+bR9u
	0m7wQtUbOSQzkWqa46hpJ0w9DJjPXsFoMJL3KKs83DRFNF+mOK30pEGN7pj205fGD0xTZ5
	Z585a8UVCOK31D1kNafDtXIG4B7IbGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791472429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9zqyAUXTCmHML//7dA6W07y4wqyOLiR+6T722Jgzub0=;
	b=ah7mNLdmodYT+fs/k64lZsEI4HQ20tV/LXV+Kt/ro3CsSUtCjeKn+6K7Ck2uv4ktoOn/0B
	dhK5tHO8DXnRr5oDO3k5PMN0tZuUrFNQUx72ktvE8wcjKuZaoxiJe5ajfXykpABOQB2fI6
	OG1bMtuuv5ZL6xlYT0buQh5WH+B/4ME=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="JyPLHH/F";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E6CB92049B;
	Thu, 08 Oct 2026 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791472429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zqyAUXTCmHML//7dA6W07y4wqyOLiR+6T722Jgzub0=;
	b=JyPLHH/F+p+d4sirSq2cHJUF3/UwIJV5B23disprnHE8RxrsZcK1lUMgPrsnDjDdFcKl77
	QlDpIxlrogbVPR6UMXfhXUkJuk57uPhTWv96B9vfz1dxa9sI2duO2S8NnFkqdCfO4qZ+FK
	FkBd1ynXofAQi2uExM+oePzTV6VVnTw=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: sw@simonwunderlich.de, antonio@mandelbit.com, marek.lindner@mailbox.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv v2 6/8] batman-adv: tt: don't queue local events
 for
 unhashed entries
Date: Thu, 08 Oct 2026 17:13:45 +0200
Message-ID: <5334040.31r3eYUQgx@sven-desktop>
In-Reply-To: <sashiko-outbox-164327@kernel.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
 <20261008-tt-avoid-unhashed-event-v2-6-7c4eed81606d@narfation.org>
 <sashiko-outbox-164327@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4965436.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: T2EOLDRQF5JLWCXHT2WLKXA3XP365QA4
X-Message-ID-Hash: T2EOLDRQF5JLWCXHT2WLKXA3XP365QA4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T2EOLDRQF5JLWCXHT2WLKXA3XP365QA4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4965436.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Thu, 08 Oct 2026 17:13:45 +0200
Message-ID: <5334040.31r3eYUQgx@sven-desktop>
In-Reply-To: <sashiko-outbox-164327@kernel.org>
MIME-Version: 1.0

On Thursday, 8 October 2026 16:51:45 CEST sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Should this update include an atomic_inc(&hash->generation) similar to how it
> is handled in batadv_tt_local_remove_now()?
> 
> If batadv_tt_local_dump() is preempted during a netlink dump and resumes
> in the middle of a hash bucket while batadv_tt_local_purge_pending_clients()
> concurrently removes an entry, the dump offset will be shifted.
> 
> Without incrementing the hash generation counter here, cb->seq remains
> unchanged and netlink won't set NLM_F_DUMP_INTR. Does this allow userspace
> to silently skip elements in the dump without being warned of the
> inconsistency?

Pre-existing problem and not introduced in this change.
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-hash-generatopn-v1-1-5aa687343ce1@narfation.org/

Regards,
	Sven
--nextPart4965436.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasezKQAKCRBND3cr0xT1
y9YqAQDVp/rkuHJ26wPbqg2d4Dtpbh9yR4OSc9xdb2EQON42HQEAnLEMAIsZIMFW
WvOpAhmEF+cRdTynoBntkxDkhkfHbgw=
=4SjA
-----END PGP SIGNATURE-----

--nextPart4965436.LvFx2qVVIh--



