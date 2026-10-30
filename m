Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F99606A31C
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKx/QtNx
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8C47481949
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793369720;
 b=zMkw/1qv9Pj4Pj1WxlYd4SOnmpjvwlWFO+tkC85x+0wzgxxrZ7evKg0pTB2mbR4ggBbyQ
 uplI3FXLKmd62lgP99fOVJ5A06DXmNQBEsyqMCThzELSlK9BiewwWV/4Im7znOXlZ5o9USA
 ICMt90aBLKS1jT9hhecTXJgI0SBMkNY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793369720; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
 b=stysvu3MFJ+1AOrfV1RqrYSwHwGy+FEELE/DsfjQXSQYER+4+WDnn1IGYySyK4pvWU1HE
 H0bPuXD233MCcd6SFF4Lg8uq/aA9raKSjO8/aAWpdlkUHInaYqkUGFkRXqmMP0JviiE6KEC
 Bjy+fzxK0zwPsIez3/PE1p2I+FsRj2M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2FFD1845BE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:54:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368452;
	b=Bap7sUsJmYixAmRNjEMcMnNI2ZjseY/mehnf+aiDWoAfvpD39AYv20z4F+GkBYTzY4Kc3g
	R0gJENHnR9ijE9cjHUXR4YGJtl5/MHjcfnFq0hiGILL4eG4m1OxfFw2DcD9Az/5Kkp7NHG
	oP6/Mo4fEIlBMHZTPofYyaph88jTLw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=K3rtarKW+drH9ZwZKMdD+Vi64fKqcGiMtOUokzssgzQJcD14pt0+fr2qcP4Bh+pGHptqo+
	Se9P9+0dBPC6lxf2JfWVzpCZyYUxcXqkwOM8xlfj2mXtxwq7LT7fGuG/LcfNNNXUIQu12l
	hIYTNnvND5ikZetBED90oA64OPlcClI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NKx/QtNx";
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sinfo@kernel.org
 designates 172.234.252.31 as permitted sender)
 smtp.mailfrom=netdev-bot+sinfo@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 594394327D;
	Fri, 30 Oct 2026 13:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8351F00A02;
	Fri, 30 Oct 2026 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368450;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKx/QtNxvaXy4LF6+fqiasc92+h/amu3roL+fgyDve6otOFQYnqXZG5v+Xg7EThoA
	 E4nLppR+Qbs8ItR3sYnI+qRLhxMyH3u8aaJ1jWTOiWx1TW0ZzA++YgGWO9XeH/I635
	 oaVFj4eIazCYm/aTltX3BEG5qT3EyE5ISwn1JHnn4TMryLuSoyqNpl210hLGOPyMZa
	 rLZpLux1Xlz04qmUnN2B64NEGY0Pbv4TlYaKFVhqwpy05HQhXEWPCDwhwfUMzSzx9E
	 z61m1qG9BY5nSd2+ONdhm3ZcO47xTREt8erSzfsSMMeH6Bd4Nko67ZZ6Z+VXb1lYGw
	 oqRGwVKk7uurg==
From: netdev-bot+sinfo@kernel.org
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Fri, 30 Oct 2026 13:54:09 +0000
Message-ID: <179336844924.3327.3891347335688345941@kernel.org>
In-Reply-To: <20261030135105.2555887-2-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
 <20261030135105.2555887-2-sw@simonwunderlich.de>
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
Message-ID-Hash: 4QWOSSH5I3DX5PRXWVR44ZNM3N4EIME2
X-Message-ID-Hash: 4QWOSSH5I3DX5PRXWVR44ZNM3N4EIME2
X-Mailman-Approved-At: Fri, 30 Oct 2026 15:15:06 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4QWOSSH5I3DX5PRXWVR44ZNM3N4EIME2/>
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
