Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EA8C636CC
	for <batman-adv@archiver.kernel.org>; Fri,  3 Feb 2023 08:30:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8EF19807D7
	for <batman-adv@archiver.kernel.org>; Fri,  3 Feb 2023 09:30:20 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2B4388058D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  3 Feb 2023 09:29:52 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675412992; a=rsa-sha256;
	cv=none;
	b=2rLO3NJSpNf+Ype2bWjoXFi5JbJ+aWGgfwif1koGYgo4aLapi5Q8kHbIACjX2Cq6n03H8T
	9+wwi61DUWRdUpLcQpWkZZeTkB+ZtM7V3DflGQbLZ/8/0ejl8eA/+9rsWMR7EuO9PZLuOs
	PbyShN1Qrl3yRBULrE7jAU/kQYWJ+Eo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=resnulli-us.20210112.gappssmtp.com header.s=20210112 header.b=NffqiT2N;
	spf=none (diktynna.open-mesh.org: domain of jiri@resnulli.us has no SPF policy when checking 2a00:1450:4864:20::529) smtp.mailfrom=jiri@resnulli.us;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675412992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hfmKJdlXOxE/kFxDa2h7oLPDGZoAZETt39bcuIPKzu8=;
	b=SLPneNZAUD3Y4uHG5x8w0fJQxH9vExfo6NLzm5MxzdzScyFMBY7CjGbNiH36wTkFRzTxp9
	u+Ac9uo7MU9Mz8cr9YVb5XJWGu2qc6ICkeM6Rn8Ik6IeZpL1Wtvc9H6fDxU9ZxPhNDolJW
	nfVc+xg1aXMtO/PjX502cSWXehayNY8=
Received: by mail-ed1-x529.google.com with SMTP id f7so4427579edw.5
        for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 03 Feb 2023 00:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfmKJdlXOxE/kFxDa2h7oLPDGZoAZETt39bcuIPKzu8=;
        b=NffqiT2NvfuoTuVPABcBDZIwN8I0YPurOPxCWSagS99//JrPJ9ume8Ci6gFzSLBi90
         ZynFGl3ybJvTIuYfIcDeBqIUp0OunEovH8zp9AKfcioXt3KXS2K1TLid/WEkbQOJGvzS
         ZlzoK+zxH7hzjENsbqq3BYgRYrdGOZHLbKdl/XEi6pUf6rAzZ6kHcY1pATJ2Dav0uOJF
         v7V2A3a+qdWXT10grNh7OTc4+dlKNKFiPoz06J29tVmY7xRhPiTo4KX+EDkp7qARjNu0
         gULDAjvjXNE+s/V6f5NZ/toSWtXDS1hV7uI81D1VuuEUU+Wwt/qDfsMoCv/Kq5OpY2y4
         3SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfmKJdlXOxE/kFxDa2h7oLPDGZoAZETt39bcuIPKzu8=;
        b=O1xnbqeucWAxGVUNEfdazI8RdzeYp30jzOMYV8eFPTamWPkaJLOWfW6FuECNqhFKDf
         KH9joY2CqDjjwRL0oCnxnJgiPW4IxroYDj2k0Y0FNWFAw8VmQ6/F/ruK/0bA1fVEa0Jo
         nIW1FaF9cnO+h93NwuxQdb1EgyU/2icgEX9zrsrPpV1nzpGMmGoSRKxro5By2PC/Cljf
         AiketTJoCBDf9Kpgs6KTomIxZ1OiSbwiRluiOZRJFTx0s3qs3WZtIc0jIHxV3EKPsM+w
         Z3Dh7C7H5FUD4Tgli0sl7plMxsahCRggRp4+WNae4BdwwXNorrac4jlpJUXzaCXQHjzS
         8zTg==
X-Gm-Message-State: AO0yUKWMXEMv7m9Eqyym65oHWwuWMdPODG9hjiKZdeREFsSwfMY1hqDW
	WTZbGQXxscihJRqHAIduPQeRtA==
X-Google-Smtp-Source: AK7set/uM5zQzVi4uj4iY9Ov7WgR4ieUlLdZpB6qbpLADbe5rj15JkYBgBn4Gn0WcvjF3rdhK5Jv+w==
X-Received: by 2002:a05:6402:26cb:b0:4a3:43c1:8439 with SMTP id x11-20020a05640226cb00b004a343c18439mr5272420edd.13.1675412991699;
        Fri, 03 Feb 2023 00:29:51 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ez22-20020a056402451600b004a2666397casm748456edb.63.2023.02.03.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:29:51 -0800 (PST)
Date: Fri, 3 Feb 2023 09:29:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Message-ID: <Y9zF/kEDF7hAAlsB@nanopsycho>
References: <20230127102133.700173-1-sw@simonwunderlich.de>
 <20230127102133.700173-2-sw@simonwunderlich.de>
 <Y9faTA0rNSXg/sLD@nanopsycho>
 <Y9wEdn1MJBOjgE5h@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9wEdn1MJBOjgE5h@sellars>
Message-ID-Hash: NRDVHGXVGIJRVEL4SWZHWAJRBW67GPC6
X-Message-ID-Hash: NRDVHGXVGIJRVEL4SWZHWAJRBW67GPC6
X-MailFrom: jiri@resnulli.us
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NRDVHGXVGIJRVEL4SWZHWAJRBW67GPC6/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thu, Feb 02, 2023 at 07:44:06PM CET, linus.luessing@c0d3.blue wrote:
>On Mon, Jan 30, 2023 at 03:55:08PM +0100, Jiri Pirko wrote:
>> Fri, Jan 27, 2023 at 11:21:29AM CET, sw@simonwunderlich.de wrote:
>> >This version will contain all the (major or even only minor) changes for
>> >Linux 6.3.
>> >
>> >The version number isn't a semantic version number with major and minor
>> >information. It is just encoding the year of the expected publishing as
>> >Linux -rc1 and the number of published versions this year (starting at 0).
>> 
>> I wonder, what is this versioning good for?
>
>The best reason in my opinion is that it's useful to convince
>ordinary people that they should update :-).
>
>Usually when debugging reported issues one of the first things we ask
>users is to provide the output of "batctl -v":
>
>```
>$ batctl -v
>batctl debian-2023.0-1 [batman-adv: 2022.3]

Why kernel version is not enough for you? My point is, why to maintain
internal driver version alongside with the kernel version?

I just don't see any point of having these parallel driver versions.
Looks like a historical relict. IDK.

I'w just wondering, that's all.


>```
>
>If there is a very old year in there I think it's easier to tell
>and convince people to try again with newer versions and to
>update.
>
>And also as a developer I find it easier to (roughly) memorize
>when a feature was added by year than by kernel version number.
>So I know by heart that TVLVs were added in 2014 and multicast
>snooping patches and new multicast handling was added around 2019
>for instance. But don't ask me which kernel version that was :D.
>I'd have to look that up. So if "batctl -v" displayed a kernel
>version number that would be less helpful for me.
>
>Also makes it easier for ordinary users to look up and
>compare their version with our news archive:
>https://www.open-mesh.org/projects/open-mesh/wiki/News-archive
>
>Also note that we can't do a simple kernel version to year
>notation mapping in userspace in batctl. OpenWrt uses the most
>recent Linux LTS release. But might feature a backport of a more
>recent batman-adv which is newer than the one this stable kernel
>would provide. Or people also often use Debian stable but compile
>and use the latest batman-adv version with it.

Yeah, for out of tree driver, have whatever.

>
>Does that make sense?
