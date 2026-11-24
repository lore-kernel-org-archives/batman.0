Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25C606A688
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=PwJkcziC
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A910482F98
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:16:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795551387;
 b=Ht53klG80eIWArg3/JAoMYAhTXebooYLKBt4F7fTw/wHZ+qiIP4m47StDKFst3TERRElC
 vmjHcHjMN7WRydk2gHraJqEDnwUkD1tnNrw9hWrhv90kU601iDHgC/JcKHvzXAbGLtfa1U5
 FpGgUn9rFDkDD7oEmO7fAwRAj0ecZz0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795551387; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SgFAIxmUxHx6nwXdXG+ldkr9MHmCx9LhmQjMWY/spG0=;
 b=conNeSau80fHu7UbAOXLAt1DxoOTmWTTrKLmcNotcTv5BBoL+TYqjTYd2sUsT8XzSb78b
 4+Rrm+JgHPuel4hxvWPfgc/m9I27cBOzcCYpXh2Xqu6qZB3mHSYQ55g0iro+QMfk5AUqa3V
 vxMTPOcvx+wPTd/xb1K1ZN4g5qUFG0E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D0E5E8040B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 21:16:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795551380;
	b=vBi9Lky5g6KjSirfWv8BMDCpfxrE18moggquQXbwYac36vGIV7Zgcy2s+F6VD0NkBiFYDa
	/hVLnlXxf6+xwseAmLpZTq2cFnPGh67jmyKz2z6IYasaA0xTilSQain4EC/R9ZG7oaFjTB
	URP1T+EVGPtpnmLXlMHPRqoRDsxVHfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795551380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=SgFAIxmUxHx6nwXdXG+ldkr9MHmCx9LhmQjMWY/spG0=;
	b=FIUlVSGBu7qB/mZlfGmC44BCNGZzfFwuHlLbulh0Nz8evhLx7EjuJHYPptT6CQ4SvMgHu4
	ilt8EGDD0EwuBhdq2J2tTpRWW5yysjK6C6cg3iJFQ4ha7sg7IesgXVslO8OgE1Yj7+225M
	Qjih5gBO1WOIp+VISXISf+DZZAY6GX8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PwJkcziC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 30A1B20277;
	Tue, 24 Nov 2026 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795551380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SgFAIxmUxHx6nwXdXG+ldkr9MHmCx9LhmQjMWY/spG0=;
	b=PwJkcziCmpqUvZ/HiSYOCKPpIowJw/+L6uygO5ZzEB6NqmQCyC8LnNtlOPYFkEZ7PrlBO8
	vYH4avZaILBs1cEMLgsbM4G2qZU+pnxPfVNCSa4J9lNDxwUqRd1Vb59tZPqgPfk2meOncj
	Ovpj4lTPGA0Qmac+fjHSWJgR4+OnUFI=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 12/15] batman-adv: tt: extract removal of pending
 local
 entry
Date: Tue, 24 Nov 2026 21:16:15 +0100
Message-ID: <8807006.NyiUUSuA9g@sven-desktop>
In-Reply-To: <179554084613.3135.2138652598368843379@kernel.org>
References: <20261123171827.3294525-13-sw@simonwunderlich.de>
 <179554084613.3135.2138652598368843379@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2081065.usQuhbGJ8B";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: FXKBFEOST6FGBLEHZFZIK3DLCFJCLYQR
X-Message-ID-Hash: FXKBFEOST6FGBLEHZFZIK3DLCFJCLYQR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FXKBFEOST6FGBLEHZFZIK3DLCFJCLYQR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart2081065.usQuhbGJ8B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 21:16:15 +0100
Message-ID: <8807006.NyiUUSuA9g@sven-desktop>
In-Reply-To: <179554084613.3135.2138652598368843379@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:46 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > @@ -4550,6 +4588,43 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
> >  	}
> >  }
> >  
> > +/**
> > + * batadv_tt_local_unhash_pending() - remove a pending entry from the local table
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @tt_local: the local TT entry to remove
> > + *
> > + * Only an entry which is marked as BATADV_TT_CLIENT_PENDING and whose DEL was
> > + * queued is removed. An entry which still waits for its DEL (del_unqueued) must
> > + * stay in the local table until batadv_tt_local_purge_list() was able to queue
> > + * it.
> > + *
> > + * The caller must hold the hash bucket list_lock and the flags_lock of the
> > + * entry.
> > + *
> > + * Return: true if the entry was unhashed and the caller has to drop the
> > + * reference of the hash, false otherwise.
> > + */
[...]
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc of batadv_tt_local_unhash_pending()
> seems to leave out a requirement it inherits from batadv_tt_local_unhash().

Ok, will copy the requirements in a follow up patch:

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b4b6d564a2a3b1564d1d5352b9df5947c..82eadd73b072550b712485485238d422ce0c2f6c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4744,10 +4744,10 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  * it.
  *
  * The caller must hold the hash bucket list_lock and the flags_lock of the
- * entry.
+ * entry. It must have checked that the entry is still part of the local table.
  *
  * Return: true if the entry was unhashed and the caller has to drop the
- * reference of the hash, false otherwise.
+ * reference of the hash after it released the flags_lock, false otherwise.
  */
 static bool
 batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,


Regards,
	Sven
--nextPart2081065.usQuhbGJ8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXwjwAKCRBND3cr0xT1
y8ZcAP9s4KgI0PjASQjQDQBQJyvKA5PozpXSDkrSfM3qslnmvQEAxdXZ66oqEuz2
QlzRiLl+4gP05c56znDXTPX07YUpzQ0=
=/ih1
-----END PGP SIGNATURE-----

--nextPart2081065.usQuhbGJ8B--



