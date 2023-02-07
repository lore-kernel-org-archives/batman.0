Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FC4C636CC
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 11:20:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4EFB8847B4
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 12:20:39 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5F513809E6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Feb 2023 12:20:15 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675768815; a=rsa-sha256;
	cv=none;
	b=2NW1/vGdf3J0BBV6jx6Y1Jlf8rHyVoN9oRtUSbKu8qbOfWRYe2zkcl0m4VZvFehZcDB1Pu
	7JoHUaqUmiO2O3xDKcmEBPmHKS12E7wXaWKzqYzHrDv6TZUk7O9qUsOXYptiUxIlVCegim
	DCKmI7RbiAOuAGycDKGiwcBxTYwGLmw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=M5QmM7O0;
	spf=pass (diktynna.open-mesh.org: domain of leon@kernel.org designates 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=leon@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675768815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zEjNh4ctBwNftmNH7PqbIWDNSiGDEosjwMjPvSClzEc=;
	b=abavTAtE8E4YqLC6VSr1TitUg6qETLx9QiyuXKO0sWDckms6AP9PU7k8HIhS3iSxZz6bM3
	wXoTuKakFe4JM3xE+EqsD9CCGsdPNSe3F1iYn7LElm8KqxQ73YrNI43YJOGfoPAvfXJG57
	KOz+DT4IJq4qAV5d4QwKtJRDUFL5ALY=
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DBBA611BD;
	Tue,  7 Feb 2023 11:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225E5C433D2;
	Tue,  7 Feb 2023 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675768813;
	bh=6f3B48rxmBQjdRWhohv4VFKJPegEtPUeHZvgP80nCeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5QmM7O0O0esedqalWyLlFR3hQl6ia6SGe72stnwL6n7iqwmgN35D0ul1EyCeGnS2
	 8TCxipSWSl+0D687TcK9FlBSC9pxuiZC6ERD7EV2B/gqprZxLGZ0jAPtMITYMdPLWG
	 9c4P9r8hrJsUbJuj3Es48TXXlHWFiSO/bzxowJDarLQohS52YsVQnDNrtyZt4cF2gr
	 p//VZQnLd1i+00whdGxTafsB95SdlPUKuSMGYUhTmbM5BNVg5h9Rm31r59kzgb1n3z
	 YqJE/24yxIoTk+e/po+UdX6JWMa4BkQjGGbJFvEEvbAhLdogQ0ZIErdghQccgQovAd
	 s4phmzNerUNeQ==
Date: Tue, 7 Feb 2023 13:20:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y+Iz6dYsiwXnPCUw@unreal>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <4503106.V25eIC5XRa@ripper>
 <Y+Iq8dv0QZGebBFU@unreal>
 <3940036.VdNmn5OnKV@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3940036.VdNmn5OnKV@ripper>
Message-ID-Hash: MAITBOGDWTFUGAYQANJ2WTKTUZJ3RV6Q
X-Message-ID-Hash: MAITBOGDWTFUGAYQANJ2WTKTUZJ3RV6Q
X-MailFrom: leon@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
CC: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MAITBOGDWTFUGAYQANJ2WTKTUZJ3RV6Q/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Feb 07, 2023 at 11:57:41AM +0100, Sven Eckelmann wrote:
> On Tuesday, 7 February 2023 11:41:53 CET Leon Romanovsky wrote:
> > Once you stop to update version, you will push users to look on the real
> > version (kernel) which really matters.
> 
> I would have understood if you say "let us use a magic value like 'in-tree' or 
> 'linux'" but setting it to an old (existing) version number - I don't want to 
> live with the headaches it creates. Because this is what users often don't 
> (want) to understand: if it looks like a valid version number, why isn't it 
> the valid version number? So I have to do a lot of pushing - without any 
> rewards because it is necessary to push every new "user".

I'm not sharing your view about users and think they need to be educated,
even it is hard and non-rewarding job.

Thanks

> 
> Kind regards,
> 	Sven

