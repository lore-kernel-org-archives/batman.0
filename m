Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56EC53200
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 15:38:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3CD1382F80
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 17:38:36 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785339516;
 b=cdU+K9UOj53vDoiwIUSVwDJNUNNaJ5gPtLHecReiaBnWMNw2BGc6oEOOLnh32v4Q1bhtC
 zZZDxqEr6cffvok1QgpAqV0WVywoDvLF+j4ZH0fUOwWLTRwclHMQvZKKNAdgqpODl+6OAHm
 fCkErTfTaDhP9PDZzIGiUuaxve2iXtY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785339516; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=88tItzqaAxrsVQ5glfH+qcJeGmZ5GkFUmxEoEyI81V0=;
 b=3iCHKtcztO/D9PFNWJmv7NsGv64lyp5X24p8PiYvSG+iPS799AydFxnLHT/k5YE2gB+U9
 lg1cQ4QxxM19BoFxK68KN/sZFO2UeYp6FYqg3iau/9GM80toEDkOIqabYNI2tEdtUBMbiRR
 BeJwuvD430tS0WB91iXAZEOmkwiiAEM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4F8DD8059C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 17:38:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785339495;
	b=KQp+ftQkFom0Kk+K34M1Uk1wiGHVvqxW5+KZn/yBHFDM6qYARXQgzQQKLrk1kFykqJa7wz
	c3CEjz91fddNlF+kFhDsvYhqq66+t/GGbvf59Q+Jd0pxNCDudFk8ZQm8n9417k7KyhIDdA
	P/LlSD6T29vImJgIepoWtoG7binyxG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785339495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=88tItzqaAxrsVQ5glfH+qcJeGmZ5GkFUmxEoEyI81V0=;
	b=wShVs5SUnd4OUawE5U+fc6zg9TEC8pjSnubuSorznmx5GygldkdIY38aX6x1RVIGKtQSSh
	46P0H5G+X1dkTdBQvsxf4jkw5Xx8eo+CJWYKjSB1F7U8Y9pIostSbZutDPqHdRZU4kevNO
	m1vxpio+z/UTeAsJu9ZmV0yNPKvwadI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xyOWfAB0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B80831FDDB;
	Wed, 29 Jul 2026 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785339478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88tItzqaAxrsVQ5glfH+qcJeGmZ5GkFUmxEoEyI81V0=;
	b=xyOWfAB0LBW57zOhwm5dlTBnZYBCzfaCTRWJi0XfSa61mda0XZseLIAM0OtZiDvlxKcz8U
	9WWftph1HXf56MJpdUW2K+QicdsDH/JSW1zqM+dyCO43wbabYmTYJ09an0QL9+qDgWwwid
	oy63nKFfd5jx7t+e9wb4DmuW2p+2Eck=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] batman-adv: handle errors in batadv_init()
From: Sven Eckelmann <sven@narfation.org>
To: Minhong He <heminhong@kylinos.cn>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260729084435.128142-1-heminhong@kylinos.cn>
References: <20260728031050.76643-1-heminhong@kylinos.cn>
 <20260729084435.128142-1-heminhong@kylinos.cn>
Date: Wed, 29 Jul 2026 17:37:47 +0200
Message-Id: <178533946744.235865.9920756941934744327.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=sven@narfation.org;
 h=from:subject:message-id; bh=dhKgfzDzKbnKosN7hqc0r9tB1YoQTFpz59Cvyr/nG0Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlZckEa/6uvhQRF6Ced4n1ldFo92m1noN3JwycY3N7+i
 b/n1fy+o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAnCRQIa/EvtsFyuZ33lzcMrU
 vxUyed1T3fP3Zu8T7eq+c+vG/USLPYwMnfZd7amfv4n9vszy3I63Wtoi8v+ChE6jLKkXay6cb2B
 lBQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HX35XJQG4K7ZZBJM67Z7IYTSRYNLEXFT
X-Message-ID-Hash: HX35XJQG4K7ZZBJM67Z7IYTSRYNLEXFT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HX35XJQG4K7ZZBJM67Z7IYTSRYNLEXFT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, 29 Jul 2026 16:44:35 +0800, Minhong He <heminhong@kylinos.cn> wrote:
> batadv_init() ignores errors from several initialization helpers, so the
> module can load without those registrations in place.
> 
> Check the fallible init steps and unwind prior initialization in reverse
> order of acquisition on failure.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>

Please don't send new versions as reply to the old version.

"batadv" would be correct prefix for the batadv.git repo at
https://git.open-mesh.org/batadv.git. So something like "[PATCH batadv v2]"

>
>
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 73becb0549488..8fe8a2b27a744 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -94,35 +94,63 @@ static int __init batadv_init(void)
> [ ... skip 52 lines ... ]
> +err_wifi:
>  	destroy_workqueue(batadv_event_workqueue);
>  	batadv_event_workqueue = NULL;
>  	rcu_barrier();
> +	batadv_wifi_net_devices_deinit();
> +	goto err_iv;

No, this is hard to see an will attract the goto raptor.

Feel free to move the "ret = batadv_wifi_net_devices_init();" before the
"batadv_event_workqueue = create_singlethread_workqueue("bat_events");" to keep
the reverse deinit order and only have a single rcu_barrier().

-- 
Sven Eckelmann <sven@narfation.org>
