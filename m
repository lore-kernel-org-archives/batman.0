Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED0C9830E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 14:15:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A6657840F3
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 16:15:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790518518;
 b=3ShH3CNF9ZmDqg9YQeC+JC2gud29TVjRRZ5WybG15sSOSIR2JQFt6Ya2nJX7aaOz2a6/3
 0StBZe/UFZAVKjQbPoskWjKUcah2MIkdFQwBpdKnhM8qydD28JyXQ2O92QSW2YxQ16WqMQc
 CZr2O2QoZdJMto0qL6j0YnnkxzsgYh8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790518518; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EzcO6WM2z4y/JhOjZDRBSmhARn259FsRxPqV1J4V2gg=;
 b=lf6A7/XacvaXNrKdKL4RalkvUe4R2gAg262t0JgUCrerB/EvaJVgXmqYXOJ0D40XNt0Da
 XjxDPzad9CCCJUjuEP2uQcSLgn/PLc2IV+gmP4E+bJy0yiLaitt9lV8ATQFhfPrweZDGh7g
 +uOe+v9Ns1J1DsPH+BlsMWa1L+NVQmg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 315B18185A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 16:14:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790518506;
	b=ApzwLqyfGhzzOu0J9ny1TWFriFTC49EWnKInyQd8mMh6PhhC4W4YMeySHx78JdhgAT801p
	/Ei8Z1pN6fyPSqg/woojE212qPyFfjVOOowoglwFvd+K+zrQ1hE4l2CHBLgoWHV9Vn5OcD
	RhFdmH8yLKcMk9IWp8V2cdgbUaPskoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790518506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EzcO6WM2z4y/JhOjZDRBSmhARn259FsRxPqV1J4V2gg=;
	b=eKMOEROB9Iepp5iW9SSJURWzaSEmFOoza0oePrvD1mtrtEdSltwDgmf1nPnzIVJrPY+QeE
	3wqgdAfCCvoU9GfUdwj+k2zaKkOkdZa3R6rVfmFNPCrEql0U13tX6VLnaHrsZICAvMVyy/
	Wi0QyOC1hcrET2nxFK1fe7OOACN1oS4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AvPZFyKw;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 24B2D202F3;
	Sun, 27 Sep 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790518494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzcO6WM2z4y/JhOjZDRBSmhARn259FsRxPqV1J4V2gg=;
	b=AvPZFyKwJLD/y8CPtj5j0j7qqgvRwdkYYdBDbvwfHh+9JcmLhMm24TC+FhAPGEVz63WpUV
	x4Zb+IWBHdQ884wKZfQTQDv+fiplh11GCwPGneKlo+YVvDi6WaZZKtVLEWF/3wdedhff8Q
	I9Cg/P7uekdAUzA5VxkmleW/cT9pYxk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260927101624.3812927-1-nicoyip.dev@gmail.com>
References: <20260927101624.3812927-1-nicoyip.dev@gmail.com>
Subject: Re: [PATCH v2] batman-adv: Close OGM aggregation before
 transmission
Message-Id: <179051846810.161654.4949360252053674460.b4-ty@b4>
Date: Sun, 27 Sep 2026 16:14:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=311; i=sven@narfation.org;
 h=from:subject:message-id; bh=EDVFnN9pEiku9y9JdkPvVGcfHCnHE5m/l20yN5lDlbo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7VW4qcAVyBj9w3hJdOWX1yQuJj63THjL+dji2o3/P9
 Nt+xrKrO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATaVdnZPgntvHuqoye67bF
 WS6HW7kecVy0b62e2e0WZ2haPvP3I16G/wUXf01aG2exvJdJ/UCm+vuDS6ZNnSW6ac6ZJ1EnD93
 kecAJAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HKXG7HM7TJPYCLP2VHOMZTAYW5L5PXTE
X-Message-ID-Hash: HKXG7HM7TJPYCLP2VHOMZTAYW5L5PXTE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HKXG7HM7TJPYCLP2VHOMZTAYW5L5PXTE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 27 Sep 2026 18:16:24 +0800, Chengfeng Ye wrote:
> batman-adv: Close OGM aggregation before transmission

Applied, thanks!

[1/1] batman-adv: Close OGM aggregation before transmission
      https://git.open-mesh.org/batadv/c/c31a4d235404

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

