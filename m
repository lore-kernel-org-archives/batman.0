Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA04C4345F
	for <batman@archiver.kernel.org>; Wed,  1 May 2024 20:17:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D73E48217E
	for <batman@archiver.kernel.org>; Wed,  1 May 2024 22:17:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714594642;
 b=Rk6LwTNR3eyUQcQ2c/bnCRY8BGgZayws5rohSTg1biBQYYRqB/kjK/Op0EzzIOkMiRr9r
 gnXEzc9apCr3lwcMb4lMWqDr2JH3SC1xtbYYLFKoh3rtd2UdTfZ6JgMrQnZLccVZmt5/4/z
 VAx6OtwVHnyW/qp6YvlDG4lOFOyZj+8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714594642; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
 b=ztDfBkPcJed36eqF+b06mremOVNhnkktv5s/RNcLJ+GsKMW6s/khVREk6jzh+3F0j7klI
 x0oDZrBn0i7DWJwE9tnUSZL4LVlZwf4DDWwlJpXFF1qWBq0gtTnNpTMS+Ecw/Lot0UNrq2S
 x8k1V1NHN7Q425ri6mLMWb7I6qyDVeM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=chromium.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=chromium.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=chromium.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=chromium.org policy.dmarc=none
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 04E4C81D2A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  1 May 2024 22:17:17 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714594638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
	b=aTWzaDSE4J3+/DQV61HNVD9dypHsTCeISggwqfnaMWdee9D5zn7EXkwzimRfai7tvGYPLe
	Y6Tu2/2itCTl0ebVZykmU5qwk9POKXHplLlxKuF/DyIvz4s18aUdCSv+5kX4fcvXuokwx9
	BUK4lWEU1hIAQ2JXkT3MKTXwOiXQYc8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714594638; a=rsa-sha256;
	cv=none;
	b=HfIl4Qy4CGZuzWthLWTXL/aaXO3zRPtrdTNL1vktYfjGFWSPuWlEcthx5Py/fvMB5rSC8m
	BH2TdXWZLCOUl0Ip0aDan5iKfDw7HfLwQVCMX+mE6kwXpJAWqeNIBTgesQO3wt2rpkE67u
	fq7KdUD8HfpLZCHmjkMIKf+PSl0AG9I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=chromium.org header.s=google header.b=B1YeXCRU;
	spf=pass (diktynna.open-mesh.org: domain of keescook@chromium.org designates
 2607:f8b0:4864:20::435 as permitted sender)
 smtp.mailfrom=keescook@chromium.org;
	dmarc=pass (policy=none) header.from=chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f074520c8cso6839174b3a.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 01 May 2024 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594636; x=1715199436;
 darn=lists.open-mesh.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=B1YeXCRUn96c0JERMl9rIKfTenUd7434EPtcettf6NXqaHohTogeKPtXW5ii9nmfbN
         tmE/tyMTsurCaaJn55z5HmqycI/rvV5v+yz2NZHBYCIPVB5JiNG1uDJUo2ZN5I6ZlQhx
         fJsHVCV+rzM1VVk8hZtMLRucu34rULTvE3h9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594636; x=1715199436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=D9/x54wKSsYdAeErnnOHpXzxve+/m/KQ8WxxL7dgQBcWsTRYEGfLB73/XhsnPvhybz
         c7qoBJn0SiK9pF+9Ha7Ef+m09sysJ8fPxXCjdHi/q2dY8GG2MbCZju0c6hz9BldldFIh
         f/WFzjuYuszPjCURqOSW/xqNRf75EF66pVYxieMC1cxsITGtAwgtRPU9ybNV4fhMON+j
         SrtZ8pUnc6c6IWMfWD9JGxMmV3AILB4M2RBCt+XSFGhOKld/GW9IEIvAgoccc5CyeY7w
         EyNzLI6vt13gyPQL6J+gdluabgemvNRsfoAD2sybFjVvB58DN7LR2HTVFUStoBLHpOZb
         kC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVshqNWQrg+JhvlfkvCctMjFYashq3MZumPt+kpabfL+jCOTCMrMGvVv7GoiLy75wh0iaoOubdkFfNcYch1C2jBnsyNu0L5FeX5mrtqJ0sm
X-Gm-Message-State: AOJu0Yw7uPRtS1O5I/yJ1OrWDX1MAvxGKXr7A8eQVRgEmouFgL5aokcL
	uZ0IVeGj/GIzw/Ghvv+T0jN7cJlem+jUZUFWevzdE1dFUKpWPNpCvVko0e/deA==
X-Google-Smtp-Source: 
 AGHT+IGbzYi1d+ldsT9LN6hCvo5dwU6UWZPN8BaXQ/g+gSm91//aeds7KiSLXD8zvIV8i+uTgvZrTQ==
X-Received: by 2002:a05:6a21:6d82:b0:1ac:d96a:4fd6 with SMTP id
 wl2-20020a056a216d8200b001acd96a4fd6mr4640333pzb.23.1714594636355;
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 j19-20020aa783d3000000b006eaf3fd91a1sm23012143pfn.62.2024.05.01.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Date: Wed, 1 May 2024 13:17:15 -0700
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
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405011317.9896F210@keescook>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Message-ID-Hash: VXDMMH2XHPW7FG64XIF64WIC5C3LMU7Q
X-Message-ID-Hash: VXDMMH2XHPW7FG64XIF64WIC5C3LMU7Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VXDMMH2XHPW7FG64XIF64WIC5C3LMU7Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, May 01, 2024 at 05:02:42PM +0200, Erick Archer wrote:
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
> The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:
> 
> -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> 
> +	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +						     + flex_size);
> 
> is intended to prevent the compiler from generating an "out-of-bounds"
> notification due to the __counted_by attribute. The compiler can do a
> pointer calculation using the vlan_data flexible array memory, or in
> other words, this may be calculated as an array offset, since it is the
> same as:
> 
>         &tt_data->vlan_data[num_vlan]
> 
> Therefore, we go past the end of the array. In other "multiple trailing
> flexible array" situations, this has been solved by addressing from the
> base pointer, since the compiler either knows the full allocation size
> or it knows nothing about it (this case, since it came from a "void *"
> function argument).
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

Thanks for the tweak!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
