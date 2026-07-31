Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C24C54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:14:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 826DB83FC8
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 08:14:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785478472;
 b=KdXB4jTyU8FaaFyjSW+n6YsePq/9Ixkw8QZfdICCyuwVaajiQ6yM1rAAQq/US9DqHNKmD
 T7guZhIQpuChXwcoEBWKvCQRR8M0C6WES5/HeKi8Gt/HeFx+Iz9Cuu8ABnsoFnW1IuJ9Omo
 67ffeed+W+4qeH12QqsWpgmZajTgnqM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785478472; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1NOqLgReEvXl3reHMH9kZ+M3GCKL1cgfpHKlSueC170=;
 b=oLmyywXWYwKg9IS14fXIyMuy04D1R65uj/tI6yLPcTFczTcTeb/VTxssakGjcnLN/1oTp
 zQByeann1kYT1DmVv/6pb0slTAXad+njkM4K2+wYWxF1zTwaaxGLxUXdx7yAm4nW3CfM2ZC
 UhCzNeHQVKBqC0/yxD4GNjGthMb1qRE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5EEAB8082D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 08:14:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785478452;
	b=CDKv5/L6GlMYR7A0GKNz8XPV672lQ/K4taBLkTu0UnTNu49xuj7doxZQj4y+Rz2szWKEWA
	y/qiKeFmAUnf1o5pmgADQMdqg2FxPASrshyITyxNyiPqpL44ay5HpQLcCNvkf4OcxTrE0g
	jv2B0SfXNISjOcCy9D6nXEZ2vi0pFk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785478452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1NOqLgReEvXl3reHMH9kZ+M3GCKL1cgfpHKlSueC170=;
	b=P+CC+cC301YYhpQKkSLj2sPjz5xF8P15p7/TnIYna7fKeP0XACKl7U9ovYmx5pGff7sX1C
	gQ2BGSCG125TCJITmgIYUHfBDztFhx1RdQZbGkkjNtgE9lGjFCJK+wk8EYbJNRVuIGUhXU
	rMmWNzNZb3DjkB+OupTZcghbnBj609U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nQgfTa8x;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8CC1D1FE4D;
	Fri, 31 Jul 2026 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785478437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NOqLgReEvXl3reHMH9kZ+M3GCKL1cgfpHKlSueC170=;
	b=nQgfTa8xhNNUiWhmyewiENPSd8GWk0BWDUvmiETD7etky2O0qyyvcy/B+cBDFNLt+V+BlN
	XBlXkjnCLRGRkmeaZ9rXp0rfjDt70O+l82tguLWfnS7bDmTteEg4Nddw9i0H3zs8qYsnvH
	lSJbEHKgnFljXySyDuh4vi28Y2GyTGQ=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH batadv v3] batman-adv: handle errors in batadv_init()
From: Sven Eckelmann <sven@narfation.org>
To: Minhong He <heminhong@kylinos.cn>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260731023333.70727-1-heminhong@kylinos.cn>
References: <20260731023333.70727-1-heminhong@kylinos.cn>
Date: Fri, 31 Jul 2026 08:13:42 +0200
Message-Id: <178547842268.6371.3735845718174969986.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=217; i=sven@narfation.org;
 h=from:subject:message-id; bh=bjypEdxSlBPdjfzPq+BUF+fU+K4X4ix5BFlMNBbcTrM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5ttKnf/wz/Mq/+Fpa2xtt3STjszMv3Dp0UEJEfv/K5
 L2BVSKuHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJfFvLyHDjxof4QOEnxSFv
 L59S1e/OWHb7k/2VmG3fWnp3HcyWtTvCyNBoFdKr3xnpZ3OAvWfepW8Si8WC1dm89hWdCfn9nON
 hPDsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IA37I4YN2THWTTQSD7FZFVIW2HFTLOLG
X-Message-ID-Hash: IA37I4YN2THWTTQSD7FZFVIW2HFTLOLG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IA37I4YN2THWTTQSD7FZFVIW2HFTLOLG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 31 Jul 2026 10:33:33 +0800, Minhong He <heminhong@kylinos.cn> wrote:
> batman-adv: handle errors in batadv_init()

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
