Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE72ED78303
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 10:27:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6ECFB83F22
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 11:27:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733135220;
 b=pwwjn0ZRNAEPolfto1c93yAI0WY9g/KZ/6bkvxxTeKwSTesJmlHUJ+4jLaKWWFp3/6RoY
 /nKy921zHb4ukR+8ScXozLlN85xxSeiN13hNNJXw5zOc/EwsYzzwygEY3zR5PbyUALuTwqu
 guGbokarwIaDlQd1pYlo81RWi4h+8ww=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733135220; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AspwrmyTLMd5jO7A9zmo1ZUVU6ElmhegbW1Cadgdee4=;
 b=mzvmrw28Vjx8aCyyRTU6QhZ0CnUAqxO7wbxsjOd3t8zcJqPFxZMxhZ2IKfdrNqz7HtFoR
 A5mzMabboSUDOHL1dZwevfhjUNrFxibgCO7z9ndbBL8Rgbep4Gt60uHBxA1Zxd15/wEiY9a
 YsfmBqQCanDC5WegJKY0+Bh5DSB4lsQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BD78F811B7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 00:16:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733094964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=AspwrmyTLMd5jO7A9zmo1ZUVU6ElmhegbW1Cadgdee4=;
	b=JCl2FtdbqHS0cuG1iLjFDXRtiEY7qpFPg6DyJ1z/Pu6TLAr/0tDWGFcqR2YHpEuXSmBhcG
	9imUZWIqR2YQRW/y2XNA8XsbjMhocp9zDIhzxqApnTjJThJiD2MbwbaxTTFZ+d5j5JeGiX
	R75wHk7A2PZi4VkHOygt+J91fGNluMQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733094964; a=rsa-sha256;
	cv=none;
	b=OY4TKO/A6gO0iNYzCGikjwYcemJLpFajUYaTUlT0YpuWVR8jwSMXt+a5HxoG+8gNvAJETF
	l04LYocauVoyc5pAOj7S/TilHTrqnxZ5CuUz7UdwnEjRmltQAtqdJ5vu7PSkpQ88OZPmDh
	uOXP2FHjM32HbP2T1Exwk8m66F2WRJ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3M-5MZwkbAIQ067sittmzixxql.owwotm20mzkwv1mv1.kwu@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3M-5MZwkbAIQ067sittmzixxql.owwotm20mzkwv1mv1.kwu@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7e39b48a2so20699425ab.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 01 Dec 2024 15:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733094963; x=1733699763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AspwrmyTLMd5jO7A9zmo1ZUVU6ElmhegbW1Cadgdee4=;
        b=YR95CO2XIoTec2Fxgswl7GDdzKOYRhkBY/A4wXMkDkQz1ulJ/HQCbzEbvQDNQ6u4y3
         iys8eTsJA1Bz8Lz5SMSGPGzNroN56uf0A3deAr5ERDtFJzuQZJ01yX3QWWBHrdxcJLdJ
         13qXnIWAM2yeJybZM8CeNXOJd+FOisoXWzHdLsu0k5cMgNg64vtSzSpl+fTTFUlx+e1t
         TP9RxkM0zPs0/+DhULGTaq4ZsCRp+Dlnp80jhXlsuhZIlrcLzwsPzfsrrdrX+QSbaDoJ
         Eh0eme0h/lAMdu9kAnTePpQ3TrautxuE7CHMCRTETJ7Vk01wEfI4DihLno199bHpVh/S
         /i1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZwh2kRJe+PbgpnufuwQTdFyOwRquQh3ufmkDcz89RBZOY1AP+VACK/G+MExwINt9GCbMHdzmzl+00LQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yw8xOBnproHijR3blMY3e9p44T2rKNzm13GTBMvSo7qLPcUNnSd
	NvoixsYIhAdUqqG920yTygISh9DKVP7sfW4gcxKvBcs44Nq2iPKzlipSq36ycf5bAfnEA7Qu2ec
	PltS/5SBKyjL8ZhnvnUJW8IcZyAlu2x2kRwL3SUcI0SWZgkvfpDg4lbw=
X-Google-Smtp-Source: 
 AGHT+IFdgO7VWoz1ICpvTp5NAPXlQj63DADp03XqbbCbV544dMEp769mRn76SvfLryXTJQSSxg1mJgMJMm+gMq0Zuy0YCzkdOexU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3a7c5580ea4mr196802765ab.14.1733094963538; Sun, 01 Dec 2024
 15:16:03 -0800 (PST)
Date: Sun, 01 Dec 2024 15:16:03 -0800
In-Reply-To: <673913ac.050a0220.e8d8d.016b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674cee33.050a0220.48a03.0019.GAE@google.com>
Subject: Re: [syzbot] [batman?] [mm?] [ext4?] INFO: rcu detected stall in
 rescuer_thread
From: syzbot <syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, gregkh@linuxfoundation.org, horms@kernel.org,
	kuba@kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org,
	oneukum@suse.com, pabeni@redhat.com, rafael@kernel.org,
	stern@rowland.harvard.edu, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3M-5MZwkbAIQ067sittmzixxql.owwotm20mzkwv1mv1.kwu@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: RU4YTL3STZEJBN2HUU5HOS5IJ2M5UHIK
X-Message-ID-Hash: RU4YTL3STZEJBN2HUU5HOS5IJ2M5UHIK
X-Mailman-Approved-At: Mon, 02 Dec 2024 11:26:30 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RU4YTL3STZEJBN2HUU5HOS5IJ2M5UHIK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10553d30580000
start commit:   cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12553d30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14553d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14486b5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112182e8580000

Reported-by: syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
