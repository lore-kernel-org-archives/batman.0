Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A407C53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:34:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A31128423B
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:34:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245693;
 b=P7JcCV2hepxfdirSGlCXlTPTxrqQqG5/jlPj41JZs2802N7/fySFwhpPnjXkuEn8OpEjz
 Xb/D9azzTjlHozEu/+GqcHZolmdmaTxP8q++cSBD7k5vtIxiMF0O6GSo9m+6ouoKbYCctE+
 HlD/vMDOFwZXeEZe/K2MDul9oXncDro=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245693; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vk0e40MdEPMEmBvUfjT882PvwL+5RQo883zOtWeorUw=;
 b=zDzbVH00H8eKzuoHvMo0rNRR7SM1TyQSWGnJQGKwRiR4aPWmgExov9Na602bgBh91erZo
 5rYlqmSNK7l74jRdDAwnmV5MbqDSdYQEifJ8abvYMSDIxSPJN9wVYXeeqtHJN1nvXw5vDF1
 k4AHQrtvWHv1rNG7U0cPEZC38Tc05Ck=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CE20F8418E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245610;
	b=x8NyhuffmI+dP2UAknng5r/inW8NNTYGrP+YcEttBzrao475KoTNRnAenclyJF/Difr5yC
	fgVh0yw+cbYuOi3gT9KYiARbM3KliPgpE95mIBunf7mroQvE51p9pl3Yn2+c8nO9U7x1Xn
	BplA2Q2Y9HL6IDZQkqijzWepqTjNVI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vk0e40MdEPMEmBvUfjT882PvwL+5RQo883zOtWeorUw=;
	b=b1EmuksmhRuAd5jqyXAVBhzV8jDVZXx5qeZL1F9c6K4ZECKEnMC6w7FN+HkU6rY8n4qJbz
	so6/WvxuAMQJ2iJstSBqEpIWtkpoAKRIOW5Ljtbc07dr9+7GGox4kf1hIWsSloAwzN5OjW
	awMoP/ib9Ot/TaJY1/yXYB2mXmdKMz4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AggffTQ0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 997AA20536;
	Tue, 28 Jul 2026 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk0e40MdEPMEmBvUfjT882PvwL+5RQo883zOtWeorUw=;
	b=AggffTQ0B3e6eoNOhg6zONLzosVAgj6hw7On7BiLUpUKlx2r3Y6zdQilW7/+aiYQjdZVZV
	3bVBtQ5NjBcDgKpCjB8RuWDCZud0VGOKq9OcaELjrXnpdZbG2KhvIf2kvSKd/S56AFQcsk
	BSjvgCCxhElQtSTqUZEQQrYrlEmFUbQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:10 +0200
Subject: [PATCH 1/7] alfred: gpsd: show unix-path option in the usage
 output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-1-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=sven@narfation.org;
 h=from:subject:message-id; bh=U4Q8+rCboQ/irQt0VrxuXkRvgkPO4B1nO5P0UBnBmOo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61umu5xq+aMqd2Lyq7vLrTcoVEzgVVe1XRB/olb0d
 NqqNX1LO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT+b6XkeHJu4pTJpqR3CKz
 Es7H2qhmFJpWiygdFWUz2bFtXdMk11ZGhp8nmOUNEztZ99udZ/zYwd4slXr9Y33l1uOJRf1LY8T
 vsgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PBIS5EKOT565TAQK72JJRNHV3JWSVGUL
X-Message-ID-Hash: PBIS5EKOT565TAQK72JJRNHV3JWSVGUL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PBIS5EKOT565TAQK72JJRNHV3JWSVGUL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

gpsd_init() accepts -u/--unix-path to select the unix socket of the alfred
daemon. It should be documented for gpsd as it is for all other clients.

Fixes: 6c6a6f735054 ("alfred: Make unix socket path configurable")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 04f7a46..4a00526 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -354,6 +354,7 @@ static void gpsd_usage(void)
 	printf("  -s, --server                start up in server mode, which regularly updates gpsd data from batman-adv\n");
 	printf("  -l <lat>,<lon>,<alt>        Static location\n");
 	printf("  -g server[:port[:device]]   GPSD source\n");
+	printf("  -u, --unix-path <path>      path to unix socket used for alfred server communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
 	printf("  -v, --version               print the version\n");
 	printf("  -h, --help                  this help\n");
 	printf("\n");

-- 
2.47.3

