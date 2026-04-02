Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C3D6AAE4
	for <batman-adv@archiver.kernel.org>; Thu,  2 Apr 2026 15:41:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BECFB85925
	for <batman-adv@archiver.kernel.org>; Thu, 02 Apr 2026 17:41:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1775144504;
 b=2VPI0b4izfwaCaETG1MDj4fwPe0hSWncy4Aoqf7BTMeZerZkRS8CX/oO3vZMoZjNhnRHK
 VTwTcKw/yEXwDxwxnU8/TWjJQpav6YIer/8LfzCRJgJIXdt1ZrmHT3cdrimqk89yI3YbpP2
 wG0iFqM9zXA5X6NaEmXxr0j5Imj/Ln8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1775144504; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HMLKN6+DFzl+KveR0ngqcK+e+QLEHyshk8tGIc9QbzQ=;
 b=vc8frCEx0mqXXaE8JMzgaSTzVSWNcqjPqFNqY5riSEn0JnQ8zq7KJoD4NfkuIr8ZPndDk
 sSaULRcuN9EYdoCrQjQQxWrao6uhdt2T3jT90yqnKwtiZql8VcSRLC8Z0lM9VT87vourLXQ
 w6yFYcHq+yJyb+0k/FjHVDa1w8xxme8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 57FEE83AAD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 02 Apr 2026 17:41:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1775144476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HMLKN6+DFzl+KveR0ngqcK+e+QLEHyshk8tGIc9QbzQ=;
	b=xGk1sb84Rc7+wU4Gq4/GOJin7fBlspYTmQC9y8/eixIJFILxzymYmokkd/fxfSqoFuENqW
	hyTRapjkPAAZxBC2fO7jnbB55OjF7qLTC/uTv0Fegc5tfohtfKOQCAXKBEQLESmm74ELSV
	p8MZzUSQwYgixMVhSQqTBdgPa6GNaiU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Dyb8LWcd;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1775144476;
	b=2Pyg4+ltUxor5kgQzg0BNLcGwNfH2lncrJtlvr6ugLVpYCnAgXqdtflS/coLqQziQ7w1Mh
	h5mxeU0MrXQFa2s2xlvcZtGQwFNO/mfGjgamu6wUYXrV77o92s3mDXIaFQxps6FraV//Z7
	gFEguE1LMmug3DOy/KSTXyWFY5+JJ90=
Received: by dvalin.narfation.org (Postfix) id 4C66020D7E;
	Thu, 02 Apr 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1775144475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMLKN6+DFzl+KveR0ngqcK+e+QLEHyshk8tGIc9QbzQ=;
	b=Dyb8LWcdbbOgiyhpzVg7petD/yM5XsqLAiNoyKpQuSeYN6jOApYKdwv1XZZQXA9kuDM2fj
	ZzzgXlpj89C/wOQI4k0Nc87Qkf5GynHJnG7RF/yVxnBhkUquB76M8WgjEM+ck87R7LDMX0
	bBuNWO+jt22t+JaRo5sVKSaqbYNRRVQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Ren Wei <n05ec@lzu.edu.cn>
Cc: Sven Eckelmann <sven@narfation.org>,
	marek.lindner@mailbox.org,
	antonio@mandelbit.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] batman-adv: reject oversized global TT response
 buffers
Date: Thu,  2 Apr 2026 17:40:50 +0200
Message-ID: <177514407836.3993083.12834978230665818269.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: 
 <f1ae21c92be31b48651378f1ceba0dbbb43c2847.1774947926.git.caoruide123@gmail.com>
References: 
 <f1ae21c92be31b48651378f1ceba0dbbb43c2847.1774947926.git.caoruide123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GNT23CGP47OFQUQW2ANB6JVCI6EANW63
X-Message-ID-Hash: GNT23CGP47OFQUQW2ANB6JVCI6EANW63
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GNT23CGP47OFQUQW2ANB6JVCI6EANW63/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Thu, 02 Apr 2026 23:12:31 +0800, Ren Wei wrote:
> batman-adv: reject oversized global TT response buffers

Applied, thanks!

[1/1] batman-adv: reject oversized global TT response buffers
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=3a359bf5c61d52e7f09754108309d637532164a6

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
