Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A60C55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:28:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5C19B841F7
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:28:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785839315;
 b=uYhY2lUqwMj7s8F94kiMU1Wm61nEjqk9XngMUChSJJw+fKldaTajAg4C+1C31mJBKkJdc
 KMDM8wyYDsEMAylYRuy+xLoUnJOEhHVRIUbPZsiyUb8n7I0nmZ6Z5YbC9F2mfQXnTpGtiJz
 Ds9k17+vLvlt+LdNTwpmnH6DdOUTbdc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785839315; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
 b=O5anj7zHvgWEyaTES5SFZ0IwdpRu1n5wiOHAcnSXtvobI7GK0HPl70abidousHkDs32oJ
 p5L3dSQXfo6a93/+A7qJok83fadqBumAzJ3cqZ3wY5H9PM+JcJpHfn35EJw2qt55VEMaIGH
 s63ESIr26BSUcaXCnKJAE+s6CQ52g3Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass header.from=redhat.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9E03A841A1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:19:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838760;
	b=Im746G8bllKrdGYF9bwHU4/N24ncsJ4HODIeekFF7PnXIxnK3h+cVwN4Pvu9NxLGG5Lhzp
	lHNEgDQVbFSP60pfq2EtGQYCDUmhKSdIPmuBrMGnEc1vjN6I2qiRwWfxWZJcaN4eaLNzRo
	RhXDYBLOOe8qjcynnsNqjT5f6Prdh2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
	b=Rshfu4e4yHiTbZ+VgNb1xWWLjJ7tVdJ9GxeIP5ICiZMc2EZ3V3/7lGuScvYmqGdcblPVNf
	YQE50F6ikRkoS3ikczeRMYQzbaCJNHjMio0IPbprDrGuvC8It4F5YYeOOyTuiDWR2Zpqd5
	r14iuL1fwkAHd2xvmMRLF6IzCa/b3wU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="PI+VZE/w";
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785838758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
	b=PI+VZE/wN+gjgNNgpLgFaadEgRdIROnT6REbhiDqwVyreDHHQ6DxFyFDCGhEcBNa7KMlbb
	0nA+OcLh1uJScTYRrMeAqfby2PcuvCkQhWpw4GjJ5qnUYLMIjdJCtgWaLfdnFeV0QRiukc
	qBrMtn8AmHmTocG0/HV/CA1adsZpzzY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-ZKZcEHdnOtWyMjTg2PU8Dg-1; Tue, 04 Aug 2026 06:19:16 -0400
X-MC-Unique: ZKZcEHdnOtWyMjTg2PU8Dg-1
X-Mimecast-MFC-AGG-ID: ZKZcEHdnOtWyMjTg2PU8Dg_1785838755
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f8398ed9fso4019201f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Aug 2026 03:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838755; x=1786443555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzb00odwnuqamB0eFtSgtNSpu/QbK+4/YzTl3UzECKk=;
        b=FEBhdAY7yjaT1dT5+O6a8jq+rz6HMzFWy3evg3kTiG3JJoYqUAZ02dU8RaUlP8CB7f
         vYheg791FSoaXc0/4EvWxou2t9YPsl5ktDI84jXyvwX/aesTRuhSUd3Uz9ZHiu9egvHX
         u1FRUWsoPFuNs8L5t9yi0BRIKVuG1i4HXUcQRKvl0D+gDWe0FGbLtrw2+r2X4CS30Epi
         dgiVk29BHidxfjtEvGBfBoHBPCk2AnrJDQX5XIWWtB8I+2Hn6NLERrfNjOs0rp9ZfNG+
         nlx46tUZAHV1+jYGomZW5b0lKplCcv+6F79fpq4zWMbPq0M/ZGZp9z8bq6SI6DZiG78J
         47nA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL5oWAe0o57Bllv4lu+lRKqH4J7N0IzKDUsVo51/m5d+zvjFdG6f/wkpqhriXV59uMI3jFRoL8ZZE+bg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzBvi7t/A+xkUf2y90e8jyGduva/dplmO92ekPYrs7/DhrgkbMN
	rHZqSmD3eUL0aQYSSPCtMZFiAXkUjSrbL0aMwOXPfMSn6DEvhu7cHn0yVp46y1PSMKCNKiQLOHY
	gYHSWtrks/R1jYa39U2Il50tHOHSrtZrRrg3k1Uhn9K1JCitdOFzyi8qRAlbOXRs2jDjeRA==
X-Gm-Gg: AR+sD12ouz4FaVlvtipeW4szbYebtffX4T5W2cZGoL0GNYvdlWn0b69v+olB1ofEKGj
	BMRV4drUyNg7PcLvPp03NdBmMSG0kx96AczUYn1HwYTUJQwcJEqdpn547H+aJmUttI9nvTdW9AZ
	kQSQOhTYylKdTrl/IRHTedKArQC8X/0rxV/U433UEHQo3BX4T1bQs3Q9EumIUEjexVtcsu4GfEP
	QVuJ4A6oMup1uUcv+4LQ+cECDnPJwawy0TWB8Cz2ZmPp0bauQSe/heUEAsi4goY7CXDkFod0nYG
	dosDW148FM/XWEteGjLyRQgaAdnDU6w+hLDTAVObFUFKPeQuCIzy0JVLHAbYWBF6aSs1wB/bXAK
	urOy3JLHSRO87/Mqpe2v9yvHrv3mLYTlLKSgUaygnACYsVtPi7ogX4y3QkjJqFpjLjG4CMFPxu1
	k=
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-47fd729e70dmr35637181f8f.4.1785838755228;
        Tue, 04 Aug 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-47fd729e70dmr35637081f8f.4.1785838754815;
        Tue, 04 Aug 2026 03:19:14 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it.
 [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm41800360f8f.7.2026.08.04.03.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:19:14 -0700 (PDT)
Message-ID: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
Date: Tue, 4 Aug 2026 12:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2FFJgBOTb0lYCJjEQZMD_-uNZ4_2gLErhvWatNv_DWA_1785838755
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 6RUBJFUIIZE2E7J6TASF7PMT5DO2RJ3U
X-Message-ID-Hash: 6RUBJFUIIZE2E7J6TASF7PMT5DO2RJ3U
X-Mailman-Approved-At: Tue, 04 Aug 2026 12:28:19 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6RUBJFUIIZE2E7J6TASF7PMT5DO2RJ3U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 7/28/26 3:39 PM, Simon Wunderlich wrote:
> Dear net maintainers,
> 
> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Note that it's preferred to avoid fixes and stable tags for changes
targeting the net-next tree. If the fixes are really minor, both could
possibly safely dropped. If there is some real problem behind, such
changes should instead target the net tree.

Can you easily rebase your tree and adjust the PR vs the above?

Also note that sashiko nipa has something to say, but that could be a
follow-up, AFAICS:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-1-sw%40simonwunderlich.de

/P

