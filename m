Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B425BC77B73
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 20:30:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A657081AF9
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 22:30:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1685133026;
 b=UX3hTVihPQLsGpn21lkbOIlIkU/G7+UJM0mplkqTV7b+jGod/xDi4eiqIVwKHl09e/Po8
 lc5e4Kw98Sih/kcjqcCDCw7esWgTuwRxJyO5nfJVfTw+1YJ8zCvc5FmR6Go4TkaRsRUOcCO
 AF6PkCUFzsj+drbxvOO8nCLzvhfSr4Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1685133026; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nrJocbC9yujvo/q/Zvs4to1pf3VWKChUTxeNN8aTAa0=;
 b=oeCJny0gx5ucVCPFy2q/Zxg2I+7v1RoEdhi1P7l22T/7IjmBig7nYvgabT7MKxRb31dHM
 0+6LMv1vQrM8QRRdSc7ZIy+wid8u56y1MZ9j8k3XCC8dUsFtpivnJvJRYstAHiCfKXUyNGA
 qG37FHnTborL1jdYXnu0UN6V/jmaCuc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org; arc=pass; dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 31A3280FC3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 May 2023 22:30:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1685133024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nrJocbC9yujvo/q/Zvs4to1pf3VWKChUTxeNN8aTAa0=;
	b=bwEABRsUSOqJA6IFimxNz3pP+LfoP/K/5pev/vKFiC40/eqWxbNC9UgMZPRE37M0bpt9q5
	9Pim6ngbc1E05B1Oa9l39ANMIzt0ZZ5MaJRllhcbKPvVYThBvaXVa1d7vEbrMZqWEPqgAD
	HnAdM4OAjW6hZyfTZMeLGXerKsttKN8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1685133024; a=rsa-sha256;
	cv=none;
	b=KPF88wdWCEkr5YnQUHihjCGatCcUsxkiOdLE0BR3RqPwvlpS5MQDFjzVo2rN7N7JY2KrIu
	m6YumivOwpRxJGwdRmZcR4WzK8cG3g+mbDy/mUKpDzrmFA3svRs6nNu8NRHO6um+6SrO1V
	7groE3Uue4VF46Z72eo3kL1OOneLDlU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="I/LSxf9e";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1685133022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrJocbC9yujvo/q/Zvs4to1pf3VWKChUTxeNN8aTAa0=;
	b=I/LSxf9eXH1Ikzq1flOLF5C80S7pH/0I/Jm0EFS5cz2h5bm7XpXIbRPK2L0iu7XbaFTqTq
	eNci93A+CRVdDUe6klTXO/tCMUkmTXTEk34RO8c3ohoKfnzOqMwP+DzxhjOBweZcZAYypG
	B8AS5+F3I3PkNhHN5zgPby7OKPsQst0=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Vladislav Efanov <VEfanov@ispras.ru>
Subject: Re: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Date: Fri, 26 May 2023 22:30:16 +0200
Message-ID: <7526514.EvYhyI6sBW@sven-l14>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3740035.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: PDBDOQ7SJLGY5MQSJMQQ2OPNBQ56UXRM
X-Message-ID-Hash: PDBDOQ7SJLGY5MQSJMQQ2OPNBQ56UXRM
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PDBDOQ7SJLGY5MQSJMQQ2OPNBQ56UXRM/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3740035.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 May 2023 22:30:16 +0200
Message-ID: <7526514.EvYhyI6sBW@sven-l14>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0

On Friday, 26 May 2023 18:16:32 CEST Vladislav Efanov wrote:
> Syzkaller got a lot of crashes like:
> KASAN: use-after-free Write in *_timers*
> 
> All of these crashes point to the same memory area:
> 
> The buggy address belongs to the object at ffff88801f870000
>  which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 5320 bytes inside of
>  8192-byte region [ffff88801f870000, ffff88801f872000)
> 
> This area belongs to :
>         batadv_priv->batadv_priv_dat->delayed_work->timer_list
> 
> The reason for these issues is the lack of synchronization. Delayed
> work (batadv_dat_purge) schedules new timer/work while the device
> is being deleted. As the result new timer/delayed work is set after
> cancel_delayed_work_sync() was called. So after the device is freed
> the timer list contains pointer to already freed memory.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> ---


Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart3740035.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmRxFtgACgkQXYcKB8Em
e0ZD0RAAp8e/HTANDtMQF/tKm+CEosGlP+Hp8Aqdd8nNfTXXC2DJAouO/TO2ycmq
G0N393ff6vuTkebzzuM8QqOQxFVMGCH/VDGZEkOAr+Qyq8V6Vq50uCJUyi1TkCEk
lhM/wvBXJbadpikiJdkYdfJFBMUcNqRnMsmvDU3ASPw8g4/ZlTfRDKPn56UUUjb1
juIiGBWFTQ0tzcEh5p9YgrArb/jI7YkZR4BNfheFEoPZqZRkP5CaonXE436uQIjz
raVe+QnxlGHVFUGpIyebNEB5/ZtWN1gsOXetqLcjFgjkwh9Qvow8tjNv13VqbTd5
rUHp8HoTwrq3UGNW3xUzRWuxJtQBOwKrNmebw2CN179C4qEZjipY14XnfGngZLyE
27QcB6s4wWz1UMjIiZ8OnN7gAzDmHKde1LqdQQp9WaAfLwFKCEeNMECg1QhQExaD
vsfUr5aNuaLNk9KV/l+sus4hOCzeGCgmlUsrw9rWR3yk5PEjpUeg0IkJmZr7nFkx
ykj5yPFHvgFi6q0VV7ppV4iXEoPTP7s4uZqCeHn8MQ1jVNZio/l7YhwZBYN3pfbK
5nv2jKXsK079UHV9qzmhQH31jZEh//jwcupyMF+k63RpQM8sfENKb25EkUJN5ebQ
gNnzdr1ElKsPD8TUQ1B9SVI0QKNpTGMXWsiNjX/BMVblnUvcxKE=
=sHaT
-----END PGP SIGNATURE-----

--nextPart3740035.kQq0lBPeGt--



