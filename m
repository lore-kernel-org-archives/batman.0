Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A76C282EC
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 15:36:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 46ABE83CFE
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 16:36:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742312161;
 b=DSHiYlJZKu1j6KOiW+XqI3qPlzcmQlWpEqz1V4q65KyhkhgR39WPxNxNuTOzgdthgiteW
 ZDkxZ44KX3uzH3U7EGeF3NswbXhs8ftCpnaPQnaVgSTc75Ac+DvGl1Z3NzSO8Ouut+4uIWb
 wDfhH1AYPFrR0/9Ux14S3vcsimMtbvg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742312161; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
 b=0MTKjqVIcVTNtrrXvhI1r9kB2U+jC9sp1kLOKBBOopBg/omMuzTmdO0dIJF+WkJ5XErS8
 DEWD+i/GlyFsprz9jnpD9BtJMsgJvkEe9zU/lO84FvDkHnc933+JBP9FF+GfafvwdGicQgd
 yDdOoRHp7RV7ZYZ7TlhO6E0nJBrDA8w=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=redhat.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=redhat.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0A81C81E85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 18 Mar 2025 15:28:26 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742308117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
	b=WwQ6Bs7bBSe+E/L3zbDhGUO5XtGhF6FYcmsmd7AR3dvA02GNn4JKRkUWiYZHKuNGEQhv3A
	EGW1WTxuSYDGlBsZUMdHm9Ype32qwmyz40F4AfCLRJD+puppOjFV6skr5eur5DELoksWOg
	e0vTmHDiMDexFR7oLhYFaMSUJTf89gw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ExkB6O92;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742308117; a=rsa-sha256;
	cv=none;
	b=JSulyR1MGJb8+M2c4Ua9y01Mq5GWbaWSBftSpYnDIMlijjFzaqc2MOMUsuenzF7rVSGaNN
	Umh4fXx58TjPZp7Xly3QtV+5XuTmVUbnYCJ9VsjEjLnm/mMUMf0BISo2F2HBznEtnVDM3L
	XA6i9BkHi+TM0bCmKe1R/6GBihGJZeM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742308105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
	b=ExkB6O92P9igbwVjX/rHzInUPm6XnlkLbVgiodqd/uL16sNMWjIUbcSncVDWvwF/lxWR7X
	gZU26AfKdkiJzvUwkmxpecMhPvmpFHl533GbpjscYMS7AT7SwVHumv+EExej+cFY5gzuF1
	TtK54EbIutQEh177jeJjlmWkfldK7yk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-dtV1Ua0QMHKPp0jV5pA-eQ-1; Tue, 18 Mar 2025 10:28:23 -0400
X-MC-Unique: dtV1Ua0QMHKPp0jV5pA-eQ-1
X-Mimecast-MFC-AGG-ID: dtV1Ua0QMHKPp0jV5pA-eQ_1742308102
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471ddso3064427f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 18 Mar 2025 07:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308102; x=1742912902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
        b=tsy/YS7D2fvHHqmvK/nEiAbQmzSsxDfMET9auT+x/udsr/QMJfdxP0ulFCHycyZ2pw
         0BwTaUe3HyYF1mgZOKZFb0LYiahYvgr9UebhnXAxE9Q+/urpnbAkjWMX7TJ7EiseMmha
         BrhllkH24gWb/ElEJqx/rH8+Z7QpOMu+DQbxaPiHmzA0xaWXWf1xImFWXspCUsD7/GzT
         WHGYsr9PQ7UXX7Ybhq5ISLsFToH7Xm34fH7rxc/xrTqlTFjUkKSgVOaTaiyRiQLbU7TF
         R85bYM8S0gokdSps+M28w2MvY+0k3l+QOMpPm7Rtg4Ncv+NW49ylOk1wckwOLixf6VbC
         /6fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoyt7FAKlB+NaBDenla/fE0WZvyPgSIxT0aVBZdpEkAto799N5KUDmC41qLb5V0Ez7CeKRABWRn50EjQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzELSHMX+EzFcIdl0KGoAJpAhGx/9yZVRZrVbc1tOSR+AA0/J8E
	9kTvhvIJNF1X+sitm1GNBn2ZGOd0PsdEXZGX6QTRQpWFu9UNKE9t+6wWUbtKd7cR6lV+eJdIr7r
	y8LDDtqAK9a/F18uDpWLkDK6PdkCZCdJhIIcFxvxKsJ8SvUTffPZylKTmFpZ8eUTlkQ==
X-Gm-Gg: ASbGncvlVyL0ukbh+pnKlCVamQuap8L6PvQP1sCl9fDIfrwY3F76W6SvwbVFeeDFfIu
	kWkyhT7BubvJ7S40G/7UeTEGunxvutKoe+aFZ1BKZ6RGw5rJ2GItb20sLcQpZIMko9EDq42eX2b
	Gxv9GMekGFxn99cM5EonSzQtsuIKDFpYFPoB+Fr8yA+YC+KllRuFrmIk7gzkcoYzm8M0a+hXRFh
	eeSHshMZmxG156xrv00yjxX65+356h92eFwrL0v+w3v8NnxwA/Sw9ysI1WdyR6m8bl5IszuyU86
	3ELtJuNG2D2wnVhSGVMMdk/mjcgHWSv3/J5P8aCnApR+qg==
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id
 ffacd0b85a97d-3971e2ae2fdmr12130484f8f.18.1742308102154;
        Tue, 18 Mar 2025 07:28:22 -0700 (PDT)
X-Google-Smtp-Source: 
 AGHT+IGFpdrxO3uzvqIUBt8wFXOqIzhdYYo91c5J/KZiOeZADCODR2y/7+pIUFwkH9X3kzq3KrWZMg==
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id
 ffacd0b85a97d-3971e2ae2fdmr12129409f8f.18.1742308071807;
        Tue, 18 Mar 2025 07:27:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b90sm18644606f8f.53.2025.03.18.07.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:27:51 -0700 (PDT)
Message-ID: <87c90ae7-2945-4428-b8ac-576082373661@redhat.com>
Date: Tue, 18 Mar 2025 15:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net
Cc: kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
References: <20250313161738.71299-1-sw@simonwunderlich.de>
 <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com> <3809149.MHq7AAxBmi@ripper>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3809149.MHq7AAxBmi@ripper>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fmfJo6txhmQ_zzalGazfMt0LIccL3AYgbNg3_q2rRSs_1742308102
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
Message-ID-Hash: ETQL5LTYF5TFMEDSSEPWWV37SRSHHTMV
X-Message-ID-Hash: ETQL5LTYF5TFMEDSSEPWWV37SRSHHTMV
X-Mailman-Approved-At: Tue, 18 Mar 2025 16:35:45 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ETQL5LTYF5TFMEDSSEPWWV37SRSHHTMV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 3/18/25 2:56 PM, Sven Eckelmann wrote:
> On Tuesday, 18 March 2025 12:05:52 CET Paolo Abeni wrote:
>> The series does not apply cleanly to the net tree, could you please
>> rebase it?
> 
> $ git log -1 --oneline
> 9a81fc3480bf (HEAD, net/main) ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().
> 
> $ git pull --no-ff git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313
> From git://git.open-mesh.org/linux-merge
>  * tag                         batadv-net-pullrequest-20250313 -> FETCH_HEAD
> Merge made by the 'ort' strategy.
>  net/batman-adv/bat_iv_ogm.c | 3 +--
>  net/batman-adv/bat_v_ogm.c  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> So, it works perfectly fine for me .
> 
> I understand that it is confusing that that Simon send a PR with 5 patches 
> mentioned. It is actually only 1 patch - 4 were already submitted in the last 
> PR. But still, the PR seems to apply cleanly for me.
> 
> Any hints how to reproduce your problem?

My scripts fail to apply the posted patches (when the patches are posted
on the ML, the script try to apply them and compare to the PR tag).

Direct pulling the tag is successful, but I find a single patch there:

548b0c5de761 ("batman-adv: Ignore own maximum aggregation size during R")

instead of the mentioned 5.


>> While at it, could you please include the target tree in the subj prefix?
> 
> It currently mentions net in the subject. But I think you mean to change it 
> from "[PATCH 0/5] pull request for net: batman-adv 2025-03-13" to 
> "[PATCH net 0/5] pull request: batman-adv 2025-03-13". Or which exact format 
> do you prefer?

The preferred format is the latter: "[PATCH net ...]". That additionally
helps the CI to do the right things.

Thanks,

Paolo

