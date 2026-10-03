Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE5CA5FDD
	for <batman@archiver.kernel.org>; Sat,  3 Oct 2026 08:04:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C451982C2E
	for <batman@archiver.kernel.org>; Sat, 03 Oct 2026 10:04:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791014677;
 b=Jvn9oPLogUZLOz0BblbogQnKTqJKfIjo0QoeDQefo6hXlXUKWaBJZDrnDIkgfg6m1THaz
 6iy9uy2lFXGXq9kxWT18AcGDgKkWfmGf0N5N3ZDF17i/+2IonlMcPYDYXtqrSRsUoEBISw3
 sgy70bBmdlGReR2ctX2eH5weH/HEdUI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791014677; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ry+Gokzn5ZW+SfKGOg84vVUnutz435v/+3ng2aBRrls=;
 b=KlEmn6/VNyvH15pQAndv0dJpP56Lt8n62x7gcx1pqZiNkhtqndxVBDvktfcHjAPZA5UUM
 1ompHnQuhdRCNaiDI5LAArY3i6x1OGZgoLgX8LfaZ/hCsH2yLPIwC0a0b4XEHyI5m+jr/81
 VrMJPoTtp/6J2S1pYoUVuKLg6Q25Ndw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D561C81CCE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 03 Oct 2026 10:04:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791014667;
	b=U4Dih34jwtzDIrNqPsW0DT+NmITOuWKFLXX4z+WdL7RZH1uGDt8s17PtBYmAi2dNMAOxI9
	Iv/gzXW4tZO4tQUf+KxJYp0HFT5JDxwFFIKOFRs9+IdD38oK1MLhRkOLKC8+KhuBA1rrat
	jZuLdyuUjO0Ew9vAoOw1ZZ3RNxlDOhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791014667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ry+Gokzn5ZW+SfKGOg84vVUnutz435v/+3ng2aBRrls=;
	b=oWPaO7DfB5F7Y3c1gt1QyQAeu5bnENO2bV4qD326oqs8YcvPglNFMX8FKrrsLXM+mpillL
	sNxP8LLeKVrUrQcjl5u+9xSzwrfsYOzKF7Mb2mvaHrlaQS/ggG8VQQKvIowyDyElh+WdrZ
	nGKsncqKlVXq0wK0q4i8r70ZfluEVxU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hOTDa0S1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0558C1FDA4;
	Sat, 03 Oct 2026 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791014657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ry+Gokzn5ZW+SfKGOg84vVUnutz435v/+3ng2aBRrls=;
	b=hOTDa0S1mJuBhj2AtkwCOb5wd7jo9cwNR/lmUqb9BRnZMH8hsaVazv/BQvL42kuBB8goHl
	/QkJGUs9mON5A3WbwShEY7LBAFTrVXwoY52uweF9lHyzpmH+1kkjnnY/pPuHJkCy9YBHuE
	FkM0CMv6dfwLWD1oTAYpURm3RuLnJ3A=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Subject: Re: [batadv,v12 2/5] batman-adv: split DAT cache into DAT cache and
 DAT DHT
Date: Sat, 03 Oct 2026 10:04:10 +0200
Message-ID: <3606315.aeNJFYEL58@sven-desktop>
In-Reply-To: <20261003072628.28052-3-linus.luessing@c0d3.blue>
References: <20261003072628.28052-1-linus.luessing@c0d3.blue>
 <20261003072628.28052-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3612901.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VNCIDKAIU7UQC5SZNDP6D7UIZQEZ2TZA
X-Message-ID-Hash: VNCIDKAIU7UQC5SZNDP6D7UIZQEZ2TZA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VNCIDKAIU7UQC5SZNDP6D7UIZQEZ2TZA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3612901.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Date: Sat, 03 Oct 2026 10:04:10 +0200
Message-ID: <3606315.aeNJFYEL58@sven-desktop>
In-Reply-To: <20261003072628.28052-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Saturday, 3 October 2026 09:26:25 CEST Linus L=C3=BCssing wrote:
>  #if LINUX_VERSION_IS_GEQ(6, 1, 0) // UGLY_HACK_NEW
> -       .resv_start_op =3D BATADV_CMD_SET_VLAN + 1,
> +       .resv_start_op =3D BATADV_CMD_GET_DAT_DHT + 1,
>  #endif // UGLY_HACK_STOP

No, this field is never to be changed for new commands.


 * @resv_start_op: first operation for which reserved fields of the header
 *	can be validated and policies are required (see below);
 *	new families should leave this field at zero
[...]
 * Attribute policies (the combination of @policy and @maxattr fields)
 * can be attached at the family level or at the operation level.
 * If both are present the per-operation policy takes precedence.
 * For operations before @resv_start_op lack of policy means that the core
 * will perform no attribute parsing or validation. For newer operations
 * if policy is not provided core will reject all TLV attributes.

You should make sure that your new op has an appropriate policy and the cli=
ent=20
does the right thing. The former is already the case because the family pol=
icy=20
is inherited.

See

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9c5d03d362519f36cd551aec596388f895c93d2d
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4fa86555d1cd338afc6e6308cc1ff890a014ec8c
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dce48ebdd56513fa5ad9dab683a96399e00dbf464


> @@ -1498,6 +1498,12 @@ static const struct genl_small_ops batadv_netlink_=
ops[] =3D {
>                 .flags =3D GENL_UNS_ADMIN_PERM,
>                 .dumpit =3D batadv_dat_cache_dump,
>         },
> +       {
> +               .cmd =3D BATADV_CMD_GET_DAT_DHT,
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
> +               .flags =3D GENL_UNS_ADMIN_PERM,
> +               .dumpit =3D batadv_dat_dht_dump,
> +       },
>         {
>                 .cmd =3D BATADV_CMD_GET_MCAST_FLAGS,
>                 .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
>=20

Please keep it in the enum batadv_nl_commands order.

Regards,
	Sven
--nextPart3612901.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasC2+gAKCRBND3cr0xT1
y6CCAP9ax5ZGrNB1G1dAWyfFHW1FeQO7yQhJ3DJI58AKd9BB8QD+OtFPG2nycB4z
Ywr150xwOjUl1g63TJ5HOV6scdUv5A0=
=5x01
-----END PGP SIGNATURE-----

--nextPart3612901.44csPzL39Z--



