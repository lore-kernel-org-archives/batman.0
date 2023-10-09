Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D221DE95A8E
	for <batman@archiver.kernel.org>; Mon,  9 Oct 2023 09:24:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DC8EC81D34
	for <batman@archiver.kernel.org>; Mon,  9 Oct 2023 11:24:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1696843458;
 b=OGZFYqlHppsA1oKkvDTgcwG98BcvGvyWK9LKB7WIYQmmhvo57GPBx+5AGH7ryUvtpACWk
 YXKxQocGVqUwsr2xSXrqZX0mVyXDSbu/HMJwWqDoXK644zCDxjhIVUzlxXpu4bbbIcmhzoe
 zC52KuEEtT1L2OtetouW1v3GrMAvX3I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1696843458; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hPujDRn6mquV4gNuBOn8UaHjz6kc/QET8wVwYt94UoE=;
 b=sq0YATwlZc0ro7LZeUoH5hxJLExcY30SkKcZCl04ULAislIXccWRZVECyOfbrRcNAvToy
 B481hZw1cw2y/c3P/qOYkjYGOpf4C45v6zzrhCDXq1Cps+31jC9t/BNvDGFtYxO0rjhaUqz
 jLtxWDWOvKfVGhMA+NsBtsXfBXdNI40=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ACCF28041D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Oct 2023 11:23:53 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1696843433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=hPujDRn6mquV4gNuBOn8UaHjz6kc/QET8wVwYt94UoE=;
	b=VXloang0j2l/oSzvKx0iWORDUOMX74yMlUqzblRJPxP+d3pA21yWz+TH5bYvZqQCY/VbO4
	i3+jHb76vEVm/oiDWIC2W1N0CBv+HYrRgkVv5mtpeSMaqjfxLD+pHlohOG5wU6fCSZ0pdG
	E9TGFvnCSVzCKPRu7zonKUCMNqUFjMw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3qMYjZQkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.167.197 as permitted sender)
 smtp.mailfrom=3qMYjZQkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1696843433; a=rsa-sha256;
	cv=none;
	b=xdQF8xMTzvvpT9lKrmzwlMsKgvoMg968GHdJwp81UqaBOoZTEbRlrT4/KvnW1ZguO04he0
	EcVR5yP7AECRCA+fCHGpmpAKnakYQ0vcj83+OMHWBi+EINh2sGdx8PDeUXhKDXMRN9ohX5
	D2+W87xdpSHrLc2zO1BeTYnlakyhIp0=
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ae65e9d394so6244607b6e.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Oct 2023 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843432; x=1697448232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPujDRn6mquV4gNuBOn8UaHjz6kc/QET8wVwYt94UoE=;
        b=KDufcsPGonSmmIFN7Fb+9tx7TuxFU3PZBEW4Cxra79KXj94joRuZMB5/VRmyLPl0wp
         ExOCB0+l+WZTqQKpp7Xsj+W3wJmTZ5eEtrGkQeglXIhwb825tMMZyYkNV9YYgYmnlC0Q
         0xvQgbf5nh0jJF3CJ5SK8E8z9oHYN1e7HgIs3jmEzhASHwdoMAtlcnJLvh/NWzU5DVN6
         1IQSYCZ0Y22ZTsp0CITc4T6hqcL3OrSe1AzReMYSjZpbKloGg9g7sd4s8KCH9rZQXLB5
         1B99f0sHCudiK7NxljeeCmAuCbeSZtRiGFutasCWY9IUCffWoyeSpnVl/h6qrB/0wXFH
         ZAtw==
X-Gm-Message-State: AOJu0YzW4kgvHu2E/j8jwP7VBAeuRGH5S2K8uW2AdHSkQowupdfGXJEh
	HwJGNTtXaHQrWDDqgaqBeGDvjnEAR280pd08c4PAiuG27Sng
X-Google-Smtp-Source: 
 AGHT+IFn7BeMZbPq9UpSpWnsypz/Ixh2f8OpofsNTYYDSsEp2wb+6MTEBCLN8FYolbTDp8eOnaZ9OquBpDLdbMsmtCwRk8qgsSPj
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2025:b0:3ad:fe71:10cd with SMTP id
 q37-20020a056808202500b003adfe7110cdmr7702930oiw.11.1696843432454; Mon, 09
 Oct 2023 02:23:52 -0700 (PDT)
Date: Mon, 09 Oct 2023 02:23:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007f0d90607452652@google.com>
Subject: [syzbot] Monthly batman report (Oct 2023)
From: syzbot <syzbot+listbc635e7898634771116b@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: OHZUQVD5YINNI3SUCIR247CV6SIBMN4O
X-Message-ID-Hash: OHZUQVD5YINNI3SUCIR247CV6SIBMN4O
X-MailFrom: 
 3qMYjZQkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OHZUQVD5YINNI3SUCIR247CV6SIBMN4O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 167     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<2> 150     No    KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<3> 2       Yes   memory leak in skb_clone (2)
                  https://syzkaller.appspot.com/bug?extid=92f9b5fba2df252a3569

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
