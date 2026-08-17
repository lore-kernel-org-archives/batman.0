Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA2DC5B572
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 10:54:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D6005820E7
	for <batman-adv@archiver.kernel.org>; Mon, 17 Aug 2026 12:54:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786964072;
 b=yDUsCAlLkiSrekkyTc1us96BV77fi2Uo43ykcNckZEmqIUVLJoMwGpfqAtB5CAA2Do+6t
 o3aKHOK75R1Bsgc0mjSNizcQRLuKkOeSacKEbnX6v8SYVw3WF0HLcWJcjRsQApYSIjf6GkB
 Fcdlrk1y8VJKSaGkE2n30msNW0DTYd0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786964072; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FJ8WBa2jvYvoCXiVxlGZwnT/sE+UmDdw+JRzkjtj2l4=;
 b=nlFh9CEf2iCvC271y6wnAcqBuOWczNpN3z6Gp97hlHqEb3rClzDltrJoG8aeAZnXW8tXt
 t8ouQi5iLQ+ieEcnWbUtlyWGdNpHdVXPe9aG8A/vNrqW3KNZ0LxrAdAyR4NCV+RBRl0YZKT
 I8t3FXHZDtDfz6qDKzdJYBEC7ObOW5w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 32534802F3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Aug 2026 12:54:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786964064;
	b=j0Gl59f96SLI7xIDNVKrezSBUWy3ULF5Lanm1rf5pJJoDb/xm0onsmngL+PR/2Kk1+ZvXd
	xdLcfVwphSI2kCEKcRkU6b1Lp1SMzbZm4qjgZ1guwmq4mIdH6x9BLPnKHKsIAsLsmoAB6C
	8HQxDgCJu02qk2zCcT/ql+ll5Vvb98k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786964064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FJ8WBa2jvYvoCXiVxlGZwnT/sE+UmDdw+JRzkjtj2l4=;
	b=SgRi01jlXZUlVPeN9InPv38+Vtw4TNtXj3DeXIg1gtwdV5wDK/CzGy+gRBYZmrbT/dBTcY
	qAJGufNG/eZv2PKI0XBYdsSpqFdroT4C1uX9j0PDrujDPVzSEsU7n8u5l/NrABr2w6Pp9o
	kFySf0N7mJIzy5tpyzXAK/wx893Ps8s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=T7lqvcJE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A23A21FE13;
	Mon, 17 Aug 2026 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786964049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ8WBa2jvYvoCXiVxlGZwnT/sE+UmDdw+JRzkjtj2l4=;
	b=T7lqvcJESzVnxMZ7x6/tHFT/25848gHtGdfZAsjUSVprUxa64j47dTBvfyQZOkN8Rgz0yo
	+QpbIJFY2q5RZHU8enCIm7VUw4kn+djYQDZ1MmX7Vd56LkVCrn5Ec4dEbcULkR6VHJiAfR
	AiiBwKd+hBjeBwlpP7e9EgC/0U0tEbI=
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV
 offsets
Date: Mon, 17 Aug 2026 12:54:02 +0200
Message-ID: <6020830.DvuYhMxLoT@ripper>
In-Reply-To: 
 <CAC_etQHifs5Qo-syD4pF+OPkKZFwHoNJFsLdjQsQcm3=_PyydQ@mail.gmail.com>
References: <20260817084955.944189-1-david.lee@trailofbits.com>
 <178695824178.1497243.16045312752677179315.b4-review@b4>
 <CAC_etQHifs5Qo-syD4pF+OPkKZFwHoNJFsLdjQsQcm3=_PyydQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6296243.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: OQHQARJBCG6L7UQQV3B45JYIPDON6KBQ
X-Message-ID-Hash: OQHQARJBCG6L7UQQV3B45JYIPDON6KBQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OQHQARJBCG6L7UQQV3B45JYIPDON6KBQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6296243.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Date: Mon, 17 Aug 2026 12:54:02 +0200
Message-ID: <6020830.DvuYhMxLoT@ripper>
MIME-Version: 1.0

On Monday, 17 August 2026 11:41:53 CEST David Lee wrote:
> Hi Sven,
> 
> Looks to me like you've also dropped the
> Suggested-by: Sven Eckelmann <sven@narfation.org>
> 
> This was by mistake, would you want v4 to be sent out
> with the Suggested-by line?

No, not needed. Just wanted to document what I found.

Regards,
	Sven
--nextPart6296243.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaoLoSgAKCRBND3cr0xT1
y7quAP9Ifbia1KyXmtLtw69lytNqlJYKiQ+IGptNxxp0dyE13QEAgdja4wi9SvFe
cg9eeBbwvS6/4ygt8em9s3G2nMIh7wo=
=QdLk
-----END PGP SIGNATURE-----

--nextPart6296243.lOV4Wx5bFT--



