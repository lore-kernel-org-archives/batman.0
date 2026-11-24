Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADD606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Kk7aX5n7
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 48C4F81238
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:34:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795552441;
 b=EZvceXyZGAeWo2C/Y4ecRHY5E4Pw9L5/K0/QK4RmRrDSsjCVOQ+Ffi3D5zVYjy4pSqwYx
 vJMLzqCNCtZLLIoT7JtWEM9r8SYiItkya/GOp35Q4lUuSgbL/Tzd8HpFVYnJ0o3xVxSQ7vC
 dQ1XktV1clr5pO7NsY6WYSRiZ0eUM+U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795552441; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c2MHqh4y5WDPKpOHCTYLK4aLHvmoORxaMjltvDY0H5s=;
 b=MDDv/3jCNCWviFa5VQKx1qm7USf1z/CupU1vBY7/K+O6U7yUGnbbx9NXKCTks+8DG8FxU
 eEYXtfl5O7c+J9aQ9yFibPNZLeYYq60xd6+J5JEaPdtju9Ky8GrNVfWYjITKBpJHD6WhOl5
 asQJYvUAFR6UtILvlhpdrC8uuBeKGMQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ECF1F80F00
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 21:33:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795552434;
	b=ZWnlXUQHQ040YE17TqERw+9RAXBi5e0vkkbvw29I84IqPSHZEwR7AeFPjPHNf9QvGAjuLV
	PtxQ4raUbsgY1G44FYl/0hLuHNC8gwFIDa7Q/jaGuo0eQYN2QPWzVni3rZJIg4O8LiHuuX
	s2+8C/sBNalVb8Lho22iBzJGfvjsnCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795552434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c2MHqh4y5WDPKpOHCTYLK4aLHvmoORxaMjltvDY0H5s=;
	b=qIorSURxLH44VbpbLnEfkuE4qbvjUbwkMKrY9bOzejjmW9OK43AP9AF25XiJctb7dN6Iqh
	fvE1qtj2CzBk+7aPPKXn9x3WU76b5k+JGJdQgbSOOb844VrRWJMKtgkeg9GzkGL/cSXOJ9
	DlEqC+XZJ+6UQaDKzPLZ7jMwsZRUDFI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Kk7aX5n7;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5BE672026D;
	Tue, 24 Nov 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795552432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2MHqh4y5WDPKpOHCTYLK4aLHvmoORxaMjltvDY0H5s=;
	b=Kk7aX5n7S10xJ7PJRCV186lqIz3a7ff6GoQED937p6ZtDyMf8eTzBh6y4KxTW4eES/xXFv
	PF1Aoecz27L8gbQEyUZ98lX4ON2+n747mdGp6n/UlKEuF+1Avsag+NoFW3Ov47Iz7l0fVZ
	hxQWAVqkq5gptquRT2ZAqIdAN19Aaxk=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 13/15] batman-adv: tt: commit only the announced
 local
 changes
Date: Tue, 24 Nov 2026 21:33:49 +0100
Message-ID: <4550986.ejJDZkT8p0@sven-desktop>
In-Reply-To: <179554084776.3135.15585552473847641901@kernel.org>
References: <20261123171827.3294525-14-sw@simonwunderlich.de>
 <179554084776.3135.15585552473847641901@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2295529.Mh6RI2rZIc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: FHCHMQP24KRYPTCNGOCC64WX6HOHRHDU
X-Message-ID-Hash: FHCHMQP24KRYPTCNGOCC64WX6HOHRHDU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FHCHMQP24KRYPTCNGOCC64WX6HOHRHDU/>
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

--nextPart2295529.Mh6RI2rZIc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 21:33:49 +0100
Message-ID: <4550986.ejJDZkT8p0@sven-desktop>
In-Reply-To: <179554084776.3135.15585552473847641901@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:47 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 2a7f50de70fc8..b03d6c74732f4 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> 
> [ ... ]
> 
> > @@ -1876,9 +1882,8 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> >   *
> >   * All checks and modifications happen under the hash bucket list_lock and the
> >   * flags_lock of the entry. This prevents a concurrent
> > - * batadv_tt_local_purge_pending_clients() from removing the entry,
> > - * batadv_tt_local_transition_new() from clearing BATADV_TT_CLIENT_NEW and
> > - * batadv_tt_local_refresh() from modifying the entry after it was checked.
> > + * batadv_tt_local_commit_change() from removing the entry and
> > + * batadv_tt_local_refresh() from modifying it after it was checked.
> >   */
> 
> [Severity: Low]
> Should batadv_tt_local_purge_pending_clients() still be listed here?

Will adjust it in a follow up patch:

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ede6c15581242dc3fe6ecdb1ba0fab3ab601faa7..22197827fa5d220850d57e6697393ac098d0cd03 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2001,8 +2001,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  *
  * All checks and modifications happen under the hash bucket list_lock and the
  * flags_lock of the entry. This prevents a concurrent
- * batadv_tt_local_commit_change() from removing the entry and
- * batadv_tt_local_refresh() from modifying it after it was checked.
+ * batadv_tt_local_commit_change() or batadv_tt_local_purge_pending_clients()
+ * from removing the entry and batadv_tt_local_refresh() from modifying it after
+ * it was checked.
  */
 static void
 batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,


[...]
> On a related note, the comment in batadv_tt_local_unhash() is no longer
> accurate:
> 
>     /* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
>      * and must not be uncounted here.
>      */
>     if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
>         batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
> 
> batadv_tt_local_commit_change() can now set NEW again on an entry that
> was already counted, and it uncounts that entry with
> batadv_tt_local_size_dec(). The accounting is still correct, because NEW
> means "not counted right now". But "was never counted" is wrong for such
> entries. Could this comment be updated too? Later patches in the series
> change neither comment.

Will adjust it in a follow up patch:

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2c15890bc56fe195d361e51faaea602e9d37a51c..ede6c15581242dc3fe6ecdb1ba0fab3ab601faa7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1897,8 +1897,8 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
 	hlist_del_init_rcu(&tt_common->hash_entry);
 	atomic_inc(&hash->generation);
 
-	/* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
-	 * and must not be uncounted here.
+	/* An entry which carries BATADV_TT_CLIENT_NEW is currently not counted
+	 * because its ADD was not committed yet. It must not be uncounted here.
 	 */
 	if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);

> [ ... ]
> 
> > +/**
> > + * batadv_tt_local_commit_change() - apply a committed change to the local table
> > + * @bat_priv: the bat priv with all the mesh interface information
> > + * @change: the change which is announced with the new ttvn
> > + *
> > + * The CRC and the full table responses of a ttvn must reflect exactly the
> > + * changes announced with it. Only the entry affected by a committed change is
> > + * therefore modified. An entry which was added or marked for removal after the
> > + * change set was taken stays in its current state until its own change is
> > + * committed with a later ttvn.
[...]
> [Severity: Medium]
> Does this fully meet the invariant in the kernel-doc above ("must
> reflect exactly the changes announced with it") when flags change?
> 
> The CRC-relevant flags BATADV_TT_CLIENT_WIFI and BATADV_TT_CLIENT_ISOLA
> are in BATADV_TT_SYNC_MASK. They are still written to the live entry
> when their ADD is queued, not when that ADD is committed. That happens
> in batadv_tt_local_refresh_locked(), reached through
> batadv_tt_local_add()->batadv_tt_local_refresh().

Yes, this is a known limitation (already a problem before this patch) and 
there is currently no solution for it.

Regards,
	Sven
--nextPart2295529.Mh6RI2rZIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawX0rQAKCRBND3cr0xT1
y+i5AQCgUGBIbkpisvyzL1r0r90uel7EiTPu3WI7SXqY0LDT8wD9HAPO4VUiADmC
LDascDZeo9MranIFLWiQlQToz6QESg8=
=WIOJ
-----END PGP SIGNATURE-----

--nextPart2295529.Mh6RI2rZIc--



