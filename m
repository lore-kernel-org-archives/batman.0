Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309BC88E63
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 20:40:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 55D4283E1E
	for <batman-adv@archiver.kernel.org>; Sun, 13 Sep 2026 22:40:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789332053;
 b=rfypBnZ3II1lWsCuv/OjFLezR6WVjyCHuvhQtIlyXStC08BFT4Nm24A7B9HeIZ6iAREFA
 axKbxImFqUqL9zQxUBRrmk/izMqGDT+vAPl7mcBCbDzIKixB9wfRZd543hdrquMBdREVs4a
 s89oapwmMKI15isHDak5y9sh7vSDD7s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789332053; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zOivew53lYQimag25k053P+EGewrJVVN5pwPAic17W8=;
 b=ntMCg8kVF+wSvj2KzMfsIItcz4asEW1e9xDUmL8syuXTCHDU9RJDkMLpa9ipG/AWA5cTp
 dNDL+xIXX2qXYKfqSPCjwDs54uVdkhloA2mgJaAfM13deeK+NsaNVdXxoklIqazMZ9Tf/Dg
 LWakxav+rLr2Az2Gh9/0cPn18zBqr2U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 613538081C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Sep 2026 22:40:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789332044;
	b=SiI7V2NQVqXR6V2d7mLIYXrTs0Cqd2WspsaX402h/LDesPiwtuQ4ocj6XaxTOek1ZcJx1R
	6rnwc9iI8pLbDfJz+vAccuHUIPi0uGUUMHemUOpKAOikE0zMpxM94bv43O5VkkYe0MDbjR
	5td4kSeP58/T+S/d7njNFyqh3DIpisQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789332044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zOivew53lYQimag25k053P+EGewrJVVN5pwPAic17W8=;
	b=STn5/bc6HAc7MStISHKqV1HeHckcFVWe9uNQWFhL7nNtu+vk5tzblkFx0nc/33/TL4Aqh0
	GwUmY11bUCBawKHc0kgvNF8DGwaSu5qDRvQMBOi1bgB8Ud6+VaUgKCH+hHQGlnhAZqwM8J
	nlgJQIgsOkNL30V8Uv8HBFJi/HIt8qA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nL6S+nb+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A1A7320494;
	Sun, 13 Sep 2026 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1789332042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOivew53lYQimag25k053P+EGewrJVVN5pwPAic17W8=;
	b=nL6S+nb+fUmyRyHdw8cG7JrsO+RGb5a3Cu7uTS8aHwKBfFQUhD1i4AtRSWLvNQuuy4V5mw
	qv1l4O52+WvpRITmboURKy3xjNFeR8ozogKCMqmq7Feya5+AeN2P2uzlyzUV+CjY+xyU47
	w3MyOBLu+IjV0xPHVHlrch1iOTrkH9g=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com
In-Reply-To: <20260913031906.14809-1-kartikey406@gmail.com>
References: <20260913031906.14809-1-kartikey406@gmail.com>
Subject: Re: [PATCH] batman-adv: avoid WARN_ON for orig_ifinfo allocation
 failure
Message-Id: <178933202450.57204.5532409907448313172.b4-ty@b4>
Date: Sun, 13 Sep 2026 22:40:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=331; i=sven@narfation.org;
 h=from:subject:message-id; bh=eYsNVsNB9+bsKCx0GV0fy9SH21fqFrQU7cvFVnwiqy0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnLuVx49/Md39MUp7360LFf0r1CMqaes+8U7GYVWfftR
 a63c8f+jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEMpcwMqxa8nKrmbxMiFHT
 /hmBfqGV59dkS263uGGe1vClUzLXlYXhD0+nkuKO7gqfmAtzGk1tuHa1nH0d92+SyOlMu8rfM5Z
 WcgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WAWS2EIRPYN3ABP3HBE2JKXHU6UFKBA3
X-Message-ID-Hash: WAWS2EIRPYN3ABP3HBE2JKXHU6UFKBA3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WAWS2EIRPYN3ABP3HBE2JKXHU6UFKBA3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 13 Sep 2026 08:49:06 +0530, Deepanshu Kartikey wrote:
> batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Applied, thanks!

[1/1] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
      https://git.open-mesh.org/batadv/c/abfe281aeab4

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

