Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98F1CD4851
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 08:37:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 498578092B
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 10:37:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779179873;
 b=uZQV8lOs2jt2lGc2PjYyEsDZ7Pd5adKF69SfSiiEJ2qT2bf1E4GjAJFYwwNWu3vFzQwVz
 ZAnN4T4794uMw8V4UCB95qD+PaaKLdOxXninHkNoUwmT2SDWffKm60Bas9Gb9gjDs3XuOSG
 CtsJ+HMJcFxkWQuWD1W4NFZal+0Tvmg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779179873; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZnzxoHNrbiLFBlPqCsYTZbX33no/2D7ec4ZZH8yzyyM=;
 b=ET5nYs4ge9ipRvrdtsl+mQKTf2rKs03cL6/x/OvvhBJqjjAD0tumQyueNCKuxJDsm5DiU
 /st6ecZGHc/6sjteuJgLcUxhEyTxZHZs1GlhJhUFs/lyet70zqrfqD01/91RrtMAc0OCeeA
 JvabHKOes83GmKZP7ICaVj3rWL8jxKg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C34438042C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 10:37:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779179868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZnzxoHNrbiLFBlPqCsYTZbX33no/2D7ec4ZZH8yzyyM=;
	b=ULkAPYW0bLGoDnqjGLs2NSsau33FkCz6bbD6gozmy5fgnPSVioATYboAocbG8dMAkbkU+1
	0iADqVi6mZ3kfyf8mIb5zi208aVcVPAaoIX4F1vhaj6H1FkdWKNb2ujHWKaGeuwZJXLI/h
	36ZNjcn97rTwyQELTAT9HD9bxy8lbGA=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779179868;
	b=OYzgklLu5mHITegEe9Q9LXoMWVAN/bzEpOYlwym2ZMwoa8scQkRebZQ9xAkNlFYUAD8j61
	8q9sxfdpMfKCY1fhLgwqkUofnZOwhi75eVyKzlioQoarcrcQ/4L6CndASyeQ3GjaW7UZdB
	ie4OuPHWX1hz5gnR1/tcGVC5w6ChARA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yRIhkzjy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F28231FD57
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779179858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnzxoHNrbiLFBlPqCsYTZbX33no/2D7ec4ZZH8yzyyM=;
	b=yRIhkzjyylB6jfLO8bdteGvrqh5TqjENZeW8vHh/E0x8DWmXtwOiYYYjC5Y96xnlNCRgeY
	RR+zjgMDxtXjBpFX7BZZh3UFUStINd7o5U/+AacdRN9usvrQxb9hINi9Rynd3gjciwSKa1
	v+EHFYAJyyqkpTcDgGEIj7SVMteOt7Y=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv v2 0/5] batman-adv: allow to specify limits for
 remote
 learned objects
Date: Tue, 19 May 2026 10:37:34 +0200
Message-ID: <3036655.mvXUDI8C0e@ripper>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13100678.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: QJAG33UB7V23ASCWXZSCSQEA572OKSJZ
X-Message-ID-Hash: QJAG33UB7V23ASCWXZSCSQEA572OKSJZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QJAG33UB7V23ASCWXZSCSQEA572OKSJZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart13100678.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 19 May 2026 10:37:34 +0200
Message-ID: <3036655.mvXUDI8C0e@ripper>
In-Reply-To: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
MIME-Version: 1.0

On Tuesday, 19 May 2026 09:02:14 CEST Sven Eckelmann wrote:
> For the moment, I just want to demonstrate how this might work with some
> example code. I didn't invest any time to actually check out the other
> items in the list. So, please consider these lists as vague suggestions.

Please also consider the commit messages as placeholder :)

Regards,
	Sven

--nextPart13100678.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagwhTgAKCRBND3cr0xT1
yzuTAP4hklHkgdBm9mo/pgF8jwlGs0Y1buax55npmSxu3AweHwEA9nEtm3yZ/H1a
O4b8N9N2LgOfY8ll8FVRtzTi1OCWlgk=
=XIBa
-----END PGP SIGNATURE-----

--nextPart13100678.O9o76ZdvQC--



