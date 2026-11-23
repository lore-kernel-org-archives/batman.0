Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE3606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClC/i9Lg
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 065CF858C5
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 19:08:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795457301;
 b=MRFyGy3pZRXiXwM3NAQtFXmOm1kmzS52sN3lO53ZgfM7fnfL4Okkg0MFFbIP577C/buoo
 GAzSE4z1gR3kmtz/xPNjl8OiyTIBTTq8AhCaJD1NKIInDkvnxuzxnpe+Nh/3PSsAlYOlghp
 83393cPCQIsteFjFuWITKU83ykcn0EE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795457301; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
 b=olWYaRIZ1WDLhRTsUk6ynWwlSUyqsw1qCeW9uINc7k1sSxy4M7lz7BuQ02k0k+LsGY9oQ
 njIApEbqjj0k+upxwmQHTTmQbnBUPW0zC7mUgESyIuWz3sLDllXZFjDh/RqP4CWR5ZeleuJ
 evUKVAYniHJKd76an5y+fvcjEG1wwjQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 47A3185611
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:23:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454586;
	b=x0aQE59ndF8n1Jh70DM5oCzIPEE5KwCpqg1eWonplaZh68kASEUraombxwHY9uziliPiBP
	d5q6squ6fz3LHlrrixzmphgItL+B5EXtLwyE46Whle3T1wF4vIsl51CdB2sa+KCDthL8Eu
	PMmJ3ubTZQXqBMGRXFeHk1tElwUMvIo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=Nc8NYMB1M85+5DklmBX61UER8NguC1VU23dWa6K/3Jm/XJJLybo4Z5oblz4mwHmobj0eKP
	JVNi7wq50a1n58iQSQs/J3GlQbXjSUN6JUT8J7QKUUryiUVrmYAEdtbU1GaY3Z75s7PH+u
	QPCJhOjXe06QOj8M1IqDtGnWuTjOJPM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ClC/i9Lg";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sinfo@kernel.org
 designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sinfo@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DD1661F70;
	Mon, 23 Nov 2026 17:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB61F00A19;
	Mon, 23 Nov 2026 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454584;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClC/i9Lg5yQmzLC0SPuMA/B9IgOD5fPPXrxVoeYWtBHCIgVAbuTX6XxEisGeEjNdr
	 b9SjUafsFrpWz2Ulu1x9mndiY+QeyAbq5c46nogaAflUpxvzPgTsNQL4lZuPErgUqx
	 zQ9JqzFrpR8nisRGZ08REw6Xy8cXtWzRVrz1kgWdhtJvX3C0Asn5Smp0dcTGcHex/t
	 INN2VrnpIvEz8DKtpykNOPcD6DF1TgRFYl/TbgET9DL5scrt578VC4VUPfao5zffj1
	 NwNsUnH6C085C62nXHP7dvG3aIbOxp6dT1k3zDLCJhEt5ur126cD7Hzsvz8YABZxqq
	 oFpKU/p91gSlg==
From: netdev-bot+sinfo@kernel.org
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next 01/15] batman-adv: document refcount of returned
 objects
Date: Mon, 23 Nov 2026 17:23:03 +0000
Message-ID: <179545458375.3294.10693460852466613013@kernel.org>
In-Reply-To: <20261123171827.3294525-2-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
 <20261123171827.3294525-2-sw@simonwunderlich.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sinfo@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 22ANCBY4DTIKEDISOJ74YEF3CA4E5UPU
X-Message-ID-Hash: 22ANCBY4DTIKEDISOJ74YEF3CA4E5UPU
X-Mailman-Approved-At: Mon, 23 Nov 2026 19:08:15 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/22ANCBY4DTIKEDISOJ74YEF3CA4E5UPU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
