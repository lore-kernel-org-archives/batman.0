Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DE606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Zu7L2e3M
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 89E658287E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:24:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795548287;
 b=CLi2bVc+Cl0c97bJNhXQErLwkSYAn6EP7QEe02h1QakLAdhYjW0E+NjfJPHNLuZ0P4b0H
 nEiyFagbTo7QmIcx1BkJ41qWPL2o+fA7eZIgBa5uE5QRa/R0Jufu6MNHoBo6c3z9YXy++HR
 hp2quK7GOBiPgdB3xF4/09XqoeJviF8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795548287; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cORf5hs+EqkLduwnTH+/lFR4dJOv+FMKikDVrfSgwBw=;
 b=xi1yfzy2UAMCodgT2KB33c3MhZLLCBW/+KoEYkKtpZ5QwFAW5LAO7mwP0ACo8SUsbkpiU
 iYS5OaxlwBNae4K2bXGVyTHJs2RTHiqFdNVB4/BFLNdwEMb+cyKo7vt4e7cghLNf12mSYb2
 BCyUxbGzVxEQ8kWgtrN4yuSz5ySx1yI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 968BA80EC0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 20:24:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795548279;
	b=Sm5jiaOMODnOOUR3CXUOaQ93tm7Aa7OPk1/39t7F+dRa7AAEOuShGjGwUPTb8R8VTXCzfV
	cxXwaSYVvc5xkP9rvcyZPzSAMXUup77BSukGudzzxuiJdXtQfe34+/bvJ64zgtKPss7nh2
	TJDAxuLBTWRGRIuG10WP8JhiYJINBLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795548279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cORf5hs+EqkLduwnTH+/lFR4dJOv+FMKikDVrfSgwBw=;
	b=Nhmnf8mxhb1e2LgB+b3ZKs8zsNvi9Jijk3NwyscUjv+nqBjtN4D+2olKPhCA9juC/QNhF0
	Vvzu17woEQWLGKK5Xxx4k+9RS+wHgSkTvXOZEtOPVnxP5n6BWqcwZ0DA7cmnAxAYoPHz2r
	jRB6DFWLMhwWBBXOqPCcm9lEGH1iS20=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Zu7L2e3M;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42A1D2014F;
	Tue, 24 Nov 2026 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795548278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cORf5hs+EqkLduwnTH+/lFR4dJOv+FMKikDVrfSgwBw=;
	b=Zu7L2e3MHtRPaZIIxb24FE+bKJlkt4Mdtoxg1QvWZy/EKm2iyQD9Ct9R8IFg7ALPYKUeDu
	n137fmjBQPhkxul4oIOM6NdB9r3r2W3iKH2QPHOCCHOmeRDiL2B8M77lcW1BQcksjyf2K5
	g8pjlRWaBOWN76CWXdC3Rq9l1uPHOyc=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 07/15] batman-adv: tt: don't remove unhashed
 local
 entries
Date: Tue, 24 Nov 2026 20:24:35 +0100
Message-ID: <2286793.irdbgypaU6@sven-desktop>
In-Reply-To: <179554084147.3135.8288154830036400852@kernel.org>
References: <20261123171827.3294525-8-sw@simonwunderlich.de>
 <179554084147.3135.8288154830036400852@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14143459.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VHWD755ZR3G55B63CBQXMGC773KRUUTB
X-Message-ID-Hash: VHWD755ZR3G55B63CBQXMGC773KRUUTB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHWD755ZR3G55B63CBQXMGC773KRUUTB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart14143459.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 20:24:35 +0100
Message-ID: <2286793.irdbgypaU6@sven-desktop>
In-Reply-To: <179554084147.3135.8288154830036400852@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:41 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > batadv_tt_local_remove() looks up the local entry via RCU only.
> > batadv_tt_local_purge_pending_clients() can unhash it before
> > batadv_tt_local_mark_removed() acquired the hash bucket list_lock. The DEL
> > is then queued for a client which is no longer part of the local table (and
> > its CRC). And it might replace the queued ADD of a new entry which was
> > added for the same client in the meantime.
> 
> [ ... ]
> 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/bug/linux-c3e34735-5286-4ed0-9338-a77e64fef540
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [Severity: Low]
> This isn't a bug, but should this commit have a Fixes: tag?

No, Fixes: or Cc: stable@ are not allowed for net-next

[...]
> Without a Fixes: tag, backporters and the stable tooling cannot tell which
> trees contain the broken logic.

No stable maintainer involved here.

Regards,
	Sven

--nextPart14143459.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXkcwAKCRBND3cr0xT1
y5KpAP9CkaoRykRpfQeA7U6g7zlrfLEITgyQGqZHzIrzhLyGmwEA4XijW3Fj5CGp
Fpt/MOG7rfZ/9/1k1zEzysd7evgpTgU=
=G1G6
-----END PGP SIGNATURE-----

--nextPart14143459.uLZWGnKmhe--



