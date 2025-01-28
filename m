Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA8C0218A
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 22:23:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6118483E48
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 23:23:23 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738103003;
 b=PdR8T0yErN+SOVFLkEazNN8v9qXWWLFYh2b77iMqnlL3cip7ciaVhbMqQtFLo26rS39kt
 WnhUFdJ6WfuuvoS2m7WX6E2fqQmr9fWdSBGmQVQQKO07qQLDDW9k84RP0pEpAL4JQyZAuNo
 aBl9jsLh12M5G1jAwsMI/OFF3uCFCoI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738103003; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SoUbqoynN+sBzfcT9HGO8nkSlJSYhrGLCnBnhpxE0gw=;
 b=qcFExzWUruJQc7prw+K3GICAq2TaJ4mHtbM2y3XkqOoMjjo8dYsLQXurNbctbelBdU6q3
 PpO79mgLhjcVeOV+9td+FSiwiG9JpJ2y4T9R18qwWL/p/FHI4JgdW4NHDSM0Gc+eJUaTf9z
 09gJw4kLgawGgTgZJUzSNfFczxvtnDE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 210F581415
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jan 2025 23:23:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738102996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SoUbqoynN+sBzfcT9HGO8nkSlJSYhrGLCnBnhpxE0gw=;
	b=T9n3bvBlYEkweBghNjiC3167TcKBE/bFW67aT8KB+En7H22qchbpWtZDKCaMiXVHdsWW2e
	7IWBv5PzoqyJuTOKaqkmGYNTxRm2nU7+fb2baGHSP4qPBOVc+xIPIdEaIn96q9RY/STIsw
	bItb3wLRKStuPuEunbNz8mDxq+7lY10=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GNHpZ8+O;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738102996; a=rsa-sha256;
	cv=none;
	b=eY53gh5y8iSHAskYDTI8RA2nZOzBLltlc/GZZjg8yRCqeYZ9AqOz6tAgfaz+yOYcCzviCH
	3FURFGFliXKaEWeukwYatRgP7sUt7wuIbmZO3ijvZ1V2woXznv5x8Ma72t4gxG8feYJvfG
	b6LGGGnCw1Ej6gLaY2u980bHlTb/dEk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738102995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUbqoynN+sBzfcT9HGO8nkSlJSYhrGLCnBnhpxE0gw=;
	b=GNHpZ8+OYbJ56wDnsK1JmzCFNREa0yguQRFqV9JxrmjZv92a6fmL8cou61x7elOuDKOszZ
	H/D0qWYEmYL7bPVYQ+YQCNgJoB/Xdt59n8XkmTxOoynrX0vgFDJiAICo+ELHMHuyRGl5Rg
	wPJn9U14PsgoRILdUWPVw+SdJnrBCnQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>,
 Remi Pommarel <repk@triplefau.lt>, Sven Eckelmann <sven@narfation.org>
Subject: 
 Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 23:23:12 +0100
Message-ID: <4306467.QJadu78ljV@sven-l14>
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
References: 
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
 <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2693008.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 6OA34UMXGFY76UI7GNITFTX7BHJACTD7
X-Message-ID-Hash: 6OA34UMXGFY76UI7GNITFTX7BHJACTD7
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6OA34UMXGFY76UI7GNITFTX7BHJACTD7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2693008.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jan 2025 23:23:12 +0100
Message-ID: <4306467.QJadu78ljV@sven-l14>
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0

On Tuesday, 28 January 2025 23:18:06 GMT+1 Sven Eckelmann wrote:
> "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]

tt_data->vlan_data not tt_data->ttvn

Kind regards,
	Sven
--nextPart2693008.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ5lY0QAKCRBND3cr0xT1
y+SKAQCYZr8BMBWIqGtJAOrKxlJZ2moFoPa2nWHaVFUcOOuuCQD9Fs8Msh3lczt/
tCou08Mh45BrfIJu50N2q4F6rzx1UA8=
=1wo7
-----END PGP SIGNATURE-----

--nextPart2693008.CQOukoFCf9--



