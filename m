Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD982C55822
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 13:10:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E6A6884202
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 15:10:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785849029;
 b=3SARI6pVjEI8T9YXecQN36b8FILw6Dj4JAASqRQEwpqCABIfOUX4p6NTxGx6pf9OBMOh3
 x4c9TyATbSyHY2L5BdBjzRQ5UENfnZmcd5ddcUF8zkwZr8//hl2FlXnikyYcfZIF0IzVFO+
 07np0O5BCn1/SJT5lH+6mkzgZ36/Arg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785849029; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
 b=x+I+DzxGVqkWVURdDZ+6neTyXAGa0bNT4I4PjbPQCLD36Zoqnj08WAZ2DOWmW/ia2c4ZY
 sVg9W07pdbmCxtZxPfwhRZeiP2JOLYRcbe2v68GfA0AuE//h1v/YXF8WCOUcfQRnmuBQYdQ
 MkW0xElTdHSAPUSGUi4a4sXS33wV/A8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass header.from=redhat.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=redhat.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=redhat.com policy.dmarc=quarantine
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 342E180A35
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 15:08:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785848887;
	b=ctapCBDIf1XXAuEOKJ4LVy5jZ57vCcf5eqi/dQ0dSzLP3FUJ3F4VA/TiExIMseIr/JHNjq
	BAydCll+kpmh0xUs2WRqBa45HHbgleOGdhf/LHTklk8JaBQ+q/FTjE/8Q/zUII/yjkUn4Q
	q1txTBE8LmigQvXSAwO9f3KWQ0nllQk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785848887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
	b=GlJSNG90OoSV9A7lDR7yZt0/KggQSn9xua6ehauHrC18Y8WE89snGrZXkDu0jnh0kuBGkf
	NqPUqxlxf2I4G4xSCxtmCA6utD7dpc7je3s7cRfeJVQw92CmRW4fPQJDVHcR3V8cHSdRje
	mhmM5YXc/MAF/JAQTTuV7Gd/3IhRby8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RBtmHnrP;
	spf=pass (diktynna.open-mesh.org: domain of pabeni@redhat.com designates
 170.10.133.124 as permitted sender) smtp.mailfrom=pabeni@redhat.com;
	dmarc=pass (policy=quarantine) header.from=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785848885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
	b=RBtmHnrPvcT/ZHtrZ/T58VHMdAA6Nftj+t5EJFiMRtT2398+sE7WxPU2kSEEhLr/uIlL69
	m3zbjeZKtDwt9XkympgdNRRGA6BZdEOxU82r0J42hu7d0D68X2zeafrIV1fC5J7Ssgfqfq
	xPv11hk6BzFi0PyN1lH1EYbgR2YaSoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-d2nOLsfPMASbEKD8-NqKgw-1; Tue, 04 Aug 2026 09:08:04 -0400
X-MC-Unique: d2nOLsfPMASbEKD8-NqKgw-1
X-Mimecast-MFC-AGG-ID: d2nOLsfPMASbEKD8-NqKgw_1785848883
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47fe85684b9so835375f8f.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Aug 2026 06:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848883; x=1786453683;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
        b=jHAlcDukig0GnhzBPH3IddvRQZreAwp0d6cJHj9hdoGt1dHanetDhjBYO0fto+RYmh
         6+Cb2F/JFUEOGcVglXYvy7smUPJjg6WLzPSLBD1CdA3Z8154uKaWt53ENBrttZbk5OA1
         cxeNXAXwNb12mC/fa+H1c1GgOKLUtYJEsdvTUOXilrrcQv3Y2pJvEs06u9AZ6UMpemRB
         SVIz0ZWBGq45VuSpJbwg2gi8j2QESzwmfS0RRC0qe+Mw0kgst4mcig5nqg6v3OV7jxjO
         ZRkAD3AcmH9DFPPRoqNw+4MtmJQBUbHWFU+Vy24gTXgRnEeKOcA6j+jzX+kIvnFrpDJC
         YK0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop6TaP8m+O8szwRWHP9hce0MGDvryCmmguaUdCwOk4S53FAv33s1NQx0hbXpM88sS99LnL26FWyZ49qg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz3tNHi69ihhikM9i/YokO+CulL8U2XKYonjJy+q6PjwXdKu7rO
	GgIonz3TWaLuREVLYdtgdiKDi3lGTiPbZrFi+vjMNlJfv4Cdeu3NGDGtD411IZqp3OVanrttzqc
	mQ4/aUGhgMJVZJ82/vBmOho5Bc557EqWfVCnwySi9OHx3LIW0laR0bHck5ChoSYT04ue+XA==
X-Gm-Gg: AR+sD12w0TQGEXMrb7X2Z/eJO9pCVqF0W9xiMI4suDGGl7sSzs7Wd3b98wqfLQzkvfS
	Sg9+m1QqiyHWIR+0M7JmrhubEDGpxdCkVcd5fIlJA/sbh0e6ActNhevFM/vJFaPH1cN85MR9dmc
	BgPsgTqbr0xPardbuO+f3S66W8dW7Xz1+5GmzvTSIEbJ2XWFLTqGb2JJvZ2QOtbmTxaomhJIOtW
	E3butWudRt26v9bmzmFzPP9LlsNa0Hq58K6u1d8Fqz65TOYvKnosI6XWxCKRHQQfYfN6BNp8rgg
	3OG62DXp/4mBQTTMva3ulUmtObHLrPi7nvxtk3+dYZIrCPKFfR12K6iNLnB1zIIb3lITQIG1kkN
	TPGT5rioF6O61hsXOhREgzdbvy6xqei3LuNi1cnDvHUYNU7Dv82IrggNNRci0bTwuhpWS01TdRq
	0=
X-Received: by 2002:a05:6000:60a:b0:47f:9283:1fb3 with SMTP id
 ffacd0b85a97d-47fd706349cmr39912167f8f.0.1785848883040;
        Tue, 04 Aug 2026 06:08:03 -0700 (PDT)
X-Received: by 2002:a05:6000:60a:b0:47f:9283:1fb3 with SMTP id
 ffacd0b85a97d-47fd706349cmr39912042f8f.0.1785848882595;
        Tue, 04 Aug 2026 06:08:02 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it.
 [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458bb4esm42401998f8f.30.2026.08.04.06.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:08:02 -0700 (PDT)
Message-ID: <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
Date: Tue, 4 Aug 2026 15:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
 <5248054.31r3eYUQgx@sven-desktop>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5248054.31r3eYUQgx@sven-desktop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -HrP_ssUrxOsHECckfwNXg7PSwuPrWDa6QX4vCVgVpI_1785848883
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
Message-ID-Hash: BF2ZDMZHV45VZPYBPXEMBGAP4TAGKOZQ
X-Message-ID-Hash: BF2ZDMZHV45VZPYBPXEMBGAP4TAGKOZQ
X-Mailman-Approved-At: Tue, 04 Aug 2026 15:10:14 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BF2ZDMZHV45VZPYBPXEMBGAP4TAGKOZQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 8/4/26 12:38 PM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 12:19:13 CEST Paolo Abeni wrote:
>> On 7/28/26 3:39 PM, Simon Wunderlich wrote:
>>> Dear net maintainers,
>>>
>>> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
>>
>> Note that it's preferred to avoid fixes and stable tags for changes
>> targeting the net-next tree. If the fixes are really minor, both could
>> possibly safely dropped. If there is some real problem behind, such
>> changes should instead target the net tree.
>>
>> Can you easily rebase your tree and adjust the PR vs the above?
> 
> I have a different statement from Linus:
> https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u
> 
> This is why we started to not send out net.git fixes PRs for things which 
> aren't highly critical or for Linus' "just merged for this release commits"  
> late in the development process.
I actually think netdev preference is consistent with Linus'ask: move
the "fixlet" to net-next.

The additional twist is the ask to drop the stable and fixes tag
(otherwise stable will be flooded, too).

PR are a bit apart from plain series, hence my initial questions WRT how
problematic would be stripping such tags and how impactful are actually
the things addressed in the first 6 patches.

/P

