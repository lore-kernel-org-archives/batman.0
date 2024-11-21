Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E591D7877C
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 15:11:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E264E842E1
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 16:10:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732201859;
 b=06+9OKRX/4mFtfz9pPbGAPRMugEiEC6cQkutLF2VKZHyBIM4sLcsjq5k/NNDfuo/4b0Rx
 oyudN9BUcOlRL8fM+0JG/SbZZkJxtJO4GRmuVki4aiUn5GsGGv8sqObwp7RnGxFQ8VRqitU
 ryHKjosLUtQQ9OQplAysmWfwnxIsecc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732201859; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wbWpG48KdtQgSur7aKJDWmhhjFTSvWHddRqarxTPVFk=;
 b=k0H4IDXcyZAg9SvaGfpRMRdaYpSNY/A2E3yGqPkC5i4boZ0pIDAY+kkEpzRMGS+P/HqwW
 ZkbapURwdz382QPWMIp8kgVyvpvLwMQ//iSaFofgJzmiIyrzadQWmnsYK8A59oxkclb9GI+
 FmKtoJHD/vHeFBgcn5bdjhuX+EVvG40=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E04CA8428D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 16:10:47 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732201847; a=rsa-sha256;
	cv=none;
	b=rfnQExYzla/uv7a31SxJ85T22N9nr44nXHKUzbSgERSOeWwUfhItHRAZCfnH7TQhCqAz9L
	F3wGYPTbFUd3S23ZPraeQdCuPupEKNbP6VmsIk7yWnSUJQOXG9NKCKYU8ToD6mQij2PdJ5
	A8gWfQUHtDpqMAfnHFd1XSr0GdxEE7Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=gosjTMJN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nico.escande@gmail.com designates
 2a00:1450:4864:20::12c as permitted sender)
 smtp.mailfrom=nico.escande@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732201847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wbWpG48KdtQgSur7aKJDWmhhjFTSvWHddRqarxTPVFk=;
	b=NlGvHDBlHAbRBCq7Tks/jYbUqReR7y25/4mOEaCRtiVNWgmN8n6u+sIi4OxChimPJC0mHF
	eXPWXn0lW2GyDS7mKHqGf+ZrtEFOamgkB9Dyq+SZHaAcLfO6BYECC1tL7M0Bzxopwf+yr/
	asJSUCRHNAMYeiTTcMPCiM5s3uMImfo=
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53da2140769so1096585e87.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 21 Nov 2024 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732201847; x=1732806647;
 darn=lists.open-mesh.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbWpG48KdtQgSur7aKJDWmhhjFTSvWHddRqarxTPVFk=;
        b=gosjTMJN13GhfbYzGxxudlt1YHpkl4YF7Z90UZan0/GIXHp7YRRYPKZi3WUzrIkLQQ
         WCcWGm1sYK2hQoY0DOqDIfkn1m5mC2I8v/0eBTSnAtnhmX4dq42ebLeraMw3/nQg0LYf
         tIZ+eurGmGFrnVcoFPRYF/Kiq1LUX/uIbcHeI1fKwuYRDMRdtzoblP9XOcCAziEx/UdP
         rpJYC2LVTz8bsOsQM0tKd23ZzZquzK6Tr1cY7qPS6uYsN1l2e9d6PbQHpWDc2iESsCPh
         YF8t2JB4oiKCBYqg3EXO+4whcsVkVSjF3nMV8Ll9dJrSGgqZyA+Kf7MuKwMh4W+e7iBV
         nMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201847; x=1732806647;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbWpG48KdtQgSur7aKJDWmhhjFTSvWHddRqarxTPVFk=;
        b=uypSTKn/XZBrsPACy0x1/mlNwCHOf9U89okEKIz6rpE9rkTcfHtc0OaGhm5sTmRblO
         qr5tBTVYS8hKRbgxfS95rxtvbZ1tEej/02xEb3lbddl61Rx2k56spfWMiiPcqW1jz4I5
         eP68aEbP/OWT9Lo1Apm54xAFvBR8xhEr0RVwRbtf9/XQhdWpKJ7dO17viBWKSG8eyK6K
         7DJFiH/3nEcqshc7PR8ERBTGTKIC1Vb8MuFG0IkbLFoL6+Yd1rvig/RyRNuuJpzv6CNu
         aj0IPYQbbnhOCDef4U0z/HwcmvYopLReN1xHaI1CO7xrgLzyoM22xJyWBoWuTbVv3Wq3
         6BsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ7xUDgeeLHPjKXncm3shAinCWgbdvn7QuVQ4A0pW5bH6/1+Ayu17S4x1wQNE/DKpmZm8r7HJPuZ5YbQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyc2mspYQ5jQxkrAHTDiBWyHBod6+UZTIAgNik6zSniutllDyV+
	tPSqSpoTPcH+RvXozTyJd2BkdgDqb7bsFd4nN+U8c6bVSRo394jV
X-Gm-Gg: ASbGncsZDU6nH3X7oz+gVMwV5YsqBTaT7sNdCcfCTh5TWLi8ybk3pTpeqIcJyBxoV/c
	4ZxUboSyzcSUlTb9h1FleUcg7kFlgCYb7bAUDkA//cR5+TUOlHmBEi8MR2I+Evt1DVqwlgqYjfU
	ff01vlqCS0vLND0OMqNfS0LIXzPqOTMlg2GJXVKorgVixeSofRZPDogWybULhAZA2NjPNJe/fy2
	8jah22LUGsVMyB9zMq4/PhFzlcJJyIyRfSNVTjbua6r1G6N3JtoigjPQk0F085BUZRM
X-Google-Smtp-Source: 
 AGHT+IGVjtKHE43Ev49CLxmyWMhdFc/aKwEq+gfUojmNgJNKaobtr9hqhtNt2dA4Xv/MXdZf2OzG0w==
X-Received: by 2002:a05:6512:31cb:b0:53d:d202:57df with SMTP id
 2adb3069b0e04-53dd2025860mr175781e87.10.1732201846679;
        Thu, 21 Nov 2024 07:10:46 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ab44sm61320685e9.30.2024.11.21.07.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:10:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Nov 2024 16:10:45 +0100
Message-Id: <D5RYB29K4VH1.2I26Q6OMZX39J@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: "Sven Eckelmann" <sven@narfation.org>, <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [PATCH v2] batman-adv: add dynamic, bridged-in TT VID detection
 support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
 <6100761.lOV4Wx5bFT@ripper> <D5LZJSJADA7Y.35OPLU5VTB46Y@gmail.com>
 <ZzY8CdiUV_sYsHul@sellars>
In-Reply-To: <ZzY8CdiUV_sYsHul@sellars>
Message-ID-Hash: DIMAUP4B7C64QY3P6CEOB2ZYKBGIE3BP
X-Message-ID-Hash: DIMAUP4B7C64QY3P6CEOB2ZYKBGIE3BP
X-MailFrom: nico.escande@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DIMAUP4B7C64QY3P6CEOB2ZYKBGIE3BP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu Nov 14, 2024 at 7:06 PM CET, Linus L=C3=BCssing wrote:
> Hi Nicolas,
>
> Many thanks for your feedback!
>
[...]
>
> > >
> > > I am not in favour of changing the behavior of batman-adv. Now everyo=
ne can=20
> > > increase the number of managed VLANs without any control by the node =
admin.
>
> Valid concern. Especially as each added VLAN is quite costly for
> an OGM at the moment. A VLAN with one MAC address adds 12 bytes to
> a 24 bytes base OGM IV length (excluding ethernet header and other
> TVLVs).
>
> However in a way for non-VLAN TT entries this is also partially a concern=
,
> right? Someone could also flood source MAC addresses in an uncontrolled
> way, too. (Though would likely have to actively keep roaming to create a
> constant extra overhead.)
>
> Maybe it would make sense to check how the Linux bridge approaches
> this?
>
> It seems there is an admin configurable limit of
> BR_MULTICAST_DEFAULT_HASH_MAX =3D 4096 entries for the MDB
> (multicast MAC addresses).
> And a configurable fdb_max_learned (disabled by default, for
> backwards compatibility reasons according to bdb4dfda3b) for the
> FDB (unicast MAC addresse).
> Thirdly, it seems 4096 VLANs are allowed (VLAN_N_VID), the maximum
> amount. Though this one does not seem configurable.
>
> Would it maybe make sense to have a knob and by default set the
> limit to 8 or 16 VLANs? A default which could maybe be increased if the
> OGM size was decoupled from the amount of VLANs in the future?
>
I really like this idea. This either could be a compile time knob or a dyna=
mic
one to ensure we don't easilly have a too big OGM

> ---
>
> The two reasons I would like to have a dynamic VLAN feature,
> especially for wireless community mesh networks:
>
> Allow a group of people to setup and use their own address space
> when the centrally managed, default one does not match their
> needs. -> decentralization
>
> Allow to get rid of the unused VID=3D0 and VID=3D1 entries by default,
> only dynamically learn them, to typically reduce the OGM overhead
> by at least 2*12 bytes. To partially mitigate the overhead regression
> we introduced by adding TT in compat 15.
>
> ---
>
> Just my overall, conceptual thoughts on this feature. Will look into the
> refcount issue later, thanks for reporting!
>
> Regards, Linus

Thanks
