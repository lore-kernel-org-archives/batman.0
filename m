Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA628C5CFC1
	for <batman@archiver.kernel.org>; Tue, 11 Aug 2026 21:57:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB4A684091
	for <batman@archiver.kernel.org>; Tue, 11 Aug 2026 23:57:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786485441;
 b=gIYt1xGgHNv8ucU/7WTlfMffQcER8yWbR+qpK4FF+YPBO5crfKY4VipweSZ0nMJXnEmbF
 uwCDFAPLY5WOsSJA7A2UbvA/V8yVZ5SSeOX3Z5mNcTmgAiSs8sy+XXDT+fmAQA67Iuh9Eqc
 uLGxQXnHCx9eLNKu/h18ZJ0DLic8nLs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786485441; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hFIbzakitGwSk8y+vFk/wcfsQZafYclSWvL8Py7Ikak=;
 b=Wx5I2ktjokztNuO7gfgBy3sLW50uDomf2H/4w2pNlJqPe2hVqqkc8CEW7F8eAXTVq0mmu
 2Wqloqg4BnPBnEjO2sDs5SA1aM2pXV5YV6UyoiACj+BLH7uXMp/fhDLgPjV2rq4v2FpBF1S
 Mhun7XkZ+JN7wnGrcdvq+R3pctV8JAk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 38338811F6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 11 Aug 2026 23:56:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786485421;
	b=ZNc2OTQY6WM/SQzByuiwj5n7XAEBCG0wmcT1+LLJOUQcM8oVQOvMLiNdvi3zYvGmLZI4it
	rLDBBcZkGuMeQGPveuxjP6RtULfA1vA9JH2R1XkM4k+f4unK1b88BiODkJUbPj2UuQ/6yH
	2oGINimQd7+bijFPGsupbK5U8nO/nVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786485421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hFIbzakitGwSk8y+vFk/wcfsQZafYclSWvL8Py7Ikak=;
	b=NTTjtLC/XjLW3DB2sQuZ4xUfpEvdMllpXZIPkaad0gceSzOE+FdaTUDk5Bjaa0J3lzcxBs
	FskqcAvbTZpsCJXQv9E7qAgblnhjcg/IX0/dv+4DsLimhdCM6E45fsXI+SdWXWFdc6rNt6
	vfxREBSBoVx6v/nX5TMNEccOZqPWg1U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hh/8LrQo";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender)
 smtp.mailfrom=kuba@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 076BD40363;
	Tue, 11 Aug 2026 21:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763D51F000E9;
	Tue, 11 Aug 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786485408;
	bh=hFIbzakitGwSk8y+vFk/wcfsQZafYclSWvL8Py7Ikak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hh/8LrQo0BGFiDXXgS7tf/9i81S+NcOBCaTdtJ5IrIYCyZmmkb63g7n3dMyKX5H6+
	 PZ9xRSNDYRqpI/IY9LYk791rhtp8inqiWdawWV9HACNpVCHDY81KOzgKPSalEVghX7
	 eQ/kpsMuraps8+FIOjcrZUQ4DXcxE5fAwTt4afHkKI+j4+kwVd4dBCT2Di+QJFcfMD
	 0nq7XfmqcjTMVIyK33y/HIhX5jhM+s5hZUYptQ9Euhq8xq2yDQola/8k7Bido0j6Gd
	 6St9rEb0SxYMCXJ8UGjdd8nASJtwt9UHHfouV7lunZbkbVf3qGzA3Pzhd4KgYu3s4L
	 1HL36w7aahBUg==
Date: Tue, 11 Aug 2026 14:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Dominik
 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] batman-adv: reject unrepresentable multicast
 TVLV offsets
Message-ID: <20260811145647.34a190e5@kernel.org>
In-Reply-To: <20260810145754.828936-1-david.lee@trailofbits.com>
References: <20260810145754.828936-1-david.lee@trailofbits.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: YFSWAKNJED7BYD7JCYALXPX66SWKNETT
X-Message-ID-Hash: YFSWAKNJED7BYD7JCYALXPX66SWKNETT
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YFSWAKNJED7BYD7JCYALXPX66SWKNETT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon, 10 Aug 2026 14:57:51 +0000 David Lee wrote:
> +	long transport_offset = skb->data - skb->head + offset;
> +
> +	if (unlikely(transport_offset !=
> +		     (typeof(skb->transport_header))transport_offset))
> +		return false;
> +
> +	if (unlikely(transport_offset ==
> +		     (typeof(skb->transport_header))~0U))
> +		return false;
> +
> +	skb->transport_header = transport_offset;
> +	return true;

Find a better name for the variable instead of wrapping the lines.
