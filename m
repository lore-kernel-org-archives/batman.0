Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5ADC5DF97
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 11:41:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 16018814EF
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:41:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787398910;
 b=rAVXV554bhN1LgnjcrG1Xpw/IGPMes2W9aeLsVbZT7Hd2estQmgPuLZWtMWoUH9BoK8Yd
 rvVK91Kr/B7EKFSbx9VdTZQjMaeDvm58LcbXK7/lgf1fvnsHl/OPuIBVexlglV48RiV4t/e
 5vTaiFq3X6z5hWFRh/YS3Ese6hbduYs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787398910; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TekJJ3/G2DEyN7x0ZmtuopZ8f9leW9D0loLPGanNg+Y=;
 b=M9Bt1uhca0c8zsUHmhxfUxcH7CIie5OGGKosxpvhzndBSwgURAYimYPjKoJoVGqTegSpm
 0kM+DTzSrTUegSCRRmUes3v2NmloXD+saErraOiX/1IHhoZst6g5dUNX6LORb9x3pu0SwLg
 QuKWqWO4JoEvvH9vcxKSA/gwurPlabw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D69F3808AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 13:41:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787398901;
	b=zGu7W9fzuthmix7NPemy8BsAPuVRWFwxXyX4tiCKnNMh97wh67/HrGjr4EV4X4ddcP3QQx
	Iy43C/KYlmd05Wu15mNxINrHkj7U7HyLSBHB29VxiE8JlczAUupJbblgVka0Kk1bYupKKu
	VH6MPfyc47fYodqxQDdimpOXPpHB+Lo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787398901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TekJJ3/G2DEyN7x0ZmtuopZ8f9leW9D0loLPGanNg+Y=;
	b=GRFS25JTvjSKXhilJTd7UxWpPUF6/yFDPU3vG5frAgmhybPMz3nnJqqkDBcQ2goXGm2/Mj
	7XQA4SVJStq/r7o714GCmLOeChLLF/t84UIHKOH4JrKxmU+v3PyrqzuHQ94Rns6ob22Mo2
	dNsr/q6bSLZdhtRXKRZJ3cJ6loOC6tE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wjspKXsO;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 48AD01FDD3;
	Sat, 22 Aug 2026 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787398896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TekJJ3/G2DEyN7x0ZmtuopZ8f9leW9D0loLPGanNg+Y=;
	b=wjspKXsO4PXEzuo3No0hIEv5kvB0qg9rdoz0W6VJ6NrcJSr6UfnNesrM3TLWwExPQHIJTC
	iFqBA6JaqrzFAJwrrdmdvSJjbUosmDFUWOabZYEdKgqFZmvwTEozYmVSnwnxd3nRCytQ5j
	kxIp2h3+xr//6zr5zRvIrtAMQBLgLBM=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 8/9] batman-adv: mcast: linearize skbuff for packet
 generation
Date: Sat, 22 Aug 2026 13:41:34 +0200
Message-ID: <3908873.MHq7AAxBmi@sven-desktop>
In-Reply-To: <20260821094813.201800-9-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-9-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2016828.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TNCF3KMCKN5CIUKCZSPY5QYR4G75KK6S
X-Message-ID-Hash: TNCF3KMCKN5CIUKCZSPY5QYR4G75KK6S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TNCF3KMCKN5CIUKCZSPY5QYR4G75KK6S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2016828.taCxCBeP46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:41:34 +0200
Message-ID: <3908873.MHq7AAxBmi@sven-desktop>
In-Reply-To: <20260821094813.201800-9-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D8

[...]
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, but the new comment states a
> whole-skb requirement that the existing kernel-doc contradicts.
>=20
> batadv_mcast_forw_scrape() documents only a prefix requirement:
>=20
>  * Caller needs to ensure that the region from the skb data's start up
>  * to/including the to be removed bytes are linearized.
>=20
> while its body asserts the entire skb is linear:
>=20
> 	SKB_LINEAR_ASSERT(skb);
>=20
> with, in include/linux/skbuff.h:
>=20
> 	#define SKB_LINEAR_ASSERT(skb)  BUG_ON(skb_is_nonlinear(skb))
>=20
> Similarly, batadv_mcast_forw_packet()'s kernel-doc lists the caller
> obligations (set network/transport header, free the skb) but does not
> mention linearity at all; only the in-body comment mentions it, and it
> also understates the assert:
>=20
> 	/* (at least) TVLV part needs to be linearized */
> 	SKB_LINEAR_ASSERT(skb);
>=20
> Should the kernel-doc of batadv_mcast_forw_scrape() and
> batadv_mcast_forw_packet() be updated to say the whole skb must be linear?
>=20
> Along the same lines, the invariant this patch establishes is not recorded
> at either interface boundary: batadv_mcast_forw_push()'s kernel-doc does
> not mention that on success the skb is linear, and neither the
> batadv_mcast_forw_mcsend() kernel-doc nor its declaration in
> net/batman-adv/multicast.h mentions the precondition that
> batadv_mcast_forw_packet() enforces with BUG_ON().
>=20
> No in-tree caller violates this today: batadv_recv_mcast_packet() unshares
> and linearizes, and the batadv_mcast_forw_mcsend() path is now covered by
> the skb_linearize() added here. Would documenting the requirement help
> avoid a future caller reintroducing the BUG()?=20

Will definitely not deal with this documentation work this bugfix patch. Li=
nus=20
or anyone else interested can work on it: https://www.open-mesh.org/issues/=
468

Regards,
	Sven
--nextPart2016828.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomK7gAKCRBND3cr0xT1
y0dHAQDkkm6Ghk24ASYO7aRNwmGivKGlfgreBB+LR5M7otgeqQEAq/Vslc4Hbk7p
/GrkDJ3rDWy41cTXnSztK3BMHLH8xAQ=
=lW4r
-----END PGP SIGNATURE-----

--nextPart2016828.taCxCBeP46--



