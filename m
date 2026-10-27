Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23727606A31A
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BBKHFlx2
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A940D8411F
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:12:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793103125;
 b=DIC5xnuGb8y3SO5kLq+n5jO2EnrfZrgg7MxjUIUYazuibJsKMSaoYo762zGg6X3tuPSE6
 RAGq+kuACsT+YSWH2S/7OAHITfzcEd+tB5HDuCyx6wu4VMG21UBDPFbfVazc4NhXlxxOInN
 My/dN0VbLYDQI5dF2rEGW7hzPe9YGXM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793103125; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9RA/xsPWE7iX/5+zhjVd4uSj9i7bQuXj68Gc6UmAfS0=;
 b=G2p25x9wWehfGfu8MgSllvtE8mUDyfwBFUbz3UB9CHvtGVLCGIqbFiz9NXf+jTAJdsGc3
 YuCXj8Tl83CT1EY9wxa5yHK3irgfcvT9dtO/77DjIJvgJE+6oml7kF6iSYkZdzVlb27N6pB
 zdm7Ts6+eBqMGvQEEVjIF3RYkGZ2V4w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 736ED81933
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 13:11:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793103109;
	b=LHZ7BGCrvbQPMMMSWMhKs8no7CgSxA7ZlCsTX4V+9CmTHZoIytrfnbJAP4GuBpfVUzSPX5
	F6tmfoNJoLTnzur77klbxYDk8MTf34H3CTQ4UG5Dpi84adAa5lzl51VjGPgOb2p1tRqsoJ
	uR4o3YvSHQl6ZU2sDbW89CnZVTc5K5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793103109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9RA/xsPWE7iX/5+zhjVd4uSj9i7bQuXj68Gc6UmAfS0=;
	b=Jo27t1by3+1+vYnmpjBoneUadPn3FsY7oONyRvhcTzMWCjHtN8xI1goNP09lZE3wfuSK/o
	mm40lYrfYegucLj/V4krbOSlCv1i981yf9gwJRT3wl+IRb/tZwKKWPGUSTCba0JozwCJCe
	xhUGKii4kH4vLhkrk1USVQfzHylAk7c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BBKHFlx2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 029ED202F3;
	Tue, 27 Oct 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793103096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RA/xsPWE7iX/5+zhjVd4uSj9i7bQuXj68Gc6UmAfS0=;
	b=BBKHFlx2Fhz5/44C+m+jbdE9Qglch5ZLWct58ZUG56OfblYF/qENFmpe8EvTsfdrB/apHm
	ymrq6H1U51xMn+WOe5+VjqWyLHq4z4wKqtSHh/rYqkxjoivPHjxDX2cgbj528d1Ol8IcfD
	x6kYzYNjogfNz4nlk2DIaXPnj1aDUAc=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net 07/10] batman-adv: tt: only transmit local ROAM flag
 together
 with DEL
Date: Tue, 27 Oct 2026 13:11:30 +0100
Message-ID: <2294364.Icojqenx9y@ripper>
In-Reply-To: <179309132249.3134.16887364336514212941@kernel.org>
References: <20261026085309.1074911-8-sw@simonwunderlich.de>
 <179309132249.3134.16887364336514212941@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart119544528.nniJfEyVGO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: DLDHOWL43FBQ657OK6X6HFDAC6JMUFT2
X-Message-ID-Hash: DLDHOWL43FBQ657OK6X6HFDAC6JMUFT2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DLDHOWL43FBQ657OK6X6HFDAC6JMUFT2/>
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

--nextPart119544528.nniJfEyVGO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:11:30 +0100
Message-ID: <2294364.Icojqenx9y@ripper>
In-Reply-To: <179309132249.3134.16887364336514212941@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:22 CET netdev-bot+sashiko@kernel.org wrote:
> batman-adv: tt: only transmit local ROAM flag together with DEL
> 
> This patch stops local TT entries from sending BATADV_TT_CLIENT_ROAM
> unless it comes with BATADV_TT_CLIENT_DEL. The ROAM bit is now cleared
> for non-DEL events in __batadv_tt_local_event() and for full table
> responses in batadv_tt_local_valid(). The goal is to stop receivers from
> treating a plain ADD as a roaming advertisement.
[...]
> 
> [Severity: Medium]
> 
> Does this fix the requester-side symptom described in the commit
> message?
>
> The commit message says:
> 
>   When the requester is the node which sent the ROAMING_ADV, it then
>   marks its own (new) local client as roamed back to the old originator
>   and drops it when it is still NEW.


No, this is not the symptom. It is just the way the roaming works.

The relevant part is "But such a behavior doesn't make sense for non-ROAM_ADV 
because a new TTVN [...] should therefore be used to create a temporary (roam) 
global entry in a node." It is there to announce the "committed" local entries 
which everyone should use in their global table for this originator. And ADD 
is therefore required - but not the roaming flag because it would be 
interpreted as roaming announcement. See also 
https://www.open-mesh.org/projects/batman-adv/wiki/Client-roaming#Translation-table-consistency

There are also pending changes for TT which avoid this odd removal of the 
ROAMING and flash it out more in the receiver side [1,2,3].

Regards,
	Sven

[1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-2-7c4eed81606d@narfation.org/
[2] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-3-7c4eed81606d@narfation.org/
[3] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-4-7c4eed81606d@narfation.org/
--nextPart119544528.nniJfEyVGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCU8gAKCRBND3cr0xT1
y9ZtAP0drgonQgtLdtN+ois4rAObGdjhVcdOZRhqLIO/gZ9OcwD/YJbHo4BEByYC
51zGNh19L04Y0SN+ZIeks2+lvDyLtQc=
=HsmC
-----END PGP SIGNATURE-----

--nextPart119544528.nniJfEyVGO--



