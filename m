Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D2CC47422
	for <batman@archiver.kernel.org>; Wed, 17 Jan 2024 10:00:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D02583E15
	for <batman@archiver.kernel.org>; Wed, 17 Jan 2024 11:00:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1705485613;
 b=YkQaZZE33VwGcRRStyqVy/cUZqE1NJsg5B0ikmVDdazA5ZAAhDsYAvsBgA2sEkw/sAX/Z
 UOY1YBf+B9kREejzGZB00XESUNpK0g0clns2fpSOqmqF2igDUsObve0+jDLqg+hwRwrJGUO
 HtYYDi4TWSRpf1F3mctc+kLg1oEQTIk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1705485613; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yEWYXMygqwjqpXLX4r5FFUWm4Vr0B8II2TW/fN+KFgA=;
 b=X5IqSKL40yY1tCdVds6TAHkuxxn4MkRws+7gqUbEmaInVUC7ld1dL8z5W202wZN56teMy
 new3e3SpCiuDmNr5ilDbFYEMzRx2SJUrS+PgfDsAYg0yDMFZZ/XIxrvAPF2a6MNc9nrQkPi
 ryQHjI+6tYHLSv9uK1RNc01vctECpig=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 520F28043B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 17 Jan 2024 11:00:07 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1705485607; a=rsa-sha256;
	cv=none;
	b=mvbOqQJTIWZIvgv3/3zL5ZAF44pnVkMxmD6SsnW2Ty331Bzfm8uw2Ytx62v7IVrB+b1lgY
	olP4K4bp3eYi+cYYFN2qxhMI09oNFE8aa6ms0V1OTKozbLrgTGekcfMFdZdEC3ApN1yzHz
	oHmbPvbQ5PPJUjXQs0NbifLHN4b9BAY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3JqWnZQkbAEMx34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3JqWnZQkbAEMx34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1705485607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=yEWYXMygqwjqpXLX4r5FFUWm4Vr0B8II2TW/fN+KFgA=;
	b=ysjwJ2ulYiABWxf2mobK6GOQl9N6oeUFRcaSoFB3VRnO39eYW3vIz2GtYJgbPLX5S6TPno
	a9Tgu8OhVX4+m3tHO/FFtLFbQ2o56qU7KI0ECe/8h9skAn3WIP4hR+e2NTsrmK475CRnMS
	btLQw3IqyhTzbJ9Su/y/qzvBY8l98bY=
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-35fffb6fe5bso106899055ab.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 17 Jan 2024 02:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485606; x=1706090406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEWYXMygqwjqpXLX4r5FFUWm4Vr0B8II2TW/fN+KFgA=;
        b=leZxS1XyEgcNSdFFL/3se0QLE5iWSHxzQjCI0I0O/a+jDR3uL3kuPfv2Hjzmgz8KcW
         vHCPzDDlUudpIIh23r81gx/QRLj0O23BtDpv1/6Rjqh+xJbXBB3GFO3TemKppw2oiDxS
         RB8C4ehl7rw4DWQI/g1GlTw6qX9bkedsgAr0q042q1PfsMYRnIsS4QQDfrh14lIc67CL
         inkhOFZ/WzHjReYtKSsQ9WPoe8t7Vtz9GR1gw2Pmit95S7O9CKgnKvxujThNUxia0dBg
         NJcIZSARSV5FbnuT0ELHiq372l+yPgn2Pw6DdsolQDrIM5RNAITNXblXPpBZh5SCxmZ0
         ra2Q==
X-Gm-Message-State: AOJu0YxRUUnkcE6pPFBDkklHXC2gJooCPGijmoBhzpLX1u6g69sceAvm
	aI8u4xWzOelVIsWn6XX278k6pIwfbtXX7wnrELLylWQDZpOxsUA=
X-Google-Smtp-Source: 
 AGHT+IFxzxlQiBQcX55AFmPxoteq4urJfMDjyvSOi68dybWh2/wMstcQoWDRkMhtdU1DXGkmkpRcVxbUE2YlVxE0/SEPmN1ghQFF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:35f:9ada:73a8 with SMTP id
 a13-20020a056e02180d00b0035f9ada73a8mr1265663ilv.2.1705485606163; Wed, 17 Jan
 2024 02:00:06 -0800 (PST)
Date: Wed, 17 Jan 2024 02:00:06 -0800
In-Reply-To: <5746181.DvuYhMxLoT@ripper>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9996f060f214f9f@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
From: syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sven@narfation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: OTUBGKYA5KIAE2RTBAGUABDDD5CAKED3
X-Message-ID-Hash: OTUBGKYA5KIAE2RTBAGUABDDD5CAKED3
X-MailFrom: 
 3JqWnZQkbAEMx34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OTUBGKYA5KIAE2RTBAGUABDDD5CAKED3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

Tested on:

commit:         a67d6793 batman-adv: mcast: fix memory leak on deletin..
git tree:       git://git.open-mesh.org/linux-merge.git
console output: https://syzkaller.appspot.com/x/log.txt?x=100a3dcde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87c229fb8ad5e9a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
