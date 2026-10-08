Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4FECA6015
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 23:21:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7E7C6842B3
	for <batman@archiver.kernel.org>; Fri, 09 Oct 2026 01:21:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791501682;
 b=m956/oAhoIjgn2WFiMMUuRQKq6jL2ukfsfvT8vTpS6FgCG0fp3JiBQcGC/SoWmf0EwPaJ
 DZ2fQJtEH9+JG18kNecXGTiWIZ66tg3WShHtsjPXnVXmAqP/kQgNn0kVqDzP6jGvovjQvKv
 vGXADPgZw1np6LYv3MOQ5dxTH5Il5vk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791501682; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BoeSR5PNN8geN42ItvxGDtZ23PGIh68MP9Snd5HkA0M=;
 b=ZT6LfpY9ffEkR+tLX54axbUh7TfBkUswcCm0JoZ4wcXLy6t3olz3r0OSIW8Xthmac2MzA
 LDDECWpMX+4rcZvMryX2pu2pogSRcIjc1iv7gOAeKVcTAwKCvMJQBM5q/sn2zsar01Uksic
 lmNmrAHJjWPfuv7w3c0UOtZV4mMapxg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6D5C680C92
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 09 Oct 2026 01:21:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791501673;
	b=mYSDjDyelvEGRDXMXBB1Y1LMQxbLo+BM1ou8gT44QELgPW5jE+7hsigB8ZHShOaumWM1tA
	+d0uw54rvyGhabTVLdirNAdcENyhFju7sXI9Oejsxdw1H7YbmR4yApnMk5mha1vLDZoKmX
	nGMdPl67gO0B/IXOnJ9lH3CHCSLutJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791501673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BoeSR5PNN8geN42ItvxGDtZ23PGIh68MP9Snd5HkA0M=;
	b=2ZYqOQ+iqK3hn8fQ2cQtO35e427vR3dgmp0uhqXDg7xPYIxxOatroyyfVnS7k6F1AuU4Gi
	CZFu+6Tgr/NHKwdzUUA387f/DqYs+C3njPdCj1DJhWlJoTP8GLQjYH9Nh13wgoa0PuEl8p
	YPBUPdCh6RhiraG0fQ6TuWFTS1TLSZI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XAJv5aFy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5C7282049B;
	Thu, 08 Oct 2026 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791501661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoeSR5PNN8geN42ItvxGDtZ23PGIh68MP9Snd5HkA0M=;
	b=XAJv5aFyFuo/9OarYL/cVUiQWKCX+N/SrwciO1QG6LLMhpiCRt7rNclYBM9P4GNLqqMy+6
	/Cjq62SSjHAXlQtkyxkkEeFzg6S6tMXF/+WCqqm56YwjyudLpFZTijJiysHnCbrXZAXJer
	6WRWiNe34Yqy7skii3unQgZl9bEejA0=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [batadv] batman-adv: uapi: add note/clarification on access of
 reserved bytes/bits
From: Sven Eckelmann <sven@narfation.org>
To: =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
In-Reply-To: <20261008223645.7114-1-linus.luessing@c0d3.blue>
References: <20261008223645.7114-1-linus.luessing@c0d3.blue>
Date: Fri, 09 Oct 2026 01:20:45 +0200
Message-Id: <179150164551.260338.15634935667753481742.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=sven@narfation.org;
 h=from:subject:message-id; bh=rdNQE8NXGllxsf62ZosgcmihyLiN+BDmHq/KFDWeT2Y=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFknVAMSKmXDrhcUrT034+vt1C9seU/zPL/I7VQrMH+pF
 mR8rft4RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiVVsYGRbwKGaWO+aHhrRo
 x585NSljiwJzuXvz5iUtLctnFMx3PsjI8Mlzx73Hn7unf73r6bNy57Y7thGdbG7L5kwQquTUvZz
 ygRkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TPWXCKUQFIOK6EY4UGOMBJNDUJM56XKM
X-Message-ID-Hash: TPWXCKUQFIOK6EY4UGOMBJNDUJM56XKM
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TPWXCKUQFIOK6EY4UGOMBJNDUJM56XKM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Please use [PATCH batadv] and not only [batadv]

> Similar to the note in include/uapi/linux/ethtool.h add a note regarding
> reserved fields in include/uapi/linux/batadv_packet.h, too.

"Similar to the note in include/uapi/linux/ethtool.h, add a note regarding
reserved fields to include/uapi/linux/batadv_packet.h."

> That is that userspace may not access these fields directly as they may
> change in size or be renamed completely in the future.

Reads a little bit awkward. Potential alternative:

"Userspace must not access these fields directly, as they may be renamed or
repurposed in the future. When creating packets, userspace should zero the
whole struct (e.g. via memset or a struct initializer). When parsing
packets, reserved fields must be ignored."

> While at it, unify @reserved kerneldocs text.

"While at it, unify the kernel-doc text of all @reserved members."

> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -12,6 +12,15 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  
> +/*
> + * Note on reserved space:
> + * Userspace programs may not access reserved fields directly as they may
> + * change in size or may be renamed completely in the future. Instead
> + * userspace should memset the full struct containing it to zero or use
> + * static / struct initializations which automatically zero all unspecified
> + * fields.
> + */

Please don't add an empty line at the beginning of a multiline comment - as
preferred by netdev. ethtool.h also not using an empty line for a
multi-line comment.

Why aren't you using the comment from ethtool.h?

/* Note on reserved space.
 * Reserved fields must not be accessed directly by user space because
 * they may be replaced by a different field in the future. They must
 * be initialized to zero before making the request, e.g. via memset
 * of the entire structure or implicitly by not being set in a structure
 * initializer.
 */

-- 
Sven Eckelmann <sven@narfation.org>
