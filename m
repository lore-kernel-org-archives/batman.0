Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38503CA5FFC
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:57:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C6C34811CE
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:57:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305863;
 b=nAK5dWC9xmcwOwcRwVVii5Hs+IYB/Zq2OM4Xx9i7lMyy82oJHiPkU3KWA7kXQucdF3Pm+
 04ECSNPxR0uv6+5R0kHBqa4AX1IRKxnOJoIXNBzP06gAUHvWY8/FqIYPADOSDL8AjPrhGFj
 V0UNG7BnAZWfsh5+MLtSKoLdj0UzBc0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305863; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MDOxgEpIbCv2Iai/Qw2p7zkMsSSVbWHwnTJUy6ttOEI=;
 b=kFogMXf9ZTW6IRL0DjLtgO9NTbnkGvRd7cgXySE/jbXw/TeAAaeXjHAAhG52X9miGlSct
 9ifTByOI1S8RAVW44g7rdmnH8gCzmwabTfaU/ODb4rE4jL163bbLBow37f6bc+/KEg/tMeP
 /SfY2r/YVcrwrnDlLIEkxGLTVE/t8EI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5C837811CE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:57:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305854;
	b=2O/l6ay8EFFQBQ3dxI7Xt8sQVKAxrGZR/D1LuhHfubH0TJINyuhD95MWFX4FJ5qo6fUHCt
	7i+WjgT1VV7TsEM6gGQzgNu/+VCrwGqy+/nqF6Rtty+8o7jWhDhSXUvitvvhxyal7WdBmn
	nAbgk0iKqwelROQ6ohwnWLj1dp92IS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MDOxgEpIbCv2Iai/Qw2p7zkMsSSVbWHwnTJUy6ttOEI=;
	b=H9YRiIMLgdz2jwa9OJVYwW2nl0z+FzVjvl9tnvUWEcwKPl/0Mjr5PPT0X08IXD6jrNO2bX
	FLa+f5CNE0hhlTNHrUAhFlEgin5HDq5MPBQPjRP+7AVnjuMtKFCQVndyOCE0i0zimp90P+
	eqO3300epgoV0q1d3ROU5W6cLAXYQiE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iS8QjPUP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A7E041FFBB;
	Tue, 06 Oct 2026 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDOxgEpIbCv2Iai/Qw2p7zkMsSSVbWHwnTJUy6ttOEI=;
	b=iS8QjPUPEGOGayzLlgM2B/rIi4J5yhpN6lEV35CmXb5KfdnIwfOfwfcXxXkJVIxmAWbUAO
	jR7oueGv3ZlmjwVg5VesRat1JAyJ/pD+1ZIXR92SszPy/JhzYRwB/9rRYhxLP976/2QBMw
	rSy2YUN/7WQkNRI1q7UR0FOAjFhjgCY=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH batadv] batman-adv: dat: initialize orig_node of unfilled
 candidate slots
Date: Tue, 06 Oct 2026 18:57:30 +0200
Message-ID: <6321151.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <asTVqLO0EWAVM_IE@sellars>
References: 
 <20261004-dat-eligable-uninitialized-v1-1-9674029343da@narfation.org>
 <asTVqLO0EWAVM_IE@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5146418.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SGKZQ77JAZ6A3DEYIZNEAKAKRGJQBEJ7
X-Message-ID-Hash: SGKZQ77JAZ6A3DEYIZNEAKAKRGJQBEJ7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SGKZQ77JAZ6A3DEYIZNEAKAKRGJQBEJ7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5146418.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Date: Tue, 06 Oct 2026 18:57:30 +0200
Message-ID: <6321151.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <asTVqLO0EWAVM_IE@sellars>
MIME-Version: 1.0

On Tuesday, 6 October 2026 13:04:08 CEST Linus L=C3=BCssing wrote:
[...]
> (Also, I can't read the Sashiko link, I guess it's only accessible for
> maintainers?)

I had to login to the sashiko.dev to get access to the "Bugs" section. And=
=20
even after login, I can only access the "BATMAN ADVANCED" subsystem. I have=
 no=20
idea how to make the report readable for everyone. But this is the text:

In the batman-adv Distributed ARP Table (DAT) selection process, if an
early candidate selection round fails to find an eligible node,
batadv_is_orig_node_eligible() reads uninitialized heap memory when
evaluating nodes during subsequent rounds.

The vulnerability stems from batadv_dat_select_candidates() allocating the
candidate array using kmalloc() without zeroing the memory. It then
iteratively calls batadv_choose_next_candidate() to fill each slot. If no
candidate is found during a given iteration, the slot's type is marked as
BATADV_DAT_CANDIDATE_NOT_FOUND, but its orig_node pointer remains
uninitialized. During the next iteration, batadv_choose_next_candidate()
iterates over nodes and calls batadv_is_orig_node_eligible(), which loops
over all previously processed slots (up to the current select index) and
reads res[j].orig_node to verify if the candidate was already selected.

This results in an uninitialized heap memory read during the pointer
comparison, which triggers a KMSAN violation. Because the garbage memory is
used only for equality comparison against active orig_node pointers, the
defect results in undefined behavior and a highly improbable false-positive
candidate match rather than a system crash or memory corruption.

// net/batman-adv/distributed-arp-table.c:182-206
static struct batadv_dat_candidate *
batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
{
	int select;
	< ... >
	struct batadv_dat_candidate *res;
	< ... >
	res =3D kmalloc(BATADV_DAT_CANDIDATES_NUM * sizeof(*res), GFP_ATOMIC);
	if (!res)
		return NULL;
	< ... >
	for (select =3D 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
					     &last_max);

	return res;
}

// net/batman-adv/distributed-arp-table.c:114-162
static void batadv_choose_next_candidate(...)
{
	< ... >
	cands[select].type =3D BATADV_DAT_CANDIDATE_NOT_FOUND;

	for (i =3D 0; i < hash->size; i++) {
		< ... >
		hlist_for_each_entry_rcu(...) {
			< ... >
			if (!batadv_is_orig_node_eligible(cands, select, ...))
				continue;
			< ... >
		}
		< ... >
	}
	if (max_orig_node) {
		cands[select].type =3D BATADV_DAT_CANDIDATE_ORIG;
		cands[select].orig_node =3D max_orig_node;
		< ... >
	}
	< ... >
}

// net/batman-adv/distributed-arp-table.c:69-82
static bool batadv_is_orig_node_eligible(...)
{
	bool ret =3D false;
	int j;
	< ... >
	/* Check if this node has already been selected... */
	for (j =3D 0; j < select; j++)
		if (res[j].orig_node =3D=3D candidate)
			break;
	< ... >
}
--nextPart5146418.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasUoewAKCRBND3cr0xT1
yxrwAQDXYJrtGmVUV9mGs0iW3c4cHg5CvCCTXMAseIckMkh+BQEAikjxapYSBg33
J+vb64XwX30gEaN3YhIVdtytTmqQ3Qo=
=5FuC
-----END PGP SIGNATURE-----

--nextPart5146418.31r3eYUQgx--



