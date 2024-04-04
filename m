Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CBECD1284
	for <batman-adv@archiver.kernel.org>; Thu,  4 Apr 2024 10:00:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A87481AF9
	for <batman-adv@archiver.kernel.org>; Thu,  4 Apr 2024 12:00:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712224835;
 b=ALtfLqOMLu/hJC/HPKOClunTTweHGX/tYZlJuoN0bIuCsQpxm1F4NIfNswmUFdk2rlqxc
 JvnVpVmoH0NxOS0WhM9OLs8ohTxczD6LPioe64pXTOhi8Y/8TuaG413MrpoyOg27KlUcxdL
 ZN0aGjqA0+9Wo8HwOJoz6HiX2mRafr0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712224835; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=p6vtYKckl/IIW1RC3InXjd3GHCm7k3RFvV0e/TOAowI=;
 b=vdF8Kh50x4NRm5kLY+ty1QnEN5zsr4XWlNoB1DYXSQ9LjIhDRjJE8nCUBfla/Yyq9AC1K
 6vGUKTjcX0yVPnSnRQjlXFNZM2UV+NwYQA59nX5MDK1RdCD6MN3ITkNoNAcGw34PzLR8xdr
 vb+lM+z76rjxnRcIjj9S4t5HG4u7oy8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E0597819F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  4 Apr 2024 12:00:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712224827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6vtYKckl/IIW1RC3InXjd3GHCm7k3RFvV0e/TOAowI=;
	b=zuN+g/IEHaaIGr7P87AvM28SO9i5r83tUtfSCy11PXf2pzOKGf2RV0Z6q3mZEpYglwyhc5
	isgOGli64aX6kP1Z8cIJzZnenNyHmtVwlTB5HIohT7RvVFgJPA8TvPMbaBFTu6l21f19ZD
	TZKSAigzEYTw2tZgIiY6+3k0NvgSvIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712224827; a=rsa-sha256;
	cv=none;
	b=ktgUM8eqAeHA7wCt5vGhV6H/In7Lm3TiEmGMd2Si2gMOX63k6AMi0p5gzzrWO11jq5LL4Q
	1qOJC8UHgFTW7tbVRzmnP2QaoZi+/uE0cotawz23GPrsTFP9AE4y3A4/RL7HwluxwtA0a0
	L0RhkmMz6xBp3S9SophDegH7UoaZmTs=
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: About Throughput in BATMAN_V
Date: Thu, 04 Apr 2024 12:00:22 +0200
Message-ID: <3327582.AxlXzFCzgd@rousseau>
In-Reply-To: <171221400877.1066.8144265750602425260@diktynna.open-mesh.org>
References: 
 <30040596.43St1lv6Oq@rousseau>
 <171221400877.1066.8144265750602425260@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: L6JDR6WGFIU6YE5GAZEY3YKP466MHZVA
X-Message-ID-Hash: L6JDR6WGFIU6YE5GAZEY3YKP466MHZVA
X-MailFrom: mareklindner@neomailbox.ch
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L6JDR6WGFIU6YE5GAZEY3YKP466MHZVA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

> We have two modems for each node and in one of them, expected throughput
> should be about 6 Mb/s for example, and in the other one it should be about
> 30 Mb/s. By using iperf and also throughput meter I can see that it's the
> case. But when they are added to batman with batctl if add, after typing
> batctl o, I see that the throughput values in both interfaces are 10000
> instead.
> 
> I looked at the interfaces with ethtool and the speed is 10000 Mb/s there
> for both too which is how batman must be measuring the throughput

correct. If the underlying interface provides a link speed via ethtool, batman 
uses the ethtool API to get the throughput value.


> If we use throughput override, it's fine at first but one of the modems has a
> shorter range so in our test where two nodes move away from each other,
> actual throughput gets decreased due to losses but batman still chooses the
> same interface due to the overriden value.

That is what the manual override is meant to do. A manual value that will 
override all dynamically determined values.

Can you explain what type if "modem" you are talking about? It is not clear 
why a modem depends on range. Or are you talking about a batman mesh 
connecting various modems? Please share the topology of your setup.

Is this somehow related to your earlier statement: "[..] but then even when 
actual throughput of the active interface decreases, it doesn't switch to the 
other interface because it only considers the overriden value." ?


> Basically I would prefer batman being able to change measured throughput
> dynamically.

if I understand correctly you are changing from "Batman doesn't seem to 
calculate throughput properly" to "measured throughput is preferable" ? There 
is no calculation issue with batman v?

Cheers,
Marek



