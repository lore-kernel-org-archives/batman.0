Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B4AD5E396
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 08:25:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C20E284034
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 09:25:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731831950;
 b=3F41SxfBVR8DesscU712IUNq38RIHUmiWVHtW1jrhp7csrBQvmA57QcLgxG7tN0iaTsfg
 84Jk0gDxYhr+CHTvOssp3VSAKBI1MqRwvKAcXmn8mAJwBZS5ZINgFMhZIFHup21mEhOvZLN
 gDnjlTmil7DLbjynGCVaI+JREyYbFWg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731831950; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sjQT6XVjI0XKvsESHJ7IgxMRInE3Y3mIXai/lnmz01M=;
 b=wX2syBSV8oQ5lP1hlVf77m1mZlEi4nJ1st2U6eg08tA8msEdGi7zmgw7l4eryVxRrwhSl
 v1ZS+l8T/ne3HR1CUfFmMKURI1tTpjUzwmhw24qe8BTpAs6l4MkmKptlZBIeIIC+pAo5W9N
 7YW5IfeJ8VdhCXSPnD3zTN5202CWvu0=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D40B083FCB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 Nov 2024 09:25:45 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731831945; a=rsa-sha256;
	cv=none;
	b=GGikvdVFG7fWHmSeIzYMVR5j+CH2ZlrD4iqyJnsFtldo9fmrHG67YTuISMnHKhkqTWTxFz
	pXoHksEiM5g7ZD3da1tlYiQf7RikVpfgcgJvOltBaTT01D+h2O/4mTWrItmjTkWhNm+mTm
	84sQt1KaFt+5tToDdxn0Go0gbtqcb6c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DoKvPfoH;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731831945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sjQT6XVjI0XKvsESHJ7IgxMRInE3Y3mIXai/lnmz01M=;
	b=LgRoYfJ9uq6Ll/D3Ly8KQzexzFl/Hmuljuyys4v+tOCpIGPRzQW36KAq3yT0EHDNVUf2ZL
	lET3LrcB0Q8nuUHNQ1jZnm7v7Dt1FNV6ePiv1DSRmE/Br7gAkD3cbn9ivNMpf/ZhvhzhIr
	LcnWjVmhtnyRw4vN94Nza6GjSXnXQys=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1731831945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjQT6XVjI0XKvsESHJ7IgxMRInE3Y3mIXai/lnmz01M=;
	b=DoKvPfoHmXVNAWAQvGb8xYHv1sz1i8VEiwJV9SyJmX02qcclbiRASxB4U+rcyakr24o/lR
	2n8nFMqPyimViMiUZ03wkzh97eV8px6C+u8hiCxTiNStrUAIjSzz+CO8AXSyJmYEjpYVtl
	eAbykJniU3N1nuBZYPX+KkX5/DX5Q1s=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>,
 Antonio Quartulli <a@unstable.cc>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v2 5/5] batman-adv: Don't keep redundant TT change events
Date: Sun, 17 Nov 2024 09:25:42 +0100
Message-ID: <4709754.CvnuH1ECHv@sven-l14>
In-Reply-To: 
 <1c8b34d63121834bdf6d39c7ed1447ae3536be7d.1731792497.git.repk@triplefau.lt>
References: 
 <cover.1731792497.git.repk@triplefau.lt>
 <1c8b34d63121834bdf6d39c7ed1447ae3536be7d.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1936537.eGJsNajkDb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7IITT37YPDBELQ4DTXEAU2YZFGJPXNAN
X-Message-ID-Hash: 7IITT37YPDBELQ4DTXEAU2YZFGJPXNAN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7IITT37YPDBELQ4DTXEAU2YZFGJPXNAN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1936537.eGJsNajkDb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Nov 2024 09:25:42 +0100
Message-ID: <4709754.CvnuH1ECHv@sven-l14>
MIME-Version: 1.0

On Saturday, 16 November 2024 22:32:09 CET Remi Pommarel wrote:
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -500,14 +500,17 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
>                 /* this is a second add in the same originator interval. It
>                  * means that flags have been changed: update them!
>                  */
> -               if (!del_op_requested && !del_op_entry)
> +               if (del_op_requested == del_op_entry) {
>                         entry->change.flags = flags;
> +                       goto discard;
> +               }

The comment is no longer in sync with the actual code. It is now also about 
DEL's and and only about ADDs.

And I am not sure about the flags update on DELs - maybe Antonio can enlighten 
us here.

Kind regards,
	Sven
--nextPart1936537.eGJsNajkDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzmohgAKCRBND3cr0xT1
y9efAQCdMJBoLIfd9SQrPEbqMZtC/Zx9xZpFw4VTZ4zDXI4EdQD9EdbnW/GuZ7Y8
DfHt7CdrmNYJFe8wLqRIooj0Z5VFgwU=
=GN8U
-----END PGP SIGNATURE-----

--nextPart1936537.eGJsNajkDb--



