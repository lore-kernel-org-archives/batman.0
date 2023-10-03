Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC34E8FDB3
	for <batman-adv@archiver.kernel.org>; Tue,  3 Oct 2023 21:06:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 39B82819C0
	for <batman-adv@archiver.kernel.org>; Tue,  3 Oct 2023 23:06:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1696367213;
 b=R8OVteYv8Y89zCFzI76Zs/Cp2GabdpU/zF7a8VjsU6i+TCSfMjdojqkJOGYqgC03B35R1
 Yf3k2+oa15yOerHDy1/izdha5eC/AcSwPLft/kCnVze1lZ83q1aBVZVl8XPMLLq8c9bQtSa
 51NOolp+mqDCrvL4f/cBf+zJINW60ew=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1696367213; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IjUnn003Ov/HRFpxq19+N2UTOCojKd6UBOB93r2sKqE=;
 b=kSlBb0Lsl5T81s6bQpx+tQRWtzKoVLpkcTqvl4rU4NCE0QtKWSP6itG+1jVrHsvTfnDUg
 DyLZP/fvdhl1IFCGUA9isjG2omyMGhIVs9jHUi6/Qdnl4uyM/jkkGctWX5YyrGOoU2A+103
 b8AVWzf6Se1j60sAnLRzJg/v/UomQ9Y=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1BE0380EA1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  3 Oct 2023 23:06:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1696367210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjUnn003Ov/HRFpxq19+N2UTOCojKd6UBOB93r2sKqE=;
	b=RUy3ctbeoK5ts7PGGHsuLUVH6hFhOHV/PyuKq0tXginQvXfz2S/v5LBL7NKAKksz3pp8Ve
	Tk0GFg9kx6co77eDIsErDEuIjRQVxArd2ahni4oxcvAPsaVMPqiYPwv4DDwFhziiXGj26o
	cfryuk7YWPkiQrURnYN2hH0WIkSlFAg=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1696367210; a=rsa-sha256;
	cv=none;
	b=hxTUDGajWKP+SEiLXKh3P6elzJmAqolcDt7Sayu6bCOnMHwX5rLHzQ9V5ll1UmAX3EQfLN
	w/fkLW0x+JeqGEPjSlYlAbOsOw83ZcsBqfOV7SL0giqvg6lGpIekmpsMuACGMruT8WzKB0
	EI280uMvoqpVgpK3auQA3Vluks25sZs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch;
	dmarc=none
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Date: Tue, 03 Oct 2023 23:06:45 +0200
Message-ID: <3744588.QkHrqEjB74@rousseau>
In-Reply-To: <ZRXRFFATYjEvIeVb@pilgrim>
References: <cover.1695904299.git.repk@triplefau.lt>
 <15370864.uLZWGnKmhe@rousseau> <ZRXRFFATYjEvIeVb@pilgrim>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: EOAXYUYWXIBA7BVC2DTPYMNDWUHK4YFK
X-Message-ID-Hash: EOAXYUYWXIBA7BVC2DTPYMNDWUHK4YFK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EOAXYUYWXIBA7BVC2DTPYMNDWUHK4YFK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thursday, 28 September 2023 21:16:36 CEST Remi Pommarel wrote:
> > > $ batctl o
> > > Originator     last-seen ( throughput)  Nexthop         [outgoingIF]
> > > * Orig0-Main-Mac   0.220s  (        110)  Orig1-mesh0-Mac [  mesh0 ]
> > > Orig0-Main-Mac   0.220s  (        100)  Orig1-mesh0-Mac [  mesh0 ]
> > > 
> > > So best path for Orig2 to Orig0 would go through Orig1 with an expected
> > > throughput of 110Mbps. But such a throughput cannot be reached because
> > > Orig1 has to forward packet from and to the same WiFi interface.
> > 
> > Correct. Looking at your example where is the problem with the store &
> > forward penalty?
> 
> The problem is that the wrong path is selected.
> 
> The best one should be the direct one. Because going through Orig1, 110Mbps
> would never be bereached due to the store & forward penalty on Orig1 and
> the real throughput will be below the direct path (around 80Mbps).

To summarize the problem you see: A path traversing a half duplex node might 
not be penalized enough when the weaker throughput link lies before a stronger 
throughput link because the half duplex penalty is not be applied before the 
packet is forwarded.

The underlying assumption is that this indeed is an issue in terms of 
(measurable) throughput. Are there any numbers / papers / experiments you are 
basing this on? Is the store & forward throughput limit determined by the 
throughput of the weakest link?

Cheers,
Marek



