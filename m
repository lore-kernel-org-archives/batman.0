Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6ACCAC5BB
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 06:21:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 125AE840E5
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 08:21:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759040518;
 b=0wouI68tS4jisi0YpOPsv/9LQvLoCsCCXIAVmeu1tZ97nmCl+hA8THwQAIQ3vBtu7YKCg
 91fdgEYkWOgG1mt/yWIrCVL7xlqVdKfnaq841Ifv8NeB/46ou0bxmlqNpJrnFuSM17q4+Ku
 1xFu185dhxDUPNCYzv5KJCT5V1fJ8dM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759040518; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=S/vRGevhosvEotDZYnL6q1ZsIVL8K1pu8f9Ti2RbPhw=;
 b=QwT4ieTOtHi9PKO0fL8687KlkgaaWDKEEGpmB+Kgf6gVDdGKWS5RUrSLGZ+ZsXjJpqO4E
 C18hwpFh5UPHjavUIEnzCW06XeZ5+Th50NLb/akJZ1jxz45SsXKNnbjxYQRFnfnwscgNV3m
 Q2nQr5MGDusUh03EUj/Vt75vPtnjG2E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9811683B66
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Sep 2025 22:55:56 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759006566; a=rsa-sha256;
	cv=none;
	b=V4dviYvsRO9xmhVL7bFinHByzc6aIKUBFH6dLbuRgRXHgvLRSIhP46858ORBnO6PzUF3Dp
	85vXxsxmFLreCC5onn174h7HxYuvOUNzycIPBsPLnsenQnizOOAl+2uyIHqrfcYQhN4Gqp
	4/i1P91iO09MTSX6VCRdUnYLrfBloeM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=DRZgM9jU;
	spf=pass (diktynna.open-mesh.org: domain of ebiggers@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=ebiggers@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759006566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=S/vRGevhosvEotDZYnL6q1ZsIVL8K1pu8f9Ti2RbPhw=;
	b=SEDZobsXXpWpq6YI1+xcRYEP5PhUO+skhcCmc+3/4L1gPInWgtS1in9HpzmzqdWRcnsvER
	QWyz971oCWxg6tWDUsBq/PBTiysm2k0Q/FeBvYyGWWJN7BeiLCuURXJVQaDvo2JAgCEJCH
	Wf4I0ypSgpAOizq1IGZ735lLYBD4OTs=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A87A43F63;
	Sat, 27 Sep 2025 20:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A04EC4CEE7;
	Sat, 27 Sep 2025 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759006555;
	bh=WhvCEHR71JlepeZAgEOKFLslIS3HckCTEyON7ene1Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRZgM9jUhtMTEydD42j7Nbtxg+JhtWb+Z249XgUWhuKN089P67pck7c/3ueE3mfNx
	 eX660JzdA4nIrDnLpbt3uFexE6YeMaJpO8rJbRlm8ZJp1OPKCsnTlUhqmhhGrcjn7g
	 a8uU8698JcEObJ2+EMJyUrQNSe8hlXL6QRq0KQfep1fTaaqu2XWCj8qczQs36NG9Qq
	 AsNNLqSGZsQQ2TySKM6WAgC/2T+6Xzg2yS1H1Tc/ellHXa49Km514naXvDOcjJujV1
	 +4IAbbwC1hklKbx2YEp8nmneRrcmVOZLmRMAdKNgqp8wISGB755bgyqqc86WRxPedJ
	 O8R/zKuKRcBQg==
Date: Sat, 27 Sep 2025 13:55:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in
 BLA
Message-ID: <20250927205552.GD9798@quark>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
 <20250916122441.89246-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916122441.89246-4-sw@simonwunderlich.de>
X-MailFrom: ebiggers@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: T2KMKENZD6OB76YHFROD7DA4YUMIGJ6N
X-Message-ID-Hash: T2KMKENZD6OB76YHFROD7DA4YUMIGJ6N
X-Mailman-Approved-At: Sun, 28 Sep 2025 08:21:32 +0200
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/T2KMKENZD6OB76YHFROD7DA4YUMIGJ6N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On Tue, Sep 16, 2025 at 02:24:40PM +0200, Simon Wunderlich wrote:
> +static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> +{
> +	unsigned int to = skb->len;
> +	unsigned int consumed = 0;
> +	struct skb_seq_state st;
> +	unsigned int from;
> +	unsigned int len;
> +	const u8 *data;
> +	u32 crc = 0;
> +
> +	from = (unsigned int)(payload_ptr - skb->data);
> +
> +	skb_prepare_seq_read(skb, from, to, &st);
> +	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> +		crc = crc32c(crc, data, len);
> +		consumed += len;
> +	}
> +
> +	return htonl(crc);
> +}

Has using skb_crc32c() been considered here?

- Eric
