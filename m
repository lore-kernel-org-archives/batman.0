Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A911CA0FF2
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 01:50:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4510C83E16
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 03:50:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756691447;
 b=alttFKiRecl2ulVx2ztzLmhEdzOZ5Grh5d0kg1ifPavW1fWIDAtrL5rz07DgaYPTclAkt
 YBMvqd+1qGAf2n9+jmo3ERUcWKm7ZbYHtKTyerOJ3GZ0LVIHIflw1nATc/vD2R+ZZ8njSRa
 5tuOb3k3fl/oHFDV2eufU863ZgKUras=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756691447; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=N4bnpA/HOdFOXnMD6fv9VGVJB7aMOJ5cCx4HPUQZRIE=;
 b=hmflszV44+sv35ag6AZ/oAEDnUNvorWRQju6W18uV+wIuKBoPMUTuqpYBm0mJ4/ZBPqYV
 xYbXSclRV+TzEZvMSoV+Mtvi1duTM1H52OkZLxp5F5CuB+Xqk78578zKHlq3tP/7shp9pmE
 zYRhW/o0tG48EzxIWeyJy2NDoAjPd+c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C13F8837F8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 03:50:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756691426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4bnpA/HOdFOXnMD6fv9VGVJB7aMOJ5cCx4HPUQZRIE=;
	b=Gnfbwq1FYQG1UN5YpenuEZIGk17t1Il0Iyh3SiAlL+zDLEkYPuIhuiukdSz6vGWX0Sl2Tv
	rGpgOPxvYVGUVpEPOp4F9K+jv3v9jWgwmXI3wUS0nnIgl4pJTeYrdQq5sYmEbb/srCjsbQ
	I5inYFQ3kEAvEGI+UThJLWm8NafAChA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756691426; a=rsa-sha256;
	cv=none;
	b=0yunyt76BAZiQ2wW5649I3MsDEk5Jpl5MzU/NoEsgwUnkFHep07/YPDUy94njom4emA8eK
	GI8ONyMBctOScvzYbNJJ87p07omemTR+y7Mi3/PvN0h2NT2rdeQ7j1aZ4A7k3za6vO3ldu
	Cx5o2iqxkgbJ7vIol1RYA70xrKyk5lg=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B311541362;
	Mon,  1 Sep 2025 03:50:13 +0200 (CEST)
Date: Mon, 1 Sep 2025 03:50:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>,
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Subject: Re: [PATCH 0/2] batman-adv: remove network coding support
Message-ID: <aLT71OlX6b7YUZQj@sellars>
References: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: RGKZXM5GHXLAZQC4BMWPJO3C2R6WM2CM
X-Message-ID-Hash: RGKZXM5GHXLAZQC4BMWPJO3C2R6WM2CM
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RGKZXM5GHXLAZQC4BMWPJO3C2R6WM2CM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Aug 31, 2025 at 05:40:00PM +0200, Sven Eckelmann wrote:
> This assumption no longer holds for modern wireless mesh networks, which
> are heterogeneous and make overhearing increasingly unreliable.

.oO(I was wondering if it could be interesting again with IEEE
802.11ah HaLow. Recently read that AREDN mesh had added
experimental support in their firmware (though with using Babel,
not batman-adv), with ALFA Network Tube-AHM R0C devices.
https://www.arednmesh.org/content/aredn-production-release-32580-now-available
But testing and tuning HaLow + batman-adv + NC would still
be quite some work...)


Have had the pleasure to play with this ages ago on 802.11g
hardware. It generally semeed to work and was a lot of fun to
experiment with. But it wasn't easy to use it reliably, it needed
quite some precise placement of nodes. Rate control algorithms
wouldn't be aware of network coding opportunities, would have
been nice if it had sometimes chosen slower rates for more
NC opportunities. (Also CPU usage with promisc mode was maybe
an issue back then on many devices? But maybe I misremember that.)

I'd maybe try to ask around one more time on Freifunk or
Battlemesh channels if anyone would be interested in reviving
this, a final call. But as to my knowledge no one has used it in
practical scenarios I guess the chances are low. And I agree that
it might maybe be better to remove it then in the upstream Linux
kernel.

Many thanks for the awesome work on this exciting experiment though,
Martin! I think it inspired quite some people and contributed to
the crazy mesh excitment and pioneering back then that was going
on at all fronts.

Regards, Linus
