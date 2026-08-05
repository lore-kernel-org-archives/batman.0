Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36155C55174
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 15:07:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 522C584208
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 17:07:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785942456;
 b=mOf1kQ+GYkhKezPg4OJTTdpxSHIgYJvgHRfV7zWWBAxPmrwIOR3JdFXIE4gu0yAsIoO99
 IxAVNikB2wtZRAqH+6rE2DnJ0u0MIlqm5us4c/MZyYA+8Ods91sQ+cmsrAhqSsgb+Ui2yan
 pEEZ472cgIzWFusGobQtZ8lwlMSKIv8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785942456; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Hi2tKSR1mHj8EI4Ln8jR9R2ATeSIpaMrIMEu/N9T3fs=;
 b=cHFC5HSMNW105eNuSpQ1ZxKADApXuXPSIR9DFta1YA/2HBGuFdMxv0isAm5uubEHukxey
 w2/kpSRwnpmB3LtZgC4Q5qMnP7ZHlSaWxQbc6gkG70yb/VepJKrbMtaKo2Vi898QhHgVFGU
 /mvgkBIIGqeuLkDQhGXWaK+3NWNRJBY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0A8F78107E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 17:07:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785942440;
	b=EwWzhk5Kib0M6HHQx4Y7a4tdQOs9FkT5+yC8sECaWKdS6VsFurG8ZDnln7R01KWkU1hJPs
	arc5WTEfVJ8NANvQRFSOIqPBnd8EiXBG79Q3yrWOjJZBLbPIoGZCbs0sot0ApjR59ROd3w
	DyVkuh8VXClIQL01XsmaJZTFkCKq/68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785942440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Hi2tKSR1mHj8EI4Ln8jR9R2ATeSIpaMrIMEu/N9T3fs=;
	b=O/T0j4r9yhTBQZaefxFZljGJh+GpmgUJZ4kSH8Ilc5XzsFlgKGdbhN/+C5RsuAONg8DiCv
	U+0ZkNuY6we9ZoZ4nYoRPWIZ1q/Pc7Or3NsZdC2RvuzmB34fWqNfPLAEglYgXRnOq5/p92
	+IkLSRBf2ZVf80GbXtzH5+DU8t9tm8Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EoJGXkxS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C19FA204D0;
	Wed, 05 Aug 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785942434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hi2tKSR1mHj8EI4Ln8jR9R2ATeSIpaMrIMEu/N9T3fs=;
	b=EoJGXkxSfittqiJ9pQxLOT63vS0ssvfZphiUWr1sS47wTciAhmyBCHI7O7C9z8I72hh8xM
	+QHhMZZv8EjtcNEABFioDRxmJImpbZDEcvUMbH9cb3DoNreqoV8AfVdb8DI+KLx3b0WqYx
	q1rp1cv+7deGjKpvrAgj6/3D37dbrO0=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: compat add support for scoped_guard
Date: Wed, 05 Aug 2026 17:06:56 +0200
Message-Id: <20260805-scoped_guard-compat-v1-0-3067f6013b62@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBRc2oC/yWMQQqDMBAAvyJ7NhDTWrRfESmbZLUr1IRslIL49
 6btcQZmDhBKTAL36oBEOwuHtUBTV+CeuM6k2BcGo81Nd7pV4kIk/5g3TF658IqY1QXN1fbtZLp
 GQyljoonfv+sAFjP6Hca/l80u5PJ3Cef5AVvDScZ/AAAA
X-Change-ID: 20260805-scoped_guard-compat-3a24b95f2810
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=sven@narfation.org;
 h=from:subject:message-id; bh=89hvDzZWByQzYkCwxvCx2BvymkSph2WUyCmT1jqgTJw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnFgZM8xV66+r8siV7XJv1r2fTLKz2uPl/y29xuZ8x6+
 xm2WSXvOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATmXmR4Z/2jD3H7/IIRGQ6
 OfRG7lyfZ2jaOOnT5ZUd5hsuW6WlRm1i+KfWzefbpCcz/bOu8mehRUr2i0IbOu/PfPOuY1r89gp
 3M0YA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IJVBAG4LZXEH2HQCDYNPN53DIIEVPQ7J
X-Message-ID-Hash: IJVBAG4LZXEH2HQCDYNPN53DIIEVPQ7J
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IJVBAG4LZXEH2HQCDYNPN53DIIEVPQ7J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netdev rejected the protection of the TT flags using atomic_t. Instead, it
was requested to use spinlock_t instead. But for the implementation using
spinlocks, it can make sense to use scope_guard because the current TT code
would otherwise be an easy source of missing unlocks.

Unfortunately, scope_guard requires a C11 kernel (Linux >= 5.18). The
support for older kernels must therefore be dropped.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: compat: drop support for pre-C11 kernels
      batman-adv: compat: add scoped_guard(spinlock_bh, ...) support

 README.external.rst                   |  2 +-
 compat-include/linux/array_size.h     |  3 +-
 compat-include/linux/cleanup.h        | 48 ++++++++++++++++++
 compat-include/linux/compiler.h       | 15 ++++++
 compat-include/linux/container_of.h   | 13 -----
 compat-include/linux/etherdevice.h    | 20 --------
 compat-include/linux/if_bridge.h      | 51 -------------------
 compat-include/linux/if_vlan.h        |  2 -
 compat-include/linux/kstrtox.h        | 14 ------
 compat-include/linux/netdevice.h      | 49 +-----------------
 compat-include/linux/spinlock.h       | 20 ++++++++
 compat-include/linux/stdarg.h         | 13 -----
 compat-include/linux/string_choices.h | 12 -----
 compat-include/linux/timer.h          |  1 -
 compat-include/net/addrconf.h         | 94 -----------------------------------
 net/batman-adv/multicast.c            |  7 ---
 16 files changed, 87 insertions(+), 277 deletions(-)
---
base-commit: 46e983472304d8875436a23ccb996ea18856081a
change-id: 20260805-scoped_guard-compat-3a24b95f2810

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

