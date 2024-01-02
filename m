Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DACC47074
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 11:24:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3977683E5A
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 12:24:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704194670;
 b=cn3Y5YStRwnF2iuL8usZU+qRlljIf2jhdcFCDHfZ4NFaZP0g/wCy/ncx9530FDlu5ISYF
 GQ+B1ZKNj5+j/B7Vac8J6PaDGInWzCz7KgyPwWQ2j1DqDnYPPWwbZNc0Jyh6x1ouBpjjL5v
 pIk3J1stHWJKb7/QhGRk+AQqmR0BuI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704194670; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RL4p8JTgWtUMp+LSFYGDq2LgzfnsXq2WPu5q9VKoeO4=;
 b=i4WBrSmRDw2LqgWmxcmck7f8EsBU12EUuQ3Zd1qTgjjUPX6KAVI5aX3PC9/mHbUonV5qp
 /lYSNIij/PvoOB40TLuLHm7QEJYlgTGOvsHzbYEqiz2WnMFqBtgAY54UgcrhcYH6Uwah+V6
 ovQx+pNEpleBDdR8u4av+Ch25YCwxss=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F3F1680A6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Jan 2024 12:24:08 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704194649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RL4p8JTgWtUMp+LSFYGDq2LgzfnsXq2WPu5q9VKoeO4=;
	b=3sX3uwY4e5HfKZrWugae0VN4LC0CxnrGnQxg8aRdye/FxssFFizD3eaj7ujDMIAk/uoydb
	anm0ZSOTS06OqYF/eCxuZc+INRHZfL+sWgiCsEIUfQNbj1BWBOusvmrfnIBedzzdyYkX0p
	A+qQ9OoeHS0HsQuLzID6ml6Fb8qkzbI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704194649; a=rsa-sha256;
	cv=none;
	b=O0OS81cVihwGUejxI/vrN2o97jKHJIYi9yBU9NLkdQDfRnFZ7hiYnI6WwW6cCG5HYPdNB3
	5eMJQ/ITQMlhkdrmRcgc/6H6ekRlBNbZZdXLoC2Uwb9mptlUp3RIcx/jh9I6IBc+q+kUhT
	P8SQe3pFs6vd8rIh86Fe5oQE7iHnRi8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eGmXqasC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1704194648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RL4p8JTgWtUMp+LSFYGDq2LgzfnsXq2WPu5q9VKoeO4=;
	b=eGmXqasCdYtT4c3TgAwsOFFN82HooJbJOEvq++G/iC28O2BLpcbK4C+wGyfC2Uje+tvntd
	igtbeTIfHijeeGG1K3Uvr2hCEc582bPn5wk6RwrpaV27ttveqgQ8I4h1ScyWFnXRODeP9x
	KHo/8w0IfIJoqNIIEkj1/w8h0E/tm5Y=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner <mareklindner@neomailbox.ch>,
 Paolo Abeni <pabeni@redhat.com>, Simon Wunderlich <sw@simonwunderlich.de>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: 
 Re: [PATCH 2/2] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Tue, 02 Jan 2024 12:24:05 +0100
Message-ID: <4889340.31r3eYUQgx@sven-l14>
In-Reply-To: <d2ce9337-e1a4-4213-ad6f-926c085dc17f@web.de>
References: 
 <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
 <d2ce9337-e1a4-4213-ad6f-926c085dc17f@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4538693.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: THQONTWCOWFHKGNEZRONJVOTSFS26NCP
X-Message-ID-Hash: THQONTWCOWFHKGNEZRONJVOTSFS26NCP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/THQONTWCOWFHKGNEZRONJVOTSFS26NCP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4538693.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2024 12:24:05 +0100
Message-ID: <4889340.31r3eYUQgx@sven-l14>
In-Reply-To: <d2ce9337-e1a4-4213-ad6f-926c085dc17f@web.de>
MIME-Version: 1.0

On Tuesday, 2 January 2024 08:12:56 CET Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jan 2024 07:52:21 +0100
> 
> The kfree() function was called in up to three cases by
> the batadv_throw_uevent() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> * Thus adjust jump targets.
> 
> * Reorder kfree() calls at the end.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Sven Eckelmann <sven@narfation.org>

> ---
>  net/batman-adv/main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 5fc754b0b3f7..75119f1ffccc 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -691,29 +691,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
>  				  "%s%s", BATADV_UEV_TYPE_VAR,
>  				  batadv_uev_type_str[type]);
>  	if (!uevent_env[0])
> -		goto out;
> +		goto report_error;
> 
>  	uevent_env[1] = kasprintf(GFP_ATOMIC,
>  				  "%s%s", BATADV_UEV_ACTION_VAR,
>  				  batadv_uev_action_str[action]);
>  	if (!uevent_env[1])
> -		goto out;
> +		goto free_first_env;
> 
>  	/* If the event is DEL, ignore the data field */
>  	if (action != BATADV_UEV_DEL) {
>  		uevent_env[2] = kasprintf(GFP_ATOMIC,
>  					  "%s%s", BATADV_UEV_DATA_VAR, data);
>  		if (!uevent_env[2])
> -			goto out;
> +			goto free_second_env;
>  	}
> 
>  	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
> -out:
> -	kfree(uevent_env[0]);
> -	kfree(uevent_env[1]);
>  	kfree(uevent_env[2]);
> +free_second_env:
> +	kfree(uevent_env[1]);
> +free_first_env:
> +	kfree(uevent_env[0]);
> 
>  	if (ret)
> +report_error:
>  		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>  			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
>  			   batadv_uev_type_str[type],
> --
> 2.43.0
> 
> 


--nextPart4538693.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWT8lUACgkQXYcKB8Em
e0ZtIA//eZtvK8xgUCk7KXnL6m/xB/Hnlsa817um4kK3xG+JO1hmlgxNsNJfu0HT
VIP0Ca/QY7GRewIOz2fT60YCffgVQeht30bVdI3D7U6du5/nd6Q3JRzw8WaFuDxo
MBIvVoqtNCK3YNBjKhYILq1X/lmxgvE+4J/1n94/QQWlJ9lgZthE2JWVwbMfDa+Q
USyZI6ftogWsk9TKrt5cgWuQRrps3qtjnHUmgBNFXfWjwsRQUtjWzE960Y6au2tH
fAqTrBW7M18RE+yDKQUjnmlpETnwBLCCcudS2cZBmx9EZL4TQEdJ4T+Ka8e9iPwV
M37MJh/h+mwbxKIhv0vPnuvpBHZzQ+3opNCgIGTpS5YExATFMCIVXMeuN+kjVfC3
X1iHjqRagGxcqpQtzaUcgYsZ4/elr5ODM4GH2VzH5phqb5iS0u64K+lmuWqO/Bsx
hi7klW9+mKcrVgyeM5r83VcP9Ea+wS/3vhQBTPK4X3da71oqPq0X+2/qOYlzreBq
LIpWu9BdpkKp5NHoAL7yyxOfm8hIjGCY1EXWUsKyb9Zs08Etqr4thHJtxxTNzhM1
2ulCCmn8NNK/PzvguYQxIbXiJiK9U7bfzZoKbYSPRTEvd2xM2RxMrgZH94swmFYD
SNNMTa3ccaynMy/E/KB0/uD2ktF1PHs6739YdB6ivv7VIZTKqRI=
=sz9M
-----END PGP SIGNATURE-----

--nextPart4538693.LvFx2qVVIh--



