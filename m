Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD295D6ED34
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 13:50:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2DA35842BA
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 14:50:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732197009;
 b=InO4uin+z52E76sP+wXVUaXUgBu4hqC3czxvbOHd2p5R+gDyMu23g+hz7ERcOF13IIrIv
 agHiFKVWC2RxlU0Uk4yAwJQVIthuDLiUnhwJ3SNhVw2OUSfXDyxdylJe8uOu4dHx9TK6wHY
 dbd/i01qpEAnks/RbqkG94byX4xpK50=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732197009; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vQufzUmjMtaTdqjzhlbQy6HACDbdY/7J2i6TGINavOA=;
 b=24pMxNZkffNnBquiOSzrCOPKMr7DrKNHl336QhFhQ/2MhoLCuVIwj4jlcxUrjYmTqPfBN
 FaImd04GeiUQgbpbGoj4F8Q+am1NB5Uq/Hnz+XjHrB+RWZYFavQHp5hmu4QD3wjAxzH/SXB
 oUxLzzUO7OSvLR1HMZ0+ZvfD1cV0SS0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D043583322
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 14:49:52 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732196992; a=rsa-sha256;
	cv=none;
	b=4DO+rNENHCPnEYBW5aW5RQAJcZGHVo+i/py6a/ZSYqH3m8rA0RYYs/8Z7DiVCRoxWnJbpj
	ZvZAdSNvpCLU4camC+MvEpHeSwEOfaZoZ6Uf9XrOqcE2Tr2ly6LEW8pDiBlSXNj/0t9mf7
	U26parqL+7dFyrJkCXg24/wGDPj8apM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=C5DMQdQe;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732196992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vQufzUmjMtaTdqjzhlbQy6HACDbdY/7J2i6TGINavOA=;
	b=o0ycK5o2oGOGsKZ41LbklXIgTnBF6/CfalWi8b/juZ2npQ7qsWT8AMsa0mDBkGE7aaXn80
	tuThbvpjD7XVvT1Ji3uhAakI29KulBJ9/tjzSlXGyjY/hesH6mMBwmAd5G/pq6zqVL1KMx
	TWXQcSHak9wwIWMRZpffCN/+Xik0O5I=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 0C2284FE8;
	Thu, 21 Nov 2024 14:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732196992;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vQufzUmjMtaTdqjzhlbQy6HACDbdY/7J2i6TGINavOA=;
	b=C5DMQdQekTrou0JSikB77sY57dByp8u++FTcP15XXOzdBKMTU1xtpb1nXuPhON+Y
	0OTQ8ei3rlXjOri4o3G/pdRMhTZgb/rMoEzFLN0iXrV6Tn5XnlbdSpDcX6MQJHb1lkl
	f6T6SjGvc4QHVgYNrBB1mKmcD7O9ittnW/swDRr0IjrY5SNlTo2YEidnDHMD/947bJR
	GR/JLTQW7L8icqTjs/74XrY1e0564NjJKUS4bgOweY840juRNiR0wQZoHVxhOlCYFay
	wy8e8E27tdy+D3EqkD2R4T5AhzffhyzNnpaEYmaF7RfsUEUtPGX7WUoJkgeHHNi7gG4
	eRRfUqnU7A==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 21 Nov 2024 14:49:49 +0100 (CET)
Message-ID: <ddd55e72-7113-44f8-8150-c2cf74486449@unstable.cc>
Date: Thu, 21 Nov 2024 14:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
To: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
References: <cover.1732124716.git.repk@triplefau.lt>
 <c8ebe15252c31d9cc0dd025830ddd793345948ac.1732124716.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <c8ebe15252c31d9cc0dd025830ddd793345948ac.1732124716.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: OIXTSUBVPNYITTY5JREYQE33QRLXDVUJ
X-Message-ID-Hash: OIXTSUBVPNYITTY5JREYQE33QRLXDVUJ
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OIXTSUBVPNYITTY5JREYQE33QRLXDVUJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 20/11/2024 18:47, Remi Pommarel wrote:
> When TT changes list is too big to fit in packet due to MTU size, an
> empty OGM is sent expected other node to send TT request to get the
> changes. The issue is that tt.last_changeset was not built thus the
> originator was responding with previous changes to those TT requests
> (see batadv_send_my_tt_response). Also the changes list was never
> cleaned up effectively never ending growing from this point onwards,
> repeatedly sending the same TT response changes over and over, and a
> creating a new empty OGM every OGM interval expecting for the local
> changes to be purged.
> 

nice catch!

> When there is more TT changes that can fit in packet, drop all changes,
> send empty OGM and wait for TT request so we can respond with a full
> table instead.
> 
> Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>   net/batman-adv/translation-table.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index bbab7491c83f..d7b43868b624 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>   	int tt_diff_len, tt_change_len = 0;
>   	int tt_diff_entries_num = 0;
>   	int tt_diff_entries_count = 0;
> +	bool drop_changes = false;
>   	size_t tt_extra_len = 0;
>   	u16 tvlv_len;
>   
> @@ -997,21 +998,29 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>   	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
>   
>   	/* if we have too many changes for one packet don't send any
> -	 * and wait for the tt table request which will be fragmented
> +	 * and wait for the tt table request so we can reply with the full
> +	 * table.

I'd still say "(fragmented) table", in order to give the reader a clue 
about how we're going to handle this.

> +	 *
> +	 * The local change history should still be cleaned up or it will only
> +	 * grow from this point onwards. Also tt.last_changeset should be set
> +	 * to NULL so tt response could send the full table instead of diff.

Personally I'd not add these details.
I'd just say that the history "should still be cleaned up as we get 
ready for the next TT round". Or something along those lines.
The rest is just a consequence of the "preparation".

>   	 */
> -	if (tt_diff_len > bat_priv->soft_iface->mtu)
> +	if (tt_diff_len > bat_priv->soft_iface->mtu) {
>   		tt_diff_len = 0;
> +		tt_diff_entries_num = 0;
> +		drop_changes = true;
> +	}
>   
>   	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
>   						     &tt_change, &tt_diff_len);
>   	if (!tvlv_len)
>   		return;
>   
> -	tt_data->flags = BATADV_TT_OGM_DIFF;
> -
> -	if (tt_diff_len == 0)
> +	if (!drop_changes && tt_diff_len == 0)
>   		goto container_register;
>   
> +	tt_data->flags = BATADV_TT_OGM_DIFF;

hmm there is no mention in the commit message as to why we're moving 
this assignment. Why is that?

[And I just saw that this flag is never used.......]


Regards,


> +
>   	spin_lock_bh(&bat_priv->tt.changes_list_lock);
>   	atomic_set(&bat_priv->tt.local_changes, 0);
>   

-- 
Antonio Quartulli

