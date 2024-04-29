Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218CAC4345F
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 17:36:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 80D068214F
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 19:36:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714412189;
 b=YL49TqvYoce4pHkuyWjenuMCk+19ZTdn9Pay0rrsXqbOHQjdJWLgY77r/O8YYET2eF5cB
 svV7dkh847hi6Qru3E6cN8J0AYJvxM5AGiWqBSkJsO/gV82tqJqAstCn8qHKiGnJ2bJJtjx
 BIpAYzGpGzub8x4CWlJgMtrmWENHEAo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714412189; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
 b=WL9wIsbgQyxgL71zvU1MFX83G+2V1tcBC3uW0tygGUmMYVfA/wyjt8NNfzo+0SMS7RbBv
 xkpRVluJ6X/PRh/j7FDjzYRlc3GJcEde2XUQPj4VrU84ujJdqU1Ymh2MNkLNBokqNOylGp5
 H2MMqeX7ywNCZL6p+lBWDjnC97iZ6jE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=chromium.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=chromium.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=chromium.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=chromium.org policy.dmarc=none
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4A66281E85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Apr 2024 19:36:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714412186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
	b=oaxkSqcAo31UIhsqA65NpGiZCW9tzLr70HIJBJWqilr5+DbBNOYlcGFQ1nzWP6WyjmWz5P
	fdQh3Nq7aykfYMUItPHiRkOtXSckk7SlnsHfuoKcr+Ua/rsqFQFhMaIui+u+o++ZcXvX0e
	2WqCixUvFjLTZA6IeQGmnzeKf0lO+lY=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714412186; a=rsa-sha256;
	cv=none;
	b=NUiC+M8xVDbV402oJnUoRHytccMISn7f9pN/bNfPqs4LTH8y86OM0uChuK1EcloPvVKUKI
	1Vg8w2IqLu+s96Vg2JXgcTmS3xGikufEVAurs7pwpNp4Ca+m3Ab9cA/xA1HYwwaQGrbcQn
	vZqGhB3qEILifUwb33sxb7VJA24p5KM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=chromium.org header.s=google header.b=ma2LALkU;
	spf=pass (diktynna.open-mesh.org: domain of keescook@chromium.org designates
 2001:4860:4864:20::30 as permitted sender)
 smtp.mailfrom=keescook@chromium.org;
	dmarc=pass (policy=none) header.from=chromium.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-23333dddd8aso2199384fac.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 29 Apr 2024 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412185; x=1715016985;
 darn=lists.open-mesh.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
        b=ma2LALkU2ZOSXR+jRRT357HH3VhnVCXgAq2S1sHfCKd/UtSgBOdvwjwu+6w3T9omNv
         S2PaQx72oFNNomO665ovDHBRerDfX3wL4xi1BZSytn5B/sIuyCmiuexGuKP/ceK5W52f
         ztmUOWAiBHPHAkX2LH6NFz5J9v8DxtLF58ntc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412185; x=1715016985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
        b=MzcUp6lxzHyaHhKkmMBNm8oPGTAmCwN1dNbO6sZnry+MC2uZOU9RKGADumQJgVQKUL
         LETnsT3gN4HiLACjGPEjf1eeC0FnYtx1AUuVg68gakUC2QD9ywzImrAhgWBjvFMsmsRO
         RmKuvXFzrZsGG/G3ZgHJEP/uprL8+e5Ihat8nSgU6dH8YuyCPAnnCo0cwcts8mvWWgLC
         wAfJAFHDUZfMB6F3T7Ee8c7RT4lwWqNrmHlGfOFsCG6ZHgIk3NAf8xKB20qnMYKtIVD7
         kOAT6pZD6qNdPigBgnOohigMpImYZrT3GE7W5HOrnsnKXHmcCAndh5zE3xZSOT+ZOnWt
         IPoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTNhwww78wyP2ecb7aQ0nYJGCvNZ2GdxiMUQQBe/6FrRTZATEsFbBoAABg+F/1LrsL454ITCkXn1m9duEUuCUL3GOGONe8SiclBhiNl1nN
X-Gm-Message-State: AOJu0Ywq4biQWsfVu5qOSrcTOe2NNSwB1/AzT8BUUAJOcDHKvkFJC3LK
	3rXWfCIsACbUKkQK9dBoJoZ6t9A/WjKIfIgkQ4W42U2ZHwXo2rdJsVZ8jk2jyQ==
X-Google-Smtp-Source: 
 AGHT+IFkeheTXy7RqOcikC0mcBdqOX+uMYNFLcJxynabJyF4Wfd8rC11HWehnWpDbNdIEuOmUrxZAg==
X-Received: by 2002:a05:6870:e3d2:b0:21e:b8f7:9a1b with SMTP id
 y18-20020a056870e3d200b0021eb8f79a1bmr12046278oad.25.1714412185006;
        Mon, 29 Apr 2024 10:36:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 e131-20020a636989000000b005e43cce33f8sm19368253pgc.88.2024.04.29.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:36:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:36:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202404291030.F760C26@keescook>
References: 
 <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>
Message-ID-Hash: CEPYHR4TSL4RE63CU33OZT547NZHZC2K
X-Message-ID-Hash: CEPYHR4TSL4RE63CU33OZT547NZHZC2K
X-MailFrom: keescook@chromium.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CEPYHR4TSL4RE63CU33OZT547NZHZC2K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, Apr 26, 2024 at 07:22:47PM +0200, Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_be since variable
> "num_vlan" is of type __be16.
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

Thanks for this! I think the readability is significantly improved.

> [...]
> @@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
>  
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < flex_size)
>  		return;
>  
> -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> -	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
> +	tt_change = (struct batadv_tvlv_tt_change *)(tt_data->vlan_data +
> +						     num_vlan);

This is the only part I'm a little worried about. The math all checks
out, but the compiler may get bothered about performing a pointer
calculation using the vlan_data flexible array memory. As in, this may
be calculated as an array offset, since it is the same as:

	&tt_data->vlan_data[num_vlan]

Which, for big endian where __counted_by is in effect, the bounds
checker may throw a fit since we're going past the end of the array. In
other "multiple trailing flexible array" situations, we've done the
addressing from the base pointer, since the compiler either knows the
full allocation size or it knows nothing about it (this case, since it
came from a "void *" function argument). I would suggest:

tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data + flex_size);


-Kees

-- 
Kees Cook
