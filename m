Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6629C28B28
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 13:44:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0FCA883BC9
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 14:44:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742305478;
 b=JsnnkPMGtvwWQXbIPoGem9yVtXQMsTQsx8u+tFmzmcW+vAXE4leKxSyGtUGVdhgvHu+Xb
 crDDU7XdIYrkYHONQVBZKtUg7C4j/163irGAxFIPLm84CuK+rvbMKlHv+igi4KrqgHQ4QuI
 Ag2wQ5e0K536zHx/wL/HtGwtEvtbShc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742305478; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
 b=vMgNKSnpUByUQQHjEsoaXI9IYHXzfSWZuF+GCo4IFHZpssI2wLcWaNB8a5vvaq0MkMn0I
 Xc7iFgogRbc19ozqYfU1njk5dt+pbYzZJTuPN4Q6fJYyanVd6B0M9ze3JZfC1Kw/bI2+hux
 wvMmprWxjGwSutcnxpzN9A010kmuNw4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B228281EFE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 18 Mar 2025 12:05:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742295961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
	b=NBLnbZXtLs6Gl1N4eU2f0c8UPorJPi7lFraHnJrp1XxltLrtPhNuOCUYkyOwtOQ+TtTBxZ
	bMu1KwSSnyXVmTnUTEGkcS2Fhlqx6dTJ9s/7VQjQ8JVsKx9cw0AVXDggnZmGp7G0ilBunf
	VTLndvQqKDXvMp7PXexArDhj/O/7K0s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=d2zdxkYZ;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742295961; a=rsa-sha256;
	cv=none;
	b=gTQTl3g6x86ui6c0pK65F1XRA+EUW+B/mGMDKGNZ6Ar8ZiLg23YOZD0mE0qAM/1mS1o7gx
	Ny56vdUGRvo1f6m3Ngf0v2rl5VhmO/bJHeFu3ZrD7yrS6Q0SRaW2ZYOknjKg9eUbZyJLhB
	4joWRE1wRt54AZ9diJnVKZfmF8fwj08=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742295957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
	b=d2zdxkYZDeC228ac64ioMhLuEtZDTrMqC4DqGi9VnTtOyVZvxtZeTYWHCULse/3cdvY2Km
	zv1MlwGn5RV4AnQQbQ1hkYUfMxs42FHqPHoJgqe5jyHS4sLHeFp2XrMDR7+g3gQOUIN62F
	OK2+3LdTWcnfThIui3ktUeJX0mDcK4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-2uMk0xPJMpG7wVL5bVocyg-1; Tue, 18 Mar 2025 07:05:56 -0400
X-MC-Unique: 2uMk0xPJMpG7wVL5bVocyg-1
X-Mimecast-MFC-AGG-ID: 2uMk0xPJMpG7wVL5bVocyg_1742295955
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so22004975e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 18 Mar 2025 04:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295955; x=1742900755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
        b=Lyyexml1hcW0L3xGaXyhmvUIQt+gnlDS4kWUOjGOvgT02nDYGaNgAqHJSeD6hKCyw1
         DVRlfBdX4qV7qvmNP+CjxTBiS7tf/VxqJp5Ua7b1VS3kp1dES0RNLONvPUyHgaLIc3Bf
         nE344L07n2/c/AYEs91ZLW8Tz2o6zzBVLgl+63CCih+w7tdcNLWFDAY38mI6tNQYFesm
         8i1inL2fCxwPjPCkh5FKlm2sAw90MJyAMJCd33BciHN7IWrXL8kT9TjUm7U/xrUlot7o
         5oNY032uXjeqw4lx8xfBdUHtXq7Ec4iubpbgnPDPeatcPh0pO3/2j0dlvX3yC/qt8gOn
         vZlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwlPNJCo6GTUWx2NDpKHesA1g1PsofWRbi6V5YtuFBrkY0p+D6E9Oyi9u2UWUJGJAT3NVPxnLLsaugLA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxTZy/FQHCXEEX8MCy9xQM7lwxgoUvSnn7x8BzII8hkOlUcRCm1
	6qsI7V5eI1IbeEdsd4SrTSadCYNy5tRep+N+niCnoYvWg0a737tUeuI2L/NDtA/OaTlXIW4a/GU
	1XpjY64Ii1cz2gCY7sMqzQQO3mzpIfA4ax9HgkhvVg7jT2fiRuKW70uFmiWyG0/Lzg0hCsxcw2g
	Co
X-Gm-Gg: ASbGncudgd7DRzniySDnAz3POW3T2vBldAbNj46nP/0MBVuDgn/D0nv2lF8zm7dHf+6
	JBb21+k5vHOl1d5EckDsbrBtmKGlLfYgNkf1swrPSFen8qXyq/wMzfQVllTcffgowwa25Cq4USZ
	0CMEWs2g2z8EBCvohKNQWVLdCS7sXxt9psKKsSgQyyKQEKXyZBh++6cx3vDUOBvcQSdV0H8I7xs
	bCV2h96XZYJ+6VeFD80q+UlZgwvUnZZ+G9EiITGHo9IIsPmrQrtUI1Vk4ldxKA/7AKiD+AJFmHO
	Q/ijk4AKriqpdnNHDy0TQqKvDyTu516xldFKxfhFD8t38Q==
X-Received: by 2002:a05:600c:34c7:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-43d3b951a70mr16594205e9.6.1742295954666;
        Tue, 18 Mar 2025 04:05:54 -0700 (PDT)
X-Google-Smtp-Source: 
 AGHT+IGjOQJ9N2uizMg7NPUyYVTQbobEjlEhqs1ZRY7mDMuFURwbgXUYvDp8nOZ2LQ0I+DuyUV9WnQ==
X-Received: by 2002:a05:600c:34c7:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-43d3b951a70mr16594015e9.6.1742295954311;
        Tue, 18 Mar 2025 04:05:54 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb92csm18225173f8f.91.2025.03.18.04.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:05:53 -0700 (PDT)
Message-ID: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
Date: Tue, 18 Mar 2025 12:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
References: <20250313161738.71299-1-sw@simonwunderlich.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _STsb50S4JOTcGr0zMyK_EmMHrYDndHJcuwU_Na_ktU_1742295955
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: SIVQ3EQ5INH272HICXDHEMR5KAQEDGIZ
X-Message-ID-Hash: SIVQ3EQ5INH272HICXDHEMR5KAQEDGIZ
X-Mailman-Approved-At: Tue, 18 Mar 2025 14:44:21 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SIVQ3EQ5INH272HICXDHEMR5KAQEDGIZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On 3/13/25 5:17 PM, Simon Wunderlich wrote:
> here are some bugfixes for batman-adv which we would like to have integrated into net.
> 
> Please pull or let me know of any problem!

I'm sorry, we are lagging behind.

The series does not apply cleanly to the net tree, could you please
rebase it?

While at it, could you please include the target tree in the subj prefix?

Thanks!

Paolo

