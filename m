Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F00ECAC5A7
	for <batman-adv@archiver.kernel.org>; Tue, 23 Sep 2025 15:02:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C830184847
	for <batman-adv@archiver.kernel.org>; Tue, 23 Sep 2025 17:02:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758639746;
 b=s7Wos0tDTrGYcQ3M1e9A4qmdAvH8DHkYM0VDPWT2nWj4HU+pus6SVoWW8K7ZgeSbQ09yL
 XEu++bHwltFOpZpWGY84OyKn9wYh47wCEFTNrS1hcEPwJ/GOm3aFjCgsF7YSlfRll75lAk8
 72KNcis2AfByTQ0/Hh6qL80brJC16+g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758639746; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dDVbKqKVUc5DmX8sOGrhbARykAzUGRNjOAhzic4Sfuo=;
 b=lVOgWXCD+NSrBvBbZLW62f27FcDluur693ndpx3dxfzWP0JS2LW2BPmJLENxFem8OLop5
 fXT1jwB+E3G1SLHTcHycO64s8xTeervrXxq31qvHGGHBHkDMsPO3EkSNGBQzoJJmIpV7ZkA
 4OqEV+urSh5+mBPExSxz4GSPCKSBRbU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 35BB984586
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 23 Sep 2025 17:01:39 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758639714; a=rsa-sha256;
	cv=none;
	b=Rmx1bCQ3+HyoiPqRXP4ccdjxXjA8qFD4cZZTHuVF6i3dnvAP+eiUtTLuj9rdD9voFWkxSR
	4Y9d3C0txBHkJTWKmmOvPZ+2db+gL57e6snLiB1iOwve68XkNvNXMOSvYsKZCmU3uQ4oPY
	5ZixkKyAbEuNyovZTShrkkTIQ4vY7+g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PXnQhrKC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758639714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dDVbKqKVUc5DmX8sOGrhbARykAzUGRNjOAhzic4Sfuo=;
	b=0wY64MgSu0JIyLfT/4f8T+tOw0R5PbfQjEhjAYpEhRGDnKOwxnQvTVaToe8zjFBjPsyzyt
	CitV80LJocszdsCJewbWCdkiJYeQzjQjkOxyV0xms+JojzpPFlI9v2nnaGgUResU7A5xlh
	ixyTxaIvPVd5sc0qGQY3AsUc+xTcnVo=
Received: by dvalin.narfation.org (Postfix) id 0D936202C0;
	Tue, 23 Sep 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1758639698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDVbKqKVUc5DmX8sOGrhbARykAzUGRNjOAhzic4Sfuo=;
	b=PXnQhrKCnFtYlmEDJzZ9+z3cE3eDa0vCOBrgIR6i/FKGZ8/9mHIlauZE2wNiDkXdP/AUkQ
	e7DlHM71Jjke3tSO8DUvl3ojTpZS9K4OQ0KVBwDchfi84RMqpNGCENkvy5KVwKvtpzaPYx
	wNnMlZoW5KNAGry6HnHCUq+Hphz2YFc=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 Network Development <netdev@vger.kernel.org>,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage
 count = 2
Date: Tue, 23 Sep 2025 17:01:30 +0200
Message-ID: <5043679.31r3eYUQgx@ripper>
In-Reply-To: <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4681830.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: LCNTYVCMIWUPLZDI7LRV5QLKGTCPICTK
X-Message-ID-Hash: LCNTYVCMIWUPLZDI7LRV5QLKGTCPICTK
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LCNTYVCMIWUPLZDI7LRV5QLKGTCPICTK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4681830.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Sep 2025 17:01:30 +0200
Message-ID: <5043679.31r3eYUQgx@ripper>
MIME-Version: 1.0

On Tuesday, 23 September 2025 16:45:48 CEST Tetsuo Handa wrote:
> On 2025/09/22 23:09, Tetsuo Handa wrote:
> > I suspect that batadv_hard_if_event_meshif() has something to do upon
> > NETDEV_UNREGISTER event because batadv_hard_if_event_meshif() receives
> > NETDEV_POST_INIT / NETDEV_REGISTER / NETDEV_UNREGISTER / NETDEV_PRE_UNINIT
> > events when this reproducer is executed, but I don't know what to do...
> 
> With a change show bottom, the reproducer no longer triggers this problem.
> But is this change correct?

Thanks for the debugging. I have some doubts that the move is correct - but I 
need to check this in detail when I have more time. Unfortunately, this will 
not happen before the end of the week. I hope this is ok for you.

Regards,
	Sven
--nextPart4681830.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNK2SgAKCRBND3cr0xT1
y2JoAQDPsuCJHcvYYlRKtGScm5x4vRhLsNIfo4Z8Y1dycx2lnAD/ei2Tqec/sy24
hydpmxkXRLcP2Z3IWUmTqwHTpIlT7AU=
=18Wp
-----END PGP SIGNATURE-----

--nextPart4681830.LvFx2qVVIh--



