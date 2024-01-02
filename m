Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F311C47079
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 11:16:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF16383F28
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 12:16:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704194190;
 b=00QX3Cwup7StYaNTgQBGU8B9C8Z7eJPgJUOOAcL1Abo4XzHacSwEDv/tS1efL/wKBQlWF
 Ci50xIDJeW6R6bMM/tXPEAkNxElGKc7uoAveEDCRxTngpjdAsTafrhvNFh/Izn+PM3TUZDm
 qtbIAu26d6Mcj/vuY6ITnZrHLNNLm14=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704194190; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0ayQIvnSnVInOt8Lf6KcwxsyTgPGUOLn6Gxu/uNHiL4=;
 b=kyVwlberr9m28fRH5kPymNDowikFq5Jp+nu04WgZTeW15FEyMkZrc0+4Sl1lx2JC13sOZ
 kloIJMNG9pt6pcvk5qlj4k+Wz7ibnTmR9/zNWFKmJs3Ykk21k6gUvXad3hZy3Y7MmMvpETr
 kO77u9Bav8IyfBbrRR/PQH8ll2jTpt0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 03BE880146
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Jan 2024 08:13:15 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704179596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0ayQIvnSnVInOt8Lf6KcwxsyTgPGUOLn6Gxu/uNHiL4=;
	b=Xxld59IN/gdvCbqRbEJgW/dqY1rtQwK+vkcIgaxj9HCkvb1vb8yY5tS6I+JZZb/AYKRsW2
	CeVvIfCaCFdi3CW6Oy4ek4ovoarxpjLNjWRi86Xo/KGfKbaZcQqJDctn4kz/VUo75FPsrU
	pSJNxK3uQk/zs2FX5RmtOI8f8EXCLwU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704179596; a=rsa-sha256;
	cv=none;
	b=xyiqj6dbnDPV9vfpUq6X1ztyM6lDOgKFFSb0hkRVjb84c2fFBwgndsL8EfvHkEZsZ5MgYD
	yhFd+z11buqgfLm9bxGouHCiFxUiOXtPwGAUnETKDFHcd5pcL0eayW55b7t2xKCKmWCvV2
	eCLQeuhLQRZ+wrEx3lqP8xXxwYrTadA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=web.de header.s=s29768273 header.b=Y2CkeGTg;
	spf=pass (diktynna.open-mesh.org: domain of Markus.Elfring@web.de designates
 212.227.15.14 as permitted sender) smtp.mailfrom=Markus.Elfring@web.de;
	dmarc=pass (policy=quarantine) header.from=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704179577; x=1704784377; i=markus.elfring@web.de;
	bh=BzfHfM8ElsvZex/Uect+kFopl0XLqwkwH+F+arwONTs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Y2CkeGTgDSesaLttaMthQObZ1uW4skPAqChG/k58SisrwhJ/RnSaAcPeMc7wTmrL
	 2Wwu7w6+jSTJJ/b5R32ky01lqPjtcnrUVXuGM4npTKjVIIrEV79eymRjXGkNBR7lO
	 2tBeeuAqYG/vBbU4xDmBJOGRT/Eh5ynZu0uWqTwd5rrgzCikNFOzSxWgbklyp1zTB
	 BTmDtQqM3rESmQDrsF21D7mUnTRM5OngLmNx1cjZGvA8tU7KVhYsiEd6OlnAb3kSJ
	 A7WekoInu6+ic136epG3LhxdzLSW9A2T0ILFVXcuUSDR+y0gA9cxbwdQk7YP8Gj4F
	 B0IFC6Bw79JJUN91Dg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumJD-1r24Ec1OQV-00rRZw; Tue, 02
 Jan 2024 08:12:57 +0100
Message-ID: <d2ce9337-e1a4-4213-ad6f-926c085dc17f@web.de>
Date: Tue, 2 Jan 2024 08:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
In-Reply-To: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X8tI5V2tYneXOsAvm6L5iObE7FR3QlCz66qzzSaWxhd2o876S7p
 8qtEp1ZdHpHXIUIl/sGZ7gk5ZChmppeDJ2SCctoTwAhiA/p/RGgAzWLQOUFo95dSBxDj5MM
 fwp/6Psyok7/zLxcCxvSFSKQHwhal0M5PRT+KHgeO1uGX5J1tao8rfEbdMy+ATuGV3Q96nq
 VnVOYEyfPH8Id8tdczjyQ==
UI-OutboundReport: notjunk:1;M01:P0:k1BY0oVzLbo=;Dvl3Si46wFYS3jSy7Kllf1tk0wQ
 Lg7A3i+fI2SSage3Fbl1/cQseWp/3tjxhcwh4Kptz69UwP0hnVrVHSEyXRcgbKvfrak0dXSbl
 iEx7cXE5+H9Izm+4gvFSzkkFj4FQ8ujDwRta6apTsKLM5bhs7zLXIh+Rze8wk9w/Uz9rwbsXH
 VJ2w0oDJ3TLC9qfHkQw+oVkRk+XT24xqtdp6z/QYRJ5GGhc7AG95AXmzugDcHAgt5FE7gvi8U
 +n+d+FJTwXRDKFru7KzGpoD3ZALgzoTodQACOtl0YrJHsIxR0ckFh7qUAuiq3UI+WiXsQMzC3
 dUZ+20rVwnp2RnlGkfAz5iVdcgTFTvweVInL+BVq8zrwZIzBhR9+C66a9Apz9afPImHW/I99R
 ouJ70dqvRkeI6yFw5sbWlnZMwdJR6BruTydV3lMlW29hVCSjjG1rQLUohlGt64/r93CLsVeSR
 KGUrnLLPEedbWG8C4tDA0r3eMj5lw6JzqpomgOvRwht4c4L4Zxuef+OQso3dHKIPwd7wlIfw0
 WCCEVqXgOdUqUV+pJLt5DeCLvxHxfY6fCHKUXs5u+gW/iI8GSnXP5mGomXC2FhJdiwkbkqDWA
 Uc2aUziM3b9TG1mhBbhSxHQ2r29G+5n5y1FMkSBJuCipylQmSvu2UeFhvSvZylqe4GY7M4BdH
 7gN4OE6j6NKYBlIba/1N0rloGAJp5S6vAHSX3U/lHOhwxtot6OiSt1M6BZUIi5SJg27bu1n/m
 PAhY8EfKWH0txytOOar/ub/lN27IiiWckJAjsk9da+gM9uMZpJa+RYNS5gzFNhmYIgd4R8wts
 CP8lj3mqdUbe17ph+Oe7/dPhU60dGKA0Cz9QmJrRJ88OHn4n81OOu/siEigIBR6W0pyKomEuC
 +KA9nffLt6EW7RXFtPP9j3+TzcpdUsnGYwM6HOGBxzAh2GPBbLWVr48LF7dnkPqX4/YBweJdu
 g5bIpQ==
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 7PEGORIA4F4AUABZOJLQVGWPUODBF4QD
X-Message-ID-Hash: 7PEGORIA4F4AUABZOJLQVGWPUODBF4QD
X-Mailman-Approved-At: Tue, 02 Jan 2024 12:14:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7PEGORIA4F4AUABZOJLQVGWPUODBF4QD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2024 07:52:21 +0100

The kfree() function was called in up to three cases by
the batadv_throw_uevent() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder kfree() calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/batman-adv/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5fc754b0b3f7..75119f1ffccc 100644
=2D-- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -691,29 +691,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv=
, enum batadv_uev_type type,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
 				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
-		goto out;
+		goto report_error;

 	uevent_env[1] =3D kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_ACTION_VAR,
 				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
-		goto out;
+		goto free_first_env;

 	/* If the event is DEL, ignore the data field */
 	if (action !=3D BATADV_UEV_DEL) {
 		uevent_env[2] =3D kasprintf(GFP_ATOMIC,
 					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
-			goto out;
+			goto free_second_env;
 	}

 	ret =3D kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
+free_second_env:
+	kfree(uevent_env[1]);
+free_first_env:
+	kfree(uevent_env[0]);

 	if (ret)
+report_error:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
=2D-
2.43.0

