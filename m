Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE55CD6E56
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 09:56:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F79283DF9
	for <batman-adv@archiver.kernel.org>; Sun, 31 May 2026 11:56:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780221362;
 b=1ghMgGfwzVK5CJfWaKK7l8YRNdOHFPFrvU6Hnr5RkbFO9KN6xSJ9iPiRrRUY37Ay9dP+9
 9pyW2EO6fkUaw6QcG8ftP8fYRUkFUGJnmYelnAi6QH9kaTguXqESAWmc0mV2HbsMHKv53hI
 UkpGCDbCcLVKZLqdAgM6zoVgsPJM/w8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780221362; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=11C2W9YBJypz8rcHtIggW5fGvEXmfR1jx7s8K8Yvoa4=;
 b=iAnB3rug8+nFMwf1vEZdqP9F00thi5+dad+nZw9LQs9d5AKTuIBMUfVBza87jMOFbITaI
 jDz60en2J8VyazpR26cwHlIpSl4ZiwZfL12aLbgDzHZTOMPTq5CieX6V5q2i/dTcXcAch96
 nu9M44+rNOjiedWq5BMJ54q+U6zw5zM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B666D80274
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 11:55:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780221356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=11C2W9YBJypz8rcHtIggW5fGvEXmfR1jx7s8K8Yvoa4=;
	b=X9LOZ/P9wAf3RKhL6SJNuiw6x54mzIyCwlgASYoBUdKELybUxOXtbHhAtjBNWU8OIQV3E0
	6hAPArlPQx/OyFx0gsUMDSvETKhQYY8lYubxwyzXHopfzZ6wrPanKhN6L1aEfVDp4BETDT
	GF40KNrFTM/hheboraULvZZ9h7me/2s=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780221356;
	b=z/il70jCZQk3uj9bfaZURSInLmid5yXQmNHduL7/v4aznXhJhPJ1Mpir6sHzAmbgCz9PDy
	ol2LfSLYPlN19IDnSoc+iNbtOdkKNWiaY7BvpOCtgolEtJ4r3qC4V2Sf2GmFYCmP/h2tXK
	BwJ8uzJHMVLuFEEg8b4+r5dgCk2KeE4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QDUj+DCF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 471B91FED3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 May 2026 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780221345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11C2W9YBJypz8rcHtIggW5fGvEXmfR1jx7s8K8Yvoa4=;
	b=QDUj+DCFzYCsAwry5RDKEaZA0y5cjX3FdUzw3LBGFun/E6qAUGwv/p31ttpuPyoo6FFU+U
	BjgPNpYpsmFxdMOA8fc4VOUMb0i2cOHhteVcUx8G//L91b2LR792wi/1hWlL2Jge9w+4zB
	ol1Tfx98RMiLrBqGlSAmsQBTSR49vug=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv v4 5/6] batman-adv: tp_meter: use locking for all
 congestion control variables
Date: Sun, 31 May 2026 11:55:34 +0200
Message-ID: <3463983.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260531-tp-reason-missing-v4-5-5d2556e00128@narfation.org>
References: <20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org>
 <20260531-tp-reason-missing-v4-5-5d2556e00128@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13533897.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BTGT5WR3PBRL5VYSK4O4JNZDRWGJRJJA
X-Message-ID-Hash: BTGT5WR3PBRL5VYSK4O4JNZDRWGJRJJA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BTGT5WR3PBRL5VYSK4O4JNZDRWGJRJJA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart13533897.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 31 May 2026 11:55:34 +0200
Message-ID: <3463983.mvXUDI8C0e@sven-desktop>
MIME-Version: 1.0

On Sunday, 31 May 2026 10:28:55 CEST Sven Eckelmann wrote:
> +       static enum batadv_tp_ack_reaction reaction;

This should have been of course be non-static variable. v5 will come 
tomorrow....

Will not be applied anyway before v2 of the net-next.git PR was merged (and of 
course submitted first).

Regards,
	Sven
--nextPart13533897.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahwFlgAKCRBND3cr0xT1
y6UTAQCkpj7t9hKl/ohasDTtPf2BqvW/8/mq49D8m36uACUUrgEAup9AjPyactEK
UsnmXLqS1Uim0d1Vj9NyY+dIlvx6rgg=
=fwl0
-----END PGP SIGNATURE-----

--nextPart13533897.O9o76ZdvQC--



