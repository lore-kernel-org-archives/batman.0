Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D88DC55822
	for <batman-adv@archiver.kernel.org>; Wed,  5 Aug 2026 07:13:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6EAC481048
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 09:12:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785913978;
 b=4Iu1dzX/h0YlLxqm+u4uJ+Ha/9E5HiX940UX8peuwAQvMydhWV0cCObEM+DLrH8smhn9F
 j4jAUDPz322eTOL3l5kYmbAclVDwLCwvyCzDT4X/li0oNjoOFBcHxWuwWR/ng/UwG6QVoWI
 UZu/6g0HWWrbjaCy/aqPILQmBIr7m8I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785913978; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dRn25rA8pRhHV7j7OOHZkznWpNz0DL1keWBDqDEmtbI=;
 b=LGd3k8ThzueiLlaVwfnJFkVUW/OkV1tqZT7IBKv1GQU5MoZEHX4yDurtJQ7SqRSP9a+5s
 U6hxTfBsIzF2ePUqRhGNTmEHJBYmXFBlmuZYIlZQuKtghDuxGqVx90sIAaD3IcfE2zxWaYx
 KDcziGceQST3GKqTN8NGZJeSHcj1xCo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2B69C81045
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 09:12:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785913961;
	b=M45JJA6Be+rM7XzlR7ldFtmioqLsVjP5UaTh4eQ191WLUZHZhNWqodvVuoXQd+sjFfLjq9
	ueKoaQNh3mJzyw37493q9b+mhHimy2WYOD/5emYU/7dHk7MEDnfpDE3b4+MIdyDpVaJN37
	1EhDL7yxsoFEkln+N9pCLmvpK2vGpus=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785913961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dRn25rA8pRhHV7j7OOHZkznWpNz0DL1keWBDqDEmtbI=;
	b=g7qqYOG06YPPVjDo4yIRvVdtNeMFTAcmALMaTVkCnSIhR7OedUtmbVqz8o34aawV04J2q/
	enrcHsNnTJEfEYn6kRSbVmpC7Raf51UP/CFoS38ij4xAvJHi4VR9W/rWw/IsdhE9uISoUj
	0nSCRc5ssah1qdT9w98efN5zfZs4uDQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nHl0LK2y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 616122019A;
	Wed, 05 Aug 2026 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785913940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRn25rA8pRhHV7j7OOHZkznWpNz0DL1keWBDqDEmtbI=;
	b=nHl0LK2ylMMihAR51NljhlHYKn/qput6JlTohguJBR77zQpboll4cxDXIBB96yzbcmY3sH
	vsh7GTen3R6eQy0NMRewWHB63oI86sNRMONE0jhg+KdJM/bxgyOmJRG7Ghzcs2wEJf5ZXr
	UAYE+esFSDVgsci+yPbd7UIUHYimbt0=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>, b.a.t.m.a.n@lists.open-mesh.org,
 Minhong He <heminhong@kylinos.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260731023333.70727-1-heminhong@kylinos.cn>
References: <20260731023333.70727-1-heminhong@kylinos.cn>
Subject: Re: [PATCH batadv v3] batman-adv: handle errors in batadv_init()
Message-Id: <178591390937.9129.7114714614518787682.b4-ty@b4>
Date: Wed, 05 Aug 2026 09:11:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=287; i=sven@narfation.org;
 h=from:subject:message-id; bh=b+JrCM3sz7Kj5i5xi9fqKoY8rKs0PKP36wfboJ1a5I8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlFj9yS1nAsON8RKfn1xqNfSRffte9sslYp/OPkdHfHu
 pm7Z3K/6ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJFCX4X/ZtBy5OzqSzy1D
 +Xco/Su99vXakn0n0vy3rjY923Zpf6chw//SvOdXK4LEpxrfeXz9CqtjzBS5/jXb5E9zfTz+r/j
 TgmA+AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HRC7T3475OR65C4QLQJ7SZGEZMUOS663
X-Message-ID-Hash: HRC7T3475OR65C4QLQJ7SZGEZMUOS663
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HRC7T3475OR65C4QLQJ7SZGEZMUOS663/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Fri, 31 Jul 2026 10:33:33 +0800, Minhong He wrote:
> batman-adv: handle errors in batadv_init()

Applied, thanks!

[1/1] batman-adv: handle errors in batadv_init()
      https://git.open-mesh.org/batadv/c/085a4112165b

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

