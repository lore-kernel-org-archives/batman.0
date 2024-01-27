Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CEDC46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 19:44:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A18883E8F
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 20:44:28 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706384668;
 b=vi51UkSm0OEv1syJ8oeES2JfygCq//JtladiTrfFVM4vXUgKPUa72mFU/uN+/YlZF+RYw
 EupYY/XBfIhMeRyv1oiBjXuBACMBxczoCCaVww0OolQdUZ3N/dthlCxNdpyRIc2UqMUBZk4
 byBlm7p8ozuV+E9lXKY5a+ZrqS4E5eM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706384668; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
 b=JcA9EA33BXqQ49nF7lSsKeLyhu2+YDrx5ser/yjq8A2qkkYjwca0nYtK1wHyHweZ2vyan
 2UceLfw+vKIHQdDe6yBEgRi4S4cslsOkIi1ShdQppwP+DLe6qJbzeQaxWhQTUZnw4HFWwnY
 YjRARal3LOu3btKw3idxML4iSz4QLJE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=blackwall-org.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=blackwall-org.20230601.gappssmtp.com; arc=pass; dmarc=none
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DC0C68072E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 20:32:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706383947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
	b=nlseeCyNlPZqGrJCuRTTEgZ7UuuOSZngVtcMvCM9t/g8cZWw4q/+BtkZxJCFW7AgpQGUqq
	3gS+G/YUBfSHGV6PZXrVZMzCCjjzzZiMPwvpmTcgQIvei7TtlkxmycNF1nvEPXuQ6wi94+
	osLQRZ/nIibxLCow34cuASku1yJH9iw=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706383947; a=rsa-sha256;
	cv=none;
	b=eYCak95RnHiF4QYC4jYl5rxVSlURQ5siwH3i896k7Y5jZjlZGWYmsPplmXsyQXBbUiD3iW
	BGPERPxVN48ZTKzNXuQCBg6X+dxsn0b9T+XBxvLHoT8/JRVMrm4osSp1UoudNlZ82mPITh
	8ScRkUgTbNUBiTPVPN23w6yO2wNgDRM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=blackwall-org.20230601.gappssmtp.com header.s=20230601
 header.b=MTaegDR1;
	spf=none (diktynna.open-mesh.org: domain of razor@blackwall.org has no SPF
 policy when checking 2a00:1450:4864:20::330)
 smtp.mailfrom=razor@blackwall.org;
	dmarc=none
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso26828825e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 27 Jan 2024 11:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706383947;
 x=1706988747; darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=MTaegDR1hFwtnlxvJH1Gq2noTPz8KKuAD8tmo+C4EgD70Rdvzs5yMFhqzlHozfWIK2
         jFcXghpqo8LrZhgL2hgw2caMllyKQGz4HIyiDQEJXcvikPRKxENWvCl90GY+BoKkSgA+
         bLQmWeVjdzV5i4GqRbGiGcG+bbKmmrq0HyeXzZ2CWxt1dCdUWclj6gfdgVvyBp4pYD8O
         WapG9EbDujnMgWyadTRD1LA9zyW8/8yNBedNZxG+MK6tjD2VLktqUTYEdWPitQE+rTtd
         /7AiAMcouoxBCWwKm43+T6RjRT4O4qlMZdjuIl4NKO+G8VbzmrZGECVgzCwAhvJRn2aA
         icWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706383947; x=1706988747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEpUxuHvkxdnVuo1JHby3iXUNzNjMXHPh3NuTZ9HCOY=;
        b=q0QhQ1ndHDTaC45zEYPWa6jKX4+dXuj/Ult/XKMpauZobgXAKVUkS5TPy3/wSCXFbb
         M5FvnvDE0vgyg3dPhANa6ksNfMe5Xsa2GgCSLDW5vAQu4ZFwKg2tJHknuzTXs8vjUfaH
         s4msuT9LCqf4DbbqRakhkEzLfm1XmoskCqmlXNcGk7V4ekMrKq9k/YsoptVEgC+CmcnG
         KkJ7f1Q519EPab/9dY551WHsTh38UhkavGdaXLbJq93OSDrsp3vloo3iyJ2lJG5rCuv8
         CQrM5VYM1tjgooneoLazdRVNZmJ/DA8+bhcP6VUwIY4GzgRpmsBphoMqdmK3v2T7zwFm
         KThQ==
X-Gm-Message-State: AOJu0YzzXFQPxrP1MFLGQksBp1/XkVGKtY/0AJR/Pv7MvPRkDgn2CWOU
	TaZ2y7vJf+zBdwshSKUKDJfCHjjWZdopYpRiWvFilxAxzjsPJVxWiAyEze/QFzWtxaiE8GiYQ12
	R
X-Google-Smtp-Source: 
 AGHT+IFIburJoW4BFrmc+K2ya7vO19XpEC4+2WG74/eThfZcJLQyym2s9GswrAXPsaEejM+mq4MJwg==
X-Received: by 2002:a05:600c:3493:b0:40e:ef00:af57 with SMTP id
 a19-20020a05600c349300b0040eef00af57mr1308153wmq.36.1706383947218;
        Sat, 27 Jan 2024 11:32:27 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c348b00b0040eef2aed28sm1999515wmq.23.2024.01.27.11.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 11:32:26 -0800 (PST)
Message-ID: <43a266e9-7cde-472a-9846-c16756be8c09@blackwall.org>
Date: Sat, 27 Jan 2024 21:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bridge: mcast: fix disabled snooping after long
 uptime
Content-Language: en-US
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240127175033.9640-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240127175033.9640-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: razor@blackwall.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: G2XSB4T432HC3VHCKVHYZXCRXTFH7STT
X-Message-ID-Hash: G2XSB4T432HC3VHCKVHYZXCRXTFH7STT
X-Mailman-Approved-At: Sat, 27 Jan 2024 20:44:21 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G2XSB4T432HC3VHCKVHYZXCRXTFH7STT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 27/01/2024 19:50, Linus Lüssing wrote:
> The original idea of the delay_time check was to not apply multicast
> snooping too early when an MLD querier appears. And to instead wait at
> least for MLD reports to arrive before switching from flooding to group
> based, MLD snooped forwarding, to avoid temporary packet loss.
> 
> However in a batman-adv mesh network it was noticed that after 248 days of
> uptime 32bit MIPS based devices would start to signal that they had
> stopped applying multicast snooping due to missing queriers - even though
> they were the elected querier and still sending MLD queries themselves.
> 
> While time_is_before_jiffies() generally is safe against jiffies
> wrap-arounds, like the code comments in jiffies.h explain, it won't
> be able to track a difference larger than ULONG_MAX/2. With a 32bit
> large jiffies and one jiffies tick every 10ms (CONFIG_HZ=100) on these MIPS
> devices running OpenWrt this would result in a difference larger than
> ULONG_MAX/2 after 248 (= 2^32/100/60/60/24/2) days and
> time_is_before_jiffies() would then start to return false instead of
> true. Leading to multicast snooping not being applied to multicast
> packets anymore.
> 
> Fix this issue by using a proper timer_list object which won't have this
> ULONG_MAX/2 difference limitation.
> 
> Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
> Changelog v2:
> * removed "inline" from br_multicast_query_delay_expired()
> 
>  net/bridge/br_multicast.c | 20 +++++++++++++++-----
>  net/bridge/br_private.h   |  4 ++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

