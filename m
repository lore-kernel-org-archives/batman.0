Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F02BC761A6
	for <batman-adv@archiver.kernel.org>; Tue,  4 Apr 2023 14:21:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0E03981D56
	for <batman-adv@archiver.kernel.org>; Tue,  4 Apr 2023 16:21:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1680618048;
 b=MGhk/C/tXjfOEVbQAgC4uEGCV7CFMw0jHUKrEaOJsCrvLSERTVkAjY+HFvNcYUJzWLrvc
 xFDgLOT0AlyloAwDLuTaXe/imDkEoEtuxaODoPIPCXrTH9aPT4Hz4m32/Xi+8agN/qsp+fJ
 HtO8bg/4NXEz7UYmv+lFu2q1Z4+S3T8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1680618048; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/GrvKtmfPcwE6VR9r1v5SQA/UQ6PE7TugBTYzb94svE=;
 b=s7RaEKZai5U8/JL8YbDRyCZhkxJnXgJLx3U77D9i5ku2HyWwn8Ka1fQgAyXf9Teg+bQDz
 LIA+g6ceAyvyLBE3Owuo2BWv/ExlO2H00LPrb+88hUXfRFT06mHBWoBRo1rC24HNPMwHTMb
 4IFB1xXL9JpF7Hjum4aQomdm+FJfBHs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com policy.dmarc=none
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2442C80423
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  4 Apr 2023 16:20:47 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1680618047; a=rsa-sha256;
	cv=none;
	b=ywu66XsyzaP6kGWDUrICkjDboj+f6VH946RrS23rODXhgYfarS7PlbPZeoTZSRm5l45X4x
	h6JIYlJrj+Dt4ZHtvqp5eOOUTou/PV1W45H4DgJAhHGSe1P/QFtTSFmbkU5sZ4XBaGjVmu
	ljOrTltr9Zvt5kDDHz8nv/IikHLf2dE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of 3PTIsZAkbAHoqwxiYjjcpYnngb.emmejcsqcpamlrclr.amk@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com designates 209.85.166.198 as permitted sender) smtp.mailfrom=3PTIsZAkbAHoqwxiYjjcpYnngb.emmejcsqcpamlrclr.amk@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1680618047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/GrvKtmfPcwE6VR9r1v5SQA/UQ6PE7TugBTYzb94svE=;
	b=neMqY3thw4dWmBSHFNO7ziGwO1IA3aherZ+QOOW9Yz65BBFXVIX7iXXyWMkH+p89/0kUik
	kB57LIRCgPkr73xnoFSDqr2CL9OyMJWSFNdr5Ze34/vv7veiKLKB+UW7Z3cwsexchDCjvj
	l2VELPm3bbsbHLZUNfPezuqoLgRahps=
Received: by mail-il1-f198.google.com with SMTP id l4-20020a056e02066400b00326ce9ccbadso64306ilt.5
        for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Apr 2023 07:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618045; x=1683210045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GrvKtmfPcwE6VR9r1v5SQA/UQ6PE7TugBTYzb94svE=;
        b=QFJecel5x+083hayYKt0QwGuRT1GuvCEfJZqMHU+OilhQrNzcoXm8rv5t2Ht0jSAbx
         tA5un8daDlS9HB0oOpfW5ThsakejIY5GFrZiL/G8Qoj48YuaRaqLQMg6c0frQUb86H+z
         ZhmzGdaxG2iK7wuvhOkv2d5iFBrVh9u5aJb4COWwRUrIdgoLYOblWg+4Dhmw6NmX2bM9
         KzG7OnacGGVCkyc6V7kdgy/uDbad8nGYN4d/q739Me0vFjiOeIYQyppwcrSaZdOTed6V
         1+REBdrQDRBJ0ZvCtv+BoePupE36Yqxbf1xaKL5RYuhDYXKcEi6JiBavTXj1S3pAR5aS
         MNSg==
X-Gm-Message-State: AAQBX9cNDKQkNNcEUpocQrGUjWLUQ5zbk76uIX70xGYNVWUBDlIgTKbW
	GLyEM0jIIjfKeuPf/EuBpZ++cj2sPDB9ZYVSX7+IVFbjvXua
X-Google-Smtp-Source: AKy350brGpANmJTlt4zwcqUBj3rE8WneyIwtxCiC0oh0HxV4t8CaaY43WIPiE+2OgZJhiPeihCabdLUoykmP595ewiXqkin09CmJ
MIME-Version: 1.0
X-Received: by 2002:a02:94af:0:b0:3c5:1971:1b7f with SMTP id
 x44-20020a0294af000000b003c519711b7fmr1465381jah.6.1680618045609; Tue, 04 Apr
 2023 07:20:45 -0700 (PDT)
Date: Tue, 04 Apr 2023 07:20:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ca21e05f8836105@google.com>
Subject: [syzbot] Monthly batman report
From: syzbot <syzbot+list145669fba4a69e21f102@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: YVSK7DX7E4B4DSJD5D7MXY2MYUPD2CYP
X-Message-ID-Hash: YVSK7DX7E4B4DSJD5D7MXY2MYUPD2CYP
X-MailFrom: 3PTIsZAkbAHoqwxiYjjcpYnngb.emmejcsqcpamlrclr.amk@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YVSK7DX7E4B4DSJD5D7MXY2MYUPD2CYP/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello batman maintainers/developers,

This is a 30-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 19 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
5034    Yes   WARNING: ODEBUG bug in netdev_run_todo
              https://syzkaller.appspot.com/bug?extid=f9484b345f41843fc9a9
1367    Yes   WARNING: ODEBUG bug in netdev_freemem (2)
              https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
115     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
              https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
