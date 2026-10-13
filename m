Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872AFCC6B03
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 10:47:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 962D181819
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 12:47:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791888445;
 b=H2401KdiFflGbBquNBTKWMlS7J/zg3od0grYn0/W9WkeP5d6rOKVEXqqAH61mOU39/Acb
 nnHaD22KUQd7+pewfmJBY8laMsOHBJvI75zPa8oz/tw+Ab6ixIjnn8fCGwINPVk1uoUUqcW
 7DbhHegI3Suq7S7D1IFJWDiti0BwaMk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791888445; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ldOHzuoFyvYVHb+sVrK6xyv67llCIrqjl+nOGOaLnFg=;
 b=NyXUQDT7c0Myf0DxvUVgXMZS/7i73bbqApidJu5s83j00NSPNvIR9B40epCE3UcpMcb1X
 qdPp+OL89OoPiYzwCWEYZxqaCGm0LtsN9vHjX43PDPVYyUyBXfXvyocXvkohbwV2MUFEo3Z
 urOD42q9HfdGpxto6A0CzsdP+alpu94=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B1714802B4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 12:47:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791888435;
	b=31YhGcNyn874YHNWuNjQvwtOH9vbJ8VoBOLp49fH2AgS/+crdWUUyUHTkGTS12SpWbsrqI
	GTvrwPeV6avP3bvgqjsSOHbhJR0fBtzOLwznCljf2TSWP0RC3ojaV+lKE7puevnb85jJbe
	3f3vw4eKPn+fus6twjls2Ptcf9u4ba4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791888435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldOHzuoFyvYVHb+sVrK6xyv67llCIrqjl+nOGOaLnFg=;
	b=xryOisNgZy5z0uNjdbc0ZqD2yFmP1dOP/l/VY6tWEIa45QNWLMbPZ/Q7C81VwjLEJRDVN/
	6+kd5dMuv+EfpA3S0h5bTIh9xAgOpXKbUZOPYxQwIBnOk1Id9Rvy8gBefo7Xf22NZZviz7
	3UrFZvYTTuVzFWMMQz4Mrm9ZNFMvkDk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A99E20449;
	Tue, 13 Oct 2026 12:47:03 +0200 (CEST)
Date: Tue, 13 Oct 2026 12:47:02 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: mcast: explicitly initialize
 mcast.want_all_rtr{4,6}_list
Message-ID: <as4MJtmHx0vIDnBc@sellars>
References: <20261012-mcast_list_init-v1-1-046d66d18e0e@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012-mcast_list_init-v1-1-046d66d18e0e@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: AVC6PCJN4TMWYN4ZA6IHF72N6NYQCES2
X-Message-ID-Hash: AVC6PCJN4TMWYN4ZA6IHF72N6NYQCES2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AVC6PCJN4TMWYN4ZA6IHF72N6NYQCES2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Oct 12, 2026 at 01:10:57PM +0200, Sven Eckelmann wrote:
> All mcast.want_*_list are initialized in batadv_mesh_init() - with the
> exception of mcast.want_all_rtr4_list + mcast.want_all_rtr6_list. At the
> moment, it works because INIT_HLIST_HEAD just initializes it to NULL and
> the netdev private data is already set to 0 before being passed to
> .ndo_init.
> 
> For consistency purposes, also initialize mcast.want_all_rtr4_list +
> mcast.want_all_rtr6_list explicitly.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
