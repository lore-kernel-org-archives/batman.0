Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1862EC25B5F
	for <batman@archiver.kernel.org>; Mon,  6 May 2024 17:34:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D793825A4
	for <batman@archiver.kernel.org>; Mon,  6 May 2024 19:34:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1715016860;
 b=gU0mPM8f7DKymaZdEmI/s1kLaYuRBhMBfwu2zwUeEIuXlAH8TJis4F+DFnJ5+qs+FD2cI
 9+89hxLw0vRvgnEu44Iz5H4ck2JS9kdvdHnmARM/ipmZAzfufR2rRwBTqqpwykX8xS2h2NR
 I2jgT87fiDhVAwI94KH1Vc94XVmaGqM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1715016860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
 b=bAI7b2mgjW5tlKi6mTpgdCprRCpn/WQRFrSKf8GnTGL9mfuY7qlm99qrGY8s7joqwzYpS
 VrRFFZ7vzhk8oLuoepd7mvuFBBy9JGTCsW7e9FkuA8g25DYOgTNZwlydl+kpxrqwJmyoaAd
 lr0NUYtYlbeGLthSBDCSnUusf3Z95io=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=chromium.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=chromium.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=chromium.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=chromium.org policy.dmarc=none
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BA85180F1C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  6 May 2024 18:27:48 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1715012868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
	b=QxF6U6dSD4+wKy1e64ekh0ORCv12kPxy8EvixdAWnmIeogVH+OabC53fT7i6ZrzVUWBtCK
	fH3Clxsyvp575UhEjLt+HJTem4LqoOV9fmno0laksD2ny7FnllRrk2/t483O70sks/I18R
	LOQHH91bHdbzdO/oOcr6UmaH0m0B6Fs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=chromium.org header.s=google header.b=fUUfc8y3;
	spf=pass (diktynna.open-mesh.org: domain of keescook@chromium.org designates
 2607:f8b0:4864:20::436 as permitted sender)
 smtp.mailfrom=keescook@chromium.org;
	dmarc=pass (policy=none) header.from=chromium.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1715012868; a=rsa-sha256;
	cv=none;
	b=lQEauEQeEo2vSB2cc5PkCrrRBrSWPezFa4qgK6jex8gvBHDOH3iRIwV3M2XNAu6E9bALlS
	wTs7AC9EYpbzRSmqTis3svYCk9Q3VlkX6AH0Rzx0pmaiTB04F4lSv5Ns2IP1zhM3YkyaaS
	x29nQSQEFIu5+Pve6/QjGgj6LgglCkM=
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4521ad6c0so1477743b3a.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 06 May 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715012867; x=1715617667;
 darn=lists.open-mesh.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
        b=fUUfc8y3ziA0IIa1ErFUvG6CJUdbQfQ1FrR3qgOaPs3noYKO9utvJyxaZSUGPg8Tw/
         kOHnc02ZIL2e90CIhtTwELeQlQ6339GBRM5pVwe+z4hmgdZ/Fx/pc+DfnsPoznXalr59
         fx9pZ1ggXwf7dLXHMlDH1ULLviDOjx0ZsE8T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012867; x=1715617667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
        b=SvznFzQ3ieCknLV9j+PZRh/gIXzmcmplf3mnZ7irNkPvYWHklEHS8ZhYQKoR6yEydw
         q+IAQwMegMfZCXVNAwrINvdY7bBQQcinXLdypx2GJ+E0aTGkAUPLxYUxxLTNhAE3qUry
         tngZOv//zuGvugnec7lFW2pOdR/gKqUYG13Cn4Yka6hJBrZzDvxTXN5Rw17J8RdVWOmZ
         8ZP4CMGQPYeb4AyGhGO8yTcN1XaIwKp/kmAhehnpx0mBsXGsI59AlGwEF1h1b+gt3uN7
         bcWJuDHgcunlXRwGSfawgbZS/0zacSZy5c934Fr0pgErcgabFKBJ5CvYcCob0ixG8XAB
         8R8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDce4h8wp4mFdFXa1SmMHXAnB0vhAiUZ8xXUJSKij+0MmG+a4H9a9FfOxQLp0mO4uaAh/mpsvFSr9aQW55DxDIVyg9pnvb5eaZnzpZogX7
X-Gm-Message-State: AOJu0YxOumTQcMKHlxMi7sF97ZYJ89aM/C+2GRxn/zLBTEk5d8sYEHqH
	bkmVBlFzPHe0RDVl57GHEsP7Q1NS9Z0N5ROT3lF3uM7gTWh7ZQP8baqWRGXDMw==
X-Google-Smtp-Source: 
 AGHT+IFx5A8ojwQhkf5tzPyoBV+wXS8DrLII4KW7i+NfXJRNfcIe8ljx+OJPW04VragyCU8v5vFkvw==
X-Received: by 2002:a05:6a00:2342:b0:6f3:ea4b:d1c1 with SMTP id
 j2-20020a056a00234200b006f3ea4bd1c1mr12045012pfj.1.1715012867078;
        Mon, 06 May 2024 09:27:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 ls30-20020a056a00741e00b006f4123491d2sm7951997pfb.108.2024.05.06.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:27:46 -0700 (PDT)
Date: Mon, 6 May 2024 09:27:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Sven Eckelmann <sven@narfation.org>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405060924.4001F77D@keescook>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-MailFrom: keescook@chromium.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: BXHRPVLSCN2ACSZPQK2VFLASBMIQ5KMU
X-Message-ID-Hash: BXHRPVLSCN2ACSZPQK2VFLASBMIQ5KMU
X-Mailman-Approved-At: Mon, 06 May 2024 19:33:55 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BXHRPVLSCN2ACSZPQK2VFLASBMIQ5KMU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, May 04, 2024 at 07:08:39PM +0200, Erick Archer wrote:
> Hi Sven,
> 
> On Sat, May 04, 2024 at 11:35:38AM +0200, Sven Eckelmann wrote:
> > On Wednesday, 1 May 2024 17:02:42 CEST Erick Archer wrote:
> > > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > > index 6e25753015df..dfbe30536995 100644
> > > --- a/include/uapi/linux/batadv_packet.h
> > > +++ b/include/uapi/linux/batadv_packet.h
> > [...]
> > > +/**
> > > + * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
> > > + * @flags: translation table flags (see batadv_tt_data_flags)
> > > + * @ttvn: translation table version number
> > > + * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
> > > + *  one batadv_tvlv_tt_vlan_data object per announced vlan
> > > + * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
> > > + */
> > > +struct batadv_tvlv_tt_data {
> > > +       __u8   flags;
> > > +       __u8   ttvn;
> > > +       __be16 num_vlan;
> > > +       struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
> > > +};
> > 
> > Thanks for the updates. But I can't accept this at the moment because 
> > __counted_by_be is used in an uapi header without it being defined
> > include/uapi/linux/stddef.h (and this file is also not included in this 
> > header).
> > 
> > See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> > identifier expansion") as an example for the similar __counted_by macro.
> 
> If I understand correctly, the following changes are also needed because
> the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
> question, but I'm new to these topics.
> 
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 6e25753015df..41f39d7661c9 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -9,6 +9,7 @@
> 
>  #include <asm/byteorder.h>
>  #include <linux/if_ether.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
> 
>  /**
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..58154117d9b0 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -55,4 +55,12 @@
>  #define __counted_by(m)
>  #endif
> 
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif
> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +
>  #endif /* _UAPI_LINUX_STDDEF_H */

Yup, this is needed for UAPI as you have it. Thanks! I should have noticed
the need for this when I reviewed commit ca7e324e8ad3 ("compiler_types:
add Endianness-dependent __counted_by_{le,be}").

> If this is the right path, can these changes be merged into a
> single patch or is it better to add a previous patch to define
> __counted_by{le,be}?

We're almost on top of the merge window, so how about this: send me a
patch for just the UAPI addition, and I'll include it in this coming (next
week expected) merge window. Once -rc2 is out, re-send this batman-adv
patch since then netdev will be merged with -rc2 and the UAPI change
will be there.

-Kees

-- 
Kees Cook
