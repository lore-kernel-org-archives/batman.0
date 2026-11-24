Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74A606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyAdXER+
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1FFB84235
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:26:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541208;
 b=Q8q8wboMwg7yI8WGE7vPkoedsI8TfGnt9dTxT+Z3zzdrIDCbbsWvxLAYwEhGtVKOVi5OI
 6kIizcSS9JYAE8jFUs1DLoK2sSc0S9qEhublmGWc+TfYM07+st8UK9H/4Ytt0qYBUhb/6cN
 L/VoP5oVIfpNk4RZieasaivIWNcfrig=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541208; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c7mEqGUvASdHjf6vj1nlRmarPicG8Hbm9iUcTZzGMik=;
 b=oSVvjUpg0N4tRO47/gqEKxODJMlNdvujEDA4WVyVYfN3jtDBA0vpEj58nOyaGybwsjTz3
 EtEm5KYF5s6CQKkbCmLMaxoesZqZsq7nAAP7yk2HVAWtjVIRKBXQ8zHHiWBI9OxySrj1EN+
 pnwoEOxKqFa3B0prmaaJKfa3q1bOkoU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD7A68082E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540854;
	b=s9WcFZ+4MYYeRxqFKkkcHUzOKltgBz1b6/ZRc+OppmHxEGQ8A5xZ1hsG66IaKDiCUeBbtS
	G4q7W+jiRlG0lxmbEyZqWRfYuAp7bP1ssOQ2zAdpzKcHG6MScvrVNd5eY7L5xC74m3gwF5
	gapGjvG3mvTLxWqSpwUSfrNDys6N1bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c7mEqGUvASdHjf6vj1nlRmarPicG8Hbm9iUcTZzGMik=;
	b=VT0rl/qlssMN1pxhW/iwolH6lT9eZejEOQk+JpPrr/hkl7i3RfJi2o7oroQiJ4age/Bf8o
	qk8QwawnmeSa/jA2vY10nKJBRRSiOGS3irMAoHHoK15ir5cDLlGxPRre4VYmIp9/qMUAYx
	Xh0Y+ziAkVG/onTutwwQe2jkOQE5YeE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eyAdXER+;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.105.4.254 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A785E627FF;
	Tue, 24 Nov 2026 17:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35051F000D8;
	Tue, 24 Nov 2026 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540842;
	bh=c7mEqGUvASdHjf6vj1nlRmarPicG8Hbm9iUcTZzGMik=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eyAdXER+OnIDH22sQVx5NmIPv/VIGVM1zzTsf2RRXXHu2wUFngIUWx0V8Gb2i223u
	 9HBQ0kHsqMJ1BUr95PK7kGwgv3RCqbr4lqFopfZy4e81qwgeCgA59dWl6C0ND7oSva
	 Naeh9s4SopGoACWTMfa7GW8eDZL3X8HPT1dG6UKgGGOdCHxDYHzDVoZnheGG2EQfJH
	 glkGw6zTiHJz6NL31UsholnGz8DHz+I7SBK5mzOCRKJwZI9h+dDYoRMHy01JNVbpCW
	 usIo+AZnDpLVG55F+1gkUGATpHDAP39IY+sqMcGzyLTCfQXCB1T+dWcMBvCPvTa7TS
	 tqKSs66Mk7+Lw==
Subject: Re: [PATCH net-next 07/15] batman-adv: tt: don't remove unhashed
 local entries
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:41 +0000
Message-ID: <179554084147.3135.8288154830036400852@kernel.org>
In-Reply-To: <20261123171827.3294525-8-sw@simonwunderlich.de>
References: <20261123171827.3294525-8-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: JMASGZL7GQJDFLPCOKROJ7EVZZSGRDP3
X-Message-ID-Hash: JMASGZL7GQJDFLPCOKROJ7EVZZSGRDP3
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:24 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JMASGZL7GQJDFLPCOKROJ7EVZZSGRDP3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "batman-adv: tt: don't remove unhashed local entries"
  fixes two real races in the local translation table but has no Fixes:…

--

batman-adv: tt: don't remove unhashed local entries

This patch merges batadv_tt_local_mark_removed() and
batadv_tt_local_remove_now() into batadv_tt_local_remove_entry(). The
hashed check, the BATADV_TT_CLIENT_NEW check and the unhash now all run
under the bucket list_lock and the flags_lock of the entry. This closes a
race with batadv_tt_local_purge_pending_clients() and a second race with
batadv_tt_local_transition_new().

> batadv_tt_local_remove() looks up the local entry via RCU only.
> batadv_tt_local_purge_pending_clients() can unhash it before
> batadv_tt_local_mark_removed() acquired the hash bucket list_lock. The DEL
> is then queued for a client which is no longer part of the local table (and
> its CRC). And it might replace the queued ADD of a new entry which was
> added for the same client in the meantime.

[ ... ]

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-c3e34735-5286-4ed0-9338-a77e64fef540
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

[Severity: Low]
This isn't a bug, but should this commit have a Fixes: tag?

The commit message describes two races that already exist in the tree:

  - batadv_tt_local_mark_removed() queues a DEL without checking whether
    batadv_tt_local_purge_pending_clients() has unhashed the entry after
    the RCU lookup in batadv_tt_local_remove().

  - batadv_tt_local_mark_removed() checks BATADV_TT_CLIENT_NEW under the
    bucket list_lock, but batadv_tt_local_remove_now() unhashes the entry
    via batadv_hash_remove() only after that lock has been dropped.

Two earlier fixes to the same functions both carry a Fixes: tag:

  f95b9f28a9df ("batman-adv: tt: queue local DEL event under bucket lock")
  a6746cb19076 ("batman-adv: tt: queue local DEL event before marking
                 entry as pending")

Both of them use:

  Fixes: 976b159b3c12 ("batman-adv: tt: use protected flag modifications")

batadv_tt_local_remove_now(), which this patch removes, was added by
931de98d3960 ("batman-adv: tt: extract immediate purge of a local entry").

The missing hashed check in the first race was already there before
f95b9f28a9df. Its origin may therefore be a different commit than the one
behind the second race.

Without a Fixes: tag, backporters and the stable tooling cannot tell which
trees contain the broken logic. If leaving out the tag is intentional for
a net-next submission, as with the other fixes later in this series, please
disregard this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
