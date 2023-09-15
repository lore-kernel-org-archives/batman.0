Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB9CEED60B
	for <batman@archiver.kernel.org>; Fri, 15 Sep 2023 15:32:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 59A3583314
	for <batman@archiver.kernel.org>; Fri, 15 Sep 2023 17:32:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694791920;
 b=cuGZHON6cnoGt70MsEk5kqB5ObvLvEaNuYMooOv3MiMq3fs/3bbNlZPt5z5yal2cxmZrd
 MSyOFX4aT03VN5enZZtIvyqsgolg0OU2HMW8P+euugJtdzmIpIjSCzWyYiMKSj1IXY7QmqC
 6jLifOf0ALI5JOm4uY9RZmUsmpgtYAE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694791920; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1MF4uqhxZ+MzZCQDGMs2SweCM0suo7UDEFr5zZM0hZc=;
 b=jURSAPjvBAvgE/mo2vvd02apQcEJp1hf0Bn9ws4uWwaVWvnsmym2Dh3uoVPW3/GgOAKdP
 FPJdeZA8j8lNqdbVoi1K40pI9K7eYbh0zu8Xmt8vyxHWhP2UvVZUZVoabDQcHZPDlpJdRBF
 rcWGaYx5KU7LeRa+3q3LMTkce4z4DQs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 26C2A8015A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Sep 2023 17:31:37 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694791898; a=rsa-sha256;
	cv=none;
	b=Bd0Zk42N3gcPx2M8qo9DQZ4Kd1AyeLNm8MnJiXEH04pdeQyDii0Me17y9peQT85g9lj+E0
	a8XOBi5bkfLmYirrj6nOk50J7tdAdZiJWRJrr3BqBhvluL+6MXeakWuKzmgidPhhGCEEoH
	w0DnXAo5RiiZ0D9Nbg9qOS4kiVLmBEg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 116.203.183.178)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MF4uqhxZ+MzZCQDGMs2SweCM0suo7UDEFr5zZM0hZc=;
	b=ag8cQPrG49+snXNkjM2Z8DNC8JrficN6izpz6eQ/aRDd4sESWm0XjmK+6zdtJsRsNlQ/0O
	Z7iSlL9M12cCJRCGF+xdNJqh5kkRyjOiEoeiS62E7O+pqUYPQUbRLH+XlmgqVkHUVwv6nO
	kA2CXk46rFnlyFyzCNze5dCmas41lY0=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D039441ADE;
	Fri, 15 Sep 2023 17:31:36 +0200 (CEST)
Date: Fri, 15 Sep 2023 17:31:34 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: obiwac <obiwac@gmail.com>
Subject: Re: Fwd: Possibility of dual-licensing to ease bringing into FreeBSD
Message-ID: <ZQR41r1rkVCkg2Mo@sellars>
References: 
 <CAN8-kNUktsXSTnG2jA51h3piRxf8-a-JJBGtPF8uJdEWXspm1w@mail.gmail.com>
 <CAN8-kNWFXhFzeu0fcKg115VHHj_qLoL-GEroBRqSroHY65EMSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: 
 <CAN8-kNWFXhFzeu0fcKg115VHHj_qLoL-GEroBRqSroHY65EMSw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: GA5FEAW245QMDWH5NIRWGGFWQCX7IYEQ
X-Message-ID-Hash: GA5FEAW245QMDWH5NIRWGGFWQCX7IYEQ
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GA5FEAW245QMDWH5NIRWGGFWQCX7IYEQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Aymetric,

Nice work!

For my part, I'd be a bit reluctant. We've had requests for batman-adv from big
companies in the past for an extra license, which we turned down.
So there might unfortunately be vultures out there who'd like
to build on top of batman-adv without giving back. And I'd feel a
bit uncomfortable to have spent so much free time on this project
to just "donate" it to such big companies. Who'd enhance it and
use that superior, closed source version in products which are in direct
competition to wireles community networks like Freifunk.

If there were some ways that non-commercial wireless community
projects like Freifunk were benefitting from a dual license then I
might be up for it. But right now I don't see how they would?

Regards, Linus


On Fri, Sep 15, 2023 at 04:11:44PM +0200, obiwac wrote:
> ---------- Forwarded message ---------
> From: obiwac <obiwac@gmail.com>
> Date: Fri, 15 Sept 2023 at 16:10
> Subject: Possibility of dual-licensing to ease bringing into FreeBSD
> To: mmokhi@FreeBSD.org <mmokhi@freebsd.org>, <imp@freebsd.org>,
> <jhb@freebsd.org>
> 
> 
> Hia,
> 
> I recently ported batman-adv to FreeBSD as my GSoC project:
> 
> https://wiki.freebsd.org/SummerOfCode2023Projects/CallingTheBatmanFreeNetworksOnFreeBSD
> 
> I'd like to bring this work into the FreeBSD source tree, but they are
> reluctant to bring in any new GPL code. Would it be possible to
> dual-license batman-adv to GPL/BSD, or would you rather not (in which
> case I'll ask FreeBSD's core@ if an exception could be made for
> batman-adv)?
> 
> Thanks!
> Aymeric
