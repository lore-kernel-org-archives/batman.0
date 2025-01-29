Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DFBC02192
	for <batman-adv@archiver.kernel.org>; Wed, 29 Jan 2025 08:36:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 00B5B83EBB
	for <batman-adv@archiver.kernel.org>; Wed, 29 Jan 2025 09:36:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738139764;
 b=wmUMuLqCt6Ig3EgD+0X7EJpGgyNuQFEK4AMoceqEXODA50kUW0L0skLZyiJURccMyGaBk
 B7AtO7dw+ebR8kUPOX9F06GNgchM9Ti+okdn5JolWIkiyX/uIO4vlIlV3cwvf62j+cQEHbG
 TbY79ZE+CwQ7rfWWx9R8h+uPMOhSPEY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738139764; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
 b=GdhYcOlfdbsiaMHf47cOqMbZqBxXhiVNUdoSiRMn75XryHMCxty/X2B1XyVcXov4brMCv
 eF1Fs1AL/LOmUyBY595kguKTxDVpLI0qLYT4UmstIQxr+960dCbIxvRTxRt/5j9zTPtfA47
 2450Q2C7drrbLldOQko+jLlh/Rg8/jA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9DA9281F75
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jan 2025 09:35:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738139752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
	b=3x3wfo9oWSAWbNCwthW2bXK0JrRVlXapTSw2/tOzwFokwuP0bGUYjv0UhSiMioxkj6F6p0
	pGWj84vgH3237IvSVBa2z/x8Ku5d3FzpS8PV8nX1joxn/DXi4xBXMs7r7KenvXqkxm8mk6
	3evrP7D5yPuTmplsNkVCPNUWzwkdTrk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=smtpservice.net header.s=a1-4 header.b=VzRSWsFX;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=aZixvBhe;
	spf=pass (diktynna.open-mesh.org: domain of
 "bounce.fqii8hn5160ifw5=2xn6vtz9y7j9=s9mgcg0jm9gpsx@em510616.triplefau.lt"
 designates 158.120.84.103 as permitted sender)
 smtp.mailfrom="bounce.fqii8hn5160ifw5=2xn6vtz9y7j9=s9mgcg0jm9gpsx@em510616.triplefau.lt";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738139752; a=rsa-sha256;
	cv=none;
	b=AiuWR8PUG7htk539ZHwo4gHuiuJrOe+tYL48F6UCzdHY4/gUzm3ncWvsFz0VEmkpHJ/J0L
	GL6g1qB7Z4/N8KWPD19y+NUeXFumS4OPOJJ0AerWzGtcj0vqCbSOLwpfPOJW7vPP04TdfJ
	cMP5UAFiGyADR/7lWM9YxXByHKUZhHw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738139751; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
 b=VzRSWsFXcFZ/EcmCPtupNSH/v83FVCyQQyksjPD11y91a9/XO36ZuPzkpUC/W+Hh/Six+
 JfPy8dW8ytfa7dCkWZktaGM4XvmXMY7JE8iK4dgg6N5YsA0egXCW80SWNetzeXW5c6XOfhY
 M3xukBRZtz3QhAjSTH8fWsmVgSUJiAy1HbXAyndbj7Jbux8YItpMKdihCP5ZALOwNMn152O
 4YQuwEsdCBRdfsZKS9y5bvjLxefkyJQM+FP/PmB8c5uoD5f3JqRq1TGepkT4U/kGbilmmtU
 +5opKl4pTiy0bpo78FL8tA+12ESYJFUTuXM/THeb5f9NpoYwOcsPGFZ2SoQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738139751; h=from : subject
 : to : message-id : date;
 bh=DY7ub80gYd9tjBAAYJLj+o/B1grhiHlqArNUfs+UkGE=;
 b=aZixvBheo0rCRQZlMZgxfzOCwgXF0Snt8bo9q7OnnhBroE1uGoUhp6qxXz4w/BTfsLWpI
 FcyzUcok+MHdGycBQCHUxWUbPE/YSW0SbHrTFH5D99dLj/9i11MvdV0n9cdMW3vjJ1q+7X5
 0ur/6y3degFsizan+JrhP5oezCGq3l9THcDd/IJU687DfjXSaZSOAZzoD4p1fEnn5MosEtf
 pAyeA0s2O3r21NcBf/U5D7iwiLobDnFBI8IuXXfxxJ+JinTT1vvUplO1wGGVuwvw4yGp+TY
 RPn7cAw5c9JmkZ6C3yWP/vJL7xAx8VWF9w8sfrCpp8+kUdsYF1VV0ctU3ROw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1td3Y2-FnQW0hPpfXA-ln41;
	Wed, 29 Jan 2025 08:35:46 +0000
Date: Wed, 29 Jan 2025 09:32:02 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Erick Archer <erick.archer@outlook.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Message-ID: <Z5nngheTbToYRJFi@pilgrim>
References: 
 <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
 <2593315.VLH7GnMWUR@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2593315.VLH7GnMWUR@sven-l14>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616skYQn4pg0B
X-smtpcorp-track: f0h8_L0m20HU.0WyNcPKOHdzk._dYnVQNfwI2
Message-ID-Hash: DVVAGBEYBY5XHJUMSJCF5Y54BPHN5B2D
X-Message-ID-Hash: DVVAGBEYBY5XHJUMSJCF5Y54BPHN5B2D
X-MailFrom: 
 bounce.fqii8hn5160ifw5=2xn6vtz9y7j9=s9mgcg0jm9gpsx@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DVVAGBEYBY5XHJUMSJCF5Y54BPHN5B2D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, Jan 28, 2025 at 11:18:06PM +0100, Sven Eckelmann wrote:
> On Tuesday, 28 January 2025 16:11:06 GMT+1 Remi Pommarel wrote:
> > Since commit 4436df478860 ("batman-adv: Add flex array to struct
> > batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
> > array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
> > invalid offset. Those TT changes are supposed to be filled from the end
> > of batadv_tvlv_tt_data structure (including vlan_data flexible array),
> > but only the flex array size is taken into account missing completely
> > the size of the fixed part of the structure itself.
> > 
> > Fix the tt_change offset computation by using struct_size() instead of
> > flex_array_size() so both flex array member and its container structure
> > sizes are taken into account.
> > 
> > Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> 
> Thanks for the patch. I just wanted to dump my notes here (because it is 
> getting a little late).
> 
> 
> Original calculation was:
> 
> 1. tvlv_value_len -= 4 [sizeof(*tt_data)]
> 2. check if tvlv_value_len contains at least num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 3. tt_vlan = vlan section at offset 4 [sizeof(*tt_data)]
> 4. tt_change = change section at offset offset 4 [sizeof(*tt_data)] + num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
> 
> result:
> 
> * tt_vlan = tt_data + 4
> * tt_change = tt_data + 4 + num_vlan * 8
> * num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12
> 
> 
> After Erick's change
> 
> 1. tvlv_value_len -= 4 [sizeof(*tt_data)]
> 2. calculation of the flexible (vlan) part as num_vlan * 8 [sizeof(tt_data->vlan_data)]
> 3. check if tvlv_value_len contains at the flexible (vlan) part
> 4. tt_change = change section at offset num_vlan * 8 bytes [sizeof(*tt_vlan)]
>    (which is wrong by 4 bytes)
> 5. tvlv_value_len was reduced by num_vlan * 8 bytes [sizeof(*tt_vlan)]
> 6. num_entries was calculated using tvlv_value_len / 12 [sizeof(batadv_tvlv_tt_change)]
> 7. "tt_vlan" is implicitly used from offset  4 [tt_data->ttvn]
> 
> result:
> 
> * tt_vlan = tt_data + 4
> * tt_change = tt_data + num_vlan * 8
> * num_entries = (tvlv_value_len - (4 + num_vlan * 8)) / 12
> 
> 
> The broken part of the change was basically following:
> 
> -       tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -       tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> -       tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +                                                    + flex_size);
> +       tvlv_value_len -= flex_size;
> 
> 
> if the line
> 
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +                                                    + flex_size);
> 
> would have been replaced with
> 
> +       tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data->vlan_data
> +                                                    + flex_size);
> 
> then it should also have worked.

Erick's initial patch was almost doing that but Kees emitted concern
that this could bother the compiler bound checker and suggest the
current flawed logic [0] (hence him in CC). I wasn't sure the (void *)
cast would prevent the bound checker to complain here, so I tried to
also follow the "addressing from the base pointer" strategy Kees
mentioned.

On a side note, I am all about hardening and memory safety stuff but
if that means impacting readability and spending more time trying to
please the tool than thinking about the correctness of the code change,
that's where we end up converting a perfectly fine code into a
logically flawed one.

[0]: https://lore.kernel.org/lkml/202404291030.F760C26@keescook/

-- 
Remi
