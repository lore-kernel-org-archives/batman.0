Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80550D743D0
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 19:56:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 005A184029
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 20:56:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732132578;
 b=rLHunc5t3Z2e04sIYFdwTr+4jpTGmz8shXx6X4txWonqRr0YwhOJYp53iAzs+ea2X1nGD
 BfMqrrbdhCcdegldhjDr6/sCl8UtPkNBlpLO3GUPAWxgXtI8FC1/5X44XH7K0DMAEINAJES
 7jnXZiMn3s8yJeabPoOyMp2BdXqg/eY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732132578; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uTiafzdZIJKg1i7uCkZnqY6R2u3aRQIP06xAsYRf9aY=;
 b=Q3RPnMDcCx4Cy2OqT2Z02VOSI+p9VNK2ldD7k383b6s46mzSh0TWqkFeDeCm5/ratvDgp
 aIeWp7q8inzrSLfkWOuJ0tDPoSZ7f/JIwIn4/sQYN1zzUSW0yFTI0Aagj+QYKHZvLBT/Hu2
 ae+k63JAWPFTLnnbwC64cAp1xLfO6Y8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E53A981F63
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 20:56:06 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732132567; a=rsa-sha256;
	cv=none;
	b=TLqxcsm151G2cluZIyVEgtzBOdPstQJtDjQOgdDmDD1+mtTxkxxfFIcE0Sf/mtz3bt8w3B
	zVYTBFADChLHG+K2z5fZJj8zHc+8PB1Bc6KxcTSq8nkYYYtaPkrcn2DL+JsK9kXeWMq8IQ
	g70rCA+2T/Y4hCCa+uPCUs8mPILBAzg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=Dua5KGQs;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=dTICgTVX;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.wh49m9zi5lt3293=adqisscduwqe=sdiumpy8488tff@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.wh49m9zi5lt3293=adqisscduwqe=sdiumpy8488tff@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732132567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uTiafzdZIJKg1i7uCkZnqY6R2u3aRQIP06xAsYRf9aY=;
	b=jxfQhkaFgbZdm22OlRsThzUz0sW3DuhBBGLnZ9qQ/uU4NZeti8MuPrx68CwrYHyUZW/ke4
	T9mKEqeaPuIi9cSP3n+fzTtiEtAvtcOm54xkZO6Oudv7msbhEhhCK04DwMdtm45ueZnsZ+
	TFdxVDa8Qqti6YgnPJuobHS+IP33BZQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732133466; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=uTiafzdZIJKg1i7uCkZnqY6R2u3aRQIP06xAsYRf9aY=; b=Dua5KGQsBvp2x1FojyTOxKZ9xC
	Nobv58ETro/to/pRxbwUfP+NE9XHpYt22bf4d4KWBCVaq7Y+q68gbJtt0ycqzJSOcfUrjUssqs3vZ
	9+ws5k/UhhqXBj+a1Imyt3CkWXj9mivWYxheNrZk44ppjUtQ4IGsOnPD1ZZ7LGcC6ADo9NiAQXj/q
	5aebWffJWkz9nwUr9YH/cu4M94SWtZeIAvQvrj8xfLyXx8z8vRQtGrlr8TedG73fiNZ1CAnF9fcBp
	7jBzpYrIkJtxvVSogaWinIvIx8pg2sWjU2HJAYwdP2v9HtXLUqRNYtH1PFjJpQ38y8w2jZVrVSVhE
	ctGTGXrw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732132566; h=from : subject
 : to : message-id : date;
 bh=uTiafzdZIJKg1i7uCkZnqY6R2u3aRQIP06xAsYRf9aY=;
 b=dTICgTVXxKhWzXS1ja1UDCt7CUvHTqY8sbgIOgo/cQVLUe6BcxcjYgy/QAHB/Er5ne3uu
 nPREcXhM4Wn7A2RgtqqaxmvF+86HDbs3ikV3ZCyEqSeYBWIV6FC/aqNUxtWgVRVCDiIsLIF
 ihYzb7gd1otEGslzBXLK718wk4Tj0dPr6PbxXFCV4DYq4mtCOYMEhWPsodCKCtGXAHeFx5g
 wFRgULydu0yDtfov9l3gbRNGBbhvW1MthetDOUj3TJftf/Y5bHJo/LGupPCWWGcaO+avyOh
 fm0Z7bW8mzEd19B8dMFzZfZwJoiqF4sO18a076Cdjp6z9RU0GvmEjmPhiOeQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDqnr-TRjyyv-GA; Wed, 20 Nov 2024 19:55:55 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDqnr-AIkwcC8tK4u-HlAA; Wed, 20 Nov 2024 19:55:55 +0000
Date: Wed, 20 Nov 2024 20:54:49 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Sven Eckelmann <sven@narfation.org>
Cc: Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v3 0/5] batman-adv: TT change events fixes and
 improvements
Message-ID: <Zz4-ief3zxThRJGm@pilgrim>
References: <cover.1732124716.git.repk@triplefau.lt>
 <4969949.GXAFRqVoOG@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4969949.GXAFRqVoOG@sven-l14>
X-Smtpcorp-Track: McJrNLJg9Gfw.M9wCOKiZ3Wfs.02kvkAWy9un
Feedback-ID: 510616m:510616apGKSTK:510616s6mRG49i8X
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: E35QUZ2NMK5MGRW5HW36R7MTSUIJDME5
X-Message-ID-Hash: E35QUZ2NMK5MGRW5HW36R7MTSUIJDME5
X-MailFrom: 
 bT.wh49m9zi5lt3293=adqisscduwqe=sdiumpy8488tff@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E35QUZ2NMK5MGRW5HW36R7MTSUIJDME5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Nov 20, 2024 at 08:46:12PM +0100, Sven Eckelmann wrote:
> On Wednesday, 20 November 2024 18:47:13 CET Remi Pommarel wrote:
> > The first three patches are actual fixes.
> [...]
> > 
> > V3:
> >   - Fix commit message wording
> >   - Update outdated comments
> 
> Antonio, can you please review the patches? It is important that we get the 
> first three out early (to avoid merge conflicts when sending the second part). 
> So maybe you can have at least a look at the first three.

If it is more convenient for you, I sure can split the serie in two ?

Also just saw that I forgot to remove the "a" from "a creating" in the
commit log, sorry about that. Do you need re-spin for that ?

Thanks,

-- 
Remi
