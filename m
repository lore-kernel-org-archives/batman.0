Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD41C5B572
	for <batman@archiver.kernel.org>; Tue, 11 Aug 2026 15:33:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7618D83E1C
	for <batman@archiver.kernel.org>; Tue, 11 Aug 2026 17:33:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786462428;
 b=T2EVMbRgl8gl0ecb+O1daw8d9hl5SqGTZVnh2eMQ+Pt9rGmzQg1Y/3o8gcZaYVlZea4Or
 a/sN0y6TBNwTTfix5xJO8OBKIxHx1snAMAezPQLcjG7tsKhg08k7KuhFIvHKfePnQr3tuZF
 02muGHI5Nlm8QUD8ctqEzMCkNPB41c4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786462428; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8EaiKlbpCQVAvrexAqV7FKKO4XBVCQ96a5UJP4GhPLE=;
 b=ZnnEu+cYx21xiQff4dmgWpYf9vpbJfZobqoambC3dK21wmWJCxlctGAbv8ufNQkzOc6DF
 tEz7hKU+VBIDqKCuabYP4iQyFMx42lu9mqdyWQZmGzUOmjRa4/2yv3D5TzYeKqowZvZMq9q
 SONJ0QQT//1EXtwytb5AFHaEtqHTiDw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0831280C47
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 11 Aug 2026 17:33:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786462408;
	b=U+Rkw6URypHd26mG7Nud2KuRyU2b8Oyx1XyCYZiCat+Xq4iQ1H7tQBSN7rTiLXJ7BKKQS+
	4ZuuQ7AETwj3JaFzJ/PFmi71Kl+8QeOzMRyM4b2uM7B19IdFQN4pmu75CR9uUTEFMSc3VV
	hBkOsM+fRebGury9+Zh9MxE3QG+voSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786462408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8EaiKlbpCQVAvrexAqV7FKKO4XBVCQ96a5UJP4GhPLE=;
	b=Yxz84sPtwxpBUNFGDyKnO2IQU/MLIPpxKSlOFw3sgnhVfuio8ux3AzRnWRV+OIe2qoCAK0
	qrM1lCwXKtv/asqCleud5aF6VlexvIeFYwmI8VNmgruI1TX7VVwEDrCzUipPLXlmQw073C
	tSN2A20e596QqtqAC15cptRP6k6fJas=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DaOzcA4d;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id E374F20241;
	Tue, 11 Aug 2026 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786462393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EaiKlbpCQVAvrexAqV7FKKO4XBVCQ96a5UJP4GhPLE=;
	b=DaOzcA4dN4lDtT6zpv1yBE6l+QU0pn+X46m8vZMg1bbbn8U63A4UvBodaEIv/lVPaIgBj3
	jFrnngabblkcfyt/qSGJTqetkpvIFhzINeocZ/EnOBezAtjNdQWrJ60Ut3hmNG6nUgydmT
	FAi7fwPUG5cTOXYTFKDp1bdQ85b1GHY=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2] batman-adv: reject unrepresentable multicast
 TVLV offsets
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260810145754.828936-1-david.lee@trailofbits.com>
References: <20260810145754.828936-1-david.lee@trailofbits.com>
Date: Tue, 11 Aug 2026 17:32:59 +0200
Message-Id: <178646237968.2022359.8997893163921377425.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ani0hyGmCJGaqxrPmXmnyKjxsRejVuS2hFDgorsnmfU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnVDlubdYv021hWftyTbfPI+Fgax42ix4ZzptXpd3i2J
 P63mjG9o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR1WaMDLvvvX61bWtO0Y4N
 cYeVpvKu+B10dkHz5vfR2iuNOo5ZJiky/Hd5senGz9y7vYcW9FmKPM2Mmad17sIsr80n99m8vMV
 hNZ8ZAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YJKP6MSFSNRPWAJGROVZU557LM6PNQFF
X-Message-ID-Hash: YJKP6MSFSNRPWAJGROVZU557LM6PNQFF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YJKP6MSFSNRPWAJGROVZU557LM6PNQFF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h                                                                                                                                                                
> index 22eda1d54a0e8..dbeceaf5c3b39 100644                                                                                                                                                                                   
> --- a/include/linux/skbuff.h                                                                                                                                                                                                
> +++ b/include/linux/skbuff.h                                                                                                                                                                                                
> @@ -3126,6 +3126,32 @@ static inline void skb_set_transport_header(struct sk_buff *skb
> [...]
> +static inline bool __must_check
> +skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
> +{
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
> +}
> +

I personally don't like the way the lines are broken down. The 80 character
limit was replaced by a 100 character limit since commit bdc48fa11e46
("checkpatch/coding-style: deprecate 80-column warning"). And it seems like
there are already multiple lines in this file which are longer than 80
characters. So it should be possible not to add a line break right after a
comparison operator.

But I leave the judgement about this part to the netdev maintainers.

> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index de907c07fa154..93492d393c347 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -438,8 +438,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
>  			return NET_RX_SUCCESS;
>  
>  		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
> +		if (!skb_set_transport_header_careful(skb,
> +						      tvlv_offset + tvlv_value_len))
> +			return -EINVAL;
> +
>  		skb_set_network_header(skb, tvlv_offset);
> -		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
>  
>  		return tvlv_handler->mcast_handler(bat_priv, skb);
>  	}

For the batman-adv part:

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
