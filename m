Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C3E65D2F
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 08:16:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3830B84035
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 09:16:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732263416;
 b=duXGcTegtHboXdGkdFglBFBrVZNLpgmtfN8tzv1Rq6ByEUEN8fk04+2dTumqGT32okY+V
 3tBrfbJnBCZUvqoH6ORezU9lg7q5cf+SZcxE3mvnAPUveCShoVW6WPUQCJICM07p5rW2gc2
 fh7zOcqdlFckGjldVtStB/j90TlBHQU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732263416; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oWLsf0r5uSftmMjzSxJoEwjpnTluGOhWeJzG1s4laaU=;
 b=knrPEqf4yIE1dVD4Nfmtpqbdn6mlaFvzieuTiI7Ny/uJlSSrYnSzqiCIWPjVqqxW7UJky
 Ox2WMdDG4eaozlV4P+raKMRXBjvhkazUjA4ioaGUney/XX1wKuUtgE6c8gkbcDMkSqQVydF
 1U+VQWslSphzDTnxvIKuqZ2m7fN1VyY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 241F581841
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 09:16:43 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732263403; a=rsa-sha256;
	cv=none;
	b=dlP3Lo8foW82bQ3j9cAoQThjK61FyYhzck59qRF1yjjSrjwioEr6E8n/er/UA36MTRksTI
	ByhP4Td8pau3LTKKaZhTSQaCYaTbR8aS6zUhQHD6APFEeoTn3MLEtd2Axjo6qxeyKyofin
	vL7QeuVfATERvxc+vh1eZqva6YVwUOQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GuBqcMLN;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732263403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oWLsf0r5uSftmMjzSxJoEwjpnTluGOhWeJzG1s4laaU=;
	b=Py9IKmt3SoqBjIjq1bSgnXpNrgLVrAyI+I0GP5eVJ2sICjXEh+lZjaesfqbdQzRR2t8or/
	O7psZkop2Fh75Ac97V7caIgggAayPRtenxCLo7DqFszAbFoBjbw9Amgb5Xwem4HaOHDpej
	G+2qJuG/zhCJyMHcgx2WZ+KVOg3Zzr0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732263402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oWLsf0r5uSftmMjzSxJoEwjpnTluGOhWeJzG1s4laaU=;
	b=GuBqcMLNeS0wyaT39+y3BY3iANz4T/v3pUUyh+mLWoZ886MW63A2zBsnrwGQ7KlMpirjRy
	aG+lqzfhf5tvsU8V6mHIWbeXGdt5biR+RwIFbA1lrQ3Ab73lEOYtRUJiefYepV5bSFeRZP
	udqjdp1aepJQfsyQlyOQ+XaiG3PGzO8=
From: Sven Eckelmann <sven@narfation.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
Date: Fri, 22 Nov 2024 09:16:37 +0100
Message-ID: <2227327.C4sosBPzcN@ripper>
In-Reply-To: <Zz-W_3A9diBFXz79@pilgrim>
References: 
 <cover.1732124716.git.repk@triplefau.lt> <4345009.mogB4TqSGs@ripper>
 <Zz-W_3A9diBFXz79@pilgrim>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2577568.4XsnlVU6TS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: V5YPHKEMTOBJ6OYFO2KIDRHYPMVS3QCX
X-Message-ID-Hash: V5YPHKEMTOBJ6OYFO2KIDRHYPMVS3QCX
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V5YPHKEMTOBJ6OYFO2KIDRHYPMVS3QCX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2577568.4XsnlVU6TS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Remi Pommarel <repk@triplefau.lt>
Date: Fri, 22 Nov 2024 09:16:37 +0100
Message-ID: <2227327.C4sosBPzcN@ripper>
In-Reply-To: <Zz-W_3A9diBFXz79@pilgrim>
MIME-Version: 1.0

On Thursday, 21 November 2024 21:24:31 CET Remi Pommarel wrote:
> >
> > And then you can also move this before "tt_diff_entries_num = ..." and 
> > save the corresponding bat_priv->tt.local_changes for the spliced list to the 
> > inside the lock also in a local variable. And then operate on this variable 
> > for the other decisions. Of course, you must still clean the local list in 
> > case of an error. Which of course would slightly change the behavior in case 
> > of an allocation error in batadv_tt_prepare_tvlv_local_data (which would 
> > previously kept the list as it was).
> >
> > But if it would be done like this then we could also remove the READ_ONCE and 
> > not introduce the WRITE_ONCE - just because local_changes is only touched
> > inside a locked area (see changes_list_lock).
> >
> > Please double check these statements - this was just a simple brain dump.
> 
> Yes that would be a much more elegant way to handle it. Unfortunately,
> if I don't miss anything, the WRITE_ONCE/READ_ONCE would still be
> needed because batadv_tt_local_commit_changes_nolock() has to load
> tt.local_changes out of the lock to check if it needs to purge client
> and recompute CRCs.

Ah, you are right. I've missed this one.

Btw. just to make it clear: These changes wouldn't be for this patch/fix 
anyway. Just for a potential refactoring/cleanup patch for net-next.

Kind regards,
	Sven
--nextPart2577568.4XsnlVU6TS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ0A95QAKCRBND3cr0xT1
yxBxAQCWsSYaBfLkq6RxFzhdtISNR+istV/MNhfh4EW/HcJ59wEA9xUd8aQLdFlG
vCzVFMqJj9+1VVOYRiAmCldg8OH9eA0=
=6qvE
-----END PGP SIGNATURE-----

--nextPart2577568.4XsnlVU6TS--



