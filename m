Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF05FC0218A
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 22:18:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1C78883E3E
	for <batman-adv@archiver.kernel.org>; Tue, 28 Jan 2025 23:18:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738102701;
 b=tQnX4TIrHNuLnsEwTbGO5Xr9t6VpG8KPczY0mst93NIrZ+yy2NOXrXvdNmwJvNhQlwc8Z
 xP78bKTcOdnktMAISB1q3sSrp7lQ+kaTtDEJIbNxdYrUIF5+/eYzZPdlu1k6UhuFshhkak0
 XY5HCzNhvozAoVXzV/upCwXkTGtQG2k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738102701; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WlJ/vQSJrlC1BRhfLopAn8UyVFJn0XAPGj8Ae9LjNDk=;
 b=u53n+UmTA+Om771f7S5af8WUSR/S6nuk4VRswyX171CWy8Rl0DVpkgU8tLP5R47bKq1vm
 e6BhxOVT1gxLKyyxqi8fqz46qzKCp1pAqQSf8QA2W4YhwB/6NjZ6CGaV5xiTwtaLi/yL6rl
 bDhUNu+D0XsChHAMi38dIlJzO6sd0Xg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D10AE80D3E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jan 2025 23:18:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738102690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WlJ/vQSJrlC1BRhfLopAn8UyVFJn0XAPGj8Ae9LjNDk=;
	b=foUcgxt1FbiAgvheMwO3sx8Hnol+HzjtCs4uJuBOJLT5Y60p2fzI5s5WzSJZKbU/oSw415
	6qRrGijOeVdWC/QpgivP14jv3knmLJJ7/smFnpbIQgnMxZ3B4ebHWS/GNB9PYs6weYkQk4
	8mg0bdW3EEzU/fAwZe/O+xFVsshnIhc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JtVOZA6H;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738102690; a=rsa-sha256;
	cv=none;
	b=kDuFVDiWwMkTQ09z71q/f6DlvA7trilBu8XMIQk7Biet5bUAiYkKpSjdKFnWodUFRzLLy/
	vOLIXRxI3KFknEPu91x2ywcmKdzn1G/tPCYRcnz4AUuFmPSqKUz4kjq+Viv9csT9EvnSVL
	ZlDJa6tVZOzCpUw66uwxDTt5YHlOv2Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738102690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WlJ/vQSJrlC1BRhfLopAn8UyVFJn0XAPGj8Ae9LjNDk=;
	b=JtVOZA6HiI0Opwh5/PilrZzSrXm4Fm6PridGdsgAxKWy8sJqaY/Dzkpo5e+kvVK+u3Oc7I
	XvRzcdiYPHpj3XcTf9zWZZ4mZHji62XfjWIlUht7GROx1q0x5lb52MVr33dofcztAFyoSm
	m//B23Cd7mEmzWycQ/nY1QT05HGgVQ8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: 
 Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 23:18:06 +0100
Message-ID: <2593315.VLH7GnMWUR@sven-l14>
In-Reply-To: 
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
References: 
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9301015.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: X7VQ23KXSN73766HTZ4EZPLHFV7WVJZN
X-Message-ID-Hash: X7VQ23KXSN73766HTZ4EZPLHFV7WVJZN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X7VQ23KXSN73766HTZ4EZPLHFV7WVJZN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart9301015.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jan 2025 23:18:06 +0100
Message-ID: <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0

On Tuesday, 28 January 2025 16:11:06 GMT+1 Remi Pommarel wrote:
> Since commit 4436df478860 ("batman-adv: Add flex array to struct
> batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
> array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
> invalid offset. Those TT changes are supposed to be filled from the end
> of batadv_tvlv_tt_data structure (including vlan_data flexible array),
> but only the flex array size is taken into account missing completely
> the size of the fixed part of the structure itself.
> 
> Fix the tt_change offset computation by using struct_size() instead of
> flex_array_size() so both flex array member and its container structure
> sizes are taken into account.
> 
> Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Thanks for the patch. I just wanted to dump my notes here (because it is 
getting a little late).


Original calculation was:

1. tvlv_value_len -= 4 [sizeof(*tt_data)]
2. check if tvlv_value_len contains at least num_vlan * 8 bytes [sizeof(*tt_vlan)]
3. tt_vlan = vlan section at offset 4 [sizeof(*tt_data)]
4. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + 4 + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12


After Erick's change

1. tvlv_value_len -= 4 [sizeof(*tt_data)]
2. calculation of the flexible (vlan) part as num_vlan * 8 [sizeof(tt_data->vlan_data)]
3. check if tvlv_value_len contains at the flexible (vlan) part
4. tt_change = change section at offset num_vlan * 8 bytes [sizeof(*tt_vlan)]
   (which is wrong by 4 bytes)
5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
7. "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12


The broken part of the change was basically following:

-       tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-       tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-       tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+                                                    + flex_size);
+       tvlv_value_len -= flex_size;


if the line

+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+                                                    + flex_size);

would have been replaced with

+       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data->vlan_data
+                                                    + flex_size);

then it should also have worked.

(calculation for this changes follows below)

> ---
>  net/batman-adv/translation-table.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 3c0a14a582e4..d4b71d34310f 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -3937,23 +3937,21 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
>  	struct batadv_tvlv_tt_change *tt_change;
>  	struct batadv_tvlv_tt_data *tt_data;
>  	u16 num_entries, num_vlan;
> -	size_t flex_size;
> +	size_t tt_data_sz;
>  
>  	if (tvlv_value_len < sizeof(*tt_data))
>  		return;
>  
>  	tt_data = tvlv_value;
> -	tvlv_value_len -= sizeof(*tt_data);
> -
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> -	if (tvlv_value_len < flex_size)
> +	tt_data_sz = struct_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < tt_data_sz)
>  		return;
>  
>  	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> -						     + flex_size);
> -	tvlv_value_len -= flex_size;
> +						     + tt_data_sz);
> +	tvlv_value_len -= tt_data_sz;
>  
>  	num_entries = batadv_tt_entries(tvlv_value_len);


Remi's change:

1. size of first data part is calculated using 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
2. check if tvlv_value_len contains at least 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
3. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
4. tvlv_value_len was reduced by 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
5. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
6. "tt_vlan" is implicitly used from offset 4 [tt_data->ttvn]

result:

* tt_vlan = tt_data + 4
* tt_change = tt_data + 4 + num_vlan * 8
* num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12

Sounds at least at the moment like a plausible fix. I have already queued it 
up for batadv/net but will leave it for a moment to allow others to review it 
too.

Thanks,
	Sven
--nextPart9301015.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ5lXngAKCRBND3cr0xT1
y3xfAP4u0mrCRUsT6pG8vmB3OJXyhDzJLVA1GtDeXlK3yQ4lEwEAi72tsVDvMtr4
+Mbtf7ICIMGG/L+xYEa6Zb4wWBkSZA4=
=5Ryn
-----END PGP SIGNATURE-----

--nextPart9301015.NyiUUSuA9g--



