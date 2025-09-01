Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A3CA0FF0
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 20:39:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C56F6840EB
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 22:39:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756759182;
 b=wQNO4AZEN645O19DJPHjs4C8eStxVBboC1H2DZk5MVD5pWi/REbXbCv+WLJkjFSc3YNTh
 K+Jii3sc+vt7Rq43Bmovj7d80I6YIgtaMdMipZXdushWn02tK1cf8kAJXwD+FtRSqH3LcWo
 LyFNPsjrHilQZskuwsfeTo0/mPL2+Rc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756759182; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Bmd0QJlyRS4QfT5M16IkRJic2g8i5Yh+sxl3pz+3TNg=;
 b=D+spDNouOmkSWPdEMmWUqUpTX17IH+WuxU0gVe3jtha28A0coexQHpzik6O3AYLMOzumM
 SurTsCncKhRLJcfCobs6rfRjA9Ozc/Q1hModFaSQy5kM+bvFuamZNnPdMbBdqVg6rDe2+2u
 n6T3+PjnWu5ybIi6SxNa5Lz1MXWXFYo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 62B0883C7D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 22:39:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756759166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Bmd0QJlyRS4QfT5M16IkRJic2g8i5Yh+sxl3pz+3TNg=;
	b=j2oCn/sVb0NB+zTRhcAkqnqmg26kacOsTpmBJa39Y+19Umk+9W/mtXVtEs4OP9DXj5XBk5
	zGXirdDFAeouH7ouA5Vcsmm0/hZoyCapQKtZEzZpRR2jrFvtPiIuJVCnFnM0yqMmX99sVv
	SYA7K7AkZSmSXf93UblctSkOOJeJSS0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=RDIa+XYt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756759166; a=rsa-sha256;
	cv=none;
	b=VlfcezkLZUjH8+EcclBguEFu+3MLli7vELRtVXXAkq1cO4fsIadhe1lW9BhgQrQwUxY/OA
	QfEL5GV8l/5rXYSYNgPP4qBNapz9xjWMDvvN3PrHRLbW5xMpcPA/nvKDpUjL81/+6WHbUz
	sOqMahBZcmFpjWmv9RUVdo0dEpytA+Y=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C4C4402B8;
	Mon,  1 Sep 2025 20:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14516C4CEF0;
	Mon,  1 Sep 2025 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759164;
	bh=kyPttvyb+3E4rj7S99pOS+EBRH7mAuYA3d/9s8TmZe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RDIa+XYt1/fM2GzjX4Q7/CaU3T6ZsOVuvRb4utLjO1RModJ2SdEisjYBHGl/Exc4g
	 SFvv1tFUgFjoT1B3i0XyvAGl4e+VFhgMF+DmOBiX0ZcWwxKwd/AQc62YdbkCWXH0YJ
	 GcYuo0YWhk9+Cu2Oiw+2w+xLLxV9TqI+qXiGM/hB9nrPyCJUtZr7DcHVQDaeGIdpWM
	 i2h5VDGIV4WkXNploSfz18rfv0ofshb01Aa+BKRG9PG2SWnBBBNnmFb2R+xRMM+1F0
	 dAnyPaX98Ffijhu2h8iw0PUUFdzr2Nxkofvkvps+g++hlTk/vsasjeRx94SSvwCf7n
	 8cd+c1oGR6lcQ==
Date: Mon, 1 Sep 2025 13:39:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 0/1] pull request: batman-adv 2025-09-01
Message-ID: <20250901133923.5a06d3bb@kernel.org>
In-Reply-To: <20250901161546.1463690-1-sw@simonwunderlich.de>
References: <20250901161546.1463690-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JJUAHD63XF6O2PHJHMZUKH3762A2I2TI
X-Message-ID-Hash: JJUAHD63XF6O2PHJHMZUKH3762A2I2TI
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
CC: davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JJUAHD63XF6O2PHJHMZUKH3762A2I2TI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Mon,  1 Sep 2025 18:15:45 +0200 Simon Wunderlich wrote:
>   git+ssh://git@open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250901

For the future PRs please prefer http(s) urls
