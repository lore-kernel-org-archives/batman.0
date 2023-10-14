Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A3CDB465
	for <batman@archiver.kernel.org>; Sat, 14 Oct 2023 13:07:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B65D822D8
	for <batman@archiver.kernel.org>; Sat, 14 Oct 2023 15:07:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697288875;
 b=Zx7EUVXPB8tVEM1SAtRqZcMnZMFQAQJhbZHpzm4pKkwtkd7RmebHAYCG1DbBYtDdzTOG6
 sKOB2/a4+3cu8Oae456N68xvTHqAOQost+YJY8+RPfLx+JHShQVsmc+1B+gQBTdu07BaU5l
 Sttu2ZdD5VRHbuy6O4LXT8pC77VZAGw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697288875; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1/6ceZHQviZHWBwoxE7adPRErfGv6u0OyUKTGWcI8bI=;
 b=iHlg8BCe19aX8hs285n/P5JbvFLuiycgg9+O/+tQXlF5eIspS8200jk/flKffD0oQ0eU1
 G68pK2KLdzQTpl9cbh0ec9EKIt406EMOBeAMhYHISwZwVqu+B+5CK8HuwXySnHBKIw9SRtA
 lgEjDB7iqCY/SW4HgCMIBze2n5BrLHY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 662F88007B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Oct 2023 15:07:30 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697288850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=1/6ceZHQviZHWBwoxE7adPRErfGv6u0OyUKTGWcI8bI=;
	b=ESbhWshTWXw8ErLkQaUfei0m4JA341dvH9Z6Rk14/nrb2GwdyQnfwmOT+Ckldg2kz5ZEgS
	VCVE5VAfspvWXf0jbmV477GDofOswTZgohAEfhLafb6JPJF+YclzzW43nYEjuFR8X7LZxD
	IWkDqUrxgh3GBCaJFEpdpVFn75vXVuo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3kJIqZQkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.160.69 as permitted sender)
 smtp.mailfrom=3kJIqZQkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697288850; a=rsa-sha256;
	cv=none;
	b=0OJDBv9GeRt9UffAOR9bVb3i6Lt4Qu/9FKfx87Qn7NRHuyCtFGGRa/jOVsBeQTRnFxfAk/
	xli8VZOnLzqq91/Xn3s447oMeyaGf9c8SJwsTPZ0+HR863Ibe8nQ0+L7EpitdhXAGSwAHK
	7i/pPh99XaXq4xBH96RqFMH6D8ywIo0=
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1bf00f8cf77so4118575fac.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 14 Oct 2023 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697288849; x=1697893649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/6ceZHQviZHWBwoxE7adPRErfGv6u0OyUKTGWcI8bI=;
        b=GTclP4UemXAI7pAw07qPdACQPljmjkUXmYo/YPH5TfVf30eAtWY0xx4sfPQ+f14Zhq
         lHQ89yQuysLYnkSn2yqxf/EUgcOKSLehBcY5dajbEgBjazlZjIXBeyd+M16lzAgA7oL+
         q2qWrEJK5wrCE4u4y7vBmcYmTQ6LjxDnJ8B7vn+uXau9PSTBekjjRE+dSuICw4yH/2V/
         hx0JyV3NrdwVlRhNU15TFPpyPhpF9dqZPDMFqCjUhGzMFunCt9dE5WFwsfb27F5F0xzR
         ADaSMT9Vof2b+maCqlBB5hc0OWQs8xsfmSJgpQuaMN99H1ZgInvqyg7ge/O1jV0ATGEW
         bzNA==
X-Gm-Message-State: AOJu0YzImf+5hzRUmte+5eQAw+Bl3AkCgXwo8E+YHtBf5VTQjGeyRq/m
	NmL+uFVuUcmUAlRaLBA2V/9ZqaVvlFZjfPo+fLXx7jaLHVGm
X-Google-Smtp-Source: 
 AGHT+IEVCXmtDm4/SgXnVdwVBjmB+6iLQnnDacoQ6B2a0YxsIaEpL48b/OQOJ6nt9o5XmKqieSHSUI18COA2sWNw0RWueMJ/nlKJ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d782:b0:1e9:6b2f:5ad7 with SMTP id
 bd2-20020a056870d78200b001e96b2f5ad7mr4590286oab.1.1697288848970; Sat, 14 Oct
 2023 06:07:28 -0700 (PDT)
Date: Sat, 14 Oct 2023 06:07:28 -0700
In-Reply-To: <000000000000ea44c905ffd26705@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec9cb90607acdac9@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (3)
From: syzbot <syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org,
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: T7KBZYVOU4I4LKMZDBJH6MX4YSTKNK3E
X-Message-ID-Hash: T7KBZYVOU4I4LKMZDBJH6MX4YSTKNK3E
X-MailFrom: 
 3kJIqZQkbAI8BHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T7KBZYVOU4I4LKMZDBJH6MX4YSTKNK3E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

syzbot suspects this issue was fixed by commit:

commit e739718444f7bf2fa3d70d101761ad83056ca628
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Sat Jul 29 00:07:05 2023 +0000

    net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b26a4d680000
start commit:   d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=afb3084a933aa2bdacc6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15849d08a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13184990a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
