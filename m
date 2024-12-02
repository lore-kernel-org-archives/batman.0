Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27B3D78316
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 12:48:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2DA2283F6C
	for <batman@archiver.kernel.org>; Mon,  2 Dec 2024 13:48:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733143715;
 b=hWCjtsloLF+j9/CWsF442beqU5H4eemCHZ1qADH39SH/TA5u4dliUY9oSta4vk/+8AfMx
 9541+AtYFazpsxb/0mUHrLhwTT3obj4qo1B2W2iWlJ0TBh7PqOy4hHgdZbvGOKW+hJpwM/a
 cpH4Lb6wengVbLhbhCJL53lJCzcJWkc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733143715; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Xfp08pZGsQUE8P9yIeBaWGRBbGXhgeP5dT5ibpUyrLk=;
 b=1k6vShHsZSkOQPkoD0ysCM+h29BNA/Aj7UitLlQCBbkhqbNvpWZvG1bpmzcDHWq+fKSVj
 LuxP9hFeALn8YozZzYtPW420PluJeFpcjkfN9wtQvy2pNwSTctV7xwUqnkUz3rF44aFG/+2
 +2h2ipBOVdQEh3CDA/YeeCUSBLVPB9w=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6F7EC81EFE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  2 Dec 2024 13:48:13 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733143693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Xfp08pZGsQUE8P9yIeBaWGRBbGXhgeP5dT5ibpUyrLk=;
	b=ETLCSvRcZ0YWapyf8lGDFoDlc+LrahdeB/bRX8a02EveFwA9aBbxlkpXmtBmgFtg+3gVt6
	T1iDeZzMA8KvpKqt/FTx/DyxTca7ZvZYWRjb6oNnvTqBjN4eRHo24oDFla+sGLpqoivUqK
	9lrusoSTeF2r9L7yuJ8wOTWOacr8eII=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733143693; a=rsa-sha256;
	cv=none;
	b=KdisEt12VH5c84Nu2hbVEC7dFwwRUZhBDnXMZLrTCRdbCH8rQ8n3MPYCRxQKlX4K0VF4Em
	TEFOKn2kqRHO10yNKQJ9t0eZ26QCKq8RUW+AXDuUcNGOcJWCvacNQ8BK2QwaJJiDpw7VXg
	P8ZP00ZTgACn2YQbyee7d0js93xPnC8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UVu2sDTp;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1733143692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xfp08pZGsQUE8P9yIeBaWGRBbGXhgeP5dT5ibpUyrLk=;
	b=UVu2sDTp2I87EatcBL81lzrJRHmneCEAZ/3TDkXvGDNxlSUX54oD/i3DoEKz1gAc8se0S/
	3q9JTk3w+VHc3k57zlK40CjDRZc/mvCkKrtb9AUqBLdxUxxrS61nA+YHqUpyQd156FjQs9
	Qb7f2dMhjKi69Tqtc9l/Vx0Zzdazuag=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: [PATCH v3 3/3] batman-adv: avoid adding VLAN IDs 0 + 1 through kernel
 events
Date: Mon, 02 Dec 2024 13:48:09 +0100
Message-ID: <23745634.6Emhk5qWAg@ripper>
In-Reply-To: <20241202053511.326-4-linus.luessing@c0d3.blue>
References: 
 <20241202053511.326-1-linus.luessing@c0d3.blue>
 <20241202053511.326-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2633900.Lt9SDvczpP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KNVOCPCV542ZYQKEQPTMQXJXEGEFZ3HV
X-Message-ID-Hash: KNVOCPCV542ZYQKEQPTMQXJXEGEFZ3HV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KNVOCPCV542ZYQKEQPTMQXJXEGEFZ3HV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2633900.Lt9SDvczpP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 02 Dec 2024 13:48:09 +0100
Message-ID: <23745634.6Emhk5qWAg@ripper>
In-Reply-To: <20241202053511.326-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 2 December 2024 06:05:22 CET Linus L=FCssing wrote:
> Currently the 8021q module always registers VLAN ID 0

To ensure that HW filters would forward priority frames. If you follow the=
=20
argumentation in=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dad1afb00393915a51c21b1ae8704562bf036855f=20
then you can assume that the no-VLAN TT table entries should be used for=20
VLAN 0 because it is just for priority tagging - and not an actual VLAN.

> and the Linux
> bridge always registers VLAN ID 1 if bat0 is added to a bridge
> (probably as a quirk for hardware network/switch device drivers).

No, it is not a quirk. It just adds the default PVID of a bridge.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bridge/br_vlan.c?id=3De70140ba0d2b1a30467d4af6bcfe761327b9ec95#n1248

This sets as default PVID the 1:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bridge/br_vlan.c?id=3De70140ba0d2b1a30467d4af6bcfe761327b9ec95#n1218

And the default PVID could be changed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bridge/br_vlan.c?id=3De70140ba0d2b1a30467d4af6bcfe761327b9ec95#n1093

It will "disable" the PVID in case it is 0

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bridge/br_vlan.c?id=3De70140ba0d2b1a30467d4af6bcfe761327b9ec95#n1104

Kind regards,
	Sven
--nextPart2633900.Lt9SDvczpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ02siQAKCRBND3cr0xT1
ywEoAP0Z7O82g9kTYVOshODgQ29k4yNWw3AYIaQmgaDvOLN8QQD+IBNKpBAIhvPq
eBr2pAEy5HLD8Ie2R+bD1hAzhlpZQQs=
=csvu
-----END PGP SIGNATURE-----

--nextPart2633900.Lt9SDvczpP--



