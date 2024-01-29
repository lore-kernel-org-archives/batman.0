Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB92C47DDF
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 03:02:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 00CB080C67
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 04:02:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706497355;
 b=NHqVudXa3q4dG0r/nvInh62nhFfRRU1i6y7IqduKoCu/EgzbKzhXJ5P8u3nvdXd0YTmRz
 Jputn3HfcAnjjj8fb8nFkHeA86+2jhH3L3BSpVwOOvBTpEJ8IY9DUQtKvQkCe8omoEcn5/3
 XcijOBUlEdfm+a7KePyzhwlsMVwn+Wo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706497355; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HRvz8PS591HGfKMRN+lVXtLFxCrlyrEjaSaN8caVwAs=;
 b=NwDgxh/bsptUsS6/Tp+whCDVG0xNkxNDV1e4XgIxm+kqS+1LK1yiTG2UJMa7EFmBtP1wN
 lR1Ito1RkE8vp35cJONG7y4oQeJsfqV9XwV1HA7BGdH2kgC59Y40ExUtAxA1D+FisV1N+Dg
 yRFfdzW1LPQWEiEjVZxEVL+nZEwnRCQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AC02080C67
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Jan 2024 04:02:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706497347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRvz8PS591HGfKMRN+lVXtLFxCrlyrEjaSaN8caVwAs=;
	b=D+jUGayYO4omTcBpjOTTDbnFMHV1H5Z/1XGVLNBXaSkpJxdjezMpKcfnMK6LsAL7Dvn38L
	RCAJH0J3QKJ+jaw5Owk/hwC8705GjEPOWuIIyw/sTR5CstLu9+sFWk3tu7Lsn28VzvW+AC
	t84qcYnHsIRPkBqMl1Nvzk18JYfJWvk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706497347; a=rsa-sha256;
	cv=none;
	b=aEM2ab/obbusI9c74WnH+Kk6IqWIB/zTeKX22cWPhF9PEsU37O5rzxcVoO9hkaZw55tQe4
	wRX6H8oXNHSg0iG5Y4yfTu1zq0KS1CldcFFzGa6hVslZRr/kecAlkO5Yc4Ky4ozBBAhGi7
	Cp/p4JplGNgZKwcLlPqMkKGzJhI4JpU=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68E8540E90;
	Mon, 29 Jan 2024 04:02:26 +0100 (CET)
Date: Mon, 29 Jan 2024 04:02:24 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: doug.fajardo@gmail.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Problem starting A.L.F.R.E.D on batman-adv?
Message-ID: <ZbcVQNKlNso0D9l9@sellars>
References: <170648094014.1056.17522976996217024998@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170648094014.1056.17522976996217024998@diktynna.open-mesh.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: TSO6GLCMBMD6NNGBXFXVRSJSHHEBFIXU
X-Message-ID-Hash: TSO6GLCMBMD6NNGBXFXVRSJSHHEBFIXU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TSO6GLCMBMD6NNGBXFXVRSJSHHEBFIXU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Jan 28, 2024 at 10:29:00PM -0000, doug.fajardo@gmail.com wrote:
> I cant seem to get A.L.F.R.E.D. to start:
> doug@dougwork:~/sdshome/alfred$ sudo alfred -b bat0
> Can't start server: interface missing

I think it's complaining because the "-i" parameter is missing.
Try using "alfread -i bat0" instead.

Regards, Linus
