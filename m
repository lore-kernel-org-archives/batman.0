Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A606A321
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=uIKSh/yZ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BF5398145A
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:23:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795548185;
 b=DRP+5BDHd+mys6WpuQ99vnJkE+ALuyZlwh3TRHgeSZfcgU+/1xSTlBOMH/yxK1qsZHYaQ
 GCBgoDAOEEoyQPKiQBgamkZks4CygaZ4c+9cceWHbw1DfNTvxI6Crq5FNQ6lCgbHrK2Iege
 E4yXZqC0cVIRnqROF95nyfRxnnSGWxs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795548185; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tHXXyt04T2yfsNs+Yo7yfzANNXEyKaT9KymSoL6AxRk=;
 b=IXaVgIgiNVCd+idBnyFgCyVuH/soZV+H2s5zDJm/16sy/Vi0Rd1YdtWEkuJuWclStXFHI
 lhBEFKGhu1c9U88YRn8lF4D/bq96g334lvFE9jgzNCaj0fqRaJWOgD9UIK5GcI9hT543UBs
 ll0cEKHloKzeJrkLz9TnzeK91B+1FbE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 45F0C8093F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 20:22:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795548179;
	b=mNX11uZOr4AjxANLPvg0M9dqG9pxMkWJyJO+o1f9Lg7d+9MJJECorQRmhYKMAILYdn+Dbe
	9LWT+BFbHmlW1cpAW9zlilfdPXqACPbfag4lADplyXjuDfNlDDRlrMwUL1mLSSQbpeBSA2
	1HezIVMlCFcMMx1iADFtph8mjg73CKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795548179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tHXXyt04T2yfsNs+Yo7yfzANNXEyKaT9KymSoL6AxRk=;
	b=gTUitekxHwSHU0YiKJPUcd9C7hw2pvzIR/nC9+AQqnybl46s7qxrQv5mvpM5/QHKWSEXud
	Vif7QiZRX1RG3vjjWRF3cSfUNtWuhmOTWZN6KPq6wCjtbrjj6byj7O+3uzoYBUhZX+wyhH
	vdhgHIewzdIbVAdSXjT//kNiqrmBD2A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="uIKSh/yZ";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D387220361;
	Tue, 24 Nov 2026 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795548178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHXXyt04T2yfsNs+Yo7yfzANNXEyKaT9KymSoL6AxRk=;
	b=uIKSh/yZPFZAaaFhcKiJV92+pcwa6GoS5zeUQRjbrHRPKybmfpCBd9iC+8OJcjotGlp9Ae
	JkyUthxtfXOiiZr1w5XuTxOqIaFyRECWNF226R7fzLAT+L0BxDDFLSYCCCco1jP+rn5AQw
	2swjhXs9fIvH6RzUTLt/7fXqVKTMTzs=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 06/15] batman-adv: tt: refresh local entry in
 single
 flags_lock section
Date: Tue, 24 Nov 2026 20:22:55 +0100
Message-ID: <2434983.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179554084001.3135.10319614345027013330@kernel.org>
References: <20261123171827.3294525-7-sw@simonwunderlich.de>
 <179554084001.3135.10319614345027013330@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5120805.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: CURWGMSF6IEEPQA4EG7RSWDHKZW5KS3G
X-Message-ID-Hash: CURWGMSF6IEEPQA4EG7RSWDHKZW5KS3G
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CURWGMSF6IEEPQA4EG7RSWDHKZW5KS3G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart5120805.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 20:22:55 +0100
Message-ID: <2434983.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179554084001.3135.10319614345027013330@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:40 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > This is a preparation for the validation of the entry under the hash bucket
> > list_lock, which then only needs to cover a single region.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/bug/linux-7602d89e-b2cd-43ca-8aca-c165e5d674b2
> 
> [Severity: Low]
> The Reported-by: and Closes: tags suggest this is a bug fix. The message
> calls it a preparation patch, though, and there is no Fixes: tag. Could the
> message describe the race being fixed and what users see as a result?

No, it gives here attribution to Sashiko and helps me to figure out what I've 
handled and what not.

[...]
> Could the commit message state this consequence and add a Fixes: tag? The
> flag-update helpers being replaced seem to come from ec6edeb755ece6 and
> d72e16b1c5d527.

No, Fixes: or Cc: stable@ are not allowed for net-next

> Is this patch enough on its own to resolve the Closes: report? Or is the
> later "batman-adv: tt: don't queue local events for unhashed entries" patch
> also needed? Saying so in the message would help with backporting.

No stable maintainer involved here.

Regards,
	Sven
--nextPart5120805.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXkDwAKCRBND3cr0xT1
y0uUAP0Rdi7tAu+VT+zG7F+NoB2volUP9j27Wim2kHF/O7nLwgEAmkhkOadm3/Bb
rkXNKNVX9NElq+jd/yeZ95fU+qHX6wE=
=c6YG
-----END PGP SIGNATURE-----

--nextPart5120805.GXAFRqVoOG--



