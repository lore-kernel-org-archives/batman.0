Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA36C47DB3
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 20:03:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB74C828CF
	for <batman@archiver.kernel.org>; Mon, 29 Jan 2024 21:03:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706558617;
 b=iVPno0vC19EA5wy9Bdr3bHgnVnWQg/u20lVcyWEAWG2AOknWOcD4+GW3x16mhXL5uCd68
 E86G5WFrqlGsiuR6Nx5EofiG2+vo35PBUWHEBRaLDhtOnQ4M5Tweg0HrD65mTY8Ln+CocdU
 st4aXGQBslHKylek/8duhraI/PyRfAM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706558617; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iDC7Xap4Ui1ZBtPIINtgmdV6ni23mZyMeXB6CVkxSK0=;
 b=wOG7eVvhJP1uvVotnwL8f6QyBBNAeJX6/Uqa6GTPLLe3rB84ct6mJ7Lwac17p5/GJYpvS
 dOHRR7xEWf5zV5tMPfIQonvnHEY7mvwBI2voikcA1yEe2qvFnqpLlzR2iQ5S0joA4S3Q5T5
 6rD+EGqvl/mnV9o6B2ghHCtLofIJVCE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A9B4F81519
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Jan 2024 21:03:33 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706558613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iDC7Xap4Ui1ZBtPIINtgmdV6ni23mZyMeXB6CVkxSK0=;
	b=3DiETejMQ/fqqYX2gE8Si4CKef0ihCu7a7GdkZYn5JbI+UixxWQNgjYDe20+te81E3SaS+
	WRBvkTGbbe/3lvOXITUkEglJRJ58Bn4ktwCokIrg93c6UiS9Y+psJbvYniOjv9D8ARTGon
	C7u1tlmO7ERAb7dtPbZY44w1EfY0xsc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=jIWvR4h8;
	spf=pass (diktynna.open-mesh.org: domain of doug.fajardo@gmail.com designates
 2607:f8b0:4864:20::1129 as permitted sender)
 smtp.mailfrom=doug.fajardo@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706558613; a=rsa-sha256;
	cv=none;
	b=T9dMsO2lL2ufwgAe3cfFC/Fzs+82eC412V5VNMGif/kU9AnNStbKzl0NfmIkuStxR8I09n
	ZVaMY6zE4dmul3PodrcfXJAMCc+65dwNU6c9KgqTCS/Wn+fvpRZP/GlI4/HZK+FcrDA+Gc
	UNzhz6YTUuN6FgHDQRnccJb/YYU52K4=
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ffb07bed9bso27523407b3.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 29 Jan 2024 12:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706558612; x=1707163412;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDC7Xap4Ui1ZBtPIINtgmdV6ni23mZyMeXB6CVkxSK0=;
        b=jIWvR4h8DffBO8D1BPLYkRPxYHbcvfh3IWiHctp5s6QdVI/VZyYUlJpRzPR4Zskvne
         XIZaFVWsIQIZ5D3nGYCxuv3E1oZjWnM17qixSbdmlHOVS5kLZ6djaxejASwlNpHtLX1n
         W9HfBGJ1MCKZuQIvVMl2tS2zkFX/pgRvENJlXPMNjufw2ht5biDAoxUw+2fg9aObv9CJ
         bm0tbVlI7juGzGiOPsXU6lrrFlAN4mgdKPm4LXyW05mNslIj7rw65CtHEBS1448ygxEP
         33RqXN1ZlY6P4aeD3USXUs3sdFDN//O5GSSJUHvgVFU6zk0eZ4GefDxXhD3MOwV62MK9
         ezvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558612; x=1707163412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDC7Xap4Ui1ZBtPIINtgmdV6ni23mZyMeXB6CVkxSK0=;
        b=P7y0Lqyh3dq2PZu8/mml4m0zIYYTeno/EajtCD5FxQMMI3q335g91XpKPwB3YwBGsk
         eomuLZVYCdeAcGwPLmndytCrEKBT1BedJefpFFEh6p97085aLdAhVJz6vKbIcra09zTi
         1WiI1o6oMFUmCiAfBxEklcbsB4PnkCCfAtJv/49P2rpyTqp+woX40hLNoNtm3y+PlAKq
         lxR7XikkRWQDqRlzGvVCU1EWdHQ/bVfq30/RRrDx7HWxBA9XMK3N5I7dmloZjvkRo6gu
         //yqyi8swTdtojB0z3ClwGAJ6uZ+vQqiwZLMfkPFc4LcI/scqGaU152UJfR6j6HyQBAB
         tJvw==
X-Gm-Message-State: AOJu0Yw7rNFfcnBkkiM6Et9OBD8DhUStc4LuYy+xqaBjjmkPX4idYctd
	v3PCOC9oTALSjRd3l8I3N/Qf+7mEp/wn6091D34awPoU+1zNIZPcHtEhsM8Fww8=
X-Google-Smtp-Source: 
 AGHT+IGit9KEAyRCfSFh5IspJy66Ll0Sgda6IVMtEDmRiJUDuZQOMeNQPs81bnUACVLwMb6SMOijag==
X-Received: by 2002:a81:a801:0:b0:5ef:4a7d:2426 with SMTP id
 f1-20020a81a801000000b005ef4a7d2426mr4289428ywh.31.1706558612112;
        Mon, 29 Jan 2024 12:03:32 -0800 (PST)
Received: from ?IPV6:2601:589:4200:2a70:2556:ddea:9b4b:18f1?
 ([2601:589:4200:2a70:2556:ddea:9b4b:18f1])
        by smtp.gmail.com with ESMTPSA id
 x84-20020a0dd557000000b005ffa1fbfa7esm2655136ywd.101.2024.01.29.12.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:03:31 -0800 (PST)
Message-ID: <2fd7c965-3e7d-4919-9239-a64034f5dd21@gmail.com>
Date: Mon, 29 Jan 2024 15:03:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem starting A.L.F.R.E.D on batman-adv?
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
References: <170648094014.1056.17522976996217024998@diktynna.open-mesh.org>
 <ZbcVQNKlNso0D9l9@sellars>
Content-Language: en-US
From: Doug Fajardo <doug.fajardo@gmail.com>
In-Reply-To: <ZbcVQNKlNso0D9l9@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: B3PZFEY2QMXLOT6B4HJUQMJEVFJRNE6D
X-Message-ID-Hash: B3PZFEY2QMXLOT6B4HJUQMJEVFJRNE6D
X-MailFrom: doug.fajardo@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B3PZFEY2QMXLOT6B4HJUQMJEVFJRNE6D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On 1/28/24 22:02, Linus Lüssing wrote:
> On Sun, Jan 28, 2024 at 10:29:00PM -0000, doug.fajardo@gmail.com wrote:
>> I cant seem to get A.L.F.R.E.D. to start:
>> doug@dougwork:~/sdshome/alfred$ sudo alfred -b bat0
>> Can't start server: interface missing
> I think it's complaining because the "-i" parameter is missing.
> Try using "alfread -i bat0" instead.
>
> Regards, Linus

Linus - Thanks for your quick response. I tried this,  but it didn't 
work... Response was:

    doug@dougwork: sudo alfred -i bat0 -m

    can't bind: Cannot assign requested address

    Failed to open interfaces.

*** Doug


