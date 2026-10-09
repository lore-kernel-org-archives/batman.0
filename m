Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84072CA5FED
	for <batman@archiver.kernel.org>; Fri,  9 Oct 2026 05:55:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A3CD844EB
	for <batman@archiver.kernel.org>; Fri, 09 Oct 2026 07:55:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791525319;
 b=A8t2YF76kAAMGDevlI9Zv8MNgyRsq/4wlwGosk87eafYQEHlTeAFhAl2bE9fnaCRI2b8D
 Q+M9E3X4O2KEWsGdTfiaf3xDKLzpqvEVgJM1My0ngaOPLwONT7Q1XJi8OSt3fclL/2x/xrk
 LhdirB4IPhC3qtIrsc941dM484IL3QA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791525319; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZxzKsY8+J9r94XoTaYeUXWwntNzekr65VcQG7f6OMwg=;
 b=2YDK7V1aSlbH5ip6HCmWRz7gxrDkwReF1GNZ7QcdWKQlKnOJXBtLcUc+Wvwp48jPzshoc
 GiPman+t+/WcZZMPNY5wv/EPwStIZmiip48GnDVpF1Aya/Wa9bllVjO7R2sQPxNfCgrWRQJ
 OMDj8u7YREC5iDBPMbM1/hVDEWUkXYQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7062580C4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 09 Oct 2026 07:54:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791525310;
	b=MlPfIGQ5LcBnsMUkSdwZ+9aBVgMmfmdvUB4OCpmKO2Jc5P3YhgosmiNN3KB460LS5/wfAL
	jriXT9fQ3AN9JC40cQ+SGzZgpaP69NsJ/CHXmeWuE87w8imM2fGQ2KZ7QJ/ZdeEhC8K4wg
	uhGKow6npP+aVl1Yq8aMrHddQToANqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791525310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZxzKsY8+J9r94XoTaYeUXWwntNzekr65VcQG7f6OMwg=;
	b=BYmWBlGwHgz1NuV0k1MTd66JVK6OnQvfk3YIn/cAf9Sh/Hmb3xsoWRr+qbPUtbpIh8SMiN
	TZukQTe15OfDoanNIGq4jdsHlzabqEl2KgS+OZXIukJ1omeOybgwn2mDLJQkn1rS9+Mapz
	Hzm4xPRW0mLqqNWo2DnVQxffWmZAk98=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oQmilDm9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 00C0420320;
	Fri, 09 Oct 2026 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791525299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxzKsY8+J9r94XoTaYeUXWwntNzekr65VcQG7f6OMwg=;
	b=oQmilDm9ry4Eo3o88RvaKXGNFFsSXt4BkBQ1Ud1Eq/BbigUlmmS41QkJ6V/fybL1P1BFKm
	9Yux3GFhLc0keboRu20yC8RI5JJRgiiS4dpY5HTlgo9nYhOhL/zTKvYtkzbV4L5cDChBOe
	f5YJQgblJ3G5RdudZrJBaJsSm4+DyDc=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH batadv v2] batman-adv: uapi: add note/clarification on
 access of reserved bytes/bits
From: Sven Eckelmann <sven@narfation.org>
To: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
In-Reply-To: <20261009003057.12357-1-linus.luessing@c0d3.blue>
References: <20261009003057.12357-1-linus.luessing@c0d3.blue>
Date: Fri, 09 Oct 2026 07:54:49 +0200
Message-Id: <179152528926.271514.12283986659366155647.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=sven@narfation.org;
 h=from:subject:message-id; bh=06w3hWh0kBXq6cQ491q3e0BIUXd0Tt5VfCasnP0bRVc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFknGlcHXeZLn14voXjgPq9TzqblE7pa9kUGGk07EX/pb
 gHzDJ7PHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJdExh+MO9KEgwSUys+HbX
 a6dO4+difG/Pt/zX8pjzyvB6fZ2T4UZGhv+19yNv9gubHHrnqqZie+LJ6dnMb+Szv14pqQk+lv/
 hFwMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ILL6ANVSHZJNCRBG5Z67AU4FGDSUV5CB
X-Message-ID-Hash: ILL6ANVSHZJNCRBG5Z67AU4FGDSUV5CB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ILL6ANVSHZJNCRBG5Z67AU4FGDSUV5CB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> Similar to the note in include/uapi/linux/ethtool.h, add a note regarding
> reserved fields to include/uapi/linux/batadv_packet.h.
> 
> Userspace must not access these fields directly, as they may be renamed or
> repurposed in the future. When creating packets, userspace should zero the
> whole struct (e.g. via memset or a struct initializer). When parsing
> packets, reserved fields must be ignored.
> 
> While at it, unify the kernel-doc text of all @reserved members.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
>

Will be applied later. Don't want to try to send out this patch to net-next
while it is open for the last week (because a review takes roughly ~1 week).

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
