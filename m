Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03114C54EED
	for <batman-adv@archiver.kernel.org>; Mon, 30 Jan 2023 14:55:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 139D3846D6
	for <batman-adv@archiver.kernel.org>; Mon, 30 Jan 2023 15:55:38 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6811A8059E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Jan 2023 15:55:11 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675090511; a=rsa-sha256;
	cv=none;
	b=0ndxmmCE+KlCwoNFyfAvBSnzgX66mNcJyUbCcHEU6B/p3Z/5apmgQjdy9HUrFEa2Ox+r7I
	059IbsgDn694juI9abpQzZQShcvv1yMGFoevQTGGgjoXR4YqRk4ICQwgyBkHMLAy55IiC/
	if/ReLJLxnFuK5Srpwv6E9l+buwQ6UA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=resnulli-us.20210112.gappssmtp.com header.s=20210112 header.b=ALK4GjXC;
	spf=none (diktynna.open-mesh.org: domain of jiri@resnulli.us has no SPF policy when checking 2a00:1450:4864:20::531) smtp.mailfrom=jiri@resnulli.us;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675090511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cUFNSHT58sfD+ju2WZCYaQZYJ90zhYTbnD18geeFktY=;
	b=SEhQoWKdixwb03DjgH5qL53hno6FUhBdOms8xQ5kBlpYSa4Xx70xILub22l36wboa0xw5C
	L5LPD5ZH+asXQJDvc+aMTsTFommnl4jRuBRT2uFmP9UUtt6QjVEkLC5oPjtn0Sm47Pg4It
	pK+uN+HQf6CdC5JKcs8Ays3Z7sgqzuo=
Received: by mail-ed1-x531.google.com with SMTP id u21so11193312edv.3
        for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 30 Jan 2023 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUFNSHT58sfD+ju2WZCYaQZYJ90zhYTbnD18geeFktY=;
        b=ALK4GjXCxrh1lAOEo8KTtBr2byHp/PcVoqxLsU7ujdfRGOEQzkSEgfNl61IJTyO9mX
         co+JQfRqWxhxENCjHdgC0n984jNVEd8RRTl5r0Rm4OZbghpWhqOMH65Dh8C9XQ0iw67H
         VVY20Xtduo1NhbJSGebOSH2XTOuSySNhfc6lsQeKlsM507lFN+9Bqcm/NnEmtKNQiY2C
         Ip8G/mJyiKg9C13edCDaIix/kmI+Qe6mGdkUCcOF6A0nRzucV3ToPvCGlEF3MZcK7nk1
         GXYXt05/6F/okHRTGZFxuy5MMOJY7YQLshAIBjSjgWqds+7VOhmig+kAPvg7Vs5sAw0M
         3IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUFNSHT58sfD+ju2WZCYaQZYJ90zhYTbnD18geeFktY=;
        b=mmtSuqsx/OK7wZRkqR5vmTSkhoAbqyBNltBS8lk0iuwihifA9+Gfz/NUwpgRI7M84p
         9d3hAFeTqk+z5BCvyPyQQ8mISqurC2RHY0mOVWxhKhkpWoG+4qELWoGJ7uiAuH4v+TGF
         ShSUdTjBzLcCTZWW2VVODAt6ECHLZJ7uFkD1v0Z2m9t+GaKM22j8J5uge1PWjfV1uwta
         OkYZJq/4iHTCnJSUvg3HD1mUi7qJAk8NDdz2VQ+XQcMgfyiJIg9ha1BYwk9FmXsB/y66
         0KG+N2KUymNEHjawiBKJIJDXZa7P1NvJ573gEsI02kTAdf+r7YqBzjAEVzy6waLGt/mB
         p/3g==
X-Gm-Message-State: AFqh2kp+CowIRY/ZW0ttTfyvO29bidirdde2gKSTt9L+NNfmClRDUl6c
	zEqGYdvlzcn9GhfVaebrzKezxw==
X-Google-Smtp-Source: AMrXdXu6ZVjQGgAN4UEO2FWcMcbLMNNCTpfEntdbkNZPyofd80Qp7oUVHdaNae/Rck0qXY//LhEm1w==
X-Received: by 2002:a05:6402:197:b0:481:420e:206d with SMTP id r23-20020a056402019700b00481420e206dmr49977701edv.42.1675090510724;
        Mon, 30 Jan 2023 06:55:10 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m15-20020a056402510f00b0049f2109e4ffsm6926926edd.50.2023.01.30.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:55:09 -0800 (PST)
Date: Mon, 30 Jan 2023 15:55:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y9faTA0rNSXg/sLD@nanopsycho>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <20230127102133.700173-2-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127102133.700173-2-sw@simonwunderlich.de>
Message-ID-Hash: WEJNV3P42FI32VASMCNFNM2L6MI5TKDW
X-Message-ID-Hash: WEJNV3P42FI32VASMCNFNM2L6MI5TKDW
X-MailFrom: jiri@resnulli.us
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WEJNV3P42FI32VASMCNFNM2L6MI5TKDW/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Fri, Jan 27, 2023 at 11:21:29AM CET, sw@simonwunderlich.de wrote:
>This version will contain all the (major or even only minor) changes for
>Linux 6.3.
>
>The version number isn't a semantic version number with major and minor
>information. It is just encoding the year of the expected publishing as
>Linux -rc1 and the number of published versions this year (starting at 0).

I wonder, what is this versioning good for?
