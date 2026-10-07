Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D53DCA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 12:16:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 22892842E0
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 14:16:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791375370;
 b=0SJ1Q9wYAeVxINHexCSrT+pUbJp/m6er5gbK1vsqzmOfYnPuBiH9yLUo9BmzT6dDTf3Fr
 JW8X7MV8gmvT+9rkS6HGZyCUdpMUAWFaq7tI48nXgxDwBaXilq4UxOAYRq1V66qAvtajrj7
 6DI1aO4dxL5rDhnPfvAqSBfCy/7qWpA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791375370; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=okgKi511OVkyEIVNzliggu3RNZafOgSP7vr21BH+y68=;
 b=ANyYWLSY8aS6l2A2LCgrp4VDgo6yJIiN9GZtrWAXMkymqwd5okZIOKRGy8FdkW8H6sqY0
 gJY7/6gZGYBW651IcjKsiW2qJVhFXdwGcF9j2pOTD5C3huIMNbz7Zboski9XYgCDA3hP+Mr
 vaUaLOLO4W6yf0ASo2MvKqDJ5SEP2po=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7BAB1806E9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 14:15:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791375359;
	b=vknQz6K3g+99uFH8vKX30EGD2UiqaWm4npHgyRJ47bMzeY5rGG0tYCzftk0Xiye6hoheUS
	D7MUaNT7HWkORO2HFAP8M+waFSvDyCHeiyBNSGNE2dJbgTQHn4PI6mqAIoHZX4vOkuEfYl
	iW70nlBnUZotTQIejCCbv+oVv8jEig4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791375359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okgKi511OVkyEIVNzliggu3RNZafOgSP7vr21BH+y68=;
	b=zd/s4wHZ26jJWd8u4Unn7GsDVf3S32t4Wbw4fFm0Uj1+WC7ecm8so+50Y6bY/khHX2GvRL
	KpdlkFXghG69P4GdwJvm+t62usl8Ln8veUgFdZwso0XZuyVyhn3YQtHIxpTmELeSjS+IB5
	k/Mc+8eYecsD1E0TX/e/5v+8lfO0xWU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 650D323237;
	Wed, 07 Oct 2026 14:15:45 +0200 (CEST)
Date: Wed, 7 Oct 2026 14:15:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sashiko-reviews@lists.linux.dev,
	marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com
Subject: Re: [batadv,v14 5/5] batman-adv: avoid superfluous DAT DHT_PUT
 additions to local DAT
Message-ID: <asY38NN2pGa8FICm@sellars>
References: <asWbc64vRQgTKt9E@sellars>
 <5152412.GXAFRqVoOG@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5152412.GXAFRqVoOG@sven-desktop>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: FHVCNRJ6KQCOTCW3KE3MDRHHWKVD6ZAS
X-Message-ID-Hash: FHVCNRJ6KQCOTCW3KE3MDRHHWKVD6ZAS
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FHVCNRJ6KQCOTCW3KE3MDRHHWKVD6ZAS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Oct 07, 2026 at 09:24:23AM +0200, Sven Eckelmann wrote:
> On Wednesday, 7 October 2026 03:08:03 CEST Linus Lüssing wrote:
> > > - [Medium] batadv: UAPI source compatibility breakage via reserved field rename
> > 
> > I would have thought that for a field called "reserved" it would
> > be clear that it'd be subject to change in the future.
> 
> To play the devils advocate: But programs would still fail when they 
> manually initialize this field to 0.

On the other hand I'm thinking they should have memset() the
struct to zero in the first place, instead of manually setting a
reserved field to 0.

Similar to ioctl()'s for instance, where there too you should
memset/zero the full struct, passed argument, I believe, instead of
just zero'ing individual fields as there might be new fields getting
appended in the future.

Interestingly, include/uapi/linux/ethtool.h has an explicit note
for this:

```
  26 /* Note on reserved space.
  27  * Reserved fields must not be accessed directly by user space because
  28  * they may be replaced by a different field in the future. They must
  29  * be initialized to zero before making the request, e.g. via memset
  30  * of the entire structure or implicitly by not being set in a structure
  31  * initializer.
  32  */
```

Which we don't have in batadv_packet.h though. (So technically,
someone could complain about such a rename because we don't have such a note?)
