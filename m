Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64366C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 14:50:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 72B5D8426F
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 16:50:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786027820;
 b=UD7pASmqIUbaUGJ9ekQWpMUS6VdP/x6q+3kJim/9b3qsK7+AIFzkOE9zj7D7LfQbidCXA
 sndj7vZhWWnwxOoZNS5XypiqJxtwEwPYpE6pF4qUfI0F9fh0zUnY0tjQZ9HqrvACLFNShnk
 B9M3qYCc7S0p2UGEySLm9TzvNFm9SuI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786027820; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Nk2LetbE720VUwdle8IicEzzXoq1sgzpA9D6ECbMgKo=;
 b=xzB7wwOHytAa8+QUVSObFxUtt4iV8oaZGDVoUr/UAh/xKnqJLdTf2IG8Jx9CAcMCDCOfy
 C9sqa/HWaG17rEi6xmCAiYiRh4hdQ65nqiTkXVmBEa0KvhhW4hLuoWpdj41YZe0JW9yeCln
 xQkLDLxq5OOg267dPiRk+f6JaBnQdhU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7143B805C0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 16:49:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786027802;
	b=14AiqG67pxWuISs6S0liKJY0oLNsTum5csdhzYy8W/lJDpenUL3WXDprRE013EUFi35rw2
	NccC7P2LD72NjDDg+byCDLLAloTDAEuFQLMBXC/x+Qgxv/JM543mkT7yuaF0pk+k40Uldg
	qXSqEjoLCKfzfHb9gIz+8RPHgyRwxq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786027802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Nk2LetbE720VUwdle8IicEzzXoq1sgzpA9D6ECbMgKo=;
	b=MaO9KhkYI8fhWuej3DxIi5TT6zaGirNpH49zHBuDvxF9hAjZdmnJ9ppP/MGwVnAJQkdxZP
	DG6R7StfjVLkrbXskAnKbLkk3V5UziK27V+hU1GHIr0FOj9rh1euK0MQeKEt15lhWKB7b3
	THHrHz4ZwOeJOFALDl/W+Y9WdTZRfcI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qUGQ5KUo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CF837200D8;
	Thu, 06 Aug 2026 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786027787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk2LetbE720VUwdle8IicEzzXoq1sgzpA9D6ECbMgKo=;
	b=qUGQ5KUoTXO6cSsCUvSD8mojzSCKzUF8shS0R9gMFVVqy6Bbk+NWMuMvh5ErOH7XjWy2aQ
	rn9L+cOqodI3fG44wguNJAW1yqhhBzq3UOL2HP9OPC4Z622fR4nf4tzOuePE1nvc2LSV8Y
	7feWK12VKiZF59W6JswvCDafZ25n6ms=
From: Sven Eckelmann <sven@narfation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Date: Thu, 06 Aug 2026 16:49:40 +0200
Message-ID: <13090442.O9o76ZdvQC@sven-desktop>
In-Reply-To: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <3386526.aV6nBDHxoP@sven-l14>
 <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6161773.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SFOX454CUBJYNHQV6UPP6CMU2GNRPVOW
X-Message-ID-Hash: SFOX454CUBJYNHQV6UPP6CMU2GNRPVOW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SFOX454CUBJYNHQV6UPP6CMU2GNRPVOW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6161773.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 06 Aug 2026 16:49:40 +0200
Message-ID: <13090442.O9o76ZdvQC@sven-desktop>
In-Reply-To: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
MIME-Version: 1.0

On Tuesday, 4 August 2026 15:16:54 CEST Paolo Abeni wrote:
> Please be aware of net-next commit c82ff94592fb: the expectation is that
> submitters reply proactively to AI review comments.
> 
> Specifically it would be helpful an evaluation of how critical is
> problem reported and if it could safely addressed with a follow-up.
> 

You sashiko instance is not sending out mails and AFAIK, there is no mbox 
download button for the Sashiko "replies". It is therefore a little bit 
inconvenient to reply to something which is just on some website.

I just wanted to go through all the accusations in 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1-sw%40simonwunderlich.de

Regards,
	Sven
--nextPart6161773.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSfBAAKCRBND3cr0xT1
y/JaAP9kbzFvnPeTMwGKyBLlt6CYOZnJ7rJsp4UkHgKz3EVY1gEA33wM9ZOGl/Yb
Hz0MjjnZh5yY5541p9On6dsgRjqt5Qc=
=htMl
-----END PGP SIGNATURE-----

--nextPart6161773.DvuYhMxLoT--



