Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8DDC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 05:46:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4292C82E52
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 07:46:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785476784;
 b=u5dzbYBCTNysPnCtTBfxmrwqh4mr0NdZouzExPrPSWf+6z/f39CQSwbbFU4IN0nkhiP+0
 wrOMPJVgxNAC0n+QBtz5KFSlsAS1XP3VsRfflZhGBJoEQ5t0ISh2FuIK9uteIzcL3SipBb5
 6fCt2ZeX1+pP1xDgNs0mKg0LqHbH0KQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785476784; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ehlEcKYr53Volbvikbbow+hVf0TnutcxFKoKrahmDYE=;
 b=bLGdj8MoZMZoA3SxKN4UpWvfsqGp5AhLFAtFVemuR+/12fD42vAbB+L8vvswV4BxD8fuB
 QO+xVylQ3CHFmAp4ITNzP1hhRfqHMd+q0Omfr+SLB5ecUfyiFJ9WOb/EFksDqt0Yn4TyIKu
 F5rWRwYfSHO7WJVDJ6KR3P+dqErS6iU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3894D80DC3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 07:46:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785476763;
	b=SJ/TPJK2CmZd0hOYrY5HUoQKeYkjgTvPIc3IsjDhL3MijtV1JOE7e5fwYIyWsMz5WgIDnU
	dLJe8LAOGhMJJcVf9Kkeh86K6H5MYm2Jm0F3IvC8erlxdYmWO+Pwid0KdNFbtqtvTGlcwh
	ojhU15Fc0qaXfD8ndmQnojXbytBeaQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785476763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ehlEcKYr53Volbvikbbow+hVf0TnutcxFKoKrahmDYE=;
	b=mOD87suHk7DPJULsF7BFvgALWy0CGH5digB9X647TDNbaRLc7H2ddu8KNpXSygl4L466S9
	OPhl9Tkf8/OTGDvkORyNoh+61VzZX7Zr55tPfL8Bd5q+TVXPJg8YRW/DuNliuH+rAB9X7Y
	oQuc0ha4Fjp6NOOtLC3mQ/m6dLTlOVk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2gZjpc2d;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DFB0E1FE4D;
	Fri, 31 Jul 2026 05:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785476758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehlEcKYr53Volbvikbbow+hVf0TnutcxFKoKrahmDYE=;
	b=2gZjpc2d37DJA5UB+Wed+bwYeaOBv8pJwE/r9aEVf+3mC5S8YCfKIxL4JQeKUyBO0/fIDe
	66KcZExpE3DtuP8tT9bg7qI+ZZwbdbdb50FaSL4wC+x3m91Qm9An9ec5LiARQ8L/GwsOf7
	EwddEWmCvtWKAGZAFTbaAFO1t+eF65I=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/1] batman-adv: fix stale receive device on merged
 fragments
From: Sven Eckelmann <sven@narfation.org>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: b.a.t.m.a.n@lists.open-mesh.org, marek.lindner@mailbox.org,
 sw@simonwunderlich.de, antonio@mandelbit.com, sven@narfation.org,
 martin@hundeboll.net, vega@nebusec.ai
In-Reply-To: 
 <abdace3ea80a8ca052619d612ffc8d0963b57513.1785467374.git.zhilinz@nebusec.ai>
References: <cover.1785467374.git.zhilinz@nebusec.ai>
 <abdace3ea80a8ca052619d612ffc8d0963b57513.1785467374.git.zhilinz@nebusec.ai>
Date: Fri, 31 Jul 2026 07:45:30 +0200
Message-Id: <178547673089.6371.2262637736656059969.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=502; i=sven@narfation.org;
 h=from:subject:message-id; bh=UKGwEOF3ETijRt2HOa8jjmhkhVVhGVoaR5sq2EEcVVE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5Zs3dkZ+mNG8s7+5zufeBR1v8Ztcijj0z9+VuOT3t5
 Lxt91xXdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmwqfJ8D99pfKC67cepvuu
 tNv6UjLj0meljyte5vGnHN6+f+cZ/qhsRoab/RsOnXcQUAyWnzFFZ6foQ76e4s8ehhP0xL/cnZj
 y04cHAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5N4EO5VSLHHGQPZ6MRG3P3SLREDMCXFX
X-Message-ID-Hash: 5N4EO5VSLHHGQPZ6MRG3P3SLREDMCXFX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5N4EO5VSLHHGQPZ6MRG3P3SLREDMCXFX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 31 Jul 2026 11:18:49 +0800, Zhiling Zou <zhilinz@nebusec.ai> wrote:
> [...]
> teardown.
> 
> Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Btw. it looks to me like the use of skb->dev in DAT is wrong and should
actually be bat_priv->mesh_iface.

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
