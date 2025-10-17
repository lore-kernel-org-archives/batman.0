Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6ACCD199
	for <batman@archiver.kernel.org>; Fri, 17 Oct 2025 14:04:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 071C084C6D
	for <batman@archiver.kernel.org>; Fri, 17 Oct 2025 16:04:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1760709845;
 b=4BiXaYYUThdcK2S7KUzuoDMZbJ7Nfvh1U+1jV4plmqywgKTSYzrNWb1XrJ7x+nQzsRSKH
 EB8kkPDk8i9ni7i8mx9A9qqpFVOEzuLHyzL4vQ1yafg3Wh4ArgeJbhd+uHcG1G+WmSIfoEy
 jxWBzoSvdq+pQvkzX8qDW4XOgrjAJ0o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1760709845; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=o7X+Ca4jKDkt+8PJ+dH11dolAGnH1aWKo5ozZmGcVYs=;
 b=opUP7HtrU971neiqAOHMlzm2LwuZrqJbTfz2qQPe1j+Beu2MD4VCI5zydVTR2v8XKVisi
 /P70G0GhzGKBbQKUJoyrKO13yEYw6+odTzvVM/XX2iHbEiDZLolSBtaXpRovEYIIpcfL+ju
 nECq4hD2Jkbyw3fMA9WTBn9dVIIR6ng=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AF9A481DE8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Oct 2025 13:18:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1760699919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7X+Ca4jKDkt+8PJ+dH11dolAGnH1aWKo5ozZmGcVYs=;
	b=Yyiy8wTH6oB1y1BPUC1p+zh6YxnHKqwK/va2yPdZRd906GZ2EagP63r1lOnpwWC9iiKx3I
	hlTPd5/scxjGKjHmk+NHlAga2bm6RnOeXAMLfnOKXprzqF8kr5GD0l9PbujwmkW0LrJ2/Y
	uYMYDHT/YBg48TvPK+PyRVXptCvOoCw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 penguin-kernel@I-love.SAKURA.ne.jp designates 202.181.97.72 as permitted
 sender) smtp.mailfrom=penguin-kernel@I-love.SAKURA.ne.jp;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1760699919; a=rsa-sha256;
	cv=none;
	b=jnl1pa1lx6wOJOrd+1sVazkd4MsLKVuFahnrVwkREK/CrNzuEaMYp32BsvxVEJjjX9d3KC
	sdpD+VVj1u93DopjU2sM2dBu9pUoNt3jV+LBHtVDQ99Ro1xW4kQJfT6SO/bL7NPam2va/a
	vX3xtqhmoBdcBqqPypp9l641JJzDgWA=
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59HBIMw1032731;
	Fri, 17 Oct 2025 20:18:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59HBIM30032728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 17 Oct 2025 20:18:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6d8c06e0-4e36-415c-942c-7100c21b2de4@I-love.SAKURA.ne.jp>
Date: Fri, 17 Oct 2025 20:18:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] batman-adv: Release references to inactive interfaces
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
References: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-MailFrom: penguin-kernel@I-love.SAKURA.ne.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: QR4TTD2IFAKIWKRHS7YRLK4ANT3PMSBJ
X-Message-ID-Hash: QR4TTD2IFAKIWKRHS7YRLK4ANT3PMSBJ
X-Mailman-Approved-At: Fri, 17 Oct 2025 16:03:27 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QR4TTD2IFAKIWKRHS7YRLK4ANT3PMSBJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Is this patch recognized?

On 2025/09/28 3:01, Sven Eckelmann wrote:
> Trying to dump the originators or the neighbors via netlink for a meshif
> with an inactive primary interface is not allowed. The dump functions were
> checking this correctly but they didn't handle non-existing primary
> interfaces and existing _inactive_ interfaces differently.
> 
> (Primary) batadv_hard_ifaces hold a references to a net_device. And
> accessing them is only allowed when either being in a RCU/spinlock
> protected section or when holding a valid reference to them. The netlink
> dump functions use the latter.
> 
> But because the missing specific error handling for inactive primary
> interfaces, the reference was never dropped. This reference counting error
> was only detected when the interface should have been removed from the
> system:
> 
>   unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2
> 
> Fixes: 50eddf397ac3 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/originator.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
