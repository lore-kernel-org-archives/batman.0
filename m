Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CABC4829B
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 13:29:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 03041841C9
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 14:29:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1707744585;
 b=z4Wh7KwlZsF6X0pSwzD0UFmK82ZZnnTfk/bDgPdLFXQytFNmVT/R6xYCZmCP0uwv2jMrk
 YJjtqzebFQ2A/zqfnwSQpvGvFNvhwhaCJAw3xsdO2FIRk0OsqhKHGWHCuASvFiv6XGjfMhy
 G9u4MCtutQao/b+DvswM0/ARXc01tl8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1707744585; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ObKSC16eAptSqU30mun4surYToSSq3dApxjAL/tX6gw=;
 b=0FR9o+Vz6uC+iXy+mYtkIFgfso6S/Kb5IvGP953taFYijgCQoqsNTMdOCB086t7pNT/nR
 aqcUddHIZobhc8ysvcoOzdrLlSBurIPMFQKcWYbtp5Uhl/sWq41hqYfktZyQ+Q9p/tVpvkn
 6mDDNqWoZ9ZX+rMWElOGTOy5F6YKuCs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8CE2580095
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Feb 2024 14:28:37 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1707744517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ObKSC16eAptSqU30mun4surYToSSq3dApxjAL/tX6gw=;
	b=QQmxXk6wczppP177jV7LQQqAyHAer/K94/0wnunW6m7jpfK50Tuv7uodSsWunkZf27ib9K
	MkfGp0eeNF7SQRALGcFpGuJ1eQISi1cEJcxmp/T6pmYDYFXCTFgketJnjeiZq+rP/kmIyu
	3FqDC5GhYWa/tjcplEqIdSJ6O8pr1sM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3BB3KZQkbAJsNTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3BB3KZQkbAJsNTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1707744517; a=rsa-sha256;
	cv=none;
	b=UymnFbLEPOkKxQne1Qo34bPeoEjerFe431F9diTMf/5rIgWRn/JKTTSEaK2sqEMeDUiJbf
	NMBpMG+Fb7uu3IvnrT5y2Y9gslHIVZpYpMZGmBP3U+2sU2YEbNeXyNUVEMAXIGqmrxk3NJ
	U6UJc3kqngsOzUgN+6G2QRNYk7rojEc=
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-363befae30fso28920785ab.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 12 Feb 2024 05:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744516; x=1708349316;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObKSC16eAptSqU30mun4surYToSSq3dApxjAL/tX6gw=;
        b=H4BIyrhvK4DEU7JFI7ZuVEa2lHnG7nsP94SvsOl1ZJ+K1h88+MnvTXhgNj0RpEEJfA
         JJskPzruyejycD0SlsQLxQ/qA8zQKVFYptakhgvTBxU34+x56htsiAL1fe6NKmor0N+7
         aO7fQYA2uA6WxPY1ECx93RLlwJdLKhu/qVCxq6rCmKex+I97m8ckAdfuwa5mpczWIGIk
         94LhddsAAftgPu4CwyIIi6i5Zhj6KUJAc4QExhC1l3+QzUTShpcdqAjfVneB8aMga6NW
         ChiKdVK8SZ60zwmS7DGRTOYJZym0m995OoJJpzQ6lihzWdIpiJPGzZ2z06nnyp1kBCmb
         F3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6AUo6S+WEJmkZ5JTTgRimxPduWvf+JVUozmClJmQkslWq34M0J2vWLlThsp3o6HoKGg53xvyk5lRsdM0Cchn4R9P70mVV2AwlwIWSQoCm
X-Gm-Message-State: AOJu0YzHMwyixztzpuXu8xvcboRC284L8jnmiIR7hvM8W3XnsqIDzn1A
	C6K4dy8yP61C/hRuukFhx61nGOdoY0ZhjLcCSVD1XUJMDMISoA0Qn8JojXlzjS2n+tCDIu8V9KH
	P7PgtIt/xapR+YO/UM8ZZLROlNSZOwyW4JB2/JiIg6lRCGbNY00Hq/sQ=
X-Google-Smtp-Source: 
 AGHT+IHfkrFFxnp5qczPid0DMB6lHfZKxsUkP/JbTv6q6YSpbuczYG9H2u4I3KdB22kZsZNI292eWhtMsSwySB1BsAlvWTGzM3qO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:363:7b86:21bd with SMTP id
 i7-20020a056e0212c700b003637b8621bdmr612673ilm.4.1707744516291; Mon, 12 Feb
 2024 05:28:36 -0800 (PST)
Date: Mon, 12 Feb 2024 05:28:36 -0800
In-Reply-To: <3281463.44csPzL39Z@ripper>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042c47206112f4123@google.com>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
From: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
To: sven@narfation.org
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: VETPN3EFWICBLCOAUAQBC76YTCQISRXX
X-Message-ID-Hash: VETPN3EFWICBLCOAUAQBC76YTCQISRXX
X-MailFrom: 
 3BB3KZQkbAJsNTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VETPN3EFWICBLCOAUAQBC76YTCQISRXX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> On Monday, 12 February 2024 11:26:24 CET syzbot wrote:
>> syzbot found the following issue on:
>> 
>> HEAD commit:    41bccc98fb79 Linux 6.8-rc2
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14200118180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=451a1e62b11ea4a6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6a4b5bb3da165594cff
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/disk-41bccc98.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinux-41bccc98.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/Image-41bccc98.gz.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
>> 
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> From 5984ace8f8df7cf8d6f98ded0eebe7d962028992 Mon Sep 17 00:00:00 2001
> From: Sven Eckelmann <sven@narfation.org>
> Date: Mon, 12 Feb 2024 13:10:33 +0100
> Subject: [PATCH] batman-adv: Avoid infinite loop trying to resize local TT
>
> If the MTU of one of an attached interface becomes too small to transmit
> the local translation table then it must be resized to fit inside all
> fragments (when enabled) or a single packet.
>
> But if the MTU becomes too low to transmit even the header + the VLAN
> specific part then the resizing of the local TT will never succeed. This
> can for example happen when the usable space is 110 bytes and 11 VLANs are
> on top of batman-adv. In this case, at least 116 byte would be needed.
> There will just be an endless spam of
>
>    batman_adv: batadv0: Forced to purge local tt entries to fit new maximum fragment MTU (110)
>
> in the log but the function will never finish. Problem here is that the
> timeout will be halved in each step and will then stagnate at 0 and
> therefore never be able to reduce the table even more.
>
> There are other scenarios possible with a similar result. The number of
> BATADV_TT_CLIENT_NOPURGE entries in the local TT can for example be too
> high to fit inside a packet. Such a scenario can therefore happen also with
> only a single VLAN + 7 non-purgable addresses - requiring at least 120
> bytes.
>
> While this should be handled proactively when:
>
> * interface with too low MTU is added
> * VLAN is added
> * non-purgeable local mac is added
> * MTU of an attached interface is reduced
> * fragmentation setting gets disabled (which most likely requires dropping
>   attached interfaces)
>
> not all of these scenarios can be prevented because batman-adv is only
> consuming events without the the possibility to prevent these actions
> (non-purgable MAC address added, MTU of an attached interface is reduced).
> It is therefore necessary to also make sure that the code is able to handle
> also the situations when there were already incompatible system
> configurations present.
>
> Cc: stable@vger.kernel.org
> Fixes: a19d3d85e1b8 ("batman-adv: limit local translation table max size")
> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index b95c36765d04..2243cec18ecc 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -3948,7 +3948,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
>  
>  	spin_lock_bh(&bat_priv->tt.commit_lock);
>  
> -	while (true) {
> +	while (timeout) {
>  		table_size = batadv_tt_local_table_transmit_size(bat_priv);
>  		if (packet_size_max >= table_size)
>  			break;
> -- 
> 2.39.2
>
