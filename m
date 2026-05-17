Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE7CD4F4A
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 16:39:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A9CC85A26
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 18:39:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779035966;
 b=CLvFcxINHDt1BihY6TQVKAH+eTkIAV9zoL5XqHOTLlF77hbCvVOzsN0TxmiXtVLYQekwA
 jcXqGlrKqcX+nxnniDUN3jyoCpAwCPBZwjWxE2anLJKP8DgrTSluesEDol+WysH9SzGB2su
 HQvVoawP7FIrXI3YHiG0OIO2iZM10KM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779035966; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9jtEqAPq5w1+jKce0NBLHHzS+MTs7btBRUWZwu7xdpk=;
 b=Jp4Xvr5J+vCJ0I28/xtj+cn5nR1nQQlmI/pw6kMALaHYEtDB2/gfJ02I8oFrcGFSbGJmR
 1lpxfjUmFr3zaRZKS4TPBJhc9iyPUzKtL/dvksVkQ1PKIsAJgap+SbG3V0uDIVtAVpyoTgL
 UxSNHXsPDAWjwAKY7vzPRicbmrwTK8c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0ABD8846A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 May 2026 18:38:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779035937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jtEqAPq5w1+jKce0NBLHHzS+MTs7btBRUWZwu7xdpk=;
	b=pg33pXxIxTpPGaPeU5TEDloFq1ECe4+yxaUP+8SeyfmV9kf/R0N9mOx+MXzZH3qE994JNY
	7GgA9wMKUYGCTbW56Fthc7nxE7IyXigS/H8k2g7etwzEuU7tOmbVGsjlx9GJLD8DLYr0n2
	nu1bEGrlMlEA9wFFE6OYduOfrPZHnLI=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779035937;
	b=y696LxzMR3fjRscHeawNS55+PLQgcWRJP6M1EUow/hhgwtbFcp58/iU9Jb5gTAkXfqVjwE
	9iSxKIfxMJAs5HTVB4DdDVOB9WjhOay7lEvYwFGG3bGtff++STh0Ufp6/k7/y1S2A67P9F
	K4nGVRTpv7huAHSp9oTQul8Tk8+7lwI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6FB8754C849;
	Sun, 17 May 2026 18:38:55 +0200 (CEST)
Date: Sun, 17 May 2026 18:38:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: mcast: fix use-after-free in
 orig_node RCU release
Message-ID: <agnvHQNOj2Sn7Thr@sellars>
References: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: M7I3V5FRR6JTZRZVNEPHOHSOCVXOUCHR
X-Message-ID-Hash: M7I3V5FRR6JTZRZVNEPHOHSOCVXOUCHR
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M7I3V5FRR6JTZRZVNEPHOHSOCVXOUCHR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, May 14, 2026 at 07:41:38PM +0200, Sven Eckelmann wrote:
> batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
> does not wait for an RCU grace period before returning. Concurrent RCU
> readers may still accesses references to those entries at the point of
> removal. RCU-protected readers trying to operate on entries like
> orig->mcast_want_all_ipv6_node will then access already freed memory.

This one I don't really get yet. The mcat_want_all_* lists/entries should
be spinlock protected (&bat_priv->mcast.want_lists_lock), not RCU
protected?

We don't use RCU for these lists in the first place because within
the list changes / spinlocks &bat_priv->mcast.num_want_all_*
atomic counters are increased/decreased. And these atomic counters
are then used in fast path. Not those lists.
