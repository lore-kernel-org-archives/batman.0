Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3070E7717F
	for <batman@archiver.kernel.org>; Mon, 16 Dec 2024 20:51:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D5E9483E5E
	for <batman@archiver.kernel.org>; Mon, 16 Dec 2024 21:51:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734382294;
 b=vdIW7+fy3z5rRt+MneNDhRlESCOKsurCtKhMbupxkl59Ufmc9VOyklcsTIEYE5/iUsgDE
 2rhp0q1c+H8Iz0FGuUkmeiBWYudVZqRrhExBLqRIHRTrZQIStWesasP9xLqNAtUHYQ9j8rV
 wuZTuPkYiqNSv+5DaFtFuDpMCNOPXoY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734382294; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fJrzNWB/GZNojiwHiXx7mMMWn5o9DJb85YqLrKWNCRc=;
 b=J9ZyAbxP6cvNcb1NaCw092b6nefwSupBvMFd7zWxLsbGjTHz6Ktn0/xiqGA9u3YVUPF/v
 XAaD/0pgAk/xoHJP68SRLqercP2brrjt86bR87tqwWmiOEJaKerHFjAHXu5MOzsVUdTZo+I
 DFP+CnvR133t26jE/MN18rowCmTjOes=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 015EB815E9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Dec 2024 21:51:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734382271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fJrzNWB/GZNojiwHiXx7mMMWn5o9DJb85YqLrKWNCRc=;
	b=seK8QHGA79Q3A4HbEUTald2IHdfiVvKiNVOsWXDNw4bE/KaxtG5HrqoiF4icFWldX2mfri
	cDIbcj5kEfHpvws6cYAaznE4zMVh3whXoVXLM0b47WLu0ailRWOg+qfM3Zx9kGVb9ATiL2
	o8/qdVLeE1KaGc6Ck/jh2S1L8fGGyh0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734382271; a=rsa-sha256;
	cv=none;
	b=ipgzavU1Gh8hVQwHn07Lb5mFh44Xjn05paOfvIJTuaugOz+VSKHOnEaiF4KTce+nAwT91F
	5kMkMv8OtwEfGG8hDsiB4g2xqVE88ETKEa4RG419NmWiOIrfkMGiX7Z1XgVqf+wuQ3qSmQ
	1pJEv8yxaSu4jtlCPCFH47zd0T6kOU4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=ZiQE7vFn;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 8A5EBD3A;
	Mon, 16 Dec 2024 21:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734382270;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fJrzNWB/GZNojiwHiXx7mMMWn5o9DJb85YqLrKWNCRc=;
	b=ZiQE7vFnt2mPqwV01JDvRd90VIvLRLGQqIcmvTO0469jP7Q0+vClFeh/nJFSShQb
	i6zlkEVo8kA3Cn9OVAWSctCh+JfOKx1WfmuRDZ92z+uHUTo8uLHeEFYZlijdWdJXVXw
	w8ou3Rqw//u67d32y9NMcIOtd3jpbHV+Ku6MUaPXKtEfaCkgmV+kasPOuyXATs2/oXe
	PM2Q8vRsRovEIdfxwHUjGD+rp+rkOyiyVk8YnhRj2zTVVwnW8FIgUC64rTJUqQmZYZr
	SYOmPFYLIWrsB1SCMqm2Y3+JGOq6jYF1F69Vt+38O+o16XsxMNO0r5OmuarrnMQu2OC
	Opjv50yHUA==
Received: by smtp.mailfence.com with ESMTPSA ;
 Mon, 16 Dec 2024 21:51:08 +0100 (CET)
Message-ID: <b885662c-3ff3-4ecc-bec8-55421bf600ca@unstable.cc>
Date: Mon, 16 Dec 2024 21:51:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] batman-adv: Map VID 0 to untagged TT VLAN
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: XSKF4Z7JQABVLU5JJH7XLFZUKC2AK2HS
X-Message-ID-Hash: XSKF4Z7JQABVLU5JJH7XLFZUKC2AK2HS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XSKF4Z7JQABVLU5JJH7XLFZUKC2AK2HS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 16/12/2024 19:37, Sven Eckelmann wrote:
> VID 0 is not a valid VLAN according to "802.1Q-2011" "Table 9-2—Reserved
> VID values". It is only used to indicate "priority tag" frames which only
> contain priority information and no VID.
> 
> The 8021q is also redirecting the priority tagged frames to the underlying
> interface since commit ad1afb003939 ("vlan_dev: VLAN 0 should be treated as
> "no vlan tag" (802.1p packet)"). But at the same time, it automatically
> adds the VID 0 to all devices to ensure that VID 0 is in the allowed list
> of the HW filter. This resulted in a VLAN 0 which was always announced in
> OGM messages.
> 
> batman-adv should therefore not create a new batadv_softif_vlan for VID 0
> and handle all VID 0 related frames using the "untagged" global/local
> translation tables.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@mandelbit.com>

-- 
Antonio Quartulli

