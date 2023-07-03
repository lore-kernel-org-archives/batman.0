Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49176EB64DC
	for <batman-adv@archiver.kernel.org>; Mon,  3 Jul 2023 08:55:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB47F819AD
	for <batman-adv@archiver.kernel.org>; Mon,  3 Jul 2023 10:55:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688374554;
 b=dGXOiIU7AOQ17IuoZhHnlm3oE9RmR99MlmhzJjMr7BUPUZb4/hCwVNHajbcfoxLg7jDLY
 0TWyLo/AhGF/MO0bzO2/szdg7/FMFyHyATw/wEM1xjqIjezNAg3zUeQh3I/2Pks7PIpP2Ql
 s57ITrodDrtX/V4pSX4RjpD9LYYa7pk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688374554; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l7j1uUphfHMxLSfx5QpV48FQNGvQQ/yNy4UZXFmnzbU=;
 b=TOcb0Ed0ZiL+eftTj596VCSNkvwIkcVmobOgGM3EZITHrVyLlK1KvI/3WUpOgM1ZMHq7O
 6ZUaWDN7NGbnJtSDOG+uQh+EnChC12zbLWS6tbGrQNfi33CvMD9BddfGTberu+MjLjPDkZg
 gyUASY9gkJuYOhYKH2IXGJsorouibj0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BE50780C40
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  3 Jul 2023 10:55:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688374543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7j1uUphfHMxLSfx5QpV48FQNGvQQ/yNy4UZXFmnzbU=;
	b=bUwlX7ygey4pWALr6R+UhwSp04haGlES7gTgWKvawHOwLzZkYpQaPFH9ZfYyX/aU8LMHQ4
	yEXODAYK9xU2tVKUCBvSYP2ayjB/63TRUEUk5zJ4ziYdTFtPVKnVhOaniDe5Iw93UKBGQb
	lfqX3Sz+yH93kZgRsgINzX1/34j29LE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688374543; a=rsa-sha256;
	cv=none;
	b=KX5xs8CgzSv9ODU3HoXvPmi6q1okEUOr3IunMlQOF4uEJ09nZD24QR5k7x2b3yfXyIyMv8
	qJ6b2GvcW4j4RHMq81Mfb3VUqJzIV8qCURLloHQ9bLC+PptreI1lvXVuHrRJjMsHtqFeMT
	H1Z39ODyDQbaFQu0hFCTy8GXnw3FHGE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Authenticity of routing information in Batman
Date: Mon, 03 Jul 2023 10:55:36 +0200
Message-ID: <3737986.TLkxdtWsSY@rousseau>
In-Reply-To: <20230630144623.238fe33e@parrot>
References: <20230630144623.238fe33e@parrot>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 6U764OXFZKT3IXBOALYG64G5DANFFDZ5
X-Message-ID-Hash: 6U764OXFZKT3IXBOALYG64G5DANFFDZ5
X-MailFrom: mareklindner@neomailbox.ch
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6U764OXFZKT3IXBOALYG64G5DANFFDZ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

> I am not concerned with encryption or authentication of
> the traffic, only of the routing information. Is there anything like
> this in Batman (Adv)?

currently, batman-adv has no mesh authentication built-in.


> If not, is it planned to implement something like this?

I am not aware anyone is working on this topic.


> If there isn't, does anyone have an idea how something like this
> could be done differently (in a different layer)?

The typical approach is to use WiFi encryption (IBSS RSN or 11s SAE) which 
gives you the additional benefit of traffic encryption. SAE also allows a 
separate encryption key per peer to avoid having a sharde secret which can 
leak.

Cheers,
Marek



