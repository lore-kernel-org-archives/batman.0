Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35537C7EE2E
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 06:40:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5ABA981900
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 08:40:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686206418;
 b=VN7sQxsZtzb0Ut0awQj++RSBGBM6jjyvpHtG0t/iykvdYVy3HY4vd5jNT1P+D1Ke9/r9h
 vAaFIz3+WYDHCb2Y6u6WXYk/xEkho8VYOOz1/PKpQfNLgEaKaqQXRYb9zunyQR5nyZzEB/U
 W9Ei8RCnd6JTUt4hvyxvD127zVWPilI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686206418; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yiCG3DJAIe8OIdQH9j0nIY8ZJ/nrumF/4eCUc7ZjXwc=;
 b=1aI+KozLYCAn9P5pKmchVooPl9JwYDV/zQruFyx0GPaWFqOxac6lv6jdWaAybjXkyQuNQ
 RRvWSnGH6Z6kGC9Zjq7vWq6lDbGz06OygA1yn11A3A3EAsTWq2XvWhGEybWMzMA0r2gnAHR
 J3e3m63NkZRI7LhwbM/y24lQhzp87qw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 38CA1803FE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 07:01:30 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686200490; a=rsa-sha256;
	cv=none;
	b=AYO93nnQLjFVzZLPyzeVFac0cFojpqxmCRLoI6rpwwgZ9GZBup55A58RTeE0S0PLHlSgYV
	rSYo4HP22xYfqvGXe9ie9n9e7AAUc7+5/z1vsHfJpltJciXqdNSuE3zJ4hP7tynUcF63QO
	kPD8XFCj5G9RYOPEjlSdnK1dVfQKQCk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=MmxnIXUQ;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 139.178.84.217 as permitted sender) smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686200490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yiCG3DJAIe8OIdQH9j0nIY8ZJ/nrumF/4eCUc7ZjXwc=;
	b=ytoWmlE3lWzv1AMBF1e9ri1g+CY3TseEdjYPjE3AQ4dzt5jlKQ8mmuYct3bAmO/fFMYPgg
	EtvP1u52SDZKN12/Pzh2PHKZRqyaJOwzQ3lQCqjc5IShjI6w2cMXwnRn+j7n3JO5CH6YZ5
	fKQ/4upQGqTYSn3nluPCU86IQyK7FR0=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EFE13647DA;
	Thu,  8 Jun 2023 05:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFD3C433EF;
	Thu,  8 Jun 2023 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686200488;
	bh=uMrMVly8veTYCq4HdOYufKR4oc4LSqg1YVmq1jxs+7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmxnIXUQZ+S8jjhBUONfER3gImIjP6RDXQP8hZU6bm+19pwlj0BDOuprG3+zqvgFA
	 WbtEtsYFlKyFQz9yU4pG+Cm3XWIitccDy0J/s5rFAn4p1ktaRhAqARi0vxxDzrkiVQ
	 WuGjHaeDcLxHl0aG5lV0Of/Q0SKKvEomdxWKoXQgsZoY+QpNDlWgFrzUNWvlJXRLja
	 FGShtGIT/An9zL6FCXDI3YSIkkNaHOfcDgwSOsC42BT4tdTyO8gX3Fp9ni08TNFOop
	 6o58hpGRV8/nPIEHkSG5Q+DPhxMi2UeG8gkqmoGuV0YH7sJZf6f3J9ZaOO6re8JvOC
	 Nhw54ibk2q6pw==
Date: Wed, 7 Jun 2023 22:01:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed
 work
Message-ID: <20230607220126.26c6ee40@kernel.org>
In-Reply-To: <20230607155515.548120-2-sw@simonwunderlich.de>
References: <20230607155515.548120-1-sw@simonwunderlich.de>
	<20230607155515.548120-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: YGI7YS4KLTLQ6QPO6PPJHY6DILQAADYY
X-Message-ID-Hash: YGI7YS4KLTLQ6QPO6PPJHY6DILQAADYY
X-Mailman-Approved-At: Thu, 08 Jun 2023 08:39:30 +0200
CC: davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Vladislav Efanov <VEfanov@ispras.ru>,
 stable@kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YGI7YS4KLTLQ6QPO6PPJHY6DILQAADYY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed,  7 Jun 2023 17:55:15 +0200 Simon Wunderlich wrote:
> The reason for these issues is the lack of synchronization. Delayed
> work (batadv_dat_purge) schedules new timer/work while the device
> is being deleted. As the result new timer/delayed work is set after
> cancel_delayed_work_sync() was called. So after the device is freed
> the timer list contains pointer to already freed memory.

I guess this is better than status quo but is the fix really complete?
We're still not preventing the timer / work from getting scheduled
and staying alive after the netdev has been freed, right?
