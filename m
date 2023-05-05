Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE448C77B7C
	for <batman@archiver.kernel.org>; Fri,  5 May 2023 21:40:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DAF7B81CF0
	for <batman@archiver.kernel.org>; Fri,  5 May 2023 23:40:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1683322795;
 b=xHMg6Obte+c6dYqJAI1a7Os8AgA32dVrPNemUTE0K+GcHSYGTXzdeWp7C19tKCk7/Hb0V
 IJJYz220FnAC2QG5sigyFPzsqkWSgyA2U5OE3Db457JieNQ2nZRidIgBttjJE59wty+MpKt
 cX/Yx0FlC2aCf+wpS+eg0wB2PgxdfGI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1683322795; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iHxTdXWIlaIDUctYZGEjm1ywCtsGaf6cMRwYaTSd5aM=;
 b=eCZb8KvT+BfcCCVCDlta758te+lLnZ2tNQO30E3nAV60bJpqqZhhnsQ520iFc9jdBuBCV
 jfgayno5aDiI2IwoXmgL3s8ZNTl3iXl8FdM1HXAwwZkUjyjWg0FrAtsUAfNw282h9fvoHei
 8oBVKytU3wN+iVtsMnxFcPVzICJZyWo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com policy.dmarc=none
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7964D81581
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  5 May 2023 23:39:52 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1683322792; a=rsa-sha256;
	cv=none;
	b=b1f49341/4CW4THtvAYi+SKQNQe6MQFWUo3DNTr3WKB/Vpp9SOu5isTyJ8XnzBeij4Y8q1
	53e0Fq/CdoWeNSAk3lkm2fAabUakJbXewNHybWHpEUNkEaw+r6KnRMFNCHQC1aPNTu8wh8
	ZTMlZVf98MeeBTaR4NgosQ760yT4Xq4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of 3p3dVZAkbABYEKL6w770DwBB4z.2AA270GE0DyA9F09F.yA8@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com designates 209.85.166.69 as permitted sender) smtp.mailfrom=3p3dVZAkbABYEKL6w770DwBB4z.2AA270GE0DyA9F09F.yA8@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1683322792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=iHxTdXWIlaIDUctYZGEjm1ywCtsGaf6cMRwYaTSd5aM=;
	b=GKvWY7yOt9s3i12lK3C5fTJQvpiuVU5WgSnqa9EmJf+XwLaX5CYYqaPNoTD2xRsEQ+wKgm
	udu1ZxjXLtoHxe9NCWt7tmnOmA5MVCJq0UpgUz6A6yQWyAldN6olJZG9yrRsFsizAi+PqD
	LX6EgY+98WCEAAF/fVm5U+4hY7/yk6g=
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760ebd1bc25so144037439f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 May 2023 14:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322791; x=1685914791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHxTdXWIlaIDUctYZGEjm1ywCtsGaf6cMRwYaTSd5aM=;
        b=O3ms9B2hTHXLQIWy1WuV8dyMNay6ZvKbwOd7mVX0ioSs0/gYEsSA91WcDs+xBqlUVz
         Pg1DfogQN4ILZLQEJombIjhn6sG/Ry6l99WzIuHReoslNn+yChbZLjr4rf+F7myXGwBd
         cgLY0FKS334p/N3AxnOdDMQpEOLmRTc1uFX13h1TmDKYPiOLra6EornO7Q7bC/0xh4QH
         GFNSYFUHt+9e17rFN57/1Al4+GI+pdBUYH/Qz8ELhUwnFXaztFvPRWhS+ePS/95jtphd
         een+3KqZZgh+HlUjzN1dliDhFg2OTC/gbH52JSVgiWzm6jj0PbH46HzAfuHHD4ENuOws
         LKyw==
X-Gm-Message-State: AC+VfDwr1y0XDS1o6yTjFpM62TdY8qthduoB9li9lRUJdYEnWUbrfG5V
	FR5cLCjUvtp61Xw0wSiiQ88dulzVrfXJ105X1Xjcr5XtexRI
X-Google-Smtp-Source: ACHHUZ7JlfFpb1JLm5Tt+ZCN4sJkPj2ALDAuXqMoz00rhwQHaDNFhSUx81mmtBI/1uk2WUTtqgmKLNEqSoDdS/w0ZHArvWvuwpWy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4298:b0:74c:8243:9290 with SMTP id
 cd24-20020a056602429800b0074c82439290mr1110969iob.4.1683322791039; Fri, 05
 May 2023 14:39:51 -0700 (PDT)
Date: Fri, 05 May 2023 14:39:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000009a7505faf92136@google.com>
Subject: [syzbot] Monthly batman report (May 2023)
From: syzbot <syzbot+list2e1e5f527be1fd40d776@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: Y5ATEGJCNNLXMEVUG6F7ONH4LXLQHLIF
X-Message-ID-Hash: Y5ATEGJCNNLXMEVUG6F7ONH4LXLQHLIF
X-MailFrom: 3p3dVZAkbABYEKL6w770DwBB4z.2AA270GE0DyA9F09F.yA8@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y5ATEGJCNNLXMEVUG6F7ONH4LXLQHLIF/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
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
In total, 7 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5238    Yes   WARNING: ODEBUG bug in netdev_run_todo
                  https://syzkaller.appspot.com/bug?extid=f9484b345f41843fc9a9
<2> 1372    Yes   WARNING: ODEBUG bug in netdev_freemem (2)
                  https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
<3> 121     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
