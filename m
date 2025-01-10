Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A1DE7719D
	for <batman@archiver.kernel.org>; Fri, 10 Jan 2025 09:02:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 40D5C83FEB
	for <batman@archiver.kernel.org>; Fri, 10 Jan 2025 10:02:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736499771;
 b=MP1rx8Z0fQTKPEsRCMFv6wu0/IZCCisRiNMgY166gPhH3aDMJ6f4hCnqNXlTxCw0HN+Bu
 yMZfyDz6DVGvfTKow6VeDY7Xbbp/hP56jQyfGYezwdz+13w1L1sYlbExk9Ez8uF8JdOn7sT
 3wtT8JZh23JX8uuxlu04+hYlT0aByxw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736499771; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YqQZ6NTB044RS07QcQFC6ePNntljXlc6ixqpUpsQyIA=;
 b=CQp00mmBwj87DfLygCQpl6ZQUBPVC8xRgtwmOb8xn9HbngwN9RSBwohca0T0Qxte77AFh
 Mt60YIoLsYzutgzNsUyGahy7m6jGyIwqW0i0orhDcwzDntlqLaYHTEDOqSk68rFFOYVSbus
 p/2z+KCsOtmsi7INWHSe1+3apNV0Jgg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9831C81242
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jan 2025 10:02:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736499751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YqQZ6NTB044RS07QcQFC6ePNntljXlc6ixqpUpsQyIA=;
	b=aQ6zCYmaB+38RUoDFSCpnoHvD6ZMZLYvAOi9K5uu0txilC3XhRq59rvxghQoUGkLFikDlV
	ObwS4vVPK8ve+JNo88Is9tITJ2HsWUDdDprDeI7pDuRi6Tqr07OE5kYlRe3+jKCmLaEu2N
	mZdoA71mzfPKxspxq7oCgT/7odh+8lQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=HF5bvtyt;
	dmarc=none;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b35)
 smtp.mailfrom=andrew@andrewstrohman.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736499751; a=rsa-sha256;
	cv=none;
	b=mF+LM5hs2XtJG2g/RS45HwvyWJiXkBGQ1rRSZ+IkLyT9O567gXh+W4jI6ZlJahrsbUNUH8
	A6Jc8DPE3Db+Qcs/D6GqfoYEeJWSad/T76iTZyVy3WRtV5WcGQvTfcjgPALK69/iTCUTX3
	vmmKp+gZ0vZrGY9Jinu+8QAelCfV23s=
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3c9ec344efso2846637276.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 10 Jan 2025 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1736499750;
 x=1737104550; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YqQZ6NTB044RS07QcQFC6ePNntljXlc6ixqpUpsQyIA=;
        b=HF5bvtytCLuRNveGlpnAqqM1Xcxu9nFA0yQqirdFhUtyk9+8ZseuUhGz8OmYZo0RXX
         JpGIWqJAwuWUGKc4HCZSFoy9hiO22rqAANGYucMHDoehoHF+B2UOj3sTtdrgK6b7aA/r
         wKlN4Ycp4ed/BuRVv3IyFOPGx22wF0ElmffkI8KMjV+zXLn2HHzFBLi/Px+/ZJ1F9pcy
         ffZmE8qvDd/EgYN6X0NG317FTf3QvajnkppXhSeyScdB8jB0WjCD+fqnWZ9mmSDt1Wc1
         1NaqioaDfdAltfl56X1nAEm/aUr4SGW2z9qtS+oZYjBr0dmHHEPe/gpHAcxI6d8TJsWr
         8zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736499750; x=1737104550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqQZ6NTB044RS07QcQFC6ePNntljXlc6ixqpUpsQyIA=;
        b=aDSrXCWyYZfRlUXWk1EvR7mSZExQWkGMFPobp5tiTubbQMw9nA15Djh64p7Sz6tYYc
         seQFCO7A/Ry5If6GRIuD1q+r7vziBnVcuKtTapo0MUH+y7h0JkaXN6aJlmW9/0ss7ctM
         6uJAjujuBFSrvsU75XyBxkTplGuraxtfDoYZgNs4TIKaurvPU0znLpG7SJ9c7RLC6eCw
         iTEavwfwOrU9jvCX/DWU+/leUjWANe9xxeOS6S8EZhd+Yd5MvIFsLLsLGB3431Pmx3zC
         +2+IU2uvUKaeTBF1RflWnJoTqsaQzV39Dt4b3aMvu8I090JSPXyEsQPQyzwbjY5/ibt6
         qrPA==
X-Gm-Message-State: AOJu0Yx7Iyhq3qVHbV1pixRG6F86VlhtvWtiWP9zTYIT65Nnt3llUqIU
	oCA7wImUZ1wYFS37h3rklS/L9/WQleb8LokEbFgDhRE5lqom49NExLsc6EcJuk5nbQwHKRkIRmf
	rztZGXBX+ihAb0+2CiG/rgC+/0POPujfb9W646IxbRS/Q6fcdvM4=
X-Gm-Gg: ASbGncugNS4K2j27GaG66dZvjmETjNSpiH4mzrYvzfuVYF/ZBmg8dyqIdxHZK/QyCSY
	XGoX6f5py7mzlXA50oyYQlm0vEc6o7jLIxiQRxw==
X-Google-Smtp-Source: 
 AGHT+IH6WBx/idA4E2ROuVNVBtqgZM6aoT7CvuuQGTgR6MBxPvNL6AfUxdzA/ojQCH9Jp9yxJ7YK14TS+pkNY90Vn/A=
X-Received: by 2002:a05:6902:1581:b0:e4b:6ef6:e7bf with SMTP id
 3f1490d57ef6-e54ee20d5b9mr7631537276.32.1736499750229; Fri, 10 Jan 2025
 01:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <1882889.atdPhlSkOF@ripper>
 <CAA8ajJkhd=CaNoqZ+juKHh8PV975s_vEfLU4xLfwn-Yj+caEPg@mail.gmail.com>
 <5533653.Sb9uPGUboI@ripper>
In-Reply-To: <5533653.Sb9uPGUboI@ripper>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Fri, 10 Jan 2025 01:02:19 -0800
X-Gm-Features: AbW1kvbc4rkOonfphm7JoVr12BoixxElD1ceNflg25lJqd4Sk3ZIMmPrjR8NgQw
Message-ID: 
 <CAA8ajJnVQWO3fhLAjQtEfjEVReY7x-==TEkhrKQKZMrVJms44w@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: OQ6Z5C3WCJMR4ULBWJQJGDC42V4JO7LC
X-Message-ID-Hash: OQ6Z5C3WCJMR4ULBWJQJGDC42V4JO7LC
X-MailFrom: andrew@andrewstrohman.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OQ6Z5C3WCJMR4ULBWJQJGDC42V4JO7LC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> I would prefer when you would call cancel_work_sync when metric stuff should
> be stopped. I was expecting to see this somewhere around
> batadv_v_elp_iface_disable after the cancel_work_sync but it seems like it is
> missing there (or in a similar place)
>

I tried this:

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574..b35ded79 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -387,8 +387,20 @@ int batadv_v_elp_iface_enable(struct
batadv_hard_iface *hard_iface)
  */
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 {
+       struct batadv_hardif_neigh_node *hardif_neigh;
+
        cancel_delayed_work_sync(&hard_iface->bat_v.elp_wq);

+       rcu_read_lock();
+       hlist_for_each_entry_rcu(hardif_neigh,
+                                &hard_iface->neigh_list, list) {
+               if (!kref_get_unless_zero(&hardif_neigh->refcount))
+                       continue;
+               cancel_work_sync(&hardif_neigh->bat_v.metric_work);
+               batadv_hardif_neigh_put(hardif_neigh);
+       }
+       rcu_read_unlock();
+
        dev_kfree_skb(hard_iface->bat_v.elp_skb);
        hard_iface->bat_v.elp_skb = NULL;
 }

But it seems to cause a hang on reboot every once in a while. When the hang
happens, I'm not able to trigger sysrq over serial.

I can try kgdb, but that requires sysrq to work, so I'm not sure how
I can gain control after the machine becomes unresponsive.

I'm not sure why there isn't a watchdog bite when this happens.

Andy
