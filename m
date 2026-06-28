Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9CC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:38:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5850F8405F
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:38:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782632335;
 b=ZISdrI6mwjvRFA8RukCEEnFqF4gL572M8mU0RcS194HBRJRKpVXyR3uRLxDy+sJm12qvb
 /86ozhQL6gyMycaLdNUdGQ+Cepi0NPZ+a57I/C7OHjyWrWC9KjRwgXR6Ia1LC1XOjYFuk8M
 axXZcPnQZsVvwSUc9coRQRp9yyTALog=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782632335; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VuX1gPD7SilKJ01lCbF9DvZYW/mJOv9AQz1qDJkY11s=;
 b=VUtRtZgKtcELwIrhjYEhqoPCOwR3AJoLVIYZaKdBi8bHJih21DfLPmp45OG4Na/lpvDR4
 RN5Lq0YBkQ0S5TYnwz2S9kRoz6xGDrgqNLcFMfqcW0TePpmYlRQ1bAV9jQK1FOzsCKeqUSL
 pC61lArPXbgowdlj6eOPwK9RrIXFskk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B46318214C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:30:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631849;
	b=UklF641COim2bYLzqIcuVGIbR9VSesdkVbVwki+F0AFGcSC9Hxz9XMk3yjGi/N5BZiT4pP
	fVuRW0HQN6afcOT/QFIXERrFEUi6vRdO7BxVViTqvNb55u/fkzIQe/BEihMxyfZIrzwu/w
	Jt7Rxs5VL8qKRgOn/H8v8fj1J53KgYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuX1gPD7SilKJ01lCbF9DvZYW/mJOv9AQz1qDJkY11s=;
	b=w2kDfexXB9iWxR2UHDWJ4Es8T2RHAK/WZ3ghoWfpC25R7vdk3F+qL+MF76Tf3v4u33PMsN
	e7KRAvOKguW0/X+NbmnNShl/1luUBaltPdFPj5kz9Ls8Got6j1xWyF289ZtVho23uCPGkI
	jKJ1+Tywne+SuBcTdIDV7H4UK6/XRxs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of vulab@iscas.ac.cn designates
 159.226.251.25 as permitted sender) smtp.mailfrom=vulab@iscas.ac.cn;
	dmarc=none
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhGfzUBq4rG6FQ--.42871S2;
	Sun, 28 Jun 2026 15:30:40 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra
 batadv_meshif_vlan_put after destroy
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260627034636.59693-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 15:30:28 +0800
Cc: horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60CD91EB-833B-40D9-8DCA-A982CE336041@iscas.ac.cn>
References: <20260627034636.59693-1-vulab@iscas.ac.cn>
To: marek.lindner@mailbox.org,
 sw@simonwunderlich.de,
 antonio@mandelbit.com,
 sven@narfation.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: zQCowAB3zhGfzUBq4rG6FQ--.42871S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18XF17Jr1UJrWrXFyfXrb_yoW8Xr4kpr
	WUKFW3KFZxCayxKa9rKFy5uF1j9w4Skry0kF9akw4rAwnrta4Iga4F9r9rXFn5CFWxKF17
	Jr4UCas7X3WDWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU8U5r7UUUUU==
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixFu8QAAsl
X-MailFrom: vulab@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: YWAEVQGRI2TX6DJQUML2ZPHHRJJHBHX5
X-Message-ID-Hash: YWAEVQGRI2TX6DJQUML2ZPHHRJJHBHX5
X-Mailman-Approved-At: Sun, 28 Jun 2026 09:38:36 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YWAEVQGRI2TX6DJQUML2ZPHHRJJHBHX5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>



> 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 11:46=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In batadv_interface_kill_vid(), batadv_meshif_vlan_get() acquires a
> reference on the vlan object. batadv_meshif_destroy_vlan() internally
> calls batadv_meshif_vlan_put() which balances that reference. However, =
an
> additional batadv_meshif_vlan_put(vlan) is called after
> batadv_meshif_destroy_vlan(), causing a refcount underflow and =
potential
> use-after-free of the vlan object.
>=20
> Remove the extra batadv_meshif_vlan_put(vlan) call.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute =
framework")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> net/batman-adv/mesh-interface.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/net/batman-adv/mesh-interface.c =
b/net/batman-adv/mesh-interface.c
> index e7aa45bc6b7a..cc974f243200 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -691,9 +691,6 @@ static int batadv_interface_kill_vid(struct =
net_device *dev, __be16 proto,
>=20
> 	batadv_meshif_destroy_vlan(bat_priv, vlan);
>=20
> -	/* finally free the vlan object */
> -	batadv_meshif_vlan_put(vlan);
> -
> 	return 0;
> }
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

