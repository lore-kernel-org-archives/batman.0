Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90FE69173
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 15:57:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 404C284470
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 16:57:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732291064;
 b=Ba8+1VLJQ0m6qqPCFLbPKt/f0Nq2TdPt30Z5ESH4jvFFsQcAeEPwQ/MjuPFEHoVg8ZvED
 u5CLrzEBmU+oJ3qVSGXBGtr5uLWcxsGEdkA1p6Ow5aX0Jt1W/dgGFeW4UlI8wZpwsIdowmr
 qE1fveiCqEvb1y4ELjnMwTRR9Wgl6c4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732291064; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YtFUJNAvYoUVakj/j0QzyqvNJ/KXq1RXJI8zy3wg0zg=;
 b=S6GFY6xXWfgYpi5g/8Q7y2bBSt+T5AiWpb3qLhZj41VUHgiyeyBE2uPDQVN9j8PKP2Lvt
 hsF4QLI41Woju30cgrNeD8QVdIHfPH07ez165nV9CWUg1E9vOPtwnv/M8FbcfALHpT9H763
 DSrDlRczrw1kX70vPezY7dKvqJhrhsI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 79F1984546
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 16:56:44 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732291004; a=rsa-sha256;
	cv=none;
	b=FUyyUq2zzcRUKAf9Z1xYgaAVGkdWeu9es/McQR7MamaBOp1CJGREhKGQsW3qISLEvayLWa
	REvnjIcD6HGo2rfhZPaX1LWSVLhI6G0ycJ1hEwZqbOI20XDfAdZNF4kAmCEPWD0YdSt3z3
	Lk7ZboEBn3xrRgNzyhsualzOMpFMZA0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=R17QDH9g;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732291004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YtFUJNAvYoUVakj/j0QzyqvNJ/KXq1RXJI8zy3wg0zg=;
	b=G3EcdcxpI/o/BDXhrPpIDR4rpL5eIGv8ljQxnDF3gejwPjZLtX627i0qs4QqF6kMoalOct
	mz/smz7Jp/lJRpwNQRBd4vav3cXXcGlKD4XhjwfLqzmKpKX6KutIR90JmEqOIpuYc9U+g9
	rmxcUdQ2czyWdCXRjA3qA4sw9jxavFM=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 1AEC01384;
	Fri, 22 Nov 2024 16:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732291004;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YtFUJNAvYoUVakj/j0QzyqvNJ/KXq1RXJI8zy3wg0zg=;
	b=R17QDH9gemXLr9GTkQPvbc5aMQEqkzxFiMeUwX+a6JvX3kMyBFVaRnBmGb6d3Iu1
	WcZIaIHRAkKH1erZQW11HmTOVRwJSmVS4dYkqkh4YmpsdLQlSXPXTOI7Bpp9Sn3NvTt
	9q9pUA6+oUFNHR6L3vBOW2/oG1nt/+mjCeKuFUOevDYNdRwWVcN/Nsi3hMOoGp+8R3v
	8nDTLTKS8FoPv5E1PAVWm1XrRX0DPNvZSlS6xWkqZ3WPw+G7kAanpPzubijS/2pg4nd
	6LK2Z9FwvOjE0jw809wz/DnX+RtgTJ6bFVEzblqNXoYiAUDvSd5MpEXWJPp0fSQAo9M
	IGat7nEUOw==
Received: by smtp.mailfence.com with ESMTPSA ;
 Fri, 22 Nov 2024 16:56:42 +0100 (CET)
Message-ID: <b017b05b-eca7-4ee2-9cf9-c56fb4baa525@unstable.cc>
Date: Fri, 22 Nov 2024 16:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] batman-adv: Do not let TT changes list grows
 indefinitely
To: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
References: <cover.1732290614.git.repk@triplefau.lt>
 <7a8b08f7c9e63281cb4dbc6d43926ec5e953a306.1732290614.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <7a8b08f7c9e63281cb4dbc6d43926ec5e953a306.1732290614.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: QIZ5ICYBLVSGFPWZ2LEQ2RU5UQRM2JBS
X-Message-ID-Hash: QIZ5ICYBLVSGFPWZ2LEQ2RU5UQRM2JBS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QIZ5ICYBLVSGFPWZ2LEQ2RU5UQRM2JBS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 22/11/2024 16:52, Remi Pommarel wrote:
> When TT changes list is too big to fit in packet due to MTU size, an
> empty OGM is sent expected other node to send TT request to get the
> changes. The issue is that tt.last_changeset was not built thus the
> originator was responding with previous changes to those TT requests
> (see batadv_send_my_tt_response). Also the changes list was never
> cleaned up effectively never ending growing from this point onwards,
> repeatedly sending the same TT response changes over and over, and
> creating a new empty OGM every OGM interval expecting for the local
> changes to be purged.
> 
> When there is more TT changes that can fit in packet, drop all changes,
> send empty OGM and wait for TT request so we can respond with a full
> table instead.
> 
> Fixes: e1bf0c14096f ("batman-adv: tvlv - convert tt data sent within OGMs")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Acked-by: Antonio Quartulli <Antonio@mandelbit.com>

-- 
Antonio Quartulli

