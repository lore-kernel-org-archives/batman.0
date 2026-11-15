Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048E606A31A
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NPNm9MOM
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35C8781A49
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 10:45:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794735903;
 b=0er1BahxONXzYCfYLYAJRfyuo6GVYrvLqlszaGlc0Msy4Sy2oaR9KaMpO31uIuG5o+nDG
 ds88qJZbOg/Yb6fb04zfGXRGnNRewkBmi77LKHg0oY77WIJXLBpNzTq5xsvYdcSUQHZuCsr
 zGQ8zFFqcplpTsoK/SSantkbKKHmN+A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794735903; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dHnXQL0Q1Zu3htY5lL86h3bFX/9xtrVkhQNFd43gABg=;
 b=hme8G4Xuo2KkM3Qi+VbO/dz8PL9TMlHh++GyZCibSUyirxXjf/gyikoevd9pgdVNb2Sqs
 sMHjM1ABacRDGi2JQdLlAwmBxs0Jd5GSzLAEA6CGjIX/lKL0jTAINd24lcuf2FNzXDb+By3
 xBcZN+KsJ/7xFWlVu24oIw7jirk87Zk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 30DEB80393
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Nov 2026 10:44:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794735880;
	b=jzU5SotnQT8MkSKaadA5FfocuVbltUQHrw+A0hNsDMNZpgDC1WiKaZRa9hLt9BzjgfQmNW
	SOTJIU7aSDfRUDSCbl+5j0tJbgOnblPUX3NJcEsdGH7vBor3aDmnotfnXPp6VvB4rnp8mc
	4QNP3OtqCSdVt3ghV+Ty56oaUEiRBNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794735880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dHnXQL0Q1Zu3htY5lL86h3bFX/9xtrVkhQNFd43gABg=;
	b=E+ruRKr5YCLIA/3C+yOqEdfM68tacVGJfdMSer5RI5ywHAL3H+uIsfEmcSH2T+IkTkF8CS
	4fxz2NCyE7lwJVZmNnQU/RS6wCvnZb6WIjhYfH/0oz30vgkpxt0Fm5iJixrV3HWiWPOPsu
	cArSOoK30+SQvX0QqC8rFEG2jIuPHyg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NPNm9MOM;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5F5D5215DD;
	Sun, 15 Nov 2026 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794735879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHnXQL0Q1Zu3htY5lL86h3bFX/9xtrVkhQNFd43gABg=;
	b=NPNm9MOM9XLJTuJSf7lA68lWvha5XNGqhmu/TIkzRVPfMLhKWpgGPPsQrWjSb54bGANsKT
	73B09hLJ1WaGxH/xrcpgqhMbDwxywMKnvdnmyaABR/m4KbUqO13qxExnLJas+gEPgpUb92
	fW9TNbs9KW5QS+H6NXrLdVbqu/eVlTc=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] batman-adv: never consume skb in BLA rx
 and DAT
 incoming snooping
Date: Sun, 15 Nov 2026 10:44:36 +0100
Message-ID: <2285103.irdbgypaU6@sven-desktop>
In-Reply-To: <sashiko-outbox-215353@kernel.org>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
 <20261114091556.3336038-8-sw@simonwunderlich.de>
 <sashiko-outbox-215353@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14136404.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VOGNNWKWEMIDRLBCOJ3YQLB32P5UTJZF
X-Message-ID-Hash: VOGNNWKWEMIDRLBCOJ3YQLB32P5UTJZF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VOGNNWKWEMIDRLBCOJ3YQLB32P5UTJZF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart14136404.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Nov 2026 10:44:36 +0100
Message-ID: <2285103.irdbgypaU6@sven-desktop>
In-Reply-To: <sashiko-outbox-215353@kernel.org>
MIME-Version: 1.0

On Sunday, 15 November 2026 10:24:44 CET sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can batadv_bla_rx() ->
> batadv_handle_claim() register the local node's own backbone gateway with
> own_backbone set to false [1]?
> 
> When a frame from an unclaimed source MAC arrives on a VLAN before a local
> entry exists in bat_priv->bla.backbone_hash, batadv_bla_rx() calls
> batadv_handle_claim() with primary_if->net_dev->dev_addr before reaching
> batadv_bla_update_own_backbone_gw() at the allow label:
> 
> net/batman-adv/bridge_loop_avoidance.c:batadv_handle_claim() {
> 	...
> 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
> 						 false);
> 	...
> 	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
> 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
> 				      BATADV_CLAIM_TYPE_CLAIM);
> 	...
> }
> 
> Because batadv_bla_get_backbone_gw() inserts the new entry with
> own_backbone as false and batadv_bla_update_own_backbone_gw() then finds the
> already-inserted entry, the local gateway skips the initial
> batadv_bla_send_announce() call and never enters the
> BATADV_BLA_BACKBONE_GW_UNSYNCED startup grace period (entry->wait_periods
> and bat_priv->bla.num_requests).
> 
> [1] https://sashiko.dev/#/bug/linux-dba9d95d-5eeb-40fd-abf4-e054aee1f735
> 
> 

Not related to this patch. And the patchset to handle this better is 
pending [1] ("bla: register own backbone gw when claiming for local node" 
might be submitted outside this patchset).

Regards,
        Sven

[1] https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/resource-limit
--nextPart14136404.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavl/BQAKCRBND3cr0xT1
y/naAQDSeqyWklCQry5ne37eXsf2RtNwREMp+aLYNv4D/7XGUQEAg73yL97gSG8C
2Rk6beBBKBBJvREHVrsAs96peuFdvgk=
=mLFC
-----END PGP SIGNATURE-----

--nextPart14136404.uLZWGnKmhe--



