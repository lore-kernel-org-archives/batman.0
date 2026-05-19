Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA0CD4F5B
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 09:11:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5B6A580CA6
	for <batman-adv@archiver.kernel.org>; Tue, 19 May 2026 11:11:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779181898;
 b=c6w0XYgw1+wQBk9fBUVkEqNtO1FgittcmPKpw8LKJ/y11jMpdwXNz0Wy3aQX0KlaNTqnM
 i787gXIKMLObBgx3yHAUG/aHTD4VJnt1ujVQrRb9V9J49yqwUJketllEt7Hk08/CYHnzYXm
 7HUtlrg1QM2xLSon/FUVCgW3ukVdI6g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779181898; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eUUHE0BcTCfS29wc4RdIQIT3Ig9yu6Crov8DsGjQZFU=;
 b=Jkzcfy/DjQCVpGnmyWDLvo/ikRLnYcgzQJfIrhCq7I7FPrE3ITmH7Gp2GYKOBQ8dL2cOO
 Xqsyn1tqNl/5d7+a8KTJyXy9hPJBOJLs6n/SrQ7JCavL3i9l9X9SRj+ZQMiKHl22oT7T5Wo
 07pJeLzzq5h3cn2mAXI0lkuR2PwDSKc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 950488083F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 May 2026 11:10:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779181866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eUUHE0BcTCfS29wc4RdIQIT3Ig9yu6Crov8DsGjQZFU=;
	b=VE5ogJ0pB8dq1Kz4UA77ay6FNUKPshGJdkqtZb+hK1g4wiLRCdZYRzvQOzUm/5z3eZFn95
	z7HnntbAEF1iA1BKJ3udFSlMtV8e6SPiXXxQZf/SSqOFyDsvRZu6+zRDmd11G9DxJwySkq
	W/kbK4rqQLznjIE3NnTDmAnmKiwKVZ4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779181866;
	b=LTj4R2gjlYndLxWq4Qlqkngbr1sbt2IHDfso6jOMv8zPV8jb0RuXHIuRkmBTu1ATWDoBO+
	CsbEpK3CFZqkEDY6UaHX+y9uhGKvcbOx1taMnIK4ckt46L5xVZDdskuFF38x0w9l4icqUU
	XHjSnIrX51VZryIWsYETaxTneQWejgg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Lj+WZqaw;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 43E171FF3A;
	Tue, 19 May 2026 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779181855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eUUHE0BcTCfS29wc4RdIQIT3Ig9yu6Crov8DsGjQZFU=;
	b=Lj+WZqawsXVhzFEh1FJ65Gw31fREezt+a/IwMIknbMWrQ1KPQoXCm4IpPZQqfMhFgiPL0y
	orlTaYIBaB5ENwEwcnek4rh1gO+SI0VurSvM4KahpxYtTXRxQpsdm8hIjMhAr6zfdoBO10
	AQs+HbBAw2Dsu4z/Rx0l9nEepfAyo1w=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: simonwunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH RFC batadv v2 4/5] batman-adv: limit numbers of parallel
 learned
 BLA backbones
Date: Tue, 19 May 2026 11:10:52 +0200
Message-ID: <6472795.lOV4Wx5bFT@ripper>
In-Reply-To: <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
References: <20260519-resource-limit-v2-0-489c3c919a54@narfation.org>
 <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5306013.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WH5TPDEVD4TNN7325CCFBR7UDTL5YPQE
X-Message-ID-Hash: WH5TPDEVD4TNN7325CCFBR7UDTL5YPQE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WH5TPDEVD4TNN7325CCFBR7UDTL5YPQE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5306013.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: simonwunderlich <sw@simonwunderlich.de>
Date: Tue, 19 May 2026 11:10:52 +0200
Message-ID: <6472795.lOV4Wx5bFT@ripper>
In-Reply-To: <20260519-resource-limit-v2-4-489c3c919a54@narfation.org>
MIME-Version: 1.0

On Tuesday, 19 May 2026 09:02:18 CEST Sven Eckelmann wrote:
> @@ -505,6 +507,11 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
>                    "%s(): not found (%pM, %d), creating new entry\n", __func__,
>                    orig, batadv_print_vid(vid));
>  
> +       bla_backbone_max_learned = READ_ONCE(bat_priv->bla_backbone_max_learned);
> +       bla_backbone_learned = atomic_read(&bat_priv->bla_backbone_learned);
> +       if (bla_backbone_max_learned && bla_backbone_learned >= bla_backbone_max_learned)
> +               return NULL;
> +
>         entry = kzalloc_obj(*entry, GFP_ATOMIC);
>         if (!entry)
>                 return NULL;

@Simon: remark from Sashiko, should we actually exempt own_gateway?


@@ -508,10 +508,12 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
-	bla_backbone_max_learned = READ_ONCE(bat_priv->bla_backbone_max_learned);
-	bla_backbone_learned = atomic_read(&bat_priv->bla_backbone_learned);
-	if (bla_backbone_max_learned && bla_backbone_learned >= bla_backbone_max_learned)
-		return NULL;
+	if (!own_backbone) {
+		bla_backbone_max_learned = READ_ONCE(bat_priv->bla_backbone_max_learned);
+		bla_backbone_learned = atomic_read(&bat_priv->bla_backbone_learned);
+		if (bla_backbone_max_learned && bla_backbone_learned >= bla_backbone_max_learned)
+			return NULL;
+	}
 
 	entry = kzalloc_obj(*entry, GFP_ATOMIC);
 	if (!entry)
@@ -539,7 +541,10 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	if (unlikely(hash_added != 0)) {
 		/* hash failed, free the structure */
 		kfree(entry);
-		atomic_dec(&bat_priv->bla_backbone_learned);
+
+		if (!own_backbone)
+			atomic_dec(&bat_priv->bla_backbone_learned);
+
 		return NULL;
 	}
 
Regards,
	Sven
--nextPart5306013.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagwpHAAKCRBND3cr0xT1
ywRUAQC6metEDP9gn57XIfn2U4N+q8G6tOQigVgwtSeAsafyagD9GmP1uTNe3zGk
sbJQ5dezcamNypu7xzfFYPkY/PPMTQM=
=cR/x
-----END PGP SIGNATURE-----

--nextPart5306013.31r3eYUQgx--



