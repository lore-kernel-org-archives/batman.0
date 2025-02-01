Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7DC0218A
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 09:43:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6BE8A83E48
	for <batman-adv@archiver.kernel.org>; Sat,  1 Feb 2025 10:43:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738402988;
 b=3Am0d3zR3icZ4vrjjRqrRdqIXWaoxGiyo686rkgAx9Pjmzd2zAQtWcX+lWsJc1LU3m5pv
 R70jdbKxM4x7WGyyb3dDGzrgOkIrKC/tkCt09KqpTkZWk6QGjzplO1BNFByAnPnc//WDaBR
 dBGxeseSWdd5jY9PDpD25PcdBd1WFQg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738402988; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QJVw8oG8c7tLjUQ/WTe7JEOOsdrjlVDMGlvrKupVjME=;
 b=YBRUgKfhZ+7q/FSpwfjI9zppUqMfYjoxX3dIymrsrsUMgJUrou9NIKjKWjycVPfNUqSTg
 AvRxGU2KeS6xkVOUzY4i8Zq8HIS/9NYhLgEq8h5N2bf7BtJj2+qz+q7D6/1yPhasyeitjDM
 2SmOHvjnPCBiVQDTAZcFmXuazyQ9C2A=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A8FFE81EC7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  1 Feb 2025 10:42:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738402980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QJVw8oG8c7tLjUQ/WTe7JEOOsdrjlVDMGlvrKupVjME=;
	b=bIW784ipr6QeWm1xnsUzQ/fAgdgKFHl4czDsMm9NU7BJtHnDZGcitEQ3PMyeI6S5d5faOv
	gA4UqIvTl96wRjZ0DyEhr+TFd8pdzI+G4Yd73Pm69VJqCcEkQuhLEzMUAC3RyQDQapA5yb
	MqkSJIzFugmLzBJvibxi/f80oDFPhG4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cjTo00mj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738402980; a=rsa-sha256;
	cv=none;
	b=ajFXUZd9TLNn4rd6UAYE2r8RRMfYNbrt8Yu+rUAy0TLF0k6K9854S7EvOdpJvqsmIhyLna
	7d4o78O74JT3HwGTi/9CUrM6u2p4y59H1GpEav6/1YEbMpLvGbPGegECl6dY/fOZLagsYV
	Z8pR7zE41dYz2tZThaBI8TTlMSzsbXQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738402978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJVw8oG8c7tLjUQ/WTe7JEOOsdrjlVDMGlvrKupVjME=;
	b=cjTo00mjzsH7sUQCorVAVKc2gcAt7VRT8w615SH1QbtH8XZ/s0HE0oVVQUOdnwXlTXxIQ0
	orXbDz9BYAamOXQsiHUbl4L+iRAA1rnahIJCLqu67qPjyka/H8r8RNkdA+YS7yv331jrz1
	XDVGIXOzI6mq6u4LDsCs05tSjdOyMVo=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 Antonio Quartulli <a@unstable.cc>
Subject: Re: [PATCH v5 0/3] batman-adv: add dynamic,
 bridged-in TT VID detection
Date: Sat, 01 Feb 2025 10:42:54 +0100
Message-ID: <2662292.atdPhlSkOF@sven-l14>
In-Reply-To: <20250201043725.15217-1-linus.luessing@c0d3.blue>
References: <20250201043725.15217-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart47764768.fMDQidcC6G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 2BCOEA4V5OQ2QJ4WGGKW4U7QXQ3Y5R7U
X-Message-ID-Hash: 2BCOEA4V5OQ2QJ4WGGKW4U7QXQ3Y5R7U
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2BCOEA4V5OQ2QJ4WGGKW4U7QXQ3Y5R7U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart47764768.fMDQidcC6G
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 01 Feb 2025 10:42:54 +0100
Message-ID: <2662292.atdPhlSkOF@sven-l14>
In-Reply-To: <20250201043725.15217-1-linus.luessing@c0d3.blue>
References: <20250201043725.15217-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Saturday, 1 February 2025 05:31:27 GMT+1 Linus L=C3=BCssing wrote:
> v5:
> * rebased to current main branch:
>   -> PATCH 3/3 needed to readd the include for soft-interface.h for
>      batadv_softif_get_bridge() since commit
>      "50eddf397ac3 batman-adv: netlink: reduce duplicate code by returnin=
g interfaces"

I see also following reports:

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
    index 051e7fce..30f65708 100644
    --- a/net/batman-adv/soft-interface.c
    +++ b/net/batman-adv/soft-interface.c
    @@ -23,6 +23,7 @@
     #include <linux/kref.h>
     #include <linux/list.h>
     #include <linux/lockdep.h>
    +#include <linux/net.h>
     #include <linux/netdevice.h>
     #include <linux/netlink.h>
     #include <linux/percpu.h>

ecsv/pu: kerneldoc ./net/batman-adv/soft-interface.c
=2D---------------------------------------------------

    ./net/batman-adv/soft-interface.c:566: warning: Function parameter or s=
truct member 'own' not described in 'batadv_softif_create_vlan'
    ./net/batman-adv/soft-interface.c:626: warning: Function parameter or s=
truct member 'own' not described in 'batadv_softif_vlan_get_or_create'

ecsv/pu: unused_symbols
=2D----------------------

cfg:

 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * unused_symbols cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy

    batadv_softif_get_bridge


I am guessing I must just ignore the latter because it is only relevant for=
=20
non-mcast build and the noise from the extra #ifdef around "static" isn't=20
worth it.

The the linux/net.h "dependency" came with the second patch

Btw. I am still waiting for reviews from Antonio

Kind regards,
	Sven
--nextPart47764768.fMDQidcC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ53sngAKCRBND3cr0xT1
y+r4AP9BAWlHKfYTodO7NpmHRmFFObbnYr5PigWwYEgQzXPaYwD9FcKAJ5+NXRT0
giKrnVXFoiwtTb5EqTQ5kBrcMA9wgAc=
=P3jy
-----END PGP SIGNATURE-----

--nextPart47764768.fMDQidcC6G--



