Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09330D6ED27
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 13:05:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B963842A8
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 14:05:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732194348;
 b=V83zzs1kTwIMSohELTAcsa10KpK8ZyVHTmmhFxcHhmDuTRAgcamCJ+Bxd2+As4ls+cYYE
 WiOwNeuBoPu/ggIVpQG+ZctnBLBex/wnduybJamqESngRsfWocgj/w2mXq6B0wxMbZnEpu1
 hTEHrqASZBu1d0HelOcJ6w94VpcQKrM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732194348; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vbHbtaOmV1orf2NIzy2AVLS0dKvaT89ayWV12h5mB/0=;
 b=YPsal2yLHhYLSihHWkPFDtl6kXsh2u33HrSl051KZJBSg+6adfOEx01wP+K19iW7Oi0ey
 UtMEpoUrzJChyNri6pguBsg1oM9wVJwjoRsxjYCN+T3PkwhQYu9AlEFKnwdVGbsxxWe6bq5
 nV2KdOktgSVtIOpyiwF1M1FGiKztBtQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B8F6781B6F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 14:05:33 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732194333; a=rsa-sha256;
	cv=none;
	b=StwRijKk92BUvDRuDrDdAdXmYij2B+B1sJQZ0rv2DUZVQ6QkAMC36pyPuQ2nStFhxuhogF
	zUDNrtgYCHv11zRhRmVu/crQdo/oQyHuwxnXlLpfh2XSvRwbZf0WPD6Vi5O1tiFYXHrn8x
	lnjK6QAgCBGCk6D1T+kyI3G66a19tLU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b="GOs6/TxR";
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732194333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vbHbtaOmV1orf2NIzy2AVLS0dKvaT89ayWV12h5mB/0=;
	b=In/66Pn4Yrw2SP14ewBKoy9jDi6aITJb3xlokfElLlfsy/AYBqWVX2mn8cr0SqRsTN4jzf
	Q1i9/Wp1ZpONRN7M8nfIyJ87qqUV2dAz161nR/CC2J9B2GZcD+yTEPLCjd1dZjI49SLKrj
	F9WW7UmFiVThRuUJD2hClGZ2Be/3S7M=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 681054FAC;
	Thu, 21 Nov 2024 14:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732194333;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vbHbtaOmV1orf2NIzy2AVLS0dKvaT89ayWV12h5mB/0=;
	b=GOs6/TxRYDkhMOQfrCPE0R/BEMOzdOSzzDo0phYVbPHeOK7z/RaRUFYonXfEmwG5
	bW7ghed3ZCG/6Tw5d9dud42f0/Pkenp3iuwnMtXVfYUdVdu3D+YlqcQ6XHV9gaBZQ2H
	6K2HSWYBNiqpKi+vJyMLFFMJoMtC6NDPG3Ox1lJRxheEpn1RXPe/7seGvRoGTsJ6g0R
	Q1Rv6K472FsUE/K+Nzz9yBLoFlaHLlCf61zN0rJv9rtzzLuj5f/22Bn/u4Z/BI/8Yy7
	iOT4AOM22isaib5jWUkLv/5AqvwrU5dIbTTzNPfIZqEsh3X/aXOjhJx/cVmUejyENaF
	SjhpPSg2jg==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 21 Nov 2024 14:05:29 +0100 (CET)
Message-ID: <bf055638-afff-40af-85d7-dfdbf0afa842@unstable.cc>
Date: Thu, 21 Nov 2024 14:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
To: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
References: <cover.1732124716.git.repk@triplefau.lt>
 <fbc17f32703930e711353d82146a916106acd2f1.1732124716.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <fbc17f32703930e711353d82146a916106acd2f1.1732124716.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: NK4JYF3ANLFZQHCYL5SMABCINSLNCUY5
X-Message-ID-Hash: NK4JYF3ANLFZQHCYL5SMABCINSLNCUY5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NK4JYF3ANLFZQHCYL5SMABCINSLNCUY5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 20/11/2024 18:47, Remi Pommarel wrote:
> The number of TT changes can be less than initially expected in
> batadv_tt_tvlv_container_update() (changes can be removed by
> batadv_tt_local_event() in ADD+DEL sequence between reading
> tt_diff_entries_num and actually iterating the change list under lock).
> 
> Thus tt_diff_len could be bigger than the actual changes size that need
> to be sent. Because batadv_send_my_tt_response sends the whole
> packet, uninitialized data can be interpreted as TT changes on other
> nodes leading to weird TT global entries on those nodes such as:
> 
>   * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
>   * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)
> 
> All of the above also applies to OGM tvlv container buffer's tvlv_len.
> 
> Remove the extra allocated space to avoid sending uninitialized TT
> changes in batadv_send_my_tt_response() and batadv_v_ogm_send_softif().
> 
> Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>   net/batman-adv/translation-table.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 2243cec18ecc..f0590f9bc2b1 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -990,6 +990,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>   	int tt_diff_len, tt_change_len = 0;
>   	int tt_diff_entries_num = 0;
>   	int tt_diff_entries_count = 0;
> +	size_t tt_extra_len = 0;
>   	u16 tvlv_len;
>   
>   	tt_diff_entries_num = atomic_read(&bat_priv->tt.local_changes);
> @@ -1027,6 +1028,9 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>   	}
>   	spin_unlock_bh(&bat_priv->tt.changes_list_lock);

what speaks against acquiring tt.changes_list_lock before reading 
tt.local_changes? (and making sure the writer does the update under lock 
too) Any reason for not pursuing that path?

That should guarantee consistency across the counter and the list.

We could also have the situation where an ADD only comes between reading 
the counter and iterating over the list.
In this case we don't send random memory, but we still send a somewhat 
inconsistent changeset.


Regards,

-- 
Antonio Quartulli

