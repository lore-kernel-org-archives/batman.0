Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E6606A31D
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deKM2usx
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BC7378541B
	for <batman@archiver.kernel.org>; Mon, 26 Oct 2026 10:09:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793005744;
 b=oCuiS/B0J3kGtcjUWyUc9P2aIXxkR8Lgowx+ZAAGC5XdJ96v7p5+N880UIcow5wApD0AD
 jeyZ5T+rie7OH9aNPhuNVnDreCxZgtU1GWZOAcEvawfzT5XC+HWlsOpgS03kjvjkGg4y9Me
 Cg+6mYmU6VKpGWOTqdz7vhKsT9tn8Us=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793005744; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
 b=1A/XIJ5hxzKlJqfip4D5dJXzdM5mgMUarHRdcxRqGimmcOB3QJbu8CwDYroaP3gVRTR+D
 8pIx/J/w/UYD413AuHwYRJBtQhhFveSBTdzNPnrzDDnEkvWR1MofJwv/L5imWhRHAj4cb95
 mfHGHUECnRbLWUiwjyK/HyXZSzEsbjw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C6053854B5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 26 Oct 2026 09:56:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793004994;
	b=2+TrPIcl2dpCKIh6zLzh1uJrb16xn0ceBOeLV4PlrFFAlL29PnQ2jYYDfuOkTgFWFNixDs
	LepuCqe7LmeNgGBFOG3H9M8feuqe/PRyfJHnUhdRXhwUhXjm9u4fxV1GVsr5Mw1oxHZTwt
	SegEMJkzZMMFjIhXLPWpdodr50ZGPlY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793004994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=TS9wfnfNCZl6+sASgloevrSmu/hS5wd3pnKra2Gxgud7TczN2F3N3kUCEGB8fY2UWIupum
	yBv2bFGCA4L/lLChY5RYq5yxt10x/s+V4hLHwq6BfkRZvAzOrwVCWxUMwRLrGrtv6KV3pb
	UpX6HtjkHhMZ8FnCoxOdXcXg3m1aXl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=deKM2usx;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sinfo@kernel.org
 designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sinfo@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 72336601F9;
	Mon, 26 Oct 2026 08:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4441F01825;
	Mon, 26 Oct 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004993;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deKM2usx7YptNPuS3iqVOUudK2QUDFABxD/pdlCGBtD90+xKEBUhew68XnjXLcLR5
	 5F32zLh6yFreanZKRSWZvSDmLU48FeUCiOyCW5AViw0OV0aOgslSWf3C9AMxl37f4C
	 TT838u2Vd+ZH8wB2UHlTGBXrkPnwFDeiCgeNgB7OBUeK0mzLJT9HeHZ//A0V+aEBRp
	 mFsEmoxMPcMWiNvBHXqfm2YdM/mXqns4bb/aLYJ0EdnNcD7P6ikDhITEDOX6lvAffz
	 dmMIRW7S21Ps2syK7N48C+l/SWJBOzuhEmDpuU+umlY5IXdxnMP0W4yJrkgEMkGDXZ
	 /SnwjjTWG29HQ==
From: netdev-bot+sinfo@kernel.org
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net 01/10] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Mon, 26 Oct 2026 08:56:32 +0000
Message-ID: <179300499206.3327.5380876117216211782@kernel.org>
In-Reply-To: <20261026085309.1074911-2-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
 <20261026085309.1074911-2-sw@simonwunderlich.de>
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
Message-ID-Hash: YVR5YNSET2F5JBMSBDOQ7ZJOVZCUW3RZ
X-Message-ID-Hash: YVR5YNSET2F5JBMSBDOQ7ZJOVZCUW3RZ
X-Mailman-Approved-At: Mon, 26 Oct 2026 10:08:51 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YVR5YNSET2F5JBMSBDOQ7ZJOVZCUW3RZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
