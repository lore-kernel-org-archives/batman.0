Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C22C47258
	for <batman@archiver.kernel.org>; Wed, 17 Jan 2024 09:31:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B6393818CE
	for <batman@archiver.kernel.org>; Wed, 17 Jan 2024 10:31:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1705483864;
 b=mnwK92n768FCl5ZKvu7UQxPbwqs5jPmWY1D92TFlTCXmeX4BdgNqrNgVpD3MFUwjrYXIJ
 4VRFfPWuExN3CE/djoSt1+WSTgbWQlryH8H391GiTW8u2gN+qQLPwcQxNpA4D5ZzjPnl0Up
 DrEVBqHXo0/5xhmlCAv0xZBwNdMd8KM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1705483864; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Tk4LN5O9pnCWEgZ+hxmp9V07AVwi66XGTPjDMnz4TZI=;
 b=fQqQyVdUH7ta5iWAvCueQDeFSt9eP3iyvjJzq18GSkvc+/s+LV/Uk9V+X4JiadB3w0XXy
 +V107T4+PekrImdUjYhEFcTZe4qAzlZFEmq02pwwBt+dwxkqqtuSJ7sC8tInFYquLgrRpER
 UADIdVH63dDWdJ/V3r2HWT9GiI01s7E=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1829380138
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 17 Jan 2024 10:30:58 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1705483858; a=rsa-sha256;
	cv=none;
	b=kg+NspxtGpAm8M2zxOMqqZzmKc1jHRlx0SZXnFzoomqg2nwDdZyFWmvGpVXH5E1amwkwIr
	CVaTru/IGSMMk/70z1pcsr+JCl787VPIV+fhhdOyFvoHI5rmPsW8dnyN2SvXML4Kd3XGcP
	LrLtXqdi4nykrs1ZVj6x9yFTp2vrIjQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=p5xUY96l;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1705483858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Tk4LN5O9pnCWEgZ+hxmp9V07AVwi66XGTPjDMnz4TZI=;
	b=a5+Y3+TGifbhsUCfWeb9CCK7xKCKi8rWwzb3YShbAkIBHEjC/Mwh+lX5XB0J37W1jxEfQg
	6S+oQUvBBOkSXnfFMK2BFKzgbubtIkYVuTHrSaTXKUo60Am2csKTPyq/3ILDFq3cO0bePy
	Lhs0EzS74SjNj468QyF+nyCLJi0AjLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1705483857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk4LN5O9pnCWEgZ+hxmp9V07AVwi66XGTPjDMnz4TZI=;
	b=p5xUY96lfFeFeJhxsbwHcRYD+mU0iiTWWayJr9+pflXvgduJMa0MUabV9ucUhctV0tnxyb
	G/J88rnnDt+mJy6D4JcoB1fCb1Ylw/QqdCO+vd5NSlCRYzk6QrTGdqYMCc/pW4ORw7+Zn5
	ypeyCcmwW36MTBpTR3Zu5AIR5LTx3To=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Wed, 17 Jan 2024 10:30:55 +0100
Message-ID: <5746181.DvuYhMxLoT@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6009036.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: EI2G4MN7GT2NWBYPHAS7KLXTAVJCN6WE
X-Message-ID-Hash: EI2G4MN7GT2NWBYPHAS7KLXTAVJCN6WE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EI2G4MN7GT2NWBYPHAS7KLXTAVJCN6WE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6009036.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Wed, 17 Jan 2024 10:30:55 +0100
Message-ID: <5746181.DvuYhMxLoT@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
MIME-Version: 1.0

On Tuesday, 16 January 2024 10:27:20 CET syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14620debe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a7031f9e71583b4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a344c1e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/82a7201eef4c/disk-052d5343.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ca12b4c31826/vmlinux-052d5343.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f07360ba5a8/bzImage-052d5343.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com


#syz test git://git.open-mesh.org/linux-merge.git a67d6793286ffab46b72b1afff5fb1f0ca55f2e1

Kind regards,
	Sven
--nextPart6009036.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWnnk8ACgkQXYcKB8Em
e0bcbBAAr5gtssx/V1po0W1ajwPIxK80mbSHo+Ch0/ZBvbJGsOcFGc83+vFBoEj8
2UE42Cqv/1PUM73gCOeyOItIBJ4Nr0FW7YmddfWORjvNpnG8s5v0Q5DAOpkTjGBq
RewEg1uWVerXh9RS5k/V6W0ZRDnnZnqT6EqOm/zd04XRnihgTME1xF6zPwctkIrM
2cudZhgkGDWKYI5GSPR5/hfkxXB/DK9tpS3LtJ73bSb+QJyd5WR/WPcPTY3+hpU+
IW+cwtCYCxR0GzCAtBvFQDQ+XeKu78A26QbWTXCJ4tQn1KwRKh+VZIHS5oyAEKgc
tdA6fmQioEpm4NZkpsRl1x09iR4xYeSn5oMR56XNrsxWhg7IhXL+HnHxMKP6oGOS
GlG54yTgfIvUz3jzlJqTRP8s/OhDnYdhacRSSOFZ53lRlNIlL8SNROPiie5gLqKW
gjkZagplFhLNf139twREGp5h8HE3VNuPb/2TFYClcSj/HTbVOKbyKD37JWuqlCi0
eVO269tCpIYdUOwA/4kAwnQMeAXu1/rIO8GkCfgbYok94wuGqbNzslHUUC7JrEf+
DkIeLCtnuvdo1AHt65r75hF+lQ7TSd4r4HD2j/Z2ssVvCVBiFJkCvvExh0Nz4FHr
3kq4Q1cnTb+4evLeqpWyjvSKwp1+wmgrgwbYP/5B81aT0d3KMeE=
=UkN8
-----END PGP SIGNATURE-----

--nextPart6009036.lOV4Wx5bFT--



