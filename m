Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B476CD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 12:10:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB38585578
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 14:10:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778587819;
 b=c3w4/M+yc/PF/qrkrVePlvbeKXRPK0C7GzEWX6ECAZZKZpmjUtDPijkN2Azk+EAFCZsDT
 UytHtW79dhMp6MSg/kXJFvGul5azn4Hmrmuih0RfVldVYl3m+EydF89hsJyNRFimzk1JwX8
 aO2DmfUJGvQLfG62156dZWwecRM6sak=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778587819; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BtfGn8x6KoqA86kmcHtDoBY7EZhOTkCciPYX/2cIimM=;
 b=WlSlPiu2h2qI8R8sX2gBCbk7E3h5L9EtHkHl4rpxkN8J1jwKwmqoDhNakIvAOsaSuiNZD
 gGwZz/5WOP06H0pOOq/lYO8ppidBS9H2G6XTr7Xhcnr7DbUSJViAwqFJUbgfBE3WRX++2I4
 Y7z7ojOfsVO52pjDdK9MU2k9GYz85DM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8000083DDB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 14:09:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778587796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BtfGn8x6KoqA86kmcHtDoBY7EZhOTkCciPYX/2cIimM=;
	b=dbGy5vQisAlBTqCuXv2AJ70/lmwYwfLX2RcD1CuNtXqhQ0FqXBhMIzXvK89fnLmhO4OpqH
	P43yRpAjGB6jasS2HWG+aOcqm8XMgmjTAlktqq2OIlubyyqKrehnCc+V3oo4dPHtYOebZE
	8me0MrMmWncU8SRMxBubm1oM6iBP4BU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=cViSMod9;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778587796;
	b=2++Qsu/CViHIMHfpkJoN2nZB5LVzWTSJAsrpxB/HGs1NaOCpm0m56TjUE201HCM3YGEvpc
	ZLQ/DD79KPdeOg4LjEuug4SJSvueXvAcG1U7m6OOl/5MRzegd+HowmnVe4I8ln0tfg5GFO
	+nGBXGv3RPPkjy1w7H3wmK5It+z0I+U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778587793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtfGn8x6KoqA86kmcHtDoBY7EZhOTkCciPYX/2cIimM=;
	b=cViSMod9rwYfZKdHlCpitAjBdUerLL1zUjmjL4SNNGSeGmXtTl7Kcw8sWN3nET6K8SUjnu
	Spga3ZmXkqMygVFyTu8BSGsIBdOEQTas7mzNuPHkfa8IW8WwmTOo1izc1hiB3eoafKWtNP
	JYr5tYkKhUiAnVyfyBD7OQZ6+G8KrFokS/PywvuTcrwVZfDH483eGCJbUSjQFmOwNETiID
	apjVZzIIyZ3TjAryB6WEZkxQUEllmISTSVNntXR8bkiL98op4TDZ8jrKxCzBujgX6qDxDo
	cnztPlqy1X8MHzN+atmEq7hqRtFnsDd+UGzpJ2HLtawtynwwxWmLOVL5H9hfAw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH RFC batadv] batman-adv: bla: fix report_work leak on
 backbone_gw
 purge
Date: Tue, 12 May 2026 14:09:53 +0200
Message-ID: <2317125.72vocr9iq0@prime>
In-Reply-To: <20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org>
References: <20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: NFRCV2URLSZJHXM44UILCASVBBRK66XK
X-Message-ID-Hash: NFRCV2URLSZJHXM44UILCASVBBRK66XK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NFRCV2URLSZJHXM44UILCASVBBRK66XK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sunday, May 10, 2026 12:03:42=E2=80=AFPM Central European Summer Time Sv=
en=20
Eckelmann wrote:
> batadv_bla_purge_backbone_gw() removes stale backbone gateway entries,
> but fails to properly handle their associated report_work:
>=20
> - If report_work is running, the purge must wait for it to finish before
>   freeing the backbone_gw, otherwise the worker may access freed memory
>   (e.g. bat_priv).
> - If report_work is pending, the purge must cancel it and release the
>   reference held for that pending work item.
>=20
> The previous implementation called hlist_for_each_entry_safe() inside a
> spin_lock_bh() section, but cancel_work_sync() may sleep and therefore
> cannot be called from within a spinlock-protected region.
>=20
> Restructure the loop to handle one entry per spinlock critical section:
> acquire the lock, find the next entry to purge, remove it from the hash
> list, then release the lock before calling cancel_work_sync() and
> dropping the hash_entry reference. Repeat until no more entries require
> purging.
>=20
> Fixes: a998bf5dfbd7 ("batman-adv: add detection for complex bridge loops")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

This looks good, thank you!

Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>

Cheers,
       Simon


