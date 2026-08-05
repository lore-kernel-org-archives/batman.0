Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACE3C55174
	for <batman@archiver.kernel.org>; Wed,  5 Aug 2026 18:46:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 48EEE841F7
	for <batman@archiver.kernel.org>; Wed, 05 Aug 2026 20:46:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785955614;
 b=wSVB10iLyRe+Myu4oUMHX7YvvV1jEYqCaSgPFKYGVHyzHQHbnZQ3LFa3Wfjj7nT0P0JxF
 B4CJQCi7WuAsY9UdY4FtRGJL4hHhRnZVVFOKUe8ajs72+NYVr9RNcBzpbvEr420RV1W1rJO
 r8FYEVKAu1Cz6xZcxKKev/+Rui4kRR8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785955614; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=izF6RbTK3ryHb0UiYYWKHgf4AC+ttT3Hg0m53fNVfRQ=;
 b=OuY9uXGflZARtFUCxh3oyD2twj7IRGLNdI2WubG26JgMnNs00XVYgVUxvDBCl7DGPIWAd
 eye2B4pt3uLBG2ovNSZf/akMXJLx5dZFN0NFyZYN9625M8vHGaJw84XwLbPUF0oQM+eodDE
 J/9fZ+d4DmDClaOwHRynBZeLbllyREE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2BE4C811BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 20:46:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785955601;
	b=p7E1s7RG34iQ2AUtQ+1XuKFce/SGVl6su8Yh0Ngh1IUErAEtRmnkzuM+5Cwk0snAu/YmTi
	c59rwkCcK++6/pwEBOcpXZsyMgAoEH86JKBmDXe7HqK9p0Fjbc7J7zUFTnH2N6iUv3XVn4
	oPQLbti1pt6BsZCJ5eGuwqygHdVr3Ro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785955601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=izF6RbTK3ryHb0UiYYWKHgf4AC+ttT3Hg0m53fNVfRQ=;
	b=x/Gk8Ckt7vkS8SCdwteHkd0PabtC4CQ2gs/EL68SEcNjt1xHs5KFQq1SNJwfoe74V/A9R8
	5l6ke8/TvhKQ/VWsKgoY0eXm48ZLDDFbriRO6OdWTxPp4dSGrxHaieFl3mrCuhO1dzwxu4
	Mg4xBcS3X3BroPXazcZDKob82d87W34=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ISMLKSVo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 261FC2035A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785955591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izF6RbTK3ryHb0UiYYWKHgf4AC+ttT3Hg0m53fNVfRQ=;
	b=ISMLKSVoCuex/y69Ze8y0RuXvS3N/gwKt3vVMVWsjyi8dlVnMfJOAMcRhEDJvOXnlw46xL
	jwvs//YkS5QSt5xz+lWZKvpbeBmxMDQczQKS+6G0p8Y8z2qyCwkUpoEDgq9BTz8nhzxuN0
	tPot0brj/eb5FFIsPBZgQ/MapJeKD84=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv v3 0/6] batman-adv: tt: atomic sashiko fixes
Date: Wed, 05 Aug 2026 20:46:27 +0200
Message-ID: <13818925.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6890536.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KAKEAPCYNZAMJ4753VWF45YURG7DAGRY
X-Message-ID-Hash: KAKEAPCYNZAMJ4753VWF45YURG7DAGRY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KAKEAPCYNZAMJ4753VWF45YURG7DAGRY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6890536.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 05 Aug 2026 20:46:27 +0200
Message-ID: <13818925.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
References: <20260805-tt-fixes-v3-0-25b00b558470@narfation.org>
MIME-Version: 1.0

On Wednesday, 5 August 2026 17:09:34 CEST Sven Eckelmann wrote:
> There were a couple of sashiko reports regarding the
> batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
> to handle them and at the same time already predict what else sashiko might
> report as next. I needed to change the batadv_tt_local_remove() hash
> interaction as preparation for the related NEW flag (and counter) handling.
> 
> And the netdev maintainers rejected this approach (for now). I had to
> re-add the atomic_t code parts back in this patchset. But since the netdev
> maintainers didn't like the atomic_t implementation, everything was changed
> to atomic_t with the help of scoped_guard().
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Changes in v3:
> - switched to spinlock_bh due to rejection atomic_t by netdev (and
>   potentially easier code)

Mixed up some corner case flag handling while converting it back from atomic_t 
to the original simple handling. My bad but easy to fix in v4.

But it is more problematic that the cleanup.h states:

 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

I am not 100% sure how to deal with this at the moment

Regards,
	Sven
--nextPart6890536.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanOFAwAKCRBND3cr0xT1
y4pNAQD/H8A9O7Xd5bG6fAtYHlIal08xiQ8V2CtoAHB1AMu6cQD/RoXpURmDzPpn
oQmpjv/Y8ynM1KqYdjQz8MnbuJdRVw8=
=PY7N
-----END PGP SIGNATURE-----

--nextPart6890536.DvuYhMxLoT--



