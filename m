Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68506CD37AA
	for <batman-adv@archiver.kernel.org>; Thu,  7 May 2026 20:57:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A087585C05
	for <batman-adv@archiver.kernel.org>; Thu, 07 May 2026 22:57:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778187464;
 b=fWD82g1JNKuNX6DKaAxMSd43M2Pwz8YEO1TTIaTM/4zFsqUBifTBJBM0EzlUqUmlInA24
 OdnIR6nJ+KKStLd2XGxKHJBNeXDWP8ve42C4VPJDOcxLKpheD06x6GCZ/NH8ISM7i/Ag/Va
 IPjXGtDFgPJiRqYGzHUyBEaRA6vxhfc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778187464; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sDJLEQFq4xW1obvMFv3XH4Ldn5o/0Tg+hnOb+zRZDEk=;
 b=F3/gbDnYMw6Yyooliz4ZNTEu5pmOch3ARVkU8dDiuzP3v4v8JSbfTzd4ebliH+/ixl7V+
 2ywCdtFhGImrJuA5t5S6v3S3tgSURQrZt1cU9gF+MEeQye3uTXBkiBtTxufXCekeffrYmi6
 PT12fwrggLlRYb+H3WeS22NQVh2X+1Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3E22F85A7B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 07 May 2026 22:57:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778187456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sDJLEQFq4xW1obvMFv3XH4Ldn5o/0Tg+hnOb+zRZDEk=;
	b=ZL1S9NAK7kiUoK49oIUKR1irSnWzeP4xeFC5LVF9LxLRbLSoFbWX6/EdOEAhujBuvKRu9b
	vWrTmRrev4gIFBwhATQN+AdXMOLVTGCTCodtvgnjUylFakb8JevBtyueyh5QBmhk4X06Ba
	Bsg217v+3SewZ9BI1yBAUHYlQ4T715E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="R/Hf/hdj";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778187456;
	b=Gwucypur5gH7XycFS39XmQdTjshqfDV10pfGAQGvdVYXFKXDEOOOm5hVNkDWeuqB3T8Y41
	bLXAJMQUwPkzFYSnL/d892NjnoUnU/M54ODEv4E2GdJHRnPg5WgDQKd7eQL0LE1gCcZogV
	X79PvUoHnJ+mYelZoa5oZ1zI/IjRmXI=
Received: by dvalin.narfation.org (Postfix) id 3195520DD3;
	Thu, 07 May 2026 20:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778187445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDJLEQFq4xW1obvMFv3XH4Ldn5o/0Tg+hnOb+zRZDEk=;
	b=R/Hf/hdjw0y+UELP8T3Fg+VxzucNzyg/X17+ck5ZLPs28DbgX+un6i6Fb+cB3JHbmWcMHX
	NjHOlyGmJqHkK4yUKl7eYAiuWTmRpdYxqIWGf4RKyA9bk4OszQxldYxcPbOuiTfFG74AMn
	w+RdTl48V6iLnm49OZg/Z8kx+wZ9TI0=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH batadv 1/1] batman-adv: fix tp_meter counter underflow
 during shutdown
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, rakukuip@gmail.com
In-Reply-To: 
 <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
References: <cover.1778118303.git.rakukuip@gmail.com>
 <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
Date: Thu, 07 May 2026 22:56:49 +0200
Message-Id: <177818740941.228652.6887332849423368018.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=sven@narfation.org;
 h=from:subject:message-id; bh=t80X5BPUGmVpO62XoQ1ic3S9abIWlczIk/GA+oTjLyQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJl//szpFZu+Mcjk0/yLfLVGy/f7PXjbcnxKdceuMOdb2
 uz6tvUPO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATUdvG8E9hmtmmuCdxrqX/
 55jI1a25acnWeqxAid9sqX/JjY8HLzAx/C93OfhK0e7je/bs4Ffbf3y0PjJnb4S1dOpBi/32i7r
 PvuMBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QTNG57G5XXUHC4WD3VRSMRWZZAS2JBZQ
X-Message-ID-Hash: QTNG57G5XXUHC4WD3VRSMRWZZAS2JBZQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QTNG57G5XXUHC4WD3VRSMRWZZAS2JBZQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, 07 May 2026 23:49:46 +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 2e42f6b348c8..4c582443f67c 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -435,7 +435,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
>  static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
>  				      enum batadv_tp_meter_reason reason)
>  {
> -	if (!atomic_dec_and_test(&tp_vars->sending))
> +	if (atomic_xchg(&tp_vars->sending, 0) != 1)
>  		return;
>  
>  	tp_vars->reason = reason;

What about:


	/* ensure nobody else tries to stop the thread now */
	if (atomic_dec_and_test(&tp_vars->sending))
		tp_vars->reason = err;
	break;


in batadv_tp_send()? If shutdown is called and then batadv_tp_send reaches
this part, isn't this also ending up at -1?

Regarding the netdev mail situation: Please don't send it to
netdev@vger.kernel.org directly - they want us to first handle it internally
before forwarding it later to netdev. This should reduce the patch volume for
them. There is already a change to the MAINTAINERS file to remove the
batman-adv paths from the NETWORKING section (netdev@....) queued up
- but it was not yet forwarded to net-next (and I am just wondering whether I
should ask Simon to directly submit it to net).

Regards,
	Sven

-- 
Sven Eckelmann <sven@narfation.org>
