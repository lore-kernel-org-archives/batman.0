Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C5C77B7A
	for <batman@archiver.kernel.org>; Tue,  6 Jun 2023 23:22:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB2C7815F9
	for <batman@archiver.kernel.org>; Wed,  7 Jun 2023 01:22:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686093722;
 b=KRFCtrXbIr8Wj/goOtN5ZWXAuFkwRgc8Vt2mSk5VEcZ8FMCEYp71394uyNUXrB6as/ZNw
 VHz9oeM0VOjd+GsPQ1C52/qVEBm0XdX4bsoRdaIFghQ1yzew2YoVTuUuy3W3pRQMhiOM0xM
 ZzBc98tI9SLSNGnqsXSSy9vgjWkoI9g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686093722; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9wFCm+pZ3qAWgCZU4qe0akJLr8SDMfAA/D88EKwdCbo=;
 b=v34jlsZprrjdXqJRn59CJyboGzP4Fuk8cga2tXJZJTmrIsVZ3Gh4m3rQg59qRqEGUgsNU
 isiNmZ0sBTn8nXVTsR1EvOgedvyrchbvnJju2NWTz5SEoQRC5uUx+ybJIVBstE/QfRmBuS6
 sWShebcZs8iqkJMR1tlwIPvH+XS3kTw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0FB538045C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  7 Jun 2023 01:21:55 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686093716; a=rsa-sha256;
	cv=none;
	b=1+ENq5oh+33kiCiXy4iKzDgT847yK7FpK+t3sU+wttHRUpj7aVIDk4N3Zxt74yOKpxujqA
	zU9MlscPxPoVK5HpMaxSLmaeIxFDp8lC4oMRieqlOgaJ9gjkP3aeg9Tb9YlA5qJ5x5Vlz7
	ZT8oHyiu7SqohjUCsG7OmW2vEVk8PxY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3kr9_ZAkbADspvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.197 as permitted sender)
 smtp.mailfrom=3kr9_ZAkbADspvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686093716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=9wFCm+pZ3qAWgCZU4qe0akJLr8SDMfAA/D88EKwdCbo=;
	b=N4SO0ziFteOJcTtzhCtzVAFdFE1MsajdpdZ1UShzvh0xdrSXD86mh+pKpG3syFjaKuoq3F
	pxUN0OcTZvZ1vxhQstSYgxsopxZFg7EHqI3VsSplXrBI+wbVtqsayNVbGi8dnE3d2GpYl8
	VGldtdzqroRyKiiUbD8Zn1xPcDlSOUw=
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-33b2e96ea07so2325825ab.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 06 Jun 2023 16:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093714; x=1688685714;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wFCm+pZ3qAWgCZU4qe0akJLr8SDMfAA/D88EKwdCbo=;
        b=CTZg040E1s6TF6PydhOZBtB48+u+QdmajWbDkjgQcHrrkKcDBRGHKuQQ0W3YezKEgV
         MxLbiZGCuMcrD1Nnq+PtXi54mytfRQlCuINElw9EMpXYKVwvOngZhkMOgHu+fwlmBN7H
         TUuGEBbpEIRZBdN+gzlzJqscB1vVM/XGEYkectvIUnJTsrWyo9xu12dwNycbGtmPqVZu
         FduiD1c6OA8l7lWdrkN5mCsdLbkTSHYRgp6p7nd07FEGE1BOqDUXIukMuPmi9Mz9bN1S
         OR3iml+0HT34gqzwQilnSnq/xHQh6V4krpuzdydRGMHFQiEfUN8FwZNOuTDI7hjLg89s
         enbw==
X-Gm-Message-State: AC+VfDxwbHclr7Rj0VYQeZWRy3Sg7aD5Gi1to3Bqe7mwwlwIKzx4KYEG
	a1uWUZotif2FrJxaYmxXZdYjkG6vfKZUiVtHme2sgK6OmBT4
X-Google-Smtp-Source: 
 ACHHUZ71/HCLFMZB2QklrupN5H/+IcgTlCUUJBOQlQ9HpHL7I2uh6mqDVZw2zubtCBLLznj4lx4mLJk9V/niZtnWGVnahOsOT3V5
MIME-Version: 1.0
X-Received: by 2002:a92:c801:0:b0:335:fef6:6b84 with SMTP id
 v1-20020a92c801000000b00335fef66b84mr1814317iln.1.1686093714629; Tue, 06 Jun
 2023 16:21:54 -0700 (PDT)
Date: Tue, 06 Jun 2023 16:21:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb2c5705fd7e48e0@google.com>
Subject: [syzbot] Monthly batman report (Jun 2023)
From: syzbot <syzbot+listd313779a4df89fffaf29@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: 2HVRIM4S67EO5G6FFCKTK2H4KBDQZWDP
X-Message-ID-Hash: 2HVRIM4S67EO5G6FFCKTK2H4KBDQZWDP
X-MailFrom: 
 3kr9_ZAkbADspvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2HVRIM4S67EO5G6FFCKTK2H4KBDQZWDP/>
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
In total, 9 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5426    Yes   WARNING: ODEBUG bug in netdev_run_todo
                  https://syzkaller.appspot.com/bug?extid=f9484b345f41843fc9a9
<2> 1375    Yes   WARNING: ODEBUG bug in netdev_freemem (2)
                  https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
<3> 128     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
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
