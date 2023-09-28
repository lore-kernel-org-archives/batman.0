Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F48AE732FD
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 18:11:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 824BF8341D
	for <batman-adv@archiver.kernel.org>; Thu, 28 Sep 2023 20:11:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695924661;
 b=vSJYo3BuEqkpG7kSfs+tSXvdVbveJBUse6TOYSaL26Pd3BsOQ1l2fyEzysx5W4+OXtZR2
 mfvnlkP8qbWnEz3bND/0OlzNlI2xT+SNV4jV9ISZpmp/r+KsI1WanlNn5CadeSbKoyDCtTA
 KJPIlqvrkWNqSMOvdLpyHGUK3btF4Ps=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695924661; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZFsE9AcIWmgVmJRUA0YKqH64bJzutmshmEiKoSSw3y4=;
 b=tAI8TOeN/2RTJHSrlDWbR4RPaFLukocWXpP3Hlu24QRFnXcOx9tT3Ag1ZKm0bWR/JE2rF
 Z4eyT1Ntq4+BJ/fO1SS7KWjWSvowjdv98NQ8oqtY1ckOcrJAL7RFvvDebGV4Zgg6M1ZOOWT
 fmqh9aqp3Ss4P5UN8YZUvbALIBVn4nY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 715598045B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 20:10:53 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695924653; a=rsa-sha256;
	cv=none;
	b=XnwblWAEfX4TnesLBxSZMynHOH9vOxgY3O/GGKBUir99qDkOMu4j/t9eRvB9XuYBCYLykv
	yc7QSLQoWkffemrEgpiYOXFhNK/kXpnv92XjndocNdYHAn+gNM6+qqU6T4QUlP718UAFtK
	3vrEfbaU9xAcTI8iSuMefhQnGMlLSa0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695924653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFsE9AcIWmgVmJRUA0YKqH64bJzutmshmEiKoSSw3y4=;
	b=E7tD9grkw7cVdv9HefGb06e9SBS2UdeIXKknrTW9Q48id1EkrJQV+Mz9vkpnn6CeUXh2nN
	QrD5rte+BSKSxvIuT5Oe3dyqMyGvzpogL4a8jQnou6shc/oqRucAT5Zez2TgFaunujo0bx
	PFJQKVOJXRnPesHEeFnr/VZoHn2nJ+8=
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Date: Thu, 28 Sep 2023 20:10:48 +0200
Message-ID: <15370864.uLZWGnKmhe@rousseau>
In-Reply-To: <ZRWuVBZuzD7cdd_-@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <4312005.ElGaqSPkdT@rousseau> <ZRWuVBZuzD7cdd_-@pilgrim>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: ZNQT6WTMXULLIES6D5GS4TYRWFYH553X
X-Message-ID-Hash: ZNQT6WTMXULLIES6D5GS4TYRWFYH553X
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZNQT6WTMXULLIES6D5GS4TYRWFYH553X/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thursday, 28 September 2023 18:48:20 CEST Remi Pommarel wrote:
> > If the direct path from Orig0 to Orig2 is better than the path over Orig1
> > the metric should reflect that.
> 
> In the example there is no direct path from Orig0 to Orig2, the only
> way for Orig2 to reach Orig0 is by going through Orig1.

If there is only one path, the computed metric does not matter at all. 

If there are alternative paths (as you saying below "Orig0 and Orig2 are 
connected via a 100Mbps"), batman-adv has to find the best of the existing 
paths.


> Let's say that :
> 
>   - Orig0 and Orig1 are connected via a 200Mbps WiFi mesh link (mesh0)
>   - Orig1 and Orig2 are connected via a 110Mbps WiFi mesh link (mesh0)
>   - Orig0 and Orig2 are connected via a 100Mbps WiFi mesh link (mesh0)
> 
> With the current implementation the originator table of Orig2 will show
> something like the following:
> 
> $ batctl o
>    Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
>  * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
>    Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]
> 
> So best path for Orig2 to Orig0 would go through Orig1 with an expected
> throughput of 110Mbps. But such a throughput cannot be reached because
> Orig1 has to forward packet from and to the same WiFi interface.

Correct. Looking at your example where is the problem with the store & forward 
penalty?

Or in other words: What scenario are your patches aiming to improve?

Cheers,
Marek




