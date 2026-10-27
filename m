Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BF606A31A
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Zp7U7oNY
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 69BE584134
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:19:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793103576;
 b=f729GMbq8dZ4LjG09mve5rpFbo76EzoLDPcF3uWaYrOtPoB8B3mmxLV1bSH/IFzkSHqdT
 MF5uDsmiKWm9+0X11EHGFF1loJfUBQIWmUSRgeBXotU7zKKqA4o0WQdsagHU4J9v4tjea2v
 mmvNEParhJc1Y5fmGZqmQJGxKWQPXwU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793103576; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/nSHj2KBswUv5Xue7skD7311sQSYthAPkLKLaOPAuQ=;
 b=KtxkRWJrfiKrf57Fq1aPUvf80kkzQZ/Xb+okRVptclBhvXvxJ2PxRkiqKCetN3A2xiT3J
 izinLmR4+tX9ayGIBYzxEmXEL2CC2GIRsV3MfwnnuJwNkOH97e7cbGFVeTqwCeLmTdKOF9t
 RfJBJjPQSHH2/TzAC+K6Q6MRbO340y0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 48ED6802A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 13:19:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793103561;
	b=0+xM68WG4kkMwg9t2ent4OFpITkHPz1pstxIcMe4i4vV/xUoaP1MWomE/SinXs8+dO1tyz
	AmStJkKhZJL5dlJ9BezrGqBxrXMyqjjmULk4sS42IYeTgtnIfu3RVr+5t06vmsEIuUVRWC
	ebTDDOuko6ODpg+bf36WOBpcoDy1/Q4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793103561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f/nSHj2KBswUv5Xue7skD7311sQSYthAPkLKLaOPAuQ=;
	b=upEWdouUjLbBa7KSBqY/Klge88qIKeTKAtL0GjkBCQEiEPWRB4DAX+AA+4UvflmZiMeYCV
	N+M8FvlJcl/Edv//Q8/hhQbUystD6FrCzfC1B7EpD237ddY9QHABjGxI4RQx/J/ojiraf2
	s1F3H+NI+uoiDpEJUFKES3iZM6bcMuI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Zp7U7oNY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 842E420152;
	Tue, 27 Oct 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793103560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nSHj2KBswUv5Xue7skD7311sQSYthAPkLKLaOPAuQ=;
	b=Zp7U7oNYWqjdZGlbI+2p7Ilz8CDZY3TSCyRwgvLFpIwgv/iECaF8Tm/42OK3Ns9KbmnqgG
	cI+mYBzAl6MCRkO9Z1hK0viq/apk/9kpKCkDiWOmSNCExWXR0Dch172+mzJ9jzen04+zDP
	JN4pQJf6DNmtZ5SWB0ONyr/3CmRqW3I=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net 02/10] batman-adv: Close OGM aggregation before
 transmission
Date: Tue, 27 Oct 2026 13:19:17 +0100
Message-ID: <2498207.NG923GbCHz@ripper>
In-Reply-To: <179309132139.3134.350154128482754175@kernel.org>
References: <20261026085309.1074911-3-sw@simonwunderlich.de>
 <179309132139.3134.350154128482754175@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart896556100.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: R47L6BD2KLHYGCPZG7IWYTHHIUXGYPF4
X-Message-ID-Hash: R47L6BD2KLHYGCPZG7IWYTHHIUXGYPF4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R47L6BD2KLHYGCPZG7IWYTHHIUXGYPF4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart896556100.0ifERbkFSE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:19:17 +0100
Message-ID: <2498207.NG923GbCHz@ripper>
In-Reply-To: <179309132139.3134.350154128482754175@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:21 CET netdev-bot+sashiko@kernel.org wrote:
> batman-adv: Close OGM aggregation before transmission
> 
> This patch makes the OGM send worker mark the forwarding packet as a full
> aggregate under forw_bat_list_lock before it calls batadv_iv_ogm_emit().
> After that, no other context can append OGMs while the packet is being
> emitted and cloned. The packet stays on forw_bat_list so interface purging
> can still find it.
> 
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 158d2b8f04036..85e99506a53f5 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
> >  		goto out;
> >  	}
> >  
> > +	/* Mark aggregate as full before forcing emit. */
> > +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> > +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> > +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> 
> [Severity: Low]
> This isn't a bug, but should the kernel-doc for num_packets be updated
> to match this new use?

https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261027-kdoc-num_packets-v1-1-1fa6d584b7b3@narfation.org/

Regards,
	Sven

--nextPart896556100.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCWxQAKCRBND3cr0xT1
y1V6AQDt/ZAmmSaTCrxGEO6UbslKPV46riTMxbc2cltDAAYa3QEAwZLs7PPRwmpu
gtRNpov7f40kTS4qSPJyN9l4TfOWUgA=
=CHH7
-----END PGP SIGNATURE-----

--nextPart896556100.0ifERbkFSE--



