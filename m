Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8EFFF886F
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 09:00:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BAE1A85565
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 11:00:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777798809;
 b=fcZBItZFNPzWgO1DXnUVFsuodD0GpzS0lpnMu9eCX331+9jKdV/AI62rBBK906q3fZ//s
 w281JjONE6xiXKafm5wzh0T7LA+7Ib8heiGO/9Pr27TChr8Dl1NzEKrqiicRq8lZ8MVHk//
 wrbbhv1EjdeBPgVwSlV/lOd3fYBlVH8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777798809; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
 b=Zq0+z0VON8XuQCaT4CeXymW0cBOJ+jiL6ZXgSWeG/yiA5JjzxOe79gXxqZH8me202dYlL
 325XLWpxdOIrwZhmfy81ssTNErdF9DdLvfV87xot87ErhG6LB4M7vR7KUHGT8WG8yPkeSM/
 zQPhguIO/Jq/zZnDSiGs/1G8OHHENDI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=linux.dev;
 arc=pass;
 dmarc=pass header.from=linux.dev policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=linux.dev; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=linux.dev policy.dmarc=none
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9211085327
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 10:53:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777798442;
	b=q+ceyPxCsgQSo4wQDog0f895TXyKy6H/CD7vG+0WpCf4pyieCXnsZyPvCsZJbOuUnyEGej
	GLPkLqYcNJ+FeifojXAkYjJK36vjpfEROcGd8q3RSbqTVT3rGI9uUO8bZKktxW55utF+sZ
	RXpJGPvWETZZLXrWuY+zbi6GDWP8+ms=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ZUGLidhi;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (diktynna.open-mesh.org: domain of roman.gushchin@linux.dev
 designates 95.215.58.187 as permitted sender)
 smtp.mailfrom=roman.gushchin@linux.dev
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777798442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:dkim-signature;
	bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	b=ctc+aPBFDRq7L4aeg7r97iYngKN90dqzGL8YOKQazIVIzyVy/Tg3/gXdnkq+lqWg7WIL9P
	MDZUjWTm9B9ztU7sJnAS4E3TUq+MLS/y4imW1Fp0mhhe5pifULy8xPBqoZAtwS5X71+uo1
	oQ3bxx5bcwwAmfVPm2PpME+y8YnrntU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777798431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=yAgBGauhItVyr5yyb1nDYByVFoSZhHduED1fEoG570g=;
	b=ZUGLidhijoJB69R8DH0HYnyFbQWMYPdpUXmJdWD8thkB428vt6ZEtg4soJzSO1TPW88Xnf
	+jh8HcHm5PpCQ8UcJbnLttsJ8ZJxwOF5/3Q9uQBL0+YvvSohIgASq88VS9uBYEplJiHKEG
	AXACJv1FNkjqqklcFerPYCHhpVYEI20=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn,
 wangjiexun2025@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions
 during teardown
In-reply-to: <14078459.uLZWGnKmhe@sven-desktop>
Date: Sun, 03 May 2026 08:53:29 +0000
Message-ID: <7ia41pfslvqu.fsf@castle.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-MailFrom: roman.gushchin@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: SW27MD2N7GCCRZF5LCFVKAGX477SK3AW
X-Message-ID-Hash: SW27MD2N7GCCRZF5LCFVKAGX477SK3AW
X-Mailman-Approved-At: Sun, 03 May 2026 11:00:06 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SW27MD2N7GCCRZF5LCFVKAGX477SK3AW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


Sashiko's author here:
Embargo as a feature was requested by Jakub to prevent people from
posting 10 versions of patch per day. Currently all netdev patches are
embargoed for 24h.

Re writing feedback for reviews: sashiko support sending reviews over
the email. It's an opt-in on per-mailing list basis.

Some details here:
https://github.com/sashiko-dev/sashiko/blob/main/MAINTAINERS_GUIDE.md

Thanks
