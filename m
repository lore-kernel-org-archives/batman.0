Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A35ACA9ED2
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 10:48:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8E43C84601
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 12:48:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791888528;
 b=2uIgddEimz/q7qORE0yFodKLyu4bBkNhMwuD5S7kd2N3HhfO7TASxPW83W1bc8730t20a
 3lW59IMAPJ7r6c9Ng9LV7/58XfbNJJwUNFF829wMBrp5hRrjAMxGxIqLC6RjlTUiepoIL67
 pgk7u5spVprnp1MEj9J4dXgp0eLFrSc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791888528; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Okj2JU2SyQ8JwvKW5IVjLLxv2wdyxFbRiFHW96zwlkU=;
 b=zEBVVyu5SEAvx6PUlBWxMF8VMlDUzAc46RAck2PBJY0I3KaF7yHfUxO2tWGtiAWCbXSo8
 Ud6Cla32YdsbnkdWL4YKrcugV3VJllDLAzj17ghsQcvknPz3JfucNjLcx6b72MDQ3g9GGab
 I/oNxQVgblxsBaV3m0kbA91RO69bgQY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EC1CE80807
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 12:48:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791888518;
	b=IJi81WixqbeNm9djDd1zHt01TljHwJjdkL+EKf7cjXsu+IVjpZMcd1xvz/Kbg/65q/iX30
	uyUrieUfBJbJyJV7wr8uApgsfoIYOAmlbfYSugGUPbyBSgWImOx7Ec6R5Dvd5ayLHItFsx
	vM1siRrSUShBFb0Dpri0ArSKXySiZSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791888518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okj2JU2SyQ8JwvKW5IVjLLxv2wdyxFbRiFHW96zwlkU=;
	b=n2/2im2/Q0NkYSCNyTmyzPRMr4kxoRLSmg1QYqJxzxF3o+pvaknXMnSkanM5QCas9VErrL
	KODtqBhv7NgZ3vWe3t1d5JrAijTqC3Q3K87N1HiGPtZ88g8CtCx0z+oDRseKN8YQoc5UrV
	20EHhxZy8oGHrGDbHaWRsSmKKaa4iW8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFF7F23539;
	Tue, 13 Oct 2026 12:48:26 +0200 (CEST)
Date: Tue, 13 Oct 2026 12:48:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH batadv] batman-adv: mcast: explicitly initialize
 mcast.num_want_all_rtr{4,6)
Message-ID: <as4MenkBYiGiD339@sellars>
References: <20261012-mcast_atomic_init-v1-1-eb8d129802bf@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012-mcast_atomic_init-v1-1-eb8d129802bf@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 6BR5RZOCLGB5SVI64RV24GBD27C3YWBQ
X-Message-ID-Hash: 6BR5RZOCLGB5SVI64RV24GBD27C3YWBQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6BR5RZOCLGB5SVI64RV24GBD27C3YWBQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, Oct 12, 2026 at 01:48:37PM +0200, Sven Eckelmann wrote:
> All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
> the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
> moment, it works because atomic_set just initializes it to 0 and the netdev
> private data is already set to 0 before being passed to .ndo_init.
> 
> For consistency purposes, also initialize mcast.num_want_all_rtr4 +
> mcast.num_want_all_rtr6 explicitly.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-9dbe5dec-31ae-49eb-838a-b4b92ced4ace
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
