Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B65BC55173
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 19:06:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5DCF684009
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 21:06:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785524762;
 b=xAqmQ7rCJCv4fiNIyKtQoLipvI0slGIRgRnaXYlWfqVERyFsTZ4pW7hPkg8dUlapPBtjP
 k2ugMQi6XlPJT40ENbg7avOJRxboFF9RKVDdL/aJknJ+hLHPCU8SqigKN68Mka0i5jez/NM
 lrssfasrHx17K/8OYWGwL+lhe0Q+ZSM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785524762; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8es6j2T4uWDHkN9zn7twbC0XdaR/06DY9gMYm9pk8LQ=;
 b=o2Yxwmf8ECAq9MFo9y6Diq4e0LnxzxZvE+91sEgQdC9U3Sxot6eB10N7vxSAtRatfsp6B
 DyhuGZaP4Gu//SUNIccn0hST7WG6t63no/KR9HDsqX+7+X0IMpTdJAZzhOmMeGXc8hTFrBT
 UuDLn3NM/QVfjruwQrgjG8M1fF/qGUM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F2B8580BD0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 21:05:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785524743;
	b=TwInt1F6UPUQxn5tagUAIF1/r/K+KoHARRZTTIJQkV4d3NWT3RqInyx6egJUFvFq2AKr/s
	R5jUNklYRND1qqBbvZGE61Yao0QjmVoI/+LYd8/DL9ltkNCjRMTTxx+100ifz/VNEprlfj
	skD9DR2w/qY309ZH2ZPWimTuBR6nak4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785524743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8es6j2T4uWDHkN9zn7twbC0XdaR/06DY9gMYm9pk8LQ=;
	b=cEODTWdnLcjkbT/FY+oFnax/MNixEXwr3exGqLeJ9eFGf4X8aNgnEeyTg1sgwa7Y7tLPej
	MNy02IkDSauH/AVIF5W8Mgcc2alLIB57Pu+99A56Sq7VlOLt+PqIyA1K8ME27xnH7BR51N
	d/B+DlwYU4TkOJnIaQndWk4DvFbF0l0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="q/W4w3zD";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A141A20268;
	Fri, 31 Jul 2026 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785524728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8es6j2T4uWDHkN9zn7twbC0XdaR/06DY9gMYm9pk8LQ=;
	b=q/W4w3zDpVkKCeXSPREu4f1Jgx4+yneXOmba9fT9f2MlyDqFREKVgsS7lbNZHvWdBF8Ouh
	SNr7euBXcM4yvROD8O34Wb/IHNV03VDCQff/WY/AzvH3WN6Bv0/k6fVDHGplEUeROvnKEF
	zwetPyUi+BcprZJl1gPKf0c4/c6RKdk=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com
Cc: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Fri, 31 Jul 2026 21:05:22 +0200
Message-ID: <4820667.LvFx2qVVIh@sven-desktop>
In-Reply-To: <178551276854.62695.15966621050711216654.b4-review@b4>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
 <178551276854.62695.15966621050711216654.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2488068.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: UDQRMGHBIANXDL2GQH2F2BNCZIEW5SOE
X-Message-ID-Hash: UDQRMGHBIANXDL2GQH2F2BNCZIEW5SOE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UDQRMGHBIANXDL2GQH2F2BNCZIEW5SOE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2488068.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 21:05:22 +0200
Message-ID: <4820667.LvFx2qVVIh@sven-desktop>
In-Reply-To: <178551276854.62695.15966621050711216654.b4-review@b4>
MIME-Version: 1.0

On Friday, 31 July 2026 17:46:08 CEST Sven Eckelmann wrote:
> >
> >
> > diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> > index 5600aaf00627c..8354c62bd86a7 100644
> > --- a/net/batman-adv/tvlv.c
> > +++ b/net/batman-adv/tvlv.c
> > @@ -437,6 +437,9 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
> >                        return NET_RX_SUCCESS;
> >  
> >                tvlv_offset = (unsigned char *)tvlv_value - skb->data;
> > +              if (skb_headroom(skb) + tvlv_offset + tvlv_value_len >= U16_MAX)
> > +                      return -EINVAL;
> > +
> 
> Just for documentation purposes:
> 
> This is (skb->data - skb->head) + tvlv_offset + tvlv_value_len
> 
> The calculation in skb_set_transport_header():
> 
> offset = skb->data - skb->head
> offset += (tvlv_offset + tvlv_value_len)
> 
> >                skb_set_network_header(skb, tvlv_offset);
> >                skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
> >  

I've checked a little bit further and it might not be the preferred solution. 
Please check Eric Dumazet's
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d45cf1e7d7180256e17c9ce88e32e8061a7887fe 
for a similar problem in IPv6. It is basically the same but without the 
additional offset parameter which skb_set_transport_header_careful would need.

Regards,
	Sven
--nextPart2488068.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCamzx8gAKCRBND3cr0xT1
y8qbAQCAJpC+N8gtVp1zcu3oovIeDC71peKFSUsrUOGbgZZ34QD+NI1obkaTjFbq
liSohRms8Aq8bavyjqWupQ04BcSR4Ac=
=dZpi
-----END PGP SIGNATURE-----

--nextPart2488068.ElGaqSPkdT--



