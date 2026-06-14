Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABB2CD98D2
	for <batman@archiver.kernel.org>; Sun, 14 Jun 2026 08:58:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3666584306
	for <batman@archiver.kernel.org>; Sun, 14 Jun 2026 10:58:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781427480;
 b=R8zNAmyPCPnj6E8q/Qq9IAEGXvC4WkV/LAylLC20UOUdHfWdHhZWEvGc3D1iZV2/ze5xF
 IkxdMzPsB6bmEwWJB6CHq8biV4O4xqg4Jq6NJx69JAYt/rnZP3URQQJwaf2IWdof9GlfEgB
 JNCNddS9L9EMRnazDApfSFUmNeE/eos=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781427480; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/Yf74XCAqxb/EhjRhJDOhBrOg5DxLKG78TC6IHzJkGs=;
 b=aJ3rtAhBJzNvOg/TH9Nh03qcN5bpDU1CqjmWH3mH/fZAdm/vvlGJYMy6Lnje7CPkJah9l
 8LCCfiWrkS9Ow/GcxrQ31JVcvLV94ERzPE7wEF/lnKgKgG8o783LBPqmhXDdALacczxBMBI
 FVKqvsXg+CNCLTsw2fmYgFO1C5gUVc8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 58C6D8029D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 14 Jun 2026 10:57:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781427440;
	b=DdM/msr9q0PnjOQzwLz9nbNbuBumaAgj6a6gDzXt3GFVp3nvvDo1Y38CYtOswINcuQeOWV
	7K5oJ6wu0Y5BFHoEre0nNA+3CcD2mdy7wzOX8PB8S1gfUpwfXhuyqnyAysnSyfdXAvraur
	m7Rb+PB46oxhl7jFG1slZPR9dkHOuZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781427440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/Yf74XCAqxb/EhjRhJDOhBrOg5DxLKG78TC6IHzJkGs=;
	b=ztPh4ajQN1U7Lajz5ROVjowWbm5Z+OoKKgQQL9xbYL2nWLH8/uKA+T/o+3V2Q6Mv/T/BG3
	z3NwFsN7CtOfnBh4vV2juDDoeuXS+0DEim86d6qKYdhG9LYGgeJN0NEGmVTbc9zkBe/5Cq
	bV2o1iR7AbmCUKfmqaUxDSWLXOT49hk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="iPCV+/CL";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A56D61FDC6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 14 Jun 2026 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781427429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yf74XCAqxb/EhjRhJDOhBrOg5DxLKG78TC6IHzJkGs=;
	b=iPCV+/CLexWqNtzzoR1SSFgoVSqen/1xkRboJP3Kcxejb7cvq5y8L87Gk+sISkmbCNxEAu
	VeOjs5Y2K2fehrCi/u/VdxlwwOvqnjLkgqGcerrgMFIZcehc+O2Wk9DvyFz/pHefOSUboV
	EEvUn/RDfdSjnk242n91e9BA8kDFI9o=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: tvlv: enforce 2-byte alignment
Date: Sun, 14 Jun 2026 10:57:07 +0200
Message-ID: <12932148.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org>
References: <20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6021326.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: ARDP77XQAG4UM52SZES6WS3OXJZV626S
X-Message-ID-Hash: ARDP77XQAG4UM52SZES6WS3OXJZV626S
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ARDP77XQAG4UM52SZES6WS3OXJZV626S/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6021326.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 14 Jun 2026 10:57:07 +0200
Message-ID: <12932148.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org>
References: <20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org>
MIME-Version: 1.0

On Sunday, 14 June 2026 10:19:54 CEST Sven Eckelmann wrote:
> The fields of an aggregated OGM(v2) are accessed assuming (at least) 2-byte
> alignment, so a following OGM must start at an even offset. As the header
> length is even, an odd tvlv_len would misalign it and trigger unaligned
> accesses on strict-alignment architectures.
> 
> Such a misaligned TVLV/OGM/OGMv2 is not created by a normal participant in
> the mesh. Therefore, reject such malformed packets.
> 
> Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

batadv_recv_mcast_packet will be added in v2.


--nextPart6021326.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCai5s4wAKCRBND3cr0xT1
y3oYAQCDMJBITdYQN4vZgcLo+crQ7Gy5Gr857eLsyFLvVF15AwEAr7pWjyzTJ1Qa
rNuBWJJNrmNrH0BoQESuxP9kAnM7tAk=
=lXSf
-----END PGP SIGNATURE-----

--nextPart6021326.DvuYhMxLoT--



