Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850DEE9A02C
	for <batman-adv@archiver.kernel.org>; Wed, 18 Feb 2026 15:39:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B4C4F857AE
	for <batman-adv@archiver.kernel.org>; Wed, 18 Feb 2026 16:39:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1771429174;
 b=F30YVWa+fJ6hhcaRUvOs5wlbaSatmEUDxbUNXx9pZd47Its9ZPBjuOxIQDd2qMWwGSpe3
 Srp/fsiHp+9iJbteCb23Ojr31wuXIl0dCpbkGLzfAROuUnF+wGWqHRdnODQ+uwuX/bz9U4q
 +LPuvaqFfyJOpG4FbiGtb71iKk+mecE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1771429174; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8VvcYrea6sHh+GqMj/SJShm4gng7cbUXMHd15ATAHbI=;
 b=Y2nPZxwB8M0efswtqMUda9Uv6WBF8xohUE8Jp78etuVxI5W5zTJ9J1mpCDZFq9OsZXoTO
 LxtDAYn2NCi+XEbEwaXlOnTHZwl+WYp4V+iNhylr40SoSAcXNhx3sG9/kRFW0TpYt0zSzYU
 4UxQc1KVcrnbQrIke91JYVZfFZgdVxQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D128A84289
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Feb 2026 16:39:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1771429160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8VvcYrea6sHh+GqMj/SJShm4gng7cbUXMHd15ATAHbI=;
	b=zDfGfijLamnhpKy6LnVZROSW4rR9JkbN6aXUSLl0xEeKiKZQCNiSjqsyF0qW7yrvvl0QxP
	ygEPUOSLpU2x3OQcyqlMSI3oWiP7WzLsjjTXYbIc5onKOLP2nCMBl1xEKyS0DURs67fi5x
	pUMSK1hEP6UiPjNMYUAW274fIg84vIc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="o/rT4i6m";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1771429160;
	b=BXVyShPZiuAVHioil69wESBiEURlkvdvC51EMi0/g5GR+zdwF1xpYrOV5+2KQAujYS//on
	/xz6oHrbmg7nHpc04kdHQZkbZr9BX1jzLwhCPjQ3JZW7UBEOwIs2qH3JFdMuGfaGrNNoNo
	8x+Nf2Khl5keucSEorrKErWbeVZFcPc=
Received: by dvalin.narfation.org (Postfix) id 8E0181FF29
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Feb 2026 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1771429158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VvcYrea6sHh+GqMj/SJShm4gng7cbUXMHd15ATAHbI=;
	b=o/rT4i6mETScccBcuPqniBee+n4wURzbRg23kfqVuTxkvEHyomjWx8L447jGnT47amj+cm
	rejBYlLMnKFdLCgu6tECDbfJhpAzOL0Kyych75KbU2sOeigcd7ApdQJfbqikb8ynG0mSXK
	FwtEbN0zdZ/QsR6RgyAO+RwlsuDeDg0=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: Avoid double-rtnl_lock ELP metric worker
Date: Wed, 18 Feb 2026 16:39:16 +0100
Message-ID: <2032168.PYKUYFuaPT@ripper>
In-Reply-To: 
 <20260216-double-rtnl-lock-throughput-v1-1-513f66d3b36e@narfation.org>
References: 
 <20260216-double-rtnl-lock-throughput-v1-1-513f66d3b36e@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23010935.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 525DKXXKOUYSDQLG4YDQZHLVHDKXQ6ZR
X-Message-ID-Hash: 525DKXXKOUYSDQLG4YDQZHLVHDKXQ6ZR
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart23010935.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 18 Feb 2026 16:39:16 +0100
Message-ID: <2032168.PYKUYFuaPT@ripper>
MIME-Version: 1.0

On Monday, 16 February 2026 20:05:55 CET Sven Eckelmann wrote:
> batadv_v_elp_get_throughput() might be called when the RTNL lock is alrea=
dy
> held. This could be problematic when the work queue item is canceled via
> cancel_delayed_work_sync() in batadv_v_elp_iface_disable(). In this case,
> an rtnl_lock() would cause a deadlock.
>=20
> To avoid this, rtnl_trylock() was used in this function to skip the
> retrieval of the ethtool information in case the RTNL lock was already
> held.
>=20
> But for cfg80211 interfaces, batadv_get_real_netdev() was called - which
> also uses rtnl_lock(). The approach for __ethtool_get_link_ksettings() mu=
st
> also be used instead and the lockless version __batadv_get_real_netdev()
> has to called.
>=20
> Fixes: 405d49a20a20 ("batman-adv: Drop unmanaged ELP metric worker")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v_elp.c      | 10 +++++++++-
>  net/batman-adv/hard-interface.c |  8 ++++----
>  net/batman-adv/hard-interface.h |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)


Via github [1]:

Reported-by: Christian Schmidbauer <github@grische.xyz>
Tested-by: S=C3=B6ren Skaarup <freifunk_nordm4nn@gmx.de>

Regards,
	Sven

[1] https://github.com/freifunkMUC/site-ffm/issues/776#issuecomment-3920865=
984
--nextPart23010935.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaZXdJAAKCRBND3cr0xT1
y4g2AQCJi6xJCAj2mMDyTpOw/In+7qZr6oEgiJbhHLqUaK/9hwD/cfjpvJLRiI1U
U5syhR6f0hAL0VxcgexYuf0ERYp7oAY=
=Tz3m
-----END PGP SIGNATURE-----

--nextPart23010935.EfDdHjke4D--



