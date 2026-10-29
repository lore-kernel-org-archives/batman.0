Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F047606A31A
	for <batman@archiver.kernel.org>; Thu, 29 Oct 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P28EJu15
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35FF9843FA
	for <batman@archiver.kernel.org>; Thu, 29 Oct 2026 01:46:52 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793234812;
 b=G+xz9LmxRzT6ov5ugs6OO8RCstaIjJPZo5mCDGwtnG4s7yOPQBqYG+gEPeylGp7g2C6MV
 /gLj7XOcq9bX8DVe2hWym3MdHBxcC8xQ4jN7BmncBRoNsn1Xs9D7a/z8F7+EPJvyfDsyycX
 2lH3txq3CvIf7npLXmxZUA47ao9Y+E0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793234812; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AWpBuD0eGWaQmRug6Na7k4hqC8NUHlBhmAS+HYM3HWI=;
 b=N+MV9yhX7eJOzHZ1sxem52FDHP8Ynw/rn2Zx+7PhjZYme0X8F/WbTd2A5pIsm/5vStFV5
 YCozZ6Z86s3pKbvBbyuukQdzu+bsYLcRrtF6tnD2Jvb55o2uvZuIW0iabfYLDVUjBL58UMZ
 WXryvVuMO+gmtTJpcrDpJQ7ugWAqnhg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2B14080B88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 29 Oct 2026 01:46:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793234796;
	b=YwR596u0+elcpY79FwYXLbk0TtHYT1vMotVsdYfvPbPdOtQJRHScO7IZmdjjPW5AFTl5ai
	1rwVmvjGHHTIzx8BnV/55qrynDZSSHYOTi5pTA8eDxl2Ct0zjKKc9s8omcsx1lAMVRK8D9
	U1qzJnnVZXqN9m3kvMS34mR/SPLmi9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793234796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AWpBuD0eGWaQmRug6Na7k4hqC8NUHlBhmAS+HYM3HWI=;
	b=ku7bVx6TQRtX/8wrx9qK1GnhmcKsnqNdFpXpdkDo8+dl2hGTBOIigcduxDnzXs+/Hz2jby
	Ppboy2W9XjwYIT3WqxGL0NwBz76aMmSR1BjVWrHk4rEhc4TsgAtR7KJNlTIHGAG2sQ2j/f
	KvGc08H4lrIF6vUz7IpwwPkc8YHAatY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P28EJu15;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.105.4.254 as permitted sender) smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A4ED2600D1;
	Thu, 29 Oct 2026 00:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1551F01825;
	Thu, 29 Oct 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234784;
	bh=AWpBuD0eGWaQmRug6Na7k4hqC8NUHlBhmAS+HYM3HWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P28EJu15K4BpLeq0eMQkjjymvz0kCB1gPdzcfKGrzhnumpOrP/6xeNNQJzibA6k+k
	 o+pcyKK0NsnnDlEHx5W9jiANCHCGNnWHzYzTt6Es6PTMivBvVIGT0BnDB28wCDSmjo
	 gW/vllkxMmqeuct87YuNXwtPkt1uzEtT9h/6QJsXZA/Z/vfdc2HxU5cgFU2FmnyFfg
	 cnuvq4xfTsRmFoVwCLf3Hp1T1WRC+EKo4xYIBbWCH8awY51mQKZQ3hpWTPiehwIznS
	 K8gbqACdwsdOU+W4koSvMs1KfIgjuS67Dhg62mMgQiyKZpfhPae8oYvop4mmtuRztc
	 7aJM0BFhtaCfw==
Date: Wed, 28 Oct 2026 17:46:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann
 <sven@narfation.org>, stable@vger.kernel.org
Subject: Re: [PATCH net 08/10] batman-adv: tt: only update flags for TT
 events
Message-ID: <20261028174623.66e0024b@kernel.org>
In-Reply-To: <20261026085309.1074911-9-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
	<20261026085309.1074911-9-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: GH26E4EJO5D5KRQT3VEKD2KOGCR6SKDU
X-Message-ID-Hash: GH26E4EJO5D5KRQT3VEKD2KOGCR6SKDU
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GH26E4EJO5D5KRQT3VEKD2KOGCR6SKDU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 09:53:07 +0100 Simon Wunderlich wrote:
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")

No such sha. Could you fix please? bots will scream at us if we pull as
is. Also - please drop the assisted-by tag on patch 2 - those are not
required any more and checkpatch is apparently buggy and flags it.
