Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE5C77B73
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 16:49:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B09E81F18
	for <batman-adv@archiver.kernel.org>; Fri, 26 May 2023 18:49:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1685119766;
 b=wfHUu/QCuTIdSWxJSfOd6PAM0WF87xwToag9qAso3n+W+wf5xq3brLPppvydTVKijnkgC
 /wanYuV/3VoVdj6VI2L8+8JG99xJPEoxVfl6QIrwhdbSZ8loG5et78SrKqbsNPNY0ve6o5N
 bAC5fVUoPyOO+5IOkENygsovY4nKtS8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1685119766; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aj1j1eWnCNHkS6D2DwM5Jr/0q4xT5pPG+Y73M+V83Ao=;
 b=rim5GZ7ewsvnmqBqTOCf07XIUEa/WnDCzkYLBLTEHC2vUuGkdlfqOIBrgDYa/9BP23I9I
 lMLDO8Hg+DZYfnQHdp2mCYAnannGowyagQ3D87TkjU6K/LknVEIa6A+1JQVmLt26wNBYkcF
 EeL44x0phbq7K8yV6vPtk+MN1wQpE9Q=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org; arc=pass; dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4BEAD80F1E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 May 2023 18:49:25 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1685119765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aj1j1eWnCNHkS6D2DwM5Jr/0q4xT5pPG+Y73M+V83Ao=;
	b=vbHZ1LPjkGVmF3fibJz0hF99v3qkE8ZN747q+65Fsce49MFgOAqIo5AMObSn+rIrwj6HIH
	RQf6l3FODq5SVUnuGf33NxdZuCtf0JIDXEp245Oxcx2yBKIVPgUmFy3Eii38Fmb5H/6apd
	t4YggS7Cwqj7aL76nQ9oKuT7DiKgrP0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1685119765; a=rsa-sha256;
	cv=none;
	b=BBMswLoxDhAa7Ib46TwHMNe+LM34/+AnZpD54d5OH1wjpx0ka8dZVwjRdm14l9PdXKP+Fc
	FG68Ptf0Ltkzfv1t3PJ507CfRBjT3Rl8LFEApcUF2JxRyqEdgKCzMiI/L2SNkMFVj5Rytx
	r9R7BLE7dUC22qfFTLyMGy05IbDckrI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PPtGipJ+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1685119764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj1j1eWnCNHkS6D2DwM5Jr/0q4xT5pPG+Y73M+V83Ao=;
	b=PPtGipJ+XCfC1BdEMlL0wR14pV4KVlh6ULCXamLHvi7/yCy2Ee54zxE1Q/q3dXr8m2o6Ij
	qCodqHEpyEYzJrWzrbTjSZUFq1mO6UqMXdj1143hCwgibbfVPnYIiiuweiecv/IFx1PwR4
	+Bx1iRyCjH0IDgFHOD9aP0UPCL0DQKE=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Vladislav Efanov <VEfanov@ispras.ru>
Subject: Re: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Date: Fri, 26 May 2023 18:49:21 +0200
Message-ID: <5834562.MhkbZ0Pkbq@bentobox>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1760861.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: P3I6RE5PRIV5Q6AIAL73EECQPRXKYVPL
X-Message-ID-Hash: P3I6RE5PRIV5Q6AIAL73EECQPRXKYVPL
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Vladislav Efanov <VEfanov@ispras.ru>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.3
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P3I6RE5PRIV5Q6AIAL73EECQPRXKYVPL/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1760861.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 May 2023 18:49:21 +0200
Message-ID: <5834562.MhkbZ0Pkbq@bentobox>
In-Reply-To: <20230526161632.1460753-1-VEfanov@ispras.ru>
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
MIME-Version: 1.0

On Friday, 26 May 2023 18:16:32 CEST Vladislav Efanov wrote:
> The reason for these issues is the lack of synchronization. Delayed
> work (batadv_dat_purge) schedules new timer/work while the device
> is being deleted. As the result new timer/delayed work is set after
> cancel_delayed_work_sync() was called. So after the device is freed
> the timer list contains pointer to already freed memory.

You are most likely right but could you please point out what in the worker is 
checked by the workqueue code that prevents it from being scheduled again?  
(and which seems to be overwritten as your patch seems to suggest)

I think __cancel_work_timer marked the work as canceling but 
batadv_dat_start_timer reinitialized the worked (thus removing this important 
state). Would be nice if you could either correct me or confirm what I think to 
remember.

Kind regards,
	Sven

--nextPart1760861.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmRw4xEACgkQXYcKB8Em
e0Zk4w/9EOOJrN9tg9/gQ5TCqm6SySIDZqpQW/AeUktUNl88NPsdjzOeJtKSqv4H
hvfTgoAiOsAEuB2HoHlumdo5OZkYWwZFLmYhYbNZUH5HXVcAciAkLLabK8dSUBTX
9EKzdDb3PY7+eGIAAMUn2CF4l2WEkOzBIdVHpV6iXyL7l+qOx/IeRPDLX/WKJKPX
kh6IOP/i/bqYDdOs62+p4MYboTh2CGrSjpLGz9yOiM4rndr4clemJDQsuhbVhJ5F
fbTNtJJUtu6u4fwgdj7yHMIpZy/rXGAtj4NruSC95eR7P4Jm8R9P2j023+pF3Shy
OtzFG52bCd7Gz4fIVS5Vjqi1OMwZvVDi/ufvRfD8mRWg7oGg+SauY6iBM45GhJUx
G9R3DUuC8WJ774iWhYa1ZGHltQ6t0xBZfWOAdA1YxCoNuNbFMPOetJHcPj4D8w1y
CLY3rKYINm3hSpNPVgmcnCYEbCOL8ZJ1pDDeZtZbhcGIE1PKUaJ+QcCOseoPRyAn
gi+uoidkcG3sMDBWUYqpbx/QTjpBTtS16D4LazRUyhyBg1qLTYdhhdv06QZ2Dq2x
XaSYVWsdvLcIAFXfBXuneoff3Kj+26DTo/qOizhMzjANDYVyzn/4na80xvrCfAZS
EZ1MzcWh1zbKpRlUfFzGnUP3ZllHxRlHPmiF5qx9NjqTI074om0=
=vwPk
-----END PGP SIGNATURE-----

--nextPart1760861.VLH7GnMWUR--



