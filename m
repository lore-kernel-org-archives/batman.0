Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EFCCD199
	for <batman@archiver.kernel.org>; Fri, 17 Oct 2025 14:03:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F4BC84C6E
	for <batman@archiver.kernel.org>; Fri, 17 Oct 2025 16:03:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1760709796;
 b=HrBfVNhNqXJT2lX6pDc8SPvCWrmJOKAOTv/RuW3IYsHDVgTMdFqChIpN6MLijASToVZ4i
 0DYgaWWcGiWaOEgzHdmHpQS2LK7fBxlCVYhz5AO86Hs0lZHnBJQesRPna+DJhsZdvc/t7A3
 UtnMUlzZ4iqCt2vgdDiCRdEnX+y73Po=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1760709796; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=k6RDA7Ax/YNC08jR8Sepr5pCgb8OdYFlz93MgjA9WaM=;
 b=KXn6j8gub8RnAm15TLZz+RCmTTvTbQn8+0hBOnEfzpHFvY7fBI2wElX17CJfWyFvFIjXp
 AjvyL9+iOKxp6EXwTpJfW/KD0ScZDJg26fPWrVGp5yo2Qhgnc0TDEd52bMy7iQo7QQ8jB7L
 VHsYtSHW6BXI6F0yxO3pcNli7STtnBc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3F014817AC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Oct 2025 16:03:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1760709793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=k6RDA7Ax/YNC08jR8Sepr5pCgb8OdYFlz93MgjA9WaM=;
	b=okfT4VjlrCD59QlgVxAfHaaLhr5lt3O274pHqxEvTE+X2O9dU4n0N7cBmLzqe56+sxsm7L
	DexmySvBxFcNsGG1elT+4ihdHklBRtksV5G+OoGfljRUngNsY6k/Btwp3vSDHy3RgoISSw
	nC4gig9fNwWUqw+aILvbKYJ4olKySYE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=LWEZkwAR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1760709793; a=rsa-sha256;
	cv=none;
	b=bPUOxhWS9/VBFi8Bpgca8dfWbp5jfb6KfXlnF5I+ZRXGu3EVUnAG+ag0Re4GcNhh7Uc6jD
	NXZCNtdBoYKFQ3DpVrvxgRTjfa3jRu2nW8gMcB/dXc3PaE0+J5TD7ghjac2zsOnhka+ItE
	YET6e0RZLLR818Yw3ZVzkIpYBLrTEqE=
Received: by dvalin.narfation.org (Postfix) id 13BAB210CE;
	Fri, 17 Oct 2025 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1760709782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6RDA7Ax/YNC08jR8Sepr5pCgb8OdYFlz93MgjA9WaM=;
	b=LWEZkwARbqDJRVoQXzurZyDmpEBjzU/KuHrkiOUwrsd7Xoub09MBJnbZuVbNw9HIKcVZnw
	SqkZc5X5scyQyvVG+KXVggW/fxSXEcWgEURE+IBXqI1bB/tWrKnmwu0ISkZsZ0Su8ykKaH
	U20bMp4ZSFGhsF55hXqQQTjorga67C0=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Subject: Re: [PATCH] batman-adv: Release references to inactive interfaces
Date: Fri, 17 Oct 2025 16:02:59 +0200
Message-ID: <2676395.Lt9SDvczpP@ripper>
In-Reply-To: <6d8c06e0-4e36-415c-942c-7100c21b2de4@I-love.SAKURA.ne.jp>
References: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
 <6d8c06e0-4e36-415c-942c-7100c21b2de4@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4462098.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: DHOPVQDS2G4YOCDFGZKBLMQOGV35MSZS
X-Message-ID-Hash: DHOPVQDS2G4YOCDFGZKBLMQOGV35MSZS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DHOPVQDS2G4YOCDFGZKBLMQOGV35MSZS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4462098.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Oct 2025 16:02:59 +0200
Message-ID: <2676395.Lt9SDvczpP@ripper>
MIME-Version: 1.0

On Friday, 17 October 2025 13:18:20 CEST Tetsuo Handa wrote:
> Is this patch recognized?

Who should recognize the patch?

https://git.open-mesh.org/linux-merge.git/commit/?id=f12b69d8f22824a07f17c1399c99757072de73e0

Regards,
	Sven

> 
> On 2025/09/28 3:01, Sven Eckelmann wrote:
> > Trying to dump the originators or the neighbors via netlink for a meshif
> > with an inactive primary interface is not allowed. The dump functions were
> > checking this correctly but they didn't handle non-existing primary
> > interfaces and existing _inactive_ interfaces differently.
> > 
> > (Primary) batadv_hard_ifaces hold a references to a net_device. And
> > accessing them is only allowed when either being in a RCU/spinlock
> > protected section or when holding a valid reference to them. The netlink
> > dump functions use the latter.
> > 
> > But because the missing specific error handling for inactive primary
> > interfaces, the reference was never dropped. This reference counting error
> > was only detected when the interface should have been removed from the
> > system:
> > 
> >   unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2
> > 
> > Fixes: 50eddf397ac3 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
> > Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> >  net/batman-adv/originator.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> 


--nextPart4462098.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaPJMkwAKCRBND3cr0xT1
yyitAP4gMXfqTZgm6OPV8sKc8rPXMi45KLCaADNJ8R+UzHXY0wD9Hp4th4Hof3db
iMVyffunntjcUVGGDe/f0/CTHEi/4w4=
=ODDU
-----END PGP SIGNATURE-----

--nextPart4462098.ejJDZkT8p0--



