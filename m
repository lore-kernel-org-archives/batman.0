Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C686CA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 12:39:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BDFB183F06
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 14:39:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791376745;
 b=bp/LIwXtrg+wy0SgugebQNTWpJcmiN1BZnhdB5hC5Q8eifTd3c0aANesP9ejZquolmMuK
 /vojr/gBy1Rp0KZoIyjaMAH5/WRx36t8CmHC3lqSOIgY+HZVVNgzdu0pyQnDx301xvTld0P
 qqZesGKGTZmwqHaFpmMWW2Vyf9FoJrQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791376745; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XWiOK8jZ40zmaDNpJFrpVKMvUivr2p4ae213NrN7yRE=;
 b=wEkpJCRWogsT09xUoOqMc8fk+RQuERlED6oIeVT9gexO0OauFZs4ipgCw4g4XV/GQwkTU
 Niuw+2x4bPaNRW6sMfeh/RJQKkulblNZJVvnZnQyou6NlGr215qbyBEAS+KIVoMINNQYoPv
 JHDI0qtmw3mdd0DTD2/hex6BTXMLnp8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=lunn.ch;
 arc=pass;
 dmarc=pass header.from=lunn.ch policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=lunn.ch; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=lunn.ch policy.dmarc=none
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 08D108037F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 14:38:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791376735;
	b=khmxv/T9G86A3V9CtOQ8khadkFJI4aB2IfWkQOTEtWWtNnEnS9lbhAwoMvOa67NQrbqFET
	/zQI9Mhb/cQHqfyO4Iywh6MVKRNFLK0pljcIw4JUmCARosqO1OgfSgM6F9jh0ZJbSoBElo
	4BxfOHjAnV4lZVWbZ2Oq7qRvBRA/XcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791376735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XWiOK8jZ40zmaDNpJFrpVKMvUivr2p4ae213NrN7yRE=;
	b=pLRHlcD/hevyBNtCfMt6mvwLZ0HjKWvoOnQzGRCy78l/pLO1PyL1OdeUn7EoZDwIID/bpv
	69Guw7h6aiAMqpdtSwiRvoPweDIUid8Og7V8g+nFCr2DJiFGd4548TkkWpZe7fXyZjMz4I
	YrnZaXUmewP8VzAL5AWh14YApFJ4iWE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="mo tRJLK";
	spf=pass (diktynna.open-mesh.org: domain of andrew@lunn.ch designates
 156.67.10.101 as permitted sender) smtp.mailfrom=andrew@lunn.ch;
	dmarc=pass (policy=none) header.from=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XWiOK8jZ40zmaDNpJFrpVKMvUivr2p4ae213NrN7yRE=; b=mo
	tRJLKbr929X9Zsbt3IwAcg9Kgy2Kj2DvcjGMKby54qSOcnGXAxK7nvV6EKzzzThG/p9Zj17gf7CLl
	W+aFJGnGCPyHwOAwDKoCZJufa47KDWtOFH/t2WTztDBJP3jVqYO5mpiqC2DDVrJSaFAnJwWSG9lcA
	4ac/zwL3yyei/B8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEQuw-009SIJ-Be; Wed, 07 Oct 2026 14:38:42 +0200
Date: Wed, 7 Oct 2026 14:38:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org,
	sashiko-reviews@lists.linux.dev, marek.lindner@mailbox.org,
	sw@simonwunderlich.de, antonio@mandelbit.com
Subject: Re: [batadv,v14 5/5] batman-adv: avoid superfluous DAT DHT_PUT
 additions to local DAT
Message-ID: <7d8ffb0b-ae92-4d44-aaa9-affc0dfe7e19@lunn.ch>
References: <asWbc64vRQgTKt9E@sellars>
 <5152412.GXAFRqVoOG@sven-desktop>
 <asY38NN2pGa8FICm@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asY38NN2pGa8FICm@sellars>
Message-ID-Hash: J32LFVF7GE4PPVMWJDLUIGKKSNJFPZOO
X-Message-ID-Hash: J32LFVF7GE4PPVMWJDLUIGKKSNJFPZOO
X-MailFrom: andrew@lunn.ch
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J32LFVF7GE4PPVMWJDLUIGKKSNJFPZOO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Oct 07, 2026 at 02:15:44PM +0200, Linus Lüssing wrote:
> On Wed, Oct 07, 2026 at 09:24:23AM +0200, Sven Eckelmann wrote:
> > On Wednesday, 7 October 2026 03:08:03 CEST Linus Lüssing wrote:
> > > > - [Medium] batadv: UAPI source compatibility breakage via reserved field rename
> > > 
> > > I would have thought that for a field called "reserved" it would
> > > be clear that it'd be subject to change in the future.
> > 
> > To play the devils advocate: But programs would still fail when they 
> > manually initialize this field to 0.
> 
> On the other hand I'm thinking they should have memset() the
> struct to zero in the first place, instead of manually setting a
> reserved field to 0.

There is another general case advantage of memset. I've not looked to
see if it is actually applicable here. It will also clear any padding
bytes, if there are holes in the structure due to alignment. If the
padding bytes have always been zeroed, you can make use of them later.

Also, for kernel to userspace copies, you avoid leaking bits of the
stack to userspace, both in the padding holes, and any fields in the
structure which don't get explicitly set.

memset of a small structure, less than a cache line in length,
probably costs the same as setting a single element. Fetching it into
cache is the expensive part, once in the cache it is nearly free to
use.

	  Andrew
