Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76967C6FD1F
	for <batman-adv@archiver.kernel.org>; Tue,  2 Apr 2024 19:06:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1A1280C68
	for <batman-adv@archiver.kernel.org>; Tue,  2 Apr 2024 21:06:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712084808;
 b=P1go/Mchisqm65Rt9tvZ0Hz8KitfAPCvvhVu7RhQUfijJCXcbng3y0xxtfqKywL3fbde6
 AXbGvmeKQBJrwoXLqiSG4PBXUdRWgPrJXM1TxGD2isMCzNkpY7hgbHgOAmmEqkXCsx82/rq
 W7mFbnDvX//jlz9VGFhkYfHyuNXgdUQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712084808; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8YOkmEuC9pUsK+tk/6J60XipwO318aL0a2KtV/Z5R7c=;
 b=c2ZdshfniqmQekaFb80PFow+h9WjXCgbq7qvSh5lhvNTzKFLv4cgcKWpbk38+VY9QvCNy
 JgqW1GXzJeyfRjDiUt8v1EAsnxfKJenr7QBYyhyRc67y0I5Pf/juiXxcFmt3BrNfYVwsAMA
 MaDSlZL9w0Lew5ZhcU3kFnAhKaVHsk4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4C2F780C68
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Apr 2024 21:06:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712084803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8YOkmEuC9pUsK+tk/6J60XipwO318aL0a2KtV/Z5R7c=;
	b=Ux0GH682QyJJb1JnQciK+Ur7/9o8su/h4WycAjFhs49VCxen6ow8F54nqwGtlh5mM6fWFF
	Tqx1kGC3RMk55V7BfX3f+vjvXgSR+rP3+Je7709l3Lu3NSlkzOBWixFI82ytU8PWM1puun
	YNYlGLnoNLigC2m5xHhOEGBjHfS9XCQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=1cQ1X5a9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712084803; a=rsa-sha256;
	cv=none;
	b=c/LCwPtyg4ZGEZ5GFBCjp2jUg1pTOlZPrjglqUmXJPWIeKdytFh10W8bv3ajl2vjD81nMR
	0YT4vGCBo2Nt2/UkB1/gypcdNTI25O4C7KM/CSQfw7eVHoz0pxwEsyZQ8M23WPGehmYiMA
	CmdZz1sy6LWpT/kufWoge2okTb6vWbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1712084798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YOkmEuC9pUsK+tk/6J60XipwO318aL0a2KtV/Z5R7c=;
	b=1cQ1X5a9FEnn7pUky3k2RC1MLWAVUsKjHvXV+ap0gIexfmavkuZDqhuJ1HK0vnBpvWmjhB
	GwucBct323m5dXolJ/m+ZkFKfFNvdKgC/Laa7Zj59EKZWfHYEmnVuO7JS+isgTu2Xf0pWS
	oABPA6SEHeL4iEo/8WK4zGw1cJ+c8Vk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>
Cc: Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Tue, 02 Apr 2024 21:06:35 +0200
Message-ID: <5466543.Sb9uPGUboI@sven-l14>
In-Reply-To: 
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1984222.yKVeVyVuyW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 3WIYPBJD2OSWONZUCMBYDPEFL5HNJ5OI
X-Message-ID-Hash: 3WIYPBJD2OSWONZUCMBYDPEFL5HNJ5OI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3WIYPBJD2OSWONZUCMBYDPEFL5HNJ5OI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1984222.yKVeVyVuyW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Apr 2024 21:06:35 +0200
Message-ID: <5466543.Sb9uPGUboI@sven-l14>
MIME-Version: 1.0

On Tuesday, 2 April 2024 19:23:01 CEST Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> The order in which the structure batadv_tvlv_tt_data and the structure
> batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> type error.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro and use the "flex_array_size" helper to
> clarify some calculations, when possible.
> 
> Moreover, the new structure member also allow us to avoid the open-coded
> arithmetic on pointers in some situations. Take advantage of this.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

> ---
> Hi,
> 
> I would like to add the "__counted_by(num_vlan)" tag to the new flex member
> but I don't know if this line can affect it.
> 
> ntohs(tt_data->num_vlan)


Yes, num_vlan is a __be16. I could only identify the kernel-doc related 
scripts as consumer. But maybe they are more - so I would defer this question 
to kernel-hardening.


And with this change, I get a lot of additional warnings (-Wsparse-all)


cfg: BLA=n DAT=y DEBUG=y TRACING=n NC=y MCAST=n BATMAN_V=n
    net/batman-adv/translation-table.c:574:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3982:30: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3986:27: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4026:30: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4030:27: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4032:23: warning: cast from restricted __be16
    net/batman-adv/translation-table.c:4032:23: warning: restricted __be16 degrades to integer
    net/batman-adv/translation-table.c:4032:23: warning: incorrect type in argument 1 (different base types)
    net/batman-adv/translation-table.c:4032:23:    expected unsigned long [usertype] factor1
    net/batman-adv/translation-table.c:4032:23:    got restricted __be16 [usertype] num_vlan

[...]
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < flex_size)
>  		return;

This helper would need an #include of <linux/overflow.h> in 
net/batman-adv/translation-table.c

[....]
>  /**
> @@ -4039,8 +4029,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
>  	tt_data = tvlv_value;
>  	tvlv_value_len -= sizeof(*tt_data);
>  
> -	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
> -	tt_vlan_len *= ntohs(tt_data->num_vlan);
> +	tt_vlan_len = flex_array_size(tt_data, vlan_data, tt_data->num_vlan);

This is definitely wrong on little endian systems. You first need to convert 
num_vlan from network (big endian) to host order.

Kind regards,
	Sven

--nextPart1984222.yKVeVyVuyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmYMVzsACgkQXYcKB8Em
e0aCQBAAj3anzJhaGazYsoqA2U/5qDV64DoNdrlYz34rT3lYX3DTJKcA11cuSvN+
aDVUaOi8G7Gn4sE+Ql8FGsBmXoCMvwyLJ/eQ6mrr1MGSWLodaZbvmjRxwPRzFbou
wAK5ZE25usWliJxf2ds7gpSjm6TBFnsNIRAtQ2zz7b8dAhXOe79ASRsrl0P9QBiE
fM8QeT6hB0gLY5RXmsugrRUfCpqQOfTS44b9siyICMN+mKbRG7GpDj4Ruf/6koNo
Qy1Unmm+qhyuPUtoYBASGVzC/Gm3pDh7UXuiptY0vgU/o0yjyTHi683cFBtmD30V
d+pNZDCa2YS0+j0N8Nh/oS3fOWb36I/eKiEaCdmgx9awQ4dO3CxZE5TsLeohNNUO
OpTdwucSLW8gEo+r+BQI0G2y3+TPCtGv8vLRIXF1frSWjE7EPbXH3BjbcvoDaaYO
uO1a7tyAAbZ4zZO9wO6qIcRjz1q3E0V8Dx9LRolzC5EA4IvnNa+WQ7OZdTGe8zu3
GRlIYG/sedhar8Wla+bh8wi8oeInErE4k4pDFI6o1AS5GHTcpTR7Plp/vpnrAEPF
LAjEHTQT1LOIRLIrzvGBWC/KNnjXd3q2TluOKRBxsNYAnn+nHL3aBmYSp8gCOg9g
Sta4U5Vrs2QpAT3mk8CoAhQSujqZaOkM+fy63PcaWrhCMDh9mGo=
=CYsH
-----END PGP SIGNATURE-----

--nextPart1984222.yKVeVyVuyW--



