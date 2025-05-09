Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F01BC3ABBC
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 14:18:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B225C849AC
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 16:18:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746800295;
 b=UxyiupUaiUy889rd0a1ToTAm3mvCYsdtbd3toxFVgBxRqpqg3ZR5mXWXzMdEHM8BLykak
 WbwaHjBpj79zvpQRC7aEUeM+PYKUIG/bJzzPMzAyC5DGqxPgHuq2VmCQ/EVpb8QQPoZay0e
 FOjrN/DcGZ9JdbMg9xx4ghjf+K2LJIs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746800295; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Nn4QC2geRHigWlYfVmoghVqxMGxzVTQ8TbyACpPT6Zk=;
 b=cIgG60QSSK50+fh4p1/QhGGjcd4ScVM4vHT5q6WVrZYtqf+11b3gGqnce/zg5GZFNUfaO
 mo8Wtf5TYoKdd5kj9dTbvz4SUlawzK6LOkOE9xLGICd8RXfJJEY1ySU+XnqcvCFUxSe48Eh
 px7t6a7FIMT9aHvkjHKiJ+a1lIBxabI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 71CE6845D1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 16:17:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746800288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn4QC2geRHigWlYfVmoghVqxMGxzVTQ8TbyACpPT6Zk=;
	b=K7xWsx2tKSWEYxG2j+qOHlmMSSxzGJYhXysXRx2DmpCMuugtbTIdh6N1QDK04bU9rZnKNR
	mB28IcXHcbl6LojjCqX0nQ0DsMQTi5GaY8yai01nbGITXNQl6B0AmGYhYOVaWd2MdD828f
	Lfgb0XbS8w/isqdI3SCbd7xPHhEuRJk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746800288; a=rsa-sha256;
	cv=none;
	b=FygxdDr24U33x92tGmuZYAy4cn9YeCEKYzA4iDE5Us44/mO9g/HUlRFi2hBmePllLn29zk
	ZXBmu1g7vrSdn1xm68Ismk+F4EDGpR2bzZqKYeNma+cymBKZ3fvZ2L4wwibDXrH/yCww1z
	1CAaJ61HSABgsSe2SUrSbKiTZZMDwhI=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A5BFD54DCEB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 16:17:57 +0200 (CEST)
Date: Fri, 9 May 2025 16:17:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v6 0/3] batman-adv: add dynamic, bridged-in TT VID
 detection
Message-ID: <aB4OlGLxvaAQt0zf@sellars>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: LPYFISLWRJ4PVN6HMS7CXLVDSMIJQUH7
X-Message-ID-Hash: LPYFISLWRJ4PVN6HMS7CXLVDSMIJQUH7
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LPYFISLWRJ4PVN6HMS7CXLVDSMIJQUH7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I also got some before and after OGMv1 overhead test results
with this patchset and the VID 0 remapping patch, averaged over
one week. Not as significant as the pending DAT patchset, but still
a -15.94% OGM overhead saving on our ~200 nodes network.

The theoretical upper limit would have been 23.5% with a raw OGM
message size of 68 bytes reduced to 52 bytes. The measured 15.94%
also includes +14 bytes ethernet frame size and batman-adv aggregation
though. The more OGMs are aggregated, the closer you'd get to a
23.5% saving.


$ capinfos ogmv1-1week-before.cap:
...
Data bit rate:       43 kbps
Average packet size: 212.77 bytes
Average packet rate: 25 packets/s
...
$ capinfos ogmv1-1week-after.cap:
...
Data bit rate:       36 kbps
Average packet size: 178.84 bytes
Average packet rate: 25 packets/s
...


Regards, Linus
