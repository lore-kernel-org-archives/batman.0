Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6619DD16251
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 12:16:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C583F83D16
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 14:16:55 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728908215;
 b=f6+2EjbGSHRcJOwMK8fMi2sO2CgYu1BR0p3g22NoffTOQEXMiXojg6nUBfyOanOHGDjP/
 B/nDt/gLZ+gA3bK9Yp8JrMyZANm4ln/V+hyfsUbQsOnIdUFPA8jFs0YuMlOuyctjYUk10X4
 VbCpNKOxDrI+6DN1IIIzFObM2flKTMc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728908215; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KE+1RV7m2FOGPLNhNSEGqdDGgzbjlAE85XtRMREqhd4=;
 b=hJRpsSnNPo57jxLTcYg8oxjDxB4/3HuiLYzBSDfQARwAVkkkTA1TIc/wTaJPyA0OCRkr4
 0/VK0CTASoeaSnIlQTJRmtP6mPMTzQw54nhDBrV3hy27vVkP+FhQ1mKEDOj82DN2WT8KHeH
 jBdAYmFiTsy8vEF1LafOzPQHPzLzbVo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail;
 arc=fail (ARC-Seal[1] did not validate); dmarc=none
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org
 [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E5033815FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Oct 2024 13:26:06 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728905167; a=rsa-sha256;
	cv=none;
	b=xpocKW3+HzkR7CTdq/prVrtZH5YYU2pXWTZImVodOM0jXOquLwsZEnZkOL7hRvOZt7au3P
	thtQ73t/53jze1qgOP+ci1ugLXeF2bg7psKB/hvzvc7P0CQugHTDHsnr1B3/iAbd71gM4V
	+VWo+Vc9iGB7IWlYdBzH3fI8i8/Ppeo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of pablo@gnumonks.org designates
 2001:780:45:1d:225:90ff:fe52:c662 as permitted sender)
 smtp.mailfrom=pablo@gnumonks.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728905167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KE+1RV7m2FOGPLNhNSEGqdDGgzbjlAE85XtRMREqhd4=;
	b=Or5uQLFzzwcSBHkniDg3SafuFD2m0pXD3Sb1//47IBnkZQyJlnHC1902MWJ2vpEpgB31AO
	Gl5P3m18aL/JEDnUNw9GGDqrjnMqEe4sUb7cOZdNJ6D2rjvIqob5472Uf57vv1/5dHjva0
	Yiz/kRFqG+7fSuq35a+aK1S70UyaWNU=
Received: from [78.30.37.63] (port=43780 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1t0JD8-006HZk-B0; Mon, 14 Oct 2024 13:26:04 +0200
Date: Mon, 14 Oct 2024 13:26:01 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, paulmck@kernel.org, Tom Talpey <tom@talpey.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>, Neil Brown <neilb@suse.de>,
	linux-can@vger.kernel.org, bridge@lists.linux.dev,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	ecryptfs@vger.kernel.org, linux-block@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 00/17] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <Zwz_yU8PnqU9Ngg5@calendula>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
X-MailFrom: pablo@gnumonks.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: BD7FM6GZ42BPBQ347P2BTDC65LRAD65U
X-Message-ID-Hash: BD7FM6GZ42BPBQ347P2BTDC65LRAD65U
X-Mailman-Approved-At: Mon, 14 Oct 2024 14:16:52 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BD7FM6GZ42BPBQ347P2BTDC65LRAD65U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Oct 13, 2024 at 10:16:47PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.

Applied and squashed into single patch for netfilter these patches:

[17/17] netfilter: xt_hashlimit: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
[16/17] netfilter: expect: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
[15/17] netfilter: nf_conncount: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

this update is now flying to net-next.

Thanks
