Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE81CD128A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Apr 2024 13:16:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 728DA81A07
	for <batman-adv@archiver.kernel.org>; Wed,  3 Apr 2024 15:16:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712150201;
 b=MWpMJY2wh59yCYrigsNQhy8SKHnqQv5ArUU3FqMv0JBehgkQh9FCR40HFB7vMPnr3uanT
 6MJG4sTQvLvcLCjOvbOu2+AUD4SrMIP5XVb3fxll4s/xw+3w3PWgsQ7mTpnHV2sQxPY9kh9
 mmt3HvT0AxpUjGWR9GC6SjdTqA6TBhY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712150201; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=614luDEQqR4IxLz8W8T95ZAVDDyjdP0l1OW4akFUTaM=;
 b=p0HqUlt66BBBwNuIz/g+YBr6prqgB7BeFAyogjT0f5CGtQh+mR83rdjwuUmQAlw++iWIe
 LIzfo5PNp1utH9tB/Sa8f3A+fjwKqUta0wyq/rA+yMUtH9gz1gSb+MzGXe3vPmoexS6J6TD
 2GxlAurb7Hl+/j/S9plC+QKoJoeBAgQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from s2.neomailbox.net (s2.neomailbox.net [5.148.176.60])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 21FF48022A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  3 Apr 2024 15:16:35 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712150196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=614luDEQqR4IxLz8W8T95ZAVDDyjdP0l1OW4akFUTaM=;
	b=cIaDoOB8i1espk+06gRUiRD5b3Q4BgaL18H8ecQVEWVnP5GdGnr6feOrJLvQtgtYYfOBNd
	FIQwkyQqySUmoYoOghdIs7JtMStF6ieP4pB9bliKT7qq1L01y9Qsi1DvODCgSDh3FstJbn
	EneR22pOTv5STgJjl7T+r1szR5/pH+k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of mareklindner@neomailbox.ch
 designates 5.148.176.60 as permitted sender)
 smtp.mailfrom=mareklindner@neomailbox.ch;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712150196; a=rsa-sha256;
	cv=none;
	b=s1mG2kP0Upt7dKIWxc5l3vX+BFo07KqYC7ESEDgIwsnhUC1hg1rXrXxOo5OL2FigiW5LrN
	CGnG/Wl7fyzemVXfdZCCCO7cE5MgOntSCT3cNZ+9tUDQWzZaxIUt+2ZzBRfoqcDIG8vb0N
	k+XzHdLP4e5LUT10qoVMciLYa/pVPmI=
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org, berkay.demirci@protonmail.com
Subject: Re: About Throughput in BATMAN_V
Date: Wed, 03 Apr 2024 15:16:28 +0200
Message-ID: <30040596.43St1lv6Oq@rousseau>
In-Reply-To: <171214899190.1066.4170379207726418942@diktynna.open-mesh.org>
References: <171214899190.1066.4170379207726418942@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: MOVZL3I4HZGPL6K6E4BYMP2CFXD4ZY4N
X-Message-ID-Hash: MOVZL3I4HZGPL6K6E4BYMP2CFXD4ZY4N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MOVZL3I4HZGPL6K6E4BYMP2CFXD4ZY4N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

> Batman doesn't seem to calculate throughput properly

please provide details about what you mean? What is the expected vs
calculated throughput and how have you determined the calculation is wrong?


> so we set it manually with throughput override, but then even when actual
> throughput of the active interface decreases, it doesn't switch to the other
> interface because it only considers the overriden value.

Please describe the steps how this problem can be reproduced.


> Batman already has a tool called throughout meter, shouldn't it be used to
> continuously check the value?

A number of patches were proposed to integrate the throughput meter as
fallback when the throughput can not be determined via other means:

https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/AJYTJOONPCJ2GSPSTOFTTO5TZQKYJGOZ/

There were a few open issues that require further work. If you are interested
in spending time on this subject, I am happy to provide assistance.

Cheers,
Marek



