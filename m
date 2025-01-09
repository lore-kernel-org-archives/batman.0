Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3354E77197
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jan 2025 10:31:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 54BD084284
	for <batman-adv@archiver.kernel.org>; Thu,  9 Jan 2025 11:31:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736418695;
 b=k86r7aOWMV1xpJhgIVUtPb7pFdZMx7jCWXg26zFa5C0Pz4LO9wIOSM2tS4dqCkkoW54GS
 PXExgJ+Hi64wYdv9C8YvT7A72ce6X/3DRDHWrQD/TgRQBlkRneZrNIfBse6LLUb/HwDraXK
 UjFH0wHEAXcJZhmtEV1tPONlM9bxDIU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736418695; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J7dC4eJRqUak7d56VvoOtG+BSdmhrLVfJIJqyj5a2Ds=;
 b=mx5WgW8ZDwzAZ9rTjbsWJHo6Vw5cgLlqF7PG8Jf9W/YIvyrAPnI79ncjf8VcJOU+B9COO
 aNlcC7UB8cN8Gmaw8oXH9b4aM8OAFfiNLbQlwTu1HK0XEfdssz+webr2cVHAUhZRohkydb0
 AlCEZtcgOlBkZdaSKMh/y2VO32nBYlA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6D91882482
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 11:31:09 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736418669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=J7dC4eJRqUak7d56VvoOtG+BSdmhrLVfJIJqyj5a2Ds=;
	b=a86qnREHjfbUC2aWCxYWpQZihHLCttwFD/TczlxTgkcxh6b5HjFIxdv4CKx862mcHWrr0+
	7nLxfWvUs1z4Ws179h6p82Pza/bPdc3cDEN39HUi3x1CM3djTW4HHMQTb13frDTQbF2NnM
	T3+MkCBB2Nf1/bEEU1rBmdohIatZ6FY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="m/9q0JzM";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of matteo.fortini@gmail.com
 designates 2a00:1450:4864:20::335 as permitted sender)
 smtp.mailfrom=matteo.fortini@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736418669; a=rsa-sha256;
	cv=none;
	b=vxCf/kFIktp9aqUh8rHjeWavIV4W3Eqa1sOuRiCI/bbFl9dEu8/LsAivA26lJB7jdv3KFW
	ciiYys79ZkjdYfp+K++l4cwN3/Fz1t119AQk32/KVxsdww7VLtZRdXgz0Ft1f4mDuh8Nc3
	NpzXXnIKpVJD0I3k/tmhb97mTbK1QIs=
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso5640015e9.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 09 Jan 2025 02:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736418668; x=1737023468;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7dC4eJRqUak7d56VvoOtG+BSdmhrLVfJIJqyj5a2Ds=;
        b=m/9q0JzMtmVlC2x5apHzMv4zUmWcXuMC+BNdmZyFo8i/HHmzBveimf3l4pTc7kzXVV
         V7sk4FnA7DDXFtVSRKa0jOwQ66BCbARBXsUjmNUVwMqFIDpKh1Dwdf/g4zVt3ZxQMCdE
         gEw+tkV3tr9zMvJ2KtgEA5/JpoL//v2yAfDnMR/Vbh4aKZK052HChfwtxrgf3qIY1tBZ
         v4J+X7VOVUOwKDGUm9QcBk4/HqlaWINRUHzvIqb1JqBQvCMyR5XP4eebIcfU8HVszscq
         go8ys9JmlNDPrhUSZbVU6rM041WS2Ph2CxJf5B9GNlZc513rCdXwfz3hdh2vF9185PaM
         QchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736418668; x=1737023468;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J7dC4eJRqUak7d56VvoOtG+BSdmhrLVfJIJqyj5a2Ds=;
        b=JQHJOCC5tIcMo25au7ABDn7O3oSlBWQ1PiDSOpMqAmudngcNNkW4ZciV8WpZeuIRju
         xqjVJm2MmbOr74/mJj5xmV0c+jq7cu/BwZ8SldaYF26vinAeE6MItFa9/KIP2E1MKsmv
         yBqgi2t8dhHbq6RUaXbsgd9c+A+a0rxhbMZA4livX/3+dzdHiWfNgJNm9Vys6JEVEZMH
         BborgoAIDgo3X1XuO/0iQ9gKYp9GxcrNvMlKg4f5rZnjUZ65coS3GtABsV0+xAcgModq
         lDBHBIOMUW4HisRI+9Mvq6tw1SslRr5diEsNuYAjlXb8ky4WUZ0v4bY1CGKwDArkqnJs
         oN0w==
X-Gm-Message-State: AOJu0YxAk9TFKIxVVxhhbCmidj5Z8/p1YglOP+nxPBNe/E8DbYHQ16eU
	EU/BKf1a7OH7+SapN/ZfPvbF29a/4mQTOhWgB5lVXfeE7FuoiUeu2oMg6g==
X-Gm-Gg: ASbGncvpHHHGe1uGD/uzmzNMWfmchrJpnluzQpgxuPouUmspjZ4/GUXqjx8G5xpWPRm
	RY24hU4TBLnRkSFDixQOmCLlxml9EMRl3QsMcZLO0zJjHx/rV1zPNz3Pk+WVdZj+SBvY5/a4XFQ
	7pPemRl2QE72r67XU7S0rDrMNI8hboRfXYVHqXNJkQ6ybOpaoq1Tjn97Xz0v/a7irziPMOQo4u7
	OXHCdWaZsK1KTecNzlwXlaFrwsZsfJcV/v9YCfsD4sK7vn71fvzd+Jf/rwrjTwQdcgPQ6VycmPg
	jntmpJ4dHE7g
X-Google-Smtp-Source: 
 AGHT+IHD6dB0dv/66S90rPnkQigCCLlr6GXlsKJ3aQlUhEUywRj39sm3Tjy9tWAg/eibdq/aCoGIwA==
X-Received: by 2002:a05:600c:4f06:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-436e26b98d1mr59036435e9.14.1736418668497;
        Thu, 09 Jan 2025 02:31:08 -0800 (PST)
Received: from [192.168.99.198] (77-32-84-83.dyn.eolo.it. [77.32.84.83])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f8bsm16124295e9.23.2025.01.09.02.31.07
        for <b.a.t.m.a.n@lists.open-mesh.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 02:31:07 -0800 (PST)
Message-ID: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
Date: Thu, 9 Jan 2025 11:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: b.a.t.m.a.n@lists.open-mesh.org
From: Matteo Fortini <matteo.fortini@gmail.com>
Subject: Multiple ARP replies for same address on openwrt module
 6.6.69.2024.3-r3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JIBNLB27ZONYITKFGQL3XA4X2GC4S5NP
X-Message-ID-Hash: JIBNLB27ZONYITKFGQL3XA4X2GC4S5NP
X-MailFrom: matteo.fortini@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JIBNLB27ZONYITKFGQL3XA4X2GC4S5NP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I am noticing random unreachability of hosts in my network, in 
particular if I just nmap -sP the whole range.

I traced it down to ARP poisoning, and the source seems to be two hosts 
running batman-adv which are claiming the same address.

This is a sample output from arping

ARPING 192.168.99.1
42 bytes from 02:00:01:bb:00:07 (192.168.99.1): index=0 time=4.204 msec
56 bytes from 02:00:06:bb:00:07 (192.168.99.1): index=1 time=363.556 msec
42 bytes from 02:00:01:bb:00:07 (192.168.99.1): index=2 time=3.743 msec
56 bytes from 02:00:06:bb:00:07 (192.168.99.1): index=3 time=385.352 msec

issue is, 02:00:06:bb:00:07 is not the right node and the host is 
unreachable. The other MAC is the right one.

If I clear the ARP cache in my source host, then the remote host is 
reachable again as it gets the right answer.

The problem started after updating to the 24.10RC series of openwrt.


