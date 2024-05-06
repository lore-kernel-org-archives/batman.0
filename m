Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AB9C25B5F
	for <batman@archiver.kernel.org>; Mon,  6 May 2024 17:35:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 10AF682815
	for <batman@archiver.kernel.org>; Mon,  6 May 2024 19:35:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1715016901;
 b=yPqSYrjdMetSZjIMzznmNsGo3SXFsC0CWrAsjhPzasVEW+plUGlfeMGgx9XQ0tifMdol9
 0tEkAB60/AM2NCIH637AVWU0uaLasAfzIkhv3mmwGadkAIaM91hJ3U8itv2Pyj5PhdRqWFw
 WmGG7Jr7TZ9yy4XFBUN4n9bJyMNJfCE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1715016901; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
 b=Y67FOB/utLOJ6TmDwKyoq8SYWkTSIGTFlHJpvEo6d6AItw4p2oNJYPNCLRpOg6w5gcYLT
 3+B0o+k/2EDZGmXHqUxkdTGR4/hbQefx33yCwc7PMX5bmQfZ3pOKu1c+QGioZLt7VhIHCH0
 qM/8WfWePzkEleQt2hm6mylx+Rbr81I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=chromium.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=chromium.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=chromium.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=chromium.org policy.dmarc=none
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2499A81979
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  6 May 2024 18:29:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1715012985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
	b=wrz65ykZ9A2vcAIkryJ81TBilxmJ94JP3h9bXADBS4JjzTaUkRKrXy3uozCcHNxlzNzBzw
	PU2RHgL8u083ftpxxNPypa5RQ+4pjD5rv6esUzDlQ/ETQKeegdVSXrblhivX8xwDheRaHw
	1EnPmNztn2WquVzyw3hxoQEY8chylvM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=chromium.org header.s=google header.b=cHvFMbcg;
	spf=pass (diktynna.open-mesh.org: domain of keescook@chromium.org designates
 2607:f8b0:4864:20::62a as permitted sender)
 smtp.mailfrom=keescook@chromium.org;
	dmarc=pass (policy=none) header.from=chromium.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1715012985; a=rsa-sha256;
	cv=none;
	b=SqkmXKFb8/UpPai0TlFNET5/QeKZSG+bdTPDBDs0JvLnNT17nxEcFXgyBSdYo55LoDmQQ1
	iqYD9TJQXhYFzbFfcZTX9kx0tgOdXnK0Yc3F9I6ghgC0lRfQkvX5EboAlsqLwkqtAY4rCo
	Qp0HyLgcHcJDy8+2chCphCuABASXjBA=
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso8913155ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 06 May 2024 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715012983; x=1715617783;
 darn=lists.open-mesh.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
        b=cHvFMbcgdwlHBOS/pP681Z5drQgcaiVLlGbyP1gQW4YmObTu/76fums3YOOQSAnumd
         zcjaZFnajwxxxTxsR8O48WnYNAmcnfro4u0W7xjwzFdFBpqW6t0ZSrIqd4iO/wNT94V0
         cEQ7qAVOFc7/XB9IV6wvd86ix9CM/LyrcuMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012983; x=1715617783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
        b=htmVuiYk62RZonblRxnL2UEiEfDQXU0oC27Dpnj6xLwh3RAus5RcfzZx60gsEPHCxR
         VBmmdX5LUd7IOtT5rOjM0yuupPcNAGjk39hsU+CrlFy/BoC2QEcJtvII4tLs5ZKCztzZ
         I4e6Q8+XTANyiBLmoYNCCsqpS76FVu+QNAJ7y78Q16F9N+XTn9gzOhGjoxi0ONCT/LfP
         z4d5ryA3Twmpi6d0nCISiAw0bbz2+fBuDEQiYYX2RSTKhoQ1II/qpsLU4RRVsTERRqsA
         rLhxX4f8UCcAxdiWDqXMKT9gmlr9nV24V9eKbLMubL3gZgWRvzA62ihDzYsRxYk3gghW
         SOTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfaS4nG6ETzyhjAMomYhb+vf96k507kZ+Ex3g9/E6pjKhvDkfFen6kpSIHOjDIokWJcsy8h+SbEbZe3POie8BA+PfviOFqY4OPX4diZ6jg
X-Gm-Message-State: AOJu0YzowIvP8E2zUYFcdzi8kgUnIpUXG8ib0HFCi9h8WppDA8Hzc056
	xK0AcDNOmeTfzeiWvyrG5ATVW+P9QxFYXQR9m7sqrZ7A59YxslDXpN0Ov1STnw==
X-Google-Smtp-Source: 
 AGHT+IFbFO7WG3T0AZk4k9Vs5NN+nUuBbULzCcUX9OeVRvDR9+EhwfFkTTZglRWvChOo6sF8QSal5A==
X-Received: by 2002:a17:902:c40c:b0:1eb:dae:bd98 with SMTP id
 k12-20020a170902c40c00b001eb0daebd98mr13243215plk.51.1715012983437;
        Mon, 06 May 2024 09:29:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id
 im16-20020a170902bb1000b001ed33493868sm6958248plb.243.2024.05.06.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:29:43 -0700 (PDT)
Date: Mon, 6 May 2024 09:29:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
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
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405060928.272B235@keescook>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <9977759.T7Z3S40VBb@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9977759.T7Z3S40VBb@sven-l14>
X-MailFrom: keescook@chromium.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: ANHYCBM3Y2TZEGCF3VWN5TX7HTM4JJRU
X-Message-ID-Hash: ANHYCBM3Y2TZEGCF3VWN5TX7HTM4JJRU
X-Mailman-Approved-At: Mon, 06 May 2024 19:33:55 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ANHYCBM3Y2TZEGCF3VWN5TX7HTM4JJRU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, May 05, 2024 at 05:22:10PM +0200, Sven Eckelmann wrote:
> On Saturday, 4 May 2024 19:08:39 CEST Erick Archer wrote:
> [...]
> > > Thanks for the updates. But I can't accept this at the moment because 
> > > __counted_by_be is used in an uapi header without it being defined
> > > include/uapi/linux/stddef.h (and this file is also not included in this 
> > > header).
> > > 
> > > See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> > > identifier expansion") as an example for the similar __counted_by macro.
> > 
> > If I understand correctly, the following changes are also needed because
> > the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
> > question, but I'm new to these topics.
> 
> No, it is absolutely no stupid question.
> 
> > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > index 6e25753015df..41f39d7661c9 100644
> > --- a/include/uapi/linux/batadv_packet.h
> > +++ b/include/uapi/linux/batadv_packet.h
> > @@ -9,6 +9,7 @@
> > 
> >  #include <asm/byteorder.h>
> >  #include <linux/if_ether.h>
> > +#include <linux/stddef.h>
> >  #include <linux/types.h>
> > 
> >  /**
> 
> This must definitely go into your "original" patch
> 
> > diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> > index 2ec6f35cda32..58154117d9b0 100644
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -55,4 +55,12 @@
> >  #define __counted_by(m)
> >  #endif
> > 
> > +#ifndef __counted_by_le
> > +#define __counted_by_le(m)
> > +#endif
> 
> If you want to add this (for completeness) then please put it in an extra 
> patch. It is simply not used by batman-adv and I would not be able to find any 
> justification why it should be part of the batman-adv patch.
> 
> > +
> > +#ifndef __counted_by_be
> > +#define __counted_by_be(m)
> > +#endif
> > +
> 
> This part can be either:
> 
> * in the batman-adv patch
> * or together with the __counted_by_le change in an additional patch which is 
>   "in front" of the batman-adv patch (in the patch series).
> 
> From my perspective, it is for you to decide - but of course, other 
> maintainers might have a different opinion about it.
> 
> >  #endif /* _UAPI_LINUX_STDDEF_H */
> > 
> > If this is the right path, can these changes be merged into a
> > single patch or is it better to add a previous patch to define
> > __counted_by{le,be}?
> 
> I don't have a perfect answer here. See the comments above. The file 
> include/uapi/linux/stddef.h doesn't have a specific maintainer (according to 
> ./scripts/get_maintainer.pl) - so it should be fine to get modified through 
> the net-next tree.
> 
> But maybe Kees Cook has a different opinion about it. At least there are a lot 
> of Signed-off-bys for this file by Kees.

FWIW, I'm also fine with the UAPI going in via netdev. It's the most
likely place to use the be/le variants. Is netdev still open for
patches? Whatever the path, we should get it into this coming merge
window so we can use it elsewhere too if we need it.

-- 
Kees Cook
