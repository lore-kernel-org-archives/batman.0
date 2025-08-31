Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B3ACA0FF2
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 16:15:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1877983FEC
	for <batman-adv@archiver.kernel.org>; Sun, 31 Aug 2025 18:15:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756656922;
 b=RaIzBSpWu/hEeveTb5NKCD+RxYsh4j1BRwO8XQe++wGs+fT1y1QZKMkeo8Fcz560yqDXh
 hHG/iJOYwQryOtDNjCagvGs9UITK3ILjPaxdYA4tZ6kG6nx6FBN0bSb3qeafJeaH4rWMuhN
 aSBNtfE0Bvcuq3yReTI2H0LnJKiKY3U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756656922; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UFZOPVediVwuRxe6r+4Wa37xvCa737fwNZyA3Rpu27E=;
 b=Yo07XZuQc8/Z/xHfgdT1FQu9RvDvbP+DYQV7WsmvOzPX7R1EOwZ2zeYwF4hwhiC2rMlmN
 e3ej/jQiQi8xh84Fs8Z4l2RuTx2sIyse3jU2ifif2yUq2iLy1fXGPzhE/nHV0KsVotZCNZe
 AJ14oYcfhM0LQkqW9CWyISd5l9yr/pU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=hundeboll.net;
 arc=pass;
 dmarc=pass header.from=hundeboll.net policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=hundeboll.net;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=hundeboll.net policy.dmarc=quarantine
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 821E481A32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 31 Aug 2025 18:14:53 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756656903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UFZOPVediVwuRxe6r+4Wa37xvCa737fwNZyA3Rpu27E=;
	b=DLH+Thixt/14Hwd+ZsZWS95TRszI9xeSC6V+gXCX+dZLXFvoi7amWK+eTB0zlkbz+UTenn
	8UA4YE1rTW/xYYMDq6+p9DuV1RdlJBYIZpvaJ8EKLVH1HuIlfl8LBFdTT8ceEOiBmzkL0T
	oHoVrcQKhtXQUfNQG7tSnxsUCCHb7W4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=hundeboll.net header.s=first header.b="kmV1/AIw";
	dmarc=pass (policy=quarantine) header.from=hundeboll.net;
	spf=pass (diktynna.open-mesh.org: domain of martin@hundeboll.net designates
 116.203.34.67 as permitted sender) smtp.mailfrom=martin@hundeboll.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756656903; a=rsa-sha256;
	cv=none;
	b=MnCWzXbPeTkAx2si2fAdGekbEoO0dPNX5IpeZc5WOFn7LaOWLfO6ZpfUOk/u/0mMNKoKRl
	n5NsHCKgkTdcP3qlfWjpEqaIdN3eiAl1sd73SBEL5vfoyIikah/SXy9KU+guX/bMjwEqMv
	1gr1xRrWPhCkCe2ulMzo5ihA0qii5N4=
Received: from dummy.faircode.eu (0x5da5f928.static.cust.fastspeed.dk
 [93.165.249.40])
	by first.geanix.com (Postfix) with ESMTPSA id 2335F2076D2;
	Sun, 31 Aug 2025 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hundeboll.net;
	s=first; t=1756656892;
	bh=UFZOPVediVwuRxe6r+4Wa37xvCa737fwNZyA3Rpu27E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kmV1/AIwXXTf8c9pGKcoiQ4vXgzR6RMYVhqzN+iT5Ahh4Mi9KAudycRva0Pn8uzIR
	 B8HNlz0RAeort/HDbo8xdU2tFDW7ZW2RvU8n0cltMMxCMa6TyBHmDAAaVGz3RKKnzw
	 ejFNS4IlliF197wVau7ZxNTHu5WzpSI28sUbcaVDm4SszloguvsNlT49ad5dWrZPTN
	 eaK5lgr+/4Mlk+PvhtJwdLWCxnHj5nFElpG//vBtxkUYklyGTXeKC97yhFzyM0fFIa
	 t3pf/mA8NVjgvBqJ42rj6dMn/h2n0Aez0SGB6fIdH10T3YPNBRshpaeHJFlJxLKHUq
	 yR7/at4sq0j6w==
Date: Sun, 31 Aug 2025 18:14:52 +0200 (GMT+02:00)
From: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@hundeboll.net>
To: Sven Eckelmann <sven@narfation.org>
Message-ID: <521509b8-5c66-4a90-8c30-8a185b1365f3@hundeboll.net>
In-Reply-To: <20250831-drop-catwoman-v1-1-1071bb2a159a@narfation.org>
References: <20250831-drop-catwoman-v1-0-1071bb2a159a@narfation.org>
 <20250831-drop-catwoman-v1-1-1071bb2a159a@narfation.org>
Subject: Re: [PATCH 1/2] batman-adv: remove network coding support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <521509b8-5c66-4a90-8c30-8a185b1365f3@hundeboll.net>
Message-ID-Hash: QOWH7NSZZE32LU2ERMVZHRRTR6AJ6GLK
X-Message-ID-Hash: QOWH7NSZZE32LU2ERMVZHRRTR6AJ6GLK
X-MailFrom: martin@hundeboll.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QOWH7NSZZE32LU2ERMVZHRRTR6AJ6GLK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Aug 31, 2025 17:41:37 Sven Eckelmann <sven@narfation.org>:

> The Network Coding feature was introduced in 2013 as a GSoC project,
> based on the master thesis "Inter-Flow Network Coding for Wireless Mesh
> Networks". It relied on the assumption that neighboring mesh nodes could
> reliably overhear each other's transmissions in promiscuous mode, allowin=
g
> packets to be combined to reduce forwarding overhead.
>
> This assumption no longer holds for modern wireless mesh networks, which
> are heterogeneous and make overhearing increasingly unreliable. Factors
> such as multiple spatial streams, varying data rates, beamforming, and
> OFDMA all prevent nodes from consistently overhearing each other. The cur=
rent
> implementation in batman-adv is not able to detect these conditions and w=
ould
> require a more complex layer beyond its neighbor discovery process to do =
so.
>
> In addition, the feature has been unmaintained for years and is discourag=
ed
> for use. None of the current maintainers have the required test
> setup to verify its functionality, and known issues remain in its data
> structures (reference counting, RCU usage, and cleanup handling). Its
> continued presence also blocks necessary refactoring of the core originat=
or
> infrastructure.
>
> Remove this obsolete and unmaintained feature.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

Thanks for doing this, Sven. And thanks for introducing me to kernel contri=
butions back in 2010.

No need to change the commit message, but the GSoC project was fragmentatio=
n handling, not network coding, which was added a few years earlier (I thin=
k).

// Martin

> ---
> Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 -
> README.external.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> gen-compat-autoconf.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> net/batman-adv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 -
> net/batman-adv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> net/batman-adv/bat_iv_ogm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 5 -
> net/batman-adv/log.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 -
> net/batman-adv/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 16 -
> net/batman-adv/main.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 -
> net/batman-adv/mesh-interface.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 -
> net/batman-adv/netlink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 17 -
> net/batman-adv/network-coding.c=C2=A0=C2=A0=C2=A0 | 1878 ----------------=
--------------------
> net/batman-adv/network-coding.h=C2=A0=C2=A0=C2=A0 |=C2=A0 106 --
> net/batman-adv/originator.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 6 -
> net/batman-adv/routing.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 9 +-
> net/batman-adv/send.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 16 +-
> net/batman-adv/translation-table.c |=C2=A0=C2=A0=C2=A0 4 +-
> net/batman-adv/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 216 -----
> 18 files changed, 4 insertions(+), 2307 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c29d6f5f1890031a385ba7268a49c9eda716935b..ae3fd885d3e69173827a75c82=
2bad77769d76621 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,8 +14,6 @@ export CONFIG_BATMAN_ADV_DAT=3Dy
> export CONFIG_BATMAN_ADV_DEBUG=3Dn
> # B.A.T.M.A.N. multicast optimizations:
> export CONFIG_BATMAN_ADV_MCAST=3Dy
> -# B.A.T.M.A.N network coding (catwoman):
> -export CONFIG_BATMAN_ADV_NC=3Dn
> # B.A.T.M.A.N. tracing support:
> export CONFIG_BATMAN_ADV_TRACING=3Dn
>
> @@ -58,7 +56,6 @@ BUILD_FLAGS :=3D \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_DEBUG=3D$(CONFIG_BATMAN_ADV_DEBUG) \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_BLA=3D$(CONFIG_BATMAN_ADV_BLA) \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_DAT=3D$(CONFIG_BATMAN_ADV_DAT) \
> -=C2=A0=C2=A0 CONFIG_BATMAN_ADV_NC=3D$(CONFIG_BATMAN_ADV_NC) \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_MCAST=3D$(CONFIG_BATMAN_ADV_MCAST) \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_TRACING=3D$(CONFIG_BATMAN_ADV_TRACIN=
G) \
> =C2=A0=C2=A0=C2=A0 CONFIG_BATMAN_ADV_BATMAN_V=3D$(CONFIG_BATMAN_ADV_BATMA=
N_V) \
> diff --git a/README.external.rst b/README.external.rst
> index 06b9033e49cc49441f4ab04f43512849e46ec860..bff62a9701f75a1d40733b554=
5e80c79b86a8716 100644
> --- a/README.external.rst
> +++ b/README.external.rst
> @@ -48,7 +48,6 @@ module).=C2=A0 Available=C2=A0 options=C2=A0 and=C2=A0 =
their=C2=A0=C2=A0=C2=A0 possible=C2=A0=C2=A0 values are
> =C2=A0 * ``CONFIG_BATMAN_ADV_DAT=3D[y*|n]`` (B.A.T.M.A.N. Distributed ARP=
 Table)
> =C2=A0 * ``CONFIG_BATMAN_ADV_DEBUG=3D[y|n*]`` (B.A.T.M.A.N. debugging)
> =C2=A0 * ``CONFIG_BATMAN_ADV_MCAST=3D[y*|n]`` (B.A.T.M.A.N. multicast opt=
imizations)
> - * ``CONFIG_BATMAN_ADV_NC=3D[y|n*]`` (B.A.T.M.A.N. Network Coding)
> =C2=A0 * ``CONFIG_BATMAN_ADV_TRACING=3D[y|n*]`` (B.A.T.M.A.N. tracing sup=
port)
>
> e.g., debugging can be enabled by::
> diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
> index 3b9fc31f1ed81bc1bb148e57e236ed98608210d8..39742f06e85e726d5f7779e30=
4b7ac7f175fa665 100755
> --- a/gen-compat-autoconf.sh
> +++ b/gen-compat-autoconf.sh
> @@ -45,7 +45,6 @@ gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_=
BLA:=3D"y"} >> "${TMP}"
> gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:=3D"y"} >> "${=
TMP}"
> gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:=3D"n"} >>=
 "${TMP}"
> gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:=3D"y"} >>=
 "${TMP}"
> -gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:=3D"n"} >> "${T=
MP}"
> gen_config 'CONFIG_BATMAN_ADV_TRACING' ${CONFIG_BATMAN_ADV_TRACING:=3D"n"=
} >> "${TMP}"
>
> # only regenerate compat-autoconf.h when config was changed
> diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
> index 20b316207f9aa6e52cc7d37616cfdbba741b3d61..c299e2bc87eda118f35c4d9b6=
a718927951e09b2 100644
> --- a/net/batman-adv/Kconfig
> +++ b/net/batman-adv/Kconfig
> @@ -53,19 +53,6 @@ config BATMAN_ADV_DAT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mesh networks. If you think that your netw=
ork does not need
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this option you can safely remove it and s=
ave some space.
>
> -config BATMAN_ADV_NC
> -=C2=A0=C2=A0 bool "Network Coding"
> -=C2=A0=C2=A0 depends on BATMAN_ADV
> -=C2=A0=C2=A0 help
> -=C2=A0=C2=A0=C2=A0=C2=A0 This option enables network coding, a mechanism=
 that aims to
> -=C2=A0=C2=A0=C2=A0=C2=A0 increase the overall network throughput by fusi=
ng multiple
> -=C2=A0=C2=A0=C2=A0=C2=A0 packets in one transmission.
> -=C2=A0=C2=A0=C2=A0=C2=A0 Note that interfaces controlled by batman-adv m=
ust be manually
> -=C2=A0=C2=A0=C2=A0=C2=A0 configured to have promiscuous mode enabled in =
order to make
> -=C2=A0=C2=A0=C2=A0=C2=A0 network coding work.
> -=C2=A0=C2=A0=C2=A0=C2=A0 If you think that your network does not need th=
is feature you
> -=C2=A0=C2=A0=C2=A0=C2=A0 can safely disable it and save some space.
> -
> config BATMAN_ADV_MCAST
> =C2=A0=C2=A0=C2=A0 bool "Multicast optimisation"
> =C2=A0=C2=A0=C2=A0 depends on BATMAN_ADV && INET && !(BRIDGE=3Dm && BATMA=
N_ADV=3Dy)
> diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
> index 1cc9be6de4569a1cf18de2f94f56ae678e043a94..d3c4d4143c144280a7a410761=
ce85fdb4d0b1e71 100644
> --- a/net/batman-adv/Makefile
> +++ b/net/batman-adv/Makefile
> @@ -23,7 +23,6 @@ batman-adv-y +=3D mesh-interface.o
> batman-adv-$(CONFIG_BATMAN_ADV_MCAST) +=3D multicast.o
> batman-adv-$(CONFIG_BATMAN_ADV_MCAST) +=3D multicast_forw.o
> batman-adv-y +=3D netlink.o
> -batman-adv-$(CONFIG_BATMAN_ADV_NC) +=3D network-coding.o
> batman-adv-y +=3D originator.o
> batman-adv-y +=3D routing.o
> batman-adv-y +=3D send.o
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 54fe38b3b2fd3052cd64b1ed86ee77fcf1dac51c..b75c2228e69a652c21f240eaf=
a5bddf25261b06b 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -52,7 +52,6 @@
> #include "hash.h"
> #include "log.h"
> #include "netlink.h"
> -#include "network-coding.h"
> #include "originator.h"
> #include "routing.h"
> #include "send.h"
> @@ -1406,10 +1405,6 @@ batadv_iv_ogm_process_per_outif(const struct sk_bu=
ff *skb, int ogm_offset,
> =C2=A0=C2=A0=C2=A0 if (!orig_neigh_node)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>
> -=C2=A0=C2=A0 /* Update nc_nodes of the originator */
> -=C2=A0=C2=A0 batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_no=
de,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ogm_packet, is_single_hop_neigh);
> -
> =C2=A0=C2=A0=C2=A0 orig_neigh_router =3D batadv_orig_router_get(orig_neig=
h_node,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if_outgoing);
>
> diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
> index 567afaa8df9989771daa2b71f9a3f9edb7c01914..225b747a2048efdb86d56791c=
cab8356f2a9253f 100644
> --- a/net/batman-adv/log.h
> +++ b/net/batman-adv/log.h
> @@ -51,9 +51,6 @@ enum batadv_dbg_level {
> =C2=A0=C2=A0=C2=A0 /** @BATADV_DBG_DAT: ARP snooping and DAT related mess=
ages */
> =C2=A0=C2=A0=C2=A0 BATADV_DBG_DAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D BIT(4=
),
>
> -=C2=A0=C2=A0 /** @BATADV_DBG_NC: network coding related messages */
> -=C2=A0=C2=A0 BATADV_DBG_NC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D BIT(5=
),
> -
> =C2=A0=C2=A0=C2=A0 /** @BATADV_DBG_MCAST: multicast related messages */
> =C2=A0=C2=A0=C2=A0 BATADV_DBG_MCAST=C2=A0=C2=A0=C2=A0 =3D BIT(6),
>
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 20346d7b6b69178f7487e99af05851dfebbefb2b..1dcacfc310ee9ccbe58519e96=
ce3a317eaf3ac58 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -53,7 +53,6 @@
> #include "mesh-interface.h"
> #include "multicast.h"
> #include "netlink.h"
> -#include "network-coding.h"
> #include "originator.h"
> #include "routing.h"
> #include "send.h"
> @@ -103,7 +102,6 @@ static int __init batadv_init(void)
>
> =C2=A0=C2=A0=C2=A0 batadv_v_init();
> =C2=A0=C2=A0=C2=A0 batadv_iv_init();
> -=C2=A0=C2=A0 batadv_nc_init();
> =C2=A0=C2=A0=C2=A0 batadv_tp_meter_init();
>
> =C2=A0=C2=A0=C2=A0 batadv_event_workqueue =3D create_singlethread_workque=
ue("bat_events");
> @@ -218,12 +216,6 @@ int batadv_mesh_init(struct net_device *mesh_iface)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_dat;
> =C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0 ret =3D batadv_nc_mesh_init(bat_priv);
> -=C2=A0=C2=A0 if (ret < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&bat_priv->mesh_state, B=
ATADV_MESH_DEACTIVATING);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_nc;
> -=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0 batadv_gw_init(bat_priv);
> =C2=A0=C2=A0=C2=A0 batadv_mcast_init(bat_priv);
>
> @@ -232,8 +224,6 @@ int batadv_mesh_init(struct net_device *mesh_iface)
>
> =C2=A0=C2=A0=C2=A0 return 0;
>
> -err_nc:
> -=C2=A0=C2=A0 batadv_dat_free(bat_priv);
> err_dat:
> =C2=A0=C2=A0=C2=A0 batadv_bla_free(bat_priv);
> err_bla:
> @@ -264,7 +254,6 @@ void batadv_mesh_free(struct net_device *mesh_iface)
> =C2=A0=C2=A0=C2=A0 batadv_gw_node_free(bat_priv);
>
> =C2=A0=C2=A0=C2=A0 batadv_v_mesh_free(bat_priv);
> -=C2=A0=C2=A0 batadv_nc_mesh_free(bat_priv);
> =C2=A0=C2=A0=C2=A0 batadv_dat_free(bat_priv);
> =C2=A0=C2=A0=C2=A0 batadv_bla_free(bat_priv);
>
> @@ -336,11 +325,6 @@ int batadv_max_header_len(void)
> =C2=A0=C2=A0=C2=A0 header_len =3D max_t(int, header_len,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sizeof(struct batadv_bcast_packet));
>
> -#ifdef CONFIG_BATMAN_ADV_NC
> -=C2=A0=C2=A0 header_len =3D max_t(int, header_len,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizeof(struct batadv_coded_packet));
> -#endif
> -
> =C2=A0=C2=A0=C2=A0 return header_len + ETH_HLEN;
> }
>
> diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
> index 1481eb2bacee33736adfda4211f237440e6f7b4f..170689de7288a50b5c85dd9fb=
5911c1f1476421b 100644
> --- a/net/batman-adv/main.h
> +++ b/net/batman-adv/main.h
> @@ -121,8 +121,6 @@
> #define BATADV_RESET_PROTECTION_MS 30000
> #define BATADV_EXPECTED_SEQNO_RANGE=C2=A0=C2=A0=C2=A0 65536
>
> -#define BATADV_NC_NODE_TIMEOUT 10000 /* Milliseconds */
> -
> /**
> =C2=A0 * BATADV_TP_MAX_NUM - maximum number of simultaneously active tp s=
essions
> =C2=A0 */
> diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interf=
ace.c
> index 5872818f4e31e52e9c8cf4118d8857e1169b5197..ea82767c2a10c46c801d6c4f3=
65abc998d93b5bc 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -46,7 +46,6 @@
> #include "gateway_client.h"
> #include "hard-interface.h"
> #include "multicast.h"
> -#include "network-coding.h"
> #include "send.h"
> #include "translation-table.h"
>
> @@ -802,8 +801,6 @@ static int batadv_meshif_init_late(struct net_device =
*dev)
>
> =C2=A0=C2=A0=C2=A0 bat_priv->primary_if =3D NULL;
>
> -=C2=A0=C2=A0 batadv_nc_init_bat_priv(bat_priv);
> -
> =C2=A0=C2=A0=C2=A0 if (!bat_priv->algo_ops) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D batadv_algo_select(bat=
_priv, batadv_routing_algo);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> @@ -947,17 +944,6 @@ static const struct {
> =C2=A0=C2=A0=C2=A0 { "dat_put_rx" },
> =C2=A0=C2=A0=C2=A0 { "dat_cached_reply_tx" },
> #endif
> -#ifdef CONFIG_BATMAN_ADV_NC
> -=C2=A0=C2=A0 { "nc_code" },
> -=C2=A0=C2=A0 { "nc_code_bytes" },
> -=C2=A0=C2=A0 { "nc_recode" },
> -=C2=A0=C2=A0 { "nc_recode_bytes" },
> -=C2=A0=C2=A0 { "nc_buffer" },
> -=C2=A0=C2=A0 { "nc_decode" },
> -=C2=A0=C2=A0 { "nc_decode_bytes" },
> -=C2=A0=C2=A0 { "nc_decode_failed" },
> -=C2=A0=C2=A0 { "nc_sniffed" },
> -#endif
> };
>
> static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 =
*data)
> diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> index 399724d5a2cd170b5f8c4f2db463025cd4580342..e52f44e73cd1db611d486a4c4=
834dc7960bbecab 100644
> --- a/net/batman-adv/netlink.c
> +++ b/net/batman-adv/netlink.c
> @@ -44,7 +44,6 @@
> #include "log.h"
> #include "mesh-interface.h"
> #include "multicast.h"
> -#include "network-coding.h"
> #include "originator.h"
> #include "tp_meter.h"
> #include "translation-table.h"
> @@ -144,7 +143,6 @@ static const struct nla_policy batadv_netlink_policy[=
NUM_BATADV_ATTR] =3D {
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_LOG_LEVEL]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D { .type =3D NLA_U32 },
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]=C2=A0 =3D {=
 .type =3D NLA_U8 },
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_MULTICAST_FANOUT]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D { .type =3D NLA_U32 },
> -=C2=A0=C2=A0 [BATADV_ATTR_NETWORK_CODING_ENABLED]=C2=A0=C2=A0=C2=A0 =3D =
{ .type =3D NLA_U8 },
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_ORIG_INTERVAL]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D { .type =3D NLA_U32 },
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_ELP_INTERVAL]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D { .type =3D NLA_U32 },
> =C2=A0=C2=A0=C2=A0 [BATADV_ATTR_THROUGHPUT_OVERRIDE]=C2=A0=C2=A0 =3D { .t=
ype =3D NLA_U32 },
> @@ -345,12 +343,6 @@ static int batadv_netlink_mesh_fill(struct sk_buff *=
msg,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nla_put_failure;
> #endif /* CONFIG_BATMAN_ADV_MCAST */
>
> -#ifdef CONFIG_BATMAN_ADV_NC
> -=C2=A0=C2=A0 if (nla_put_u8(msg, BATADV_ATTR_NETWORK_CODING_ENABLED,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 !!atomic_read(&bat_priv->network_coding)))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nla_put_failure;
> -#endif /* CONFIG_BATMAN_ADV_NC */
> -
> =C2=A0=C2=A0=C2=A0 if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic=
_read(&bat_priv->orig_interval)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nla_put_failure;
> @@ -588,15 +580,6 @@ static int batadv_netlink_set_mesh(struct sk_buff *s=
kb, struct genl_info *info)
> =C2=A0=C2=A0=C2=A0 }
> #endif /* CONFIG_BATMAN_ADV_MCAST */
>
> -#ifdef CONFIG_BATMAN_ADV_NC
> -=C2=A0=C2=A0 if (info->attrs[BATADV_ATTR_NETWORK_CODING_ENABLED]) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr =3D info->attrs[BATADV_ATTR_NE=
TWORK_CODING_ENABLED];
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&bat_priv->network_codin=
g, !!nla_get_u8(attr));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_status_update(bat_priv->m=
esh_iface);
> -=C2=A0=C2=A0 }
> -#endif /* CONFIG_BATMAN_ADV_NC */
> -
> =C2=A0=C2=A0=C2=A0 if (info->attrs[BATADV_ATTR_ORIG_INTERVAL]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 orig_interval;
>
> diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-cod=
ing.c
> deleted file mode 100644
> index af97d077369f9b62000d4e0ecc575870aba1f330..0000000000000000000000000=
000000000000000
> --- a/net/batman-adv/network-coding.c
> +++ /dev/null
> @@ -1,1878 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (C) B.A.T.M.A.N. contributors:
> - *
> - * Martin Hundeb=C3=B8ll, Jeppe Ledet-Pedersen
> - */
> -
> -#include "network-coding.h"
> -#include "main.h"
> -
> -#include <linux/atomic.h>
> -#include <linux/bitops.h>
> -#include <linux/byteorder/generic.h>
> -#include <linux/compiler.h>
> -#include <linux/container_of.h>
> -#include <linux/errno.h>
> -#include <linux/etherdevice.h>
> -#include <linux/gfp.h>
> -#include <linux/if_ether.h>
> -#include <linux/if_packet.h>
> -#include <linux/init.h>
> -#include <linux/jhash.h>
> -#include <linux/jiffies.h>
> -#include <linux/kref.h>
> -#include <linux/list.h>
> -#include <linux/lockdep.h>
> -#include <linux/net.h>
> -#include <linux/netdevice.h>
> -#include <linux/printk.h>
> -#include <linux/random.h>
> -#include <linux/rculist.h>
> -#include <linux/rcupdate.h>
> -#include <linux/skbuff.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <linux/stddef.h>
> -#include <linux/string.h>
> -#include <linux/workqueue.h>
> -#include <uapi/linux/batadv_packet.h>
> -
> -#include "hash.h"
> -#include "log.h"
> -#include "originator.h"
> -#include "routing.h"
> -#include "send.h"
> -#include "tvlv.h"
> -
> -static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
> -static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
> -
> -static void batadv_nc_worker(struct work_struct *work);
> -static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_hard_i=
face *recv_if);
> -
> -/**
> - * batadv_nc_init() - one-time initialization for network coding
> - *
> - * Return: 0 on success or negative error number in case of failure
> - */
> -int __init batadv_nc_init(void)
> -{
> -=C2=A0=C2=A0 /* Register our packet type */
> -=C2=A0=C2=A0 return batadv_recv_handler_register(BATADV_CODED,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_recv=
_coded_packet);
> -}
> -
> -/**
> - * batadv_nc_start_timer() - initialise the nc periodic worker
> - * @bat_priv: the bat priv with all the mesh interface information
> - */
> -static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 queue_delayed_work(batadv_event_workqueue, &bat_priv->nc.wo=
rk,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 msecs_to_jiffies(10));
> -}
> -
> -/**
> - * batadv_nc_tvlv_container_update() - update the network coding tvlv co=
ntainer
> - *=C2=A0 after network coding setting change
> - * @bat_priv: the bat priv with all the mesh interface information
> - */
> -static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv=
)
> -{
> -=C2=A0=C2=A0 char nc_mode;
> -
> -=C2=A0=C2=A0 nc_mode =3D atomic_read(&bat_priv->network_coding);
> -
> -=C2=A0=C2=A0 switch (nc_mode) {
> -=C2=A0=C2=A0 case 0:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_tvlv_container_unregister(ba=
t_priv, BATADV_TVLV_NC, 1);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 case 1:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_tvlv_container_register(bat_=
priv, BATADV_TVLV_NC, 1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -}
> -
> -/**
> - * batadv_nc_status_update() - update the network coding tvlv container =
after
> - *=C2=A0 network coding setting change
> - * @net_dev: the mesh interface net device
> - */
> -void batadv_nc_status_update(struct net_device *net_dev)
> -{
> -=C2=A0=C2=A0 struct batadv_priv *bat_priv =3D netdev_priv(net_dev);
> -
> -=C2=A0=C2=A0 batadv_nc_tvlv_container_update(bat_priv);
> -}
> -
> -/**
> - * batadv_nc_tvlv_ogm_handler_v1() - process incoming nc tvlv container
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @orig: the orig_node of the ogm
> - * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flag=
s)
> - * @tvlv_value: tvlv buffer containing the gateway data
> - * @tvlv_value_len: tvlv buffer length
> - */
> -static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *o=
rig,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 flags,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *tvlv_value, u16 tvlv=
_value_len)
> -{
> -=C2=A0=C2=A0 if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(BATADV_ORIG_CAPA_HAS_NC, =
&orig->capabilities);
> -=C2=A0=C2=A0 else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(BATADV_ORIG_CAPA_HAS_NC, &o=
rig->capabilities);
> -}
> -
> -/**
> - * batadv_nc_mesh_init() - initialise coding hash table and start housek=
eeping
> - * @bat_priv: the bat priv with all the mesh interface information
> - *
> - * Return: 0 on success or negative error number in case of failure
> - */
> -int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 bat_priv->nc.timestamp_fwd_flush =3D jiffies;
> -=C2=A0=C2=A0 bat_priv->nc.timestamp_sniffed_purge =3D jiffies;
> -
> -=C2=A0=C2=A0 if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> -
> -=C2=A0=C2=A0 bat_priv->nc.coding_hash =3D batadv_hash_new(128);
> -=C2=A0=C2=A0 if (!bat_priv->nc.coding_hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
> -
> -=C2=A0=C2=A0 batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &batadv_nc_coding_hash_lock_class_key);
> -
> -=C2=A0=C2=A0 bat_priv->nc.decoding_hash =3D batadv_hash_new(128);
> -=C2=A0=C2=A0 if (!bat_priv->nc.decoding_hash) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_hash_destroy(bat_priv->nc.co=
ding_hash);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &batadv_nc_decoding_hash_lock_class_key);
> -
> -=C2=A0=C2=A0 INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
> -=C2=A0=C2=A0 batadv_nc_start_timer(bat_priv);
> -
> -=C2=A0=C2=A0 batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_h=
andler_v1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, BATADV_TVLV_NC, 1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BATADV_TVLV_HANDLER_OGM_CIFNOTFN=
D);
> -=C2=A0=C2=A0 batadv_nc_tvlv_container_update(bat_priv);
> -=C2=A0=C2=A0 return 0;
> -
> -err:
> -=C2=A0=C2=A0 return -ENOMEM;
> -}
> -
> -/**
> - * batadv_nc_init_bat_priv() - initialise the nc specific bat_priv varia=
bles
> - * @bat_priv: the bat priv with all the mesh interface information
> - */
> -void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 atomic_set(&bat_priv->network_coding, 0);
> -=C2=A0=C2=A0 bat_priv->nc.min_tq =3D 200;
> -=C2=A0=C2=A0 bat_priv->nc.max_fwd_delay =3D 10;
> -=C2=A0=C2=A0 bat_priv->nc.max_buffer_time =3D 200;
> -}
> -
> -/**
> - * batadv_nc_init_orig() - initialise the nc fields of an orig_node
> - * @orig_node: the orig_node which is going to be initialised
> - */
> -void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
> -{
> -=C2=A0=C2=A0 INIT_LIST_HEAD(&orig_node->in_coding_list);
> -=C2=A0=C2=A0 INIT_LIST_HEAD(&orig_node->out_coding_list);
> -=C2=A0=C2=A0 spin_lock_init(&orig_node->in_coding_list_lock);
> -=C2=A0=C2=A0 spin_lock_init(&orig_node->out_coding_list_lock);
> -}
> -
> -/**
> - * batadv_nc_node_release() - release nc_node from lists and queue for f=
ree
> - *=C2=A0 after rcu grace period
> - * @ref: kref pointer of the nc_node
> - */
> -static void batadv_nc_node_release(struct kref *ref)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_node *nc_node;
> -
> -=C2=A0=C2=A0 nc_node =3D container_of(ref, struct batadv_nc_node, refcou=
nt);
> -
> -=C2=A0=C2=A0 batadv_orig_node_put(nc_node->orig_node);
> -=C2=A0=C2=A0 kfree_rcu(nc_node, rcu);
> -}
> -
> -/**
> - * batadv_nc_node_put() - decrement the nc_node refcounter and possibly
> - *=C2=A0 release it
> - * @nc_node: nc_node to be free'd
> - */
> -static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
> -{
> -=C2=A0=C2=A0 if (!nc_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 kref_put(&nc_node->refcount, batadv_nc_node_release);
> -}
> -
> -/**
> - * batadv_nc_path_release() - release nc_path from lists and queue for f=
ree
> - *=C2=A0 after rcu grace period
> - * @ref: kref pointer of the nc_path
> - */
> -static void batadv_nc_path_release(struct kref *ref)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path;
> -
> -=C2=A0=C2=A0 nc_path =3D container_of(ref, struct batadv_nc_path, refcou=
nt);
> -
> -=C2=A0=C2=A0 kfree_rcu(nc_path, rcu);
> -}
> -
> -/**
> - * batadv_nc_path_put() - decrement the nc_path refcounter and possibly
> - *=C2=A0 release it
> - * @nc_path: nc_path to be free'd
> - */
> -static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
> -{
> -=C2=A0=C2=A0 if (!nc_path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 kref_put(&nc_path->refcount, batadv_nc_path_release);
> -}
> -
> -/**
> - * batadv_nc_packet_free() - frees nc packet
> - * @nc_packet: the nc packet to free
> - * @dropped: whether the packet is freed because is dropped
> - */
> -static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bool dropped)
> -{
> -=C2=A0=C2=A0 if (dropped)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_skb(nc_packet->skb);
> -=C2=A0=C2=A0 else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consume_skb(nc_packet->skb);
> -
> -=C2=A0=C2=A0 batadv_nc_path_put(nc_packet->nc_path);
> -=C2=A0=C2=A0 kfree(nc_packet);
> -}
> -
> -/**
> - * batadv_nc_to_purge_nc_node() - checks whether an nc node has to be pu=
rged
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @nc_node: the nc node to check
> - *
> - * Return: true if the entry has to be purged now, false otherwise
> - */
> -static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_nod=
e *nc_node)
> -{
> -=C2=A0=C2=A0 if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACT=
IVE)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -
> -=C2=A0=C2=A0 return batadv_has_timed_out(nc_node->last_seen, BATADV_NC_N=
ODE_TIMEOUT);
> -}
> -
> -/**
> - * batadv_nc_to_purge_nc_path_coding() - checks whether an nc path has t=
imed out
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @nc_path: the nc path to check
> - *
> - * Return: true if the entry has to be purged now, false otherwise
> - */
> -static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_pr=
iv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct batadv_nc_path *nc_path)
> -{
> -=C2=A0=C2=A0 if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACT=
IVE)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -
> -=C2=A0=C2=A0 /* purge the path when no packets has been added for 10 tim=
es the
> -=C2=A0=C2=A0=C2=A0 * max_fwd_delay time
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 return batadv_has_timed_out(nc_path->last_valid,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.max_fwd_delay * 10);
> -}
> -
> -/**
> - * batadv_nc_to_purge_nc_path_decoding() - checks whether an nc path has=
 timed
> - *=C2=A0 out
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @nc_path: the nc path to check
> - *
> - * Return: true if the entry has to be purged now, false otherwise
> - */
> -static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_=
priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_=
nc_path *nc_path)
> -{
> -=C2=A0=C2=A0 if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACT=
IVE)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -
> -=C2=A0=C2=A0 /* purge the path when no packets has been added for 10 tim=
es the
> -=C2=A0=C2=A0=C2=A0 * max_buffer time
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 return batadv_has_timed_out(nc_path->last_valid,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.max_buffer_time * 10);
> -}
> -
> -/**
> - * batadv_nc_purge_orig_nc_nodes() - go through list of nc nodes and pur=
ge stale
> - *=C2=A0 entries
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @list: list of nc nodes
> - * @lock: nc node list lock
> - * @to_purge: function in charge to decide whether an entry has to be pu=
rged or
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not. This function takes the nc n=
ode as argument and has to return
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a boolean value: true if the entr=
y has to be deleted, false
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise
> - */
> -static void
> -batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *list,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t *lock,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bool (*to_purge)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct batadv_nc_node *))
> -{
> -=C2=A0=C2=A0 struct batadv_nc_node *nc_node, *nc_node_tmp;
> -
> -=C2=A0=C2=A0 /* For each nc_node in list */
> -=C2=A0=C2=A0 spin_lock_bh(lock);
> -=C2=A0=C2=A0 list_for_each_entry_safe(nc_node, nc_node_tmp, list, list) =
{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if an helper function has been p=
assed as parameter,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ask it if the entry has to =
be purged or not
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (to_purge && !to_purge(bat_priv,=
 nc_node))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_dbg(BATADV_DBG_NC, bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "Removing nc_node %pM -> %pM\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nc_node->addr, nc_node->orig_node->orig);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_rcu(&nc_node->list);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_node_put(nc_node);
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 spin_unlock_bh(lock);
> -}
> -
> -/**
> - * batadv_nc_purge_orig() - purges all nc node data attached of the give=
n
> - *=C2=A0 originator
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @orig_node: orig_node with the nc node entries to be purged
> - * @to_purge: function in charge to decide whether an entry has to be pu=
rged or
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not. This function takes the nc n=
ode as argument and has to return
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a boolean value: true is the entr=
y has to be deleted, false
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise
> - */
> -void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool (*to_purge)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_nod=
e *))
> -{
> -=C2=A0=C2=A0 /* Check ingoing nc_node's of this orig_node */
> -=C2=A0=C2=A0 batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->in_codi=
ng_list,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &orig_node->in_coding_list=
_lock,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_purge);
> -
> -=C2=A0=C2=A0 /* Check outgoing nc_node's of this orig_node */
> -=C2=A0=C2=A0 batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->out_cod=
ing_list,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &orig_node->out_coding_lis=
t_lock,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_purge);
> -}
> -
> -/**
> - * batadv_nc_purge_orig_hash() - traverse entire originator hash to chec=
k if
> - *=C2=A0 they have timed out nc nodes
> - * @bat_priv: the bat priv with all the mesh interface information
> - */
> -static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 struct batadv_hashtable *hash =3D bat_priv->orig_hash;
> -=C2=A0=C2=A0 struct hlist_head *head;
> -=C2=A0=C2=A0 struct batadv_orig_node *orig_node;
> -=C2=A0=C2=A0 u32 i;
> -
> -=C2=A0=C2=A0 if (!hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 /* For each orig_node */
> -=C2=A0=C2=A0 for (i =3D 0; i < hash->size; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head =3D &hash->table[i];
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlist_for_each_entry_rcu(orig_node,=
 head, hash_entry)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_p=
urge_orig(bat_priv, orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_n=
c_to_purge_nc_node);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
> -=C2=A0=C2=A0 }
> -}
> -
> -/**
> - * batadv_nc_purge_paths() - traverse all nc paths part of the hash and =
remove
> - *=C2=A0 unused ones
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @hash: hash table containing the nc paths to check
> - * @to_purge: function in charge to decide whether an entry has to be pu=
rged or
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not. This function takes the nc n=
ode as argument and has to return
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a boolean value: true is the entr=
y has to be deleted, false
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise
> - */
> -static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_hashtable *hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bool (*to_purge)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct batadv_nc_path *))
> -{
> -=C2=A0=C2=A0 struct hlist_head *head;
> -=C2=A0=C2=A0 struct hlist_node *node_tmp;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path;
> -=C2=A0=C2=A0 spinlock_t *lock; /* Protects lists in hash */
> -=C2=A0=C2=A0 u32 i;
> -
> -=C2=A0=C2=A0 for (i =3D 0; i < hash->size; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head =3D &hash->table[i];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock =3D &hash->list_locks[i];
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For each nc_path in this bin */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlist_for_each_entry_safe(nc_path, =
node_tmp, head, hash_entry) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if an he=
lper function has been passed as parameter,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ask=
 it if the entry has to be purged or not
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (to_purg=
e && !to_purge(bat_priv, nc_path))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* purging =
an non-empty nc_path should never happen, but
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is =
observed under high CPU load. Delay the purging
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unt=
il next iteration to allow the packet_list to be
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * emp=
tied first.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!unlike=
ly(list_empty(&nc_path->packet_list))) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 net_ratelimited_function(printk,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 KERN_WARNING
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "Skipping free of non-empty nc_path (%pM -> %pM)!\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nc_path->prev_hop,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nc_path->next_hop);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* nc_path =
is unused, so remove it */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_dbg(=
BATADV_DBG_NC, bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Remove nc_path %pM -> %pM\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_path->prev_hop, nc_path->next_hop);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlist_del_r=
cu(&nc_path->hash_entry);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_p=
ath_put(nc_path);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_bh(lock);
> -=C2=A0=C2=A0 }
> -}
> -
> -/**
> - * batadv_nc_hash_key_gen() - computes the nc_path hash key
> - * @key: buffer to hold the final hash key
> - * @src: source ethernet mac address going into the hash key
> - * @dst: destination ethernet mac address going into the hash key
> - */
> -static void batadv_nc_hash_key_gen(struct batadv_nc_path *key, const cha=
r *src,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dst)
> -{
> -=C2=A0=C2=A0 memcpy(key->prev_hop, src, sizeof(key->prev_hop));
> -=C2=A0=C2=A0 memcpy(key->next_hop, dst, sizeof(key->next_hop));
> -}
> -
> -/**
> - * batadv_nc_hash_choose() - compute the hash value for an nc path
> - * @data: data to hash
> - * @size: size of the hash table
> - *
> - * Return: the selected index in the hash table for the given data.
> - */
> -static u32 batadv_nc_hash_choose(const void *data, u32 size)
> -{
> -=C2=A0=C2=A0 const struct batadv_nc_path *nc_path =3D data;
> -=C2=A0=C2=A0 u32 hash =3D 0;
> -
> -=C2=A0=C2=A0 hash =3D jhash(&nc_path->prev_hop, sizeof(nc_path->prev_hop=
), hash);
> -=C2=A0=C2=A0 hash =3D jhash(&nc_path->next_hop, sizeof(nc_path->next_hop=
), hash);
> -
> -=C2=A0=C2=A0 return hash % size;
> -}
> -
> -/**
> - * batadv_nc_hash_compare() - comparing function used in the network cod=
ing hash
> - *=C2=A0 tables
> - * @node: node in the local table
> - * @data2: second object to compare the node to
> - *
> - * Return: true if the two entry are the same, false otherwise
> - */
> -static bool batadv_nc_hash_compare(const struct hlist_node *node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data2)
> -{
> -=C2=A0=C2=A0 const struct batadv_nc_path *nc_path1, *nc_path2;
> -
> -=C2=A0=C2=A0 nc_path1 =3D container_of(node, struct batadv_nc_path, hash=
_entry);
> -=C2=A0=C2=A0 nc_path2 =3D data2;
> -
> -=C2=A0=C2=A0 /* Return 1 if the two keys are identical */
> -=C2=A0=C2=A0 if (!batadv_compare_eth(nc_path1->prev_hop, nc_path2->prev_=
hop))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 if (!batadv_compare_eth(nc_path1->next_hop, nc_path2->next_=
hop))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 return true;
> -}
> -
> -/**
> - * batadv_nc_hash_find() - search for an existing nc path and return it
> - * @hash: hash table containing the nc path
> - * @data: search key
> - *
> - * Return: the nc_path if found, NULL otherwise.
> - */
> -static struct batadv_nc_path *
> -batadv_nc_hash_find(struct batadv_hashtable *hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
> -{
> -=C2=A0=C2=A0 struct hlist_head *head;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path, *nc_path_tmp =3D NULL;
> -=C2=A0=C2=A0 int index;
> -
> -=C2=A0=C2=A0 if (!hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 index =3D batadv_nc_hash_choose(data, hash->size);
> -=C2=A0=C2=A0 head =3D &hash->table[index];
> -
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv_nc_hash_compare(&nc_pat=
h->hash_entry, data))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kref_get_unless_zero(&nc_path-=
>refcount))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_path_tmp =3D nc_path;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 return nc_path_tmp;
> -}
> -
> -/**
> - * batadv_nc_send_packet() - send non-coded packet and free nc_packet st=
ruct
> - * @nc_packet: the nc packet to send
> - */
> -static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
> -{
> -=C2=A0=C2=A0 batadv_send_unicast_skb(nc_packet->skb, nc_packet->neigh_no=
de);
> -=C2=A0=C2=A0 nc_packet->skb =3D NULL;
> -=C2=A0=C2=A0 batadv_nc_packet_free(nc_packet, false);
> -}
> -
> -/**
> - * batadv_nc_sniffed_purge() - Checks timestamp of given sniffed nc_pack=
et.
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @nc_path: the nc path the packet belongs to
> - * @nc_packet: the nc packet to be checked
> - *
> - * Checks whether the given sniffed (overheard) nc_packet has hit its bu=
ffering
> - * timeout. If so, the packet is no longer kept and the entry deleted fr=
om the
> - * queue. Has to be called with the appropriate locks.
> - *
> - * Return: false as soon as the entry in the fifo queue has not been tim=
ed out
> - * yet and true otherwise.
> - */
> -static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_path *nc_path,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet)
> -{
> -=C2=A0=C2=A0 unsigned long timeout =3D bat_priv->nc.max_buffer_time;
> -=C2=A0=C2=A0 bool res =3D false;
> -
> -=C2=A0=C2=A0 lockdep_assert_held(&nc_path->packet_list_lock);
> -
> -=C2=A0=C2=A0 /* Packets are added to tail, so the remaining packets did =
not time
> -=C2=A0=C2=A0=C2=A0 * out and we can stop processing the current queue
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_A=
CTIVE &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !batadv_has_timed_out(nc_packet->ti=
mestamp, timeout))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* purge nc packet */
> -=C2=A0=C2=A0 list_del(&nc_packet->list);
> -=C2=A0=C2=A0 batadv_nc_packet_free(nc_packet, true);
> -
> -=C2=A0=C2=A0 res =3D true;
> -
> -out:
> -=C2=A0=C2=A0 return res;
> -}
> -
> -/**
> - * batadv_nc_fwd_flush() - Checks the timestamp of the given nc packet.
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @nc_path: the nc path the packet belongs to
> - * @nc_packet: the nc packet to be checked
> - *
> - * Checks whether the given nc packet has hit its forward timeout. If so=
, the
> - * packet is no longer delayed, immediately sent and the entry deleted f=
rom the
> - * queue. Has to be called with the appropriate locks.
> - *
> - * Return: false as soon as the entry in the fifo queue has not been tim=
ed out
> - * yet and true otherwise.
> - */
> -static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct batadv_nc_path *nc_path,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet)
> -{
> -=C2=A0=C2=A0 unsigned long timeout =3D bat_priv->nc.max_fwd_delay;
> -
> -=C2=A0=C2=A0 lockdep_assert_held(&nc_path->packet_list_lock);
> -
> -=C2=A0=C2=A0 /* Packets are added to tail, so the remaining packets did =
not time
> -=C2=A0=C2=A0=C2=A0 * out and we can stop processing the current queue
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 if (atomic_read(&bat_priv->mesh_state) =3D=3D BATADV_MESH_A=
CTIVE &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !batadv_has_timed_out(nc_packet->ti=
mestamp, timeout))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 /* Send packet */
> -=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
> -=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nc_packet->skb->len + ETH_HLEN);
> -=C2=A0=C2=A0 list_del(&nc_packet->list);
> -=C2=A0=C2=A0 batadv_nc_send_packet(nc_packet);
> -
> -=C2=A0=C2=A0 return true;
> -}
> -
> -/**
> - * batadv_nc_process_nc_paths() - traverse given nc packet pool and free=
 timed
> - *=C2=A0 out nc packets
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @hash: to be processed hash table
> - * @process_fn: Function called to process given nc packet. Should retur=
n true
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to encourage this fun=
ction to proceed with the next packet.
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Otherwise the rest of=
 the current queue is skipped.
> - */
> -static void
> -batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct batadv_hashtable *hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bool (*process_fn)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct batadv_nc_path *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct batadv_nc_packet *))
> -{
> -=C2=A0=C2=A0 struct hlist_head *head;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path;
> -=C2=A0=C2=A0 bool ret;
> -=C2=A0=C2=A0 int i;
> -
> -=C2=A0=C2=A0 if (!hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 /* Loop hash table bins */
> -=C2=A0=C2=A0 for (i =3D 0; i < hash->size; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head =3D &hash->table[i];
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Loop coding paths */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlist_for_each_entry_rcu(nc_path, h=
ead, hash_entry) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Loop pac=
kets */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_b=
h(&nc_path->packet_list_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_ea=
ch_entry_safe(nc_packet, nc_packet_tmp,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nc_path=
->packet_list, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D process_fn(bat_priv, nc_path, nc_packet);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!ret)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock=
_bh(&nc_path->packet_list_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
> -=C2=A0=C2=A0 }
> -}
> -
> -/**
> - * batadv_nc_worker() - periodic task for housekeeping related to networ=
k
> - *=C2=A0 coding
> - * @work: kernel work struct
> - */
> -static void batadv_nc_worker(struct work_struct *work)
> -{
> -=C2=A0=C2=A0 struct delayed_work *delayed_work;
> -=C2=A0=C2=A0 struct batadv_priv_nc *priv_nc;
> -=C2=A0=C2=A0 struct batadv_priv *bat_priv;
> -=C2=A0=C2=A0 unsigned long timeout;
> -
> -=C2=A0=C2=A0 delayed_work =3D to_delayed_work(work);
> -=C2=A0=C2=A0 priv_nc =3D container_of(delayed_work, struct batadv_priv_n=
c, work);
> -=C2=A0=C2=A0 bat_priv =3D container_of(priv_nc, struct batadv_priv, nc);
> -
> -=C2=A0=C2=A0 batadv_nc_purge_orig_hash(bat_priv);
> -=C2=A0=C2=A0 batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_to_purge_nc_path_coding);
> -=C2=A0=C2=A0 batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_to_purge_nc_path_decoding);
> -
> -=C2=A0=C2=A0 timeout =3D bat_priv->nc.max_fwd_delay;
> -
> -=C2=A0=C2=A0 if (batadv_has_timed_out(bat_priv->nc.timestamp_fwd_flush, =
timeout)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_process_nc_paths(bat_priv=
, bat_priv->nc.coding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_fwd_flush)=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.timestamp_fwd_flush =
=3D jiffies;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 if (batadv_has_timed_out(bat_priv->nc.timestamp_sniffed_pur=
ge,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bat_priv->nc.max_buffer_time)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_process_nc_paths(bat_priv=
, bat_priv->nc.decoding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_sniffed_pu=
rge);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.timestamp_sniffed_purg=
e =3D jiffies;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* Schedule a new check */
> -=C2=A0=C2=A0 batadv_nc_start_timer(bat_priv);
> -}
> -
> -/**
> - * batadv_can_nc_with_orig() - checks whether the given orig node is sui=
table
> - *=C2=A0 for coding or not
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @orig_node: neighboring orig node which may be used as nc candidate
> - * @ogm_packet: incoming ogm packet also used for the checks
> - *
> - * Return: true if:
> - *=C2=A0 1) The OGM must have the most recent sequence number.
> - *=C2=A0 2) The TTL must be decremented by one and only one.
> - *=C2=A0 3) The OGM must be received from the first hop from orig_node.
> - *=C2=A0 4) The TQ value of the OGM must be above bat_priv->nc.min_tq.
> - */
> -static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_ogm_packet *ogm_packet)
> -{
> -=C2=A0=C2=A0 struct batadv_orig_ifinfo *orig_ifinfo;
> -=C2=A0=C2=A0 u32 last_real_seqno;
> -=C2=A0=C2=A0 u8 last_ttl;
> -
> -=C2=A0=C2=A0 orig_ifinfo =3D batadv_orig_ifinfo_get(orig_node, BATADV_IF=
_DEFAULT);
> -=C2=A0=C2=A0 if (!orig_ifinfo)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 last_ttl =3D orig_ifinfo->last_ttl;
> -=C2=A0=C2=A0 last_real_seqno =3D orig_ifinfo->last_real_seqno;
> -=C2=A0=C2=A0 batadv_orig_ifinfo_put(orig_ifinfo);
> -
> -=C2=A0=C2=A0 if (last_real_seqno !=3D ntohl(ogm_packet->seqno))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -=C2=A0=C2=A0 if (last_ttl !=3D ogm_packet->ttl + 1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -=C2=A0=C2=A0 if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_=
sender))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -=C2=A0=C2=A0 if (ogm_packet->tq < bat_priv->nc.min_tq)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 return true;
> -}
> -
> -/**
> - * batadv_nc_find_nc_node() - search for an existing nc node and return =
it
> - * @orig_node: orig node originating the ogm packet
> - * @orig_neigh_node: neighboring orig node from which we received the og=
m packet
> - *=C2=A0 (can be equal to orig_node)
> - * @in_coding: traverse incoming or outgoing network coding list
> - *
> - * Return: the nc_node if found, NULL otherwise.
> - */
> -static struct batadv_nc_node *
> -batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct batadv_orig_node *orig_neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bool in_coding)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_node *nc_node, *nc_node_out =3D NULL;
> -=C2=A0=C2=A0 struct list_head *list;
> -
> -=C2=A0=C2=A0 if (in_coding)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D &orig_neigh_node->in_codin=
g_list;
> -=C2=A0=C2=A0 else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D &orig_neigh_node->out_codi=
ng_list;
> -
> -=C2=A0=C2=A0 /* Traverse list of nc_nodes to orig_node */
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 list_for_each_entry_rcu(nc_node, list, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv_compare_eth(nc_node->ad=
dr, orig_node->orig))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kref_get_unless_zero(&nc_node-=
>refcount))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Found a match */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_node_out =3D nc_node;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 return nc_node_out;
> -}
> -
> -/**
> - * batadv_nc_get_nc_node() - retrieves an nc node or creates the entry i=
f it was
> - *=C2=A0 not found
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @orig_node: orig node originating the ogm packet
> - * @orig_neigh_node: neighboring orig node from which we received the og=
m packet
> - *=C2=A0 (can be equal to orig_node)
> - * @in_coding: traverse incoming or outgoing network coding list
> - *
> - * Return: the nc_node if found or created, NULL in case of an error.
> - */
> -static struct batadv_nc_node *
> -batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_orig_node *orig_neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool in_coding)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_node *nc_node;
> -=C2=A0=C2=A0 spinlock_t *lock; /* Used to lock list selected by "int in_=
coding" */
> -=C2=A0=C2=A0 struct list_head *list;
> -
> -=C2=A0=C2=A0 /* Select ingoing or outgoing coding node */
> -=C2=A0=C2=A0 if (in_coding) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock =3D &orig_neigh_node->in_codin=
g_list_lock;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D &orig_neigh_node->in_codin=
g_list;
> -=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock =3D &orig_neigh_node->out_codi=
ng_list_lock;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D &orig_neigh_node->out_codi=
ng_list;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 spin_lock_bh(lock);
> -
> -=C2=A0=C2=A0 /* Check if nc_node is already added */
> -=C2=A0=C2=A0 nc_node =3D batadv_nc_find_nc_node(orig_node, orig_neigh_no=
de, in_coding);
> -
> -=C2=A0=C2=A0 /* Node found */
> -=C2=A0=C2=A0 if (nc_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock;
> -
> -=C2=A0=C2=A0 nc_node =3D kzalloc(sizeof(*nc_node), GFP_ATOMIC);
> -=C2=A0=C2=A0 if (!nc_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock;
> -
> -=C2=A0=C2=A0 /* Initialize nc_node */
> -=C2=A0=C2=A0 INIT_LIST_HEAD(&nc_node->list);
> -=C2=A0=C2=A0 kref_init(&nc_node->refcount);
> -=C2=A0=C2=A0 ether_addr_copy(nc_node->addr, orig_node->orig);
> -=C2=A0=C2=A0 kref_get(&orig_neigh_node->refcount);
> -=C2=A0=C2=A0 nc_node->orig_node =3D orig_neigh_node;
> -
> -=C2=A0=C2=A0 batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_node %pM -> =
%pM\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_node->addr, nc=
_node->orig_node->orig);
> -
> -=C2=A0=C2=A0 /* Add nc_node to orig_node */
> -=C2=A0=C2=A0 kref_get(&nc_node->refcount);
> -=C2=A0=C2=A0 list_add_tail_rcu(&nc_node->list, list);
> -
> -unlock:
> -=C2=A0=C2=A0 spin_unlock_bh(lock);
> -
> -=C2=A0=C2=A0 return nc_node;
> -}
> -
> -/**
> - * batadv_nc_update_nc_node() - updates stored incoming and outgoing nc =
node
> - *=C2=A0 structs (best called on incoming OGMs)
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @orig_node: orig node originating the ogm packet
> - * @orig_neigh_node: neighboring orig node from which we received the og=
m packet
> - *=C2=A0 (can be equal to orig_node)
> - * @ogm_packet: incoming ogm packet
> - * @is_single_hop_neigh: orig_node is a single hop neighbor
> - */
> -void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *orig_neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_ogm_packet *ogm_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int is_single_hop_neigh)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_node *in_nc_node =3D NULL;
> -=C2=A0=C2=A0 struct batadv_nc_node *out_nc_node =3D NULL;
> -
> -=C2=A0=C2=A0 /* Check if network coding is enabled */
> -=C2=A0=C2=A0 if (!atomic_read(&bat_priv->network_coding))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* check if orig node is network coding enabled */
> -=C2=A0=C2=A0 if (!test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabili=
ties))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* accept ogms from 'good' neighbors and single hop neighbo=
rs */
> -=C2=A0=C2=A0 if (!batadv_can_nc_with_orig(bat_priv, orig_node, ogm_packe=
t) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !is_single_hop_neigh)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Add orig_node as in_nc_node on hop */
> -=C2=A0=C2=A0 in_nc_node =3D batadv_nc_get_nc_node(bat_priv, orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_neigh_node, tru=
e);
> -=C2=A0=C2=A0 if (!in_nc_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 in_nc_node->last_seen =3D jiffies;
> -
> -=C2=A0=C2=A0 /* Add hop as out_nc_node on orig_node */
> -=C2=A0=C2=A0 out_nc_node =3D batadv_nc_get_nc_node(bat_priv, orig_neigh_=
node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_node, fal=
se);
> -=C2=A0=C2=A0 if (!out_nc_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 out_nc_node->last_seen =3D jiffies;
> -
> -out:
> -=C2=A0=C2=A0 batadv_nc_node_put(in_nc_node);
> -=C2=A0=C2=A0 batadv_nc_node_put(out_nc_node);
> -}
> -
> -/**
> - * batadv_nc_get_path() - get existing nc_path or allocate a new one
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @hash: hash table containing the nc path
> - * @src: ethernet source address - first half of the nc path search key
> - * @dst: ethernet destination address - second half of the nc path searc=
h key
> - *
> - * Return: pointer to nc_path if the path was found or created, returns =
NULL
> - * on error.
> - */
> -static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat=
_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct b=
atadv_hashtable *hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *src,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *dst)
> -{
> -=C2=A0=C2=A0 int hash_added;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path, nc_path_key;
> -
> -=C2=A0=C2=A0 batadv_nc_hash_key_gen(&nc_path_key, src, dst);
> -
> -=C2=A0=C2=A0 /* Search for existing nc_path */
> -=C2=A0=C2=A0 nc_path =3D batadv_nc_hash_find(hash, (void *)&nc_path_key)=
;
> -
> -=C2=A0=C2=A0 if (nc_path) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Set timestamp to delay removal o=
f nc_path */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_path->last_valid =3D jiffies;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nc_path;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* No existing nc_path was found; create a new */
> -=C2=A0=C2=A0 nc_path =3D kzalloc(sizeof(*nc_path), GFP_ATOMIC);
> -
> -=C2=A0=C2=A0 if (!nc_path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* Initialize nc_path */
> -=C2=A0=C2=A0 INIT_LIST_HEAD(&nc_path->packet_list);
> -=C2=A0=C2=A0 spin_lock_init(&nc_path->packet_list_lock);
> -=C2=A0=C2=A0 kref_init(&nc_path->refcount);
> -=C2=A0=C2=A0 nc_path->last_valid =3D jiffies;
> -=C2=A0=C2=A0 ether_addr_copy(nc_path->next_hop, dst);
> -=C2=A0=C2=A0 ether_addr_copy(nc_path->prev_hop, src);
> -
> -=C2=A0=C2=A0 batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_path %pM -> =
%pM\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_path->prev_hop=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_path->next_hop=
);
> -
> -=C2=A0=C2=A0 /* Add nc_path to hash table */
> -=C2=A0=C2=A0 kref_get(&nc_path->refcount);
> -=C2=A0=C2=A0 hash_added =3D batadv_hash_add(hash, batadv_nc_hash_compare=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_nc_hash_choose, &nc_path_=
key,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nc_path->hash_entry);
> -
> -=C2=A0=C2=A0 if (hash_added < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(nc_path);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 return nc_path;
> -}
> -
> -/**
> - * batadv_nc_random_weight_tq() - scale the receivers TQ-value to avoid =
unfair
> - *=C2=A0 selection of a receiver with slightly lower TQ than the other
> - * @tq: to be weighted tq value
> - *
> - * Return: scaled tq value
> - */
> -static u8 batadv_nc_random_weight_tq(u8 tq)
> -{
> -=C2=A0=C2=A0 /* randomize the estimated packet loss (max TQ - estimated =
TQ) */
> -=C2=A0=C2=A0 u8 rand_tq =3D get_random_u32_below(BATADV_TQ_MAX_VALUE + 1=
 - tq);
> -
> -=C2=A0=C2=A0 /* convert to (randomized) estimated tq again */
> -=C2=A0=C2=A0 return BATADV_TQ_MAX_VALUE - rand_tq;
> -}
> -
> -/**
> - * batadv_nc_memxor() - XOR destination with source
> - * @dst: byte array to XOR into
> - * @src: byte array to XOR from
> - * @len: length of destination array
> - */
> -static void batadv_nc_memxor(char *dst, const char *src, unsigned int le=
n)
> -{
> -=C2=A0=C2=A0 unsigned int i;
> -
> -=C2=A0=C2=A0 for (i =3D 0; i < len; ++i)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst[i] ^=3D src[i];
> -}
> -
> -/**
> - * batadv_nc_code_packets() - code a received unicast_packet with an nc =
packet
> - *=C2=A0 into a coded_packet and send it
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: data skb to forward
> - * @ethhdr: pointer to the ethernet header inside the skb
> - * @nc_packet: structure containing the packet to the skb can be coded w=
ith
> - * @neigh_node: next hop to forward packet to
> - *
> - * Return: true if both packets are consumed, false otherwise.
> - */
> -static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ethhdr *ethhdr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_neigh_node *neigh_node)
> -{
> -=C2=A0=C2=A0 u8 tq_weighted_neigh, tq_weighted_coding, tq_tmp;
> -=C2=A0=C2=A0 struct sk_buff *skb_dest, *skb_src;
> -=C2=A0=C2=A0 struct batadv_unicast_packet *packet1;
> -=C2=A0=C2=A0 struct batadv_unicast_packet *packet2;
> -=C2=A0=C2=A0 struct batadv_coded_packet *coded_packet;
> -=C2=A0=C2=A0 struct batadv_neigh_node *neigh_tmp, *router_neigh, *first_=
dest;
> -=C2=A0=C2=A0 struct batadv_neigh_node *router_coding =3D NULL, *second_d=
est;
> -=C2=A0=C2=A0 struct batadv_neigh_ifinfo *router_neigh_ifinfo =3D NULL;
> -=C2=A0=C2=A0 struct batadv_neigh_ifinfo *router_coding_ifinfo =3D NULL;
> -=C2=A0=C2=A0 u8 *first_source, *second_source;
> -=C2=A0=C2=A0 __be32 packet_id1, packet_id2;
> -=C2=A0=C2=A0 size_t count;
> -=C2=A0=C2=A0 bool res =3D false;
> -=C2=A0=C2=A0 int coding_len;
> -=C2=A0=C2=A0 int unicast_size =3D sizeof(*packet1);
> -=C2=A0=C2=A0 int coded_size =3D sizeof(*coded_packet);
> -=C2=A0=C2=A0 int header_add =3D coded_size - unicast_size;
> -
> -=C2=A0=C2=A0 /* TODO: do we need to consider the outgoing interface for
> -=C2=A0=C2=A0=C2=A0 * coded packets?
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 router_neigh =3D batadv_orig_router_get(neigh_node->orig_no=
de,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BA=
TADV_IF_DEFAULT);
> -=C2=A0=C2=A0 if (!router_neigh)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 router_neigh_ifinfo =3D batadv_neigh_ifinfo_get(router_neig=
h,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BATADV_IF_DEFAULT);
> -=C2=A0=C2=A0 if (!router_neigh_ifinfo)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 neigh_tmp =3D nc_packet->neigh_node;
> -=C2=A0=C2=A0 router_coding =3D batadv_orig_router_get(neigh_tmp->orig_no=
de,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BATADV_IF_DEFAULT);
> -=C2=A0=C2=A0 if (!router_coding)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 router_coding_ifinfo =3D batadv_neigh_ifinfo_get(router_cod=
ing,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BATADV_IF_DEFAULT);
> -=C2=A0=C2=A0 if (!router_coding_ifinfo)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 tq_tmp =3D router_neigh_ifinfo->bat_iv.tq_avg;
> -=C2=A0=C2=A0 tq_weighted_neigh =3D batadv_nc_random_weight_tq(tq_tmp);
> -=C2=A0=C2=A0 tq_tmp =3D router_coding_ifinfo->bat_iv.tq_avg;
> -=C2=A0=C2=A0 tq_weighted_coding =3D batadv_nc_random_weight_tq(tq_tmp);
> -
> -=C2=A0=C2=A0 /* Select one destination for the MAC-header dst-field base=
d on
> -=C2=A0=C2=A0=C2=A0 * weighted TQ-values.
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 if (tq_weighted_neigh >=3D tq_weighted_coding) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Destination from nc_packet is se=
lected for MAC-header */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_dest =3D nc_packet->neigh_nod=
e;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_source =3D nc_packet->nc_path=
->prev_hop;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second_dest =3D neigh_node;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second_source =3D ethhdr->h_source;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet1 =3D (struct batadv_unicast_=
packet *)nc_packet->skb->data;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet2 =3D (struct batadv_unicast_=
packet *)skb->data;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id1 =3D nc_packet->packet_id=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id2 =3D batadv_skb_crc32(skb=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk=
b->data + sizeof(*packet2));
> -=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Destination for skb is selected =
for MAC-header */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_dest =3D neigh_node;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_source =3D ethhdr->h_source;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second_dest =3D nc_packet->neigh_no=
de;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second_source =3D nc_packet->nc_pat=
h->prev_hop;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet1 =3D (struct batadv_unicast_=
packet *)skb->data;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet2 =3D (struct batadv_unicast_=
packet *)nc_packet->skb->data;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id1 =3D batadv_skb_crc32(skb=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk=
b->data + sizeof(*packet1));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id2 =3D nc_packet->packet_id=
;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* Instead of zero padding the smallest data buffer, we
> -=C2=A0=C2=A0=C2=A0 * code into the largest.
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 if (skb->len <=3D nc_packet->skb->len) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_dest =3D nc_packet->skb;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_src =3D skb;
> -=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_dest =3D skb;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_src =3D nc_packet->skb;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* coding_len is used when decoding the packet shorter pack=
et */
> -=C2=A0=C2=A0 coding_len =3D skb_src->len - unicast_size;
> -
> -=C2=A0=C2=A0 if (skb_linearize(skb_dest) < 0 || skb_linearize(skb_src) <=
 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 skb_push(skb_dest, header_add);
> -
> -=C2=A0=C2=A0 coded_packet =3D (struct batadv_coded_packet *)skb_dest->da=
ta;
> -=C2=A0=C2=A0 skb_reset_mac_header(skb_dest);
> -
> -=C2=A0=C2=A0 coded_packet->packet_type =3D BATADV_CODED;
> -=C2=A0=C2=A0 coded_packet->version =3D BATADV_COMPAT_VERSION;
> -=C2=A0=C2=A0 coded_packet->ttl =3D packet1->ttl;
> -
> -=C2=A0=C2=A0 /* Info about first unicast packet */
> -=C2=A0=C2=A0 ether_addr_copy(coded_packet->first_source, first_source);
> -=C2=A0=C2=A0 ether_addr_copy(coded_packet->first_orig_dest, packet1->des=
t);
> -=C2=A0=C2=A0 coded_packet->first_crc =3D packet_id1;
> -=C2=A0=C2=A0 coded_packet->first_ttvn =3D packet1->ttvn;
> -
> -=C2=A0=C2=A0 /* Info about second unicast packet */
> -=C2=A0=C2=A0 ether_addr_copy(coded_packet->second_dest, second_dest->add=
r);
> -=C2=A0=C2=A0 ether_addr_copy(coded_packet->second_source, second_source)=
;
> -=C2=A0=C2=A0 ether_addr_copy(coded_packet->second_orig_dest, packet2->de=
st);
> -=C2=A0=C2=A0 coded_packet->second_crc =3D packet_id2;
> -=C2=A0=C2=A0 coded_packet->second_ttl =3D packet2->ttl;
> -=C2=A0=C2=A0 coded_packet->second_ttvn =3D packet2->ttvn;
> -=C2=A0=C2=A0 coded_packet->coded_len =3D htons(coding_len);
> -
> -=C2=A0=C2=A0 /* This is where the magic happens: Code skb_src into skb_d=
est */
> -=C2=A0=C2=A0 batadv_nc_memxor(skb_dest->data + coded_size,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_s=
rc->data + unicast_size, coding_len);
> -
> -=C2=A0=C2=A0 /* Update counters accordingly */
> -=C2=A0=C2=A0 if (BATADV_SKB_CB(skb_src)->decoded &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BATADV_SKB_CB(skb_dest)->decoded) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Both packets are recoded */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D skb_src->len + ETH_HLEN;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count +=3D skb_dest->len + ETH_HLEN=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_RECODE, 2);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_RECODE_BYTES, count);
> -=C2=A0=C2=A0 } else if (!BATADV_SKB_CB(skb_src)->decoded &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !BATADV_SKB_CB(sk=
b_dest)->decoded) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Both packets are newly coded */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D skb_src->len + ETH_HLEN;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count +=3D skb_dest->len + ETH_HLEN=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_CODE, 2);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_CODE_BYTES, count);
> -=C2=A0=C2=A0 } else if (BATADV_SKB_CB(skb_src)->decoded &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !BATADV_SKB_CB(sk=
b_dest)->decoded) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* skb_src recoded and skb_dest is =
newly coded */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_RECODE);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_RECODE_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_src->len + ETH_HLEN);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_CODE);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_CODE_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_dest->len + ETH_HLEN);
> -=C2=A0=C2=A0 } else if (!BATADV_SKB_CB(skb_src)->decoded &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BATADV_SKB_CB(skb=
_dest)->decoded) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* skb_src is newly coded and skb_d=
est is recoded */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_CODE);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_CODE_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_src->len + ETH_HLEN);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_RECODE);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV=
_CNT_NC_RECODE_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_dest->len + ETH_HLEN);
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* skb_src is now coded into skb_dest, so free it */
> -=C2=A0=C2=A0 consume_skb(skb_src);
> -
> -=C2=A0=C2=A0 /* avoid duplicate free of skb from nc_packet */
> -=C2=A0=C2=A0 nc_packet->skb =3D NULL;
> -=C2=A0=C2=A0 batadv_nc_packet_free(nc_packet, false);
> -
> -=C2=A0=C2=A0 /* Send the coded packet and return true */
> -=C2=A0=C2=A0 batadv_send_unicast_skb(skb_dest, first_dest);
> -=C2=A0=C2=A0 res =3D true;
> -out:
> -=C2=A0=C2=A0 batadv_neigh_node_put(router_neigh);
> -=C2=A0=C2=A0 batadv_neigh_node_put(router_coding);
> -=C2=A0=C2=A0 batadv_neigh_ifinfo_put(router_neigh_ifinfo);
> -=C2=A0=C2=A0 batadv_neigh_ifinfo_put(router_coding_ifinfo);
> -=C2=A0=C2=A0 return res;
> -}
> -
> -/**
> - * batadv_nc_skb_coding_possible() - true if a decoded skb is available =
at dst.
> - * @skb: data skb to forward
> - * @dst: destination mac address of the other skb to code with
> - * @src: source mac address of skb
> - *
> - * Whenever we network code a packet we have to check whether we receive=
d it in
> - * a network coded form. If so, we may not be able to use it for coding =
because
> - * some neighbors may also have received (overheard) the packet in the n=
etwork
> - * coded form without being able to decode it. It is hard to know which =
of the
> - * neighboring nodes was able to decode the packet, therefore we can onl=
y
> - * re-code the packet if the source of the previous encoded packet is in=
volved.
> - * Since the source encoded the packet we can be certain it has all nece=
ssary
> - * decode information.
> - *
> - * Return: true if coding of a decoded packet is allowed.
> - */
> -static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, =
u8 *src)
> -{
> -=C2=A0=C2=A0 if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst,=
 src))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -=C2=A0=C2=A0 return true;
> -}
> -
> -/**
> - * batadv_nc_path_search() - Find the coding path matching in_nc_node an=
d
> - *=C2=A0 out_nc_node to retrieve a buffered packet that can be used for =
coding.
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @in_nc_node: pointer to skb next hop's neighbor nc node
> - * @out_nc_node: pointer to skb source's neighbor nc node
> - * @skb: data skb to forward
> - * @eth_dst: next hop mac address of skb
> - *
> - * Return: true if coding of a decoded skb is allowed.
> - */
> -static struct batadv_nc_packet *
> -batadv_nc_path_search(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_nc_node *in_nc_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_nc_node *out_nc_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 u8 *eth_dst)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path, nc_path_key;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet_out =3D NULL;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
> -=C2=A0=C2=A0 struct batadv_hashtable *hash =3D bat_priv->nc.coding_hash;
> -=C2=A0=C2=A0 int idx;
> -
> -=C2=A0=C2=A0 if (!hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* Create almost path key */
> -=C2=A0=C2=A0 batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_nc_node->addr);
> -=C2=A0=C2=A0 idx =3D batadv_nc_hash_choose(&nc_path_key, hash->size);
> -
> -=C2=A0=C2=A0 /* Check for coding opportunities in this nc_path */
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 hlist_for_each_entry_rcu(nc_path, &hash->table[idx], hash_e=
ntry) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv_compare_eth(nc_path->pr=
ev_hop, in_nc_node->addr))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv_compare_eth(nc_path->ne=
xt_hop, out_nc_node->addr))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(&nc_path->packet_list_=
lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_empty(&nc_path->packet_lis=
t)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock=
_bh(&nc_path->packet_list_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_safe(nc_packet,=
 nc_packet_tmp,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nc_path->packet_list, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv=
_nc_skb_coding_possible(nc_packet->skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_dst,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_nc_node->addr))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Coding o=
pportunity is found! */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&n=
c_packet->list);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_packet_o=
ut =3D nc_packet;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_bh(&nc_path->packet_lis=
t_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 return nc_packet_out;
> -}
> -
> -/**
> - * batadv_nc_skb_src_search() - Loops through the list of neighboring no=
des of
> - *=C2=A0 the skb's sender (may be equal to the originator).
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: data skb to forward
> - * @eth_dst: next hop mac address of skb
> - * @eth_src: source mac address of skb
> - * @in_nc_node: pointer to skb next hop's neighbor nc node
> - *
> - * Return: an nc packet if a suitable coding packet was found, NULL othe=
rwise.
> - */
> -static struct batadv_nc_packet *
> -batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *e=
th_dst,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *e=
th_src,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t batadv_nc_node *in_nc_node)
> -{
> -=C2=A0=C2=A0 struct batadv_orig_node *orig_node;
> -=C2=A0=C2=A0 struct batadv_nc_node *out_nc_node;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet =3D NULL;
> -
> -=C2=A0=C2=A0 orig_node =3D batadv_orig_hash_find(bat_priv, eth_src);
> -=C2=A0=C2=A0 if (!orig_node)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 list_for_each_entry_rcu(out_nc_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &orig_node->out_coding_list, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if the skb is decoded and =
if recoding is possible */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!batadv_nc_skb_coding_possible(=
skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 out_nc_node->addr, eth_src))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Search for an opportunity in thi=
s nc_path */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_packet =3D batadv_nc_path_search=
(bat_priv, in_nc_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ou=
t_nc_node, skb, eth_dst);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 batadv_orig_node_put(orig_node);
> -=C2=A0=C2=A0 return nc_packet;
> -}
> -
> -/**
> - * batadv_nc_skb_store_before_coding() - set the ethernet src and dst of=
 the
> - *=C2=A0 unicast skb before it is stored for use in later decoding
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: data skb to store
> - * @eth_dst_new: new destination mac address of skb
> - */
> -static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_pr=
iv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=
 *eth_dst_new)
> -{
> -=C2=A0=C2=A0 struct ethhdr *ethhdr;
> -
> -=C2=A0=C2=A0 /* Copy skb header to change the mac header */
> -=C2=A0=C2=A0 skb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
> -=C2=A0=C2=A0 if (!skb)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 /* Set the mac header as if we actually sent the packet unc=
oded */
> -=C2=A0=C2=A0 ethhdr =3D eth_hdr(skb);
> -=C2=A0=C2=A0 ether_addr_copy(ethhdr->h_source, ethhdr->h_dest);
> -=C2=A0=C2=A0 ether_addr_copy(ethhdr->h_dest, eth_dst_new);
> -
> -=C2=A0=C2=A0 /* Set data pointer to MAC header to mimic packets from our=
 tx path */
> -=C2=A0=C2=A0 skb_push(skb, ETH_HLEN);
> -
> -=C2=A0=C2=A0 /* Add the packet to the decoding packet pool */
> -=C2=A0=C2=A0 batadv_nc_skb_store_for_decoding(bat_priv, skb);
> -
> -=C2=A0=C2=A0 /* batadv_nc_skb_store_for_decoding() clones the skb, so we=
 must free
> -=C2=A0=C2=A0=C2=A0 * our ref
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 consume_skb(skb);
> -}
> -
> -/**
> - * batadv_nc_skb_dst_search() - Loops through list of neighboring nodes =
to dst.
> - * @skb: data skb to forward
> - * @neigh_node: next hop to forward packet to
> - * @ethhdr: pointer to the ethernet header inside the skb
> - *
> - * Loops through the list of neighboring nodes the next hop has a good
> - * connection to (receives OGMs with a sufficient quality). We need to f=
ind a
> - * neighbor of our next hop that potentially sent a packet which our nex=
t hop
> - * also received (overheard) and has stored for later decoding.
> - *
> - * Return: true if the skb was consumed (encoded packet sent) or false o=
therwise
> - */
> -static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_neigh_node *neigh_=
node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ethhdr *ethhdr)
> -{
> -=C2=A0=C2=A0 struct net_device *netdev =3D neigh_node->if_incoming->mesh=
_iface;
> -=C2=A0=C2=A0 struct batadv_priv *bat_priv =3D netdev_priv(netdev);
> -=C2=A0=C2=A0 struct batadv_orig_node *orig_node =3D neigh_node->orig_nod=
e;
> -=C2=A0=C2=A0 struct batadv_nc_node *nc_node;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet =3D NULL;
> -
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 list_for_each_entry_rcu(nc_node, &orig_node->in_coding_list=
, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Search for coding opportunity wi=
th this in_nc_node */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_packet =3D batadv_nc_skb_src_sea=
rch(bat_priv, skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 neigh_node->addr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ethhdr->h_source, nc_node);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Opportunity was found, so stop s=
earching */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 if (!nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 /* Save packets for later decoding */
> -=C2=A0=C2=A0 batadv_nc_skb_store_before_coding(bat_priv, skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 neigh_node->addr);
> -=C2=A0=C2=A0 batadv_nc_skb_store_before_coding(bat_priv, nc_packet->skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_packet->neigh_node->add=
r);
> -
> -=C2=A0=C2=A0 /* Code and send packets */
> -=C2=A0=C2=A0 if (batadv_nc_code_packets(bat_priv, skb, ethhdr, nc_packet=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 neigh_node))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -
> -=C2=A0=C2=A0 /* out of mem ? Coding failed - we have to free the buffere=
d packet
> -=C2=A0=C2=A0=C2=A0 * to avoid memleaks. The skb passed as argument will =
be dealt with
> -=C2=A0=C2=A0=C2=A0 * by the calling function.
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 batadv_nc_send_packet(nc_packet);
> -=C2=A0=C2=A0 return false;
> -}
> -
> -/**
> - * batadv_nc_skb_add_to_path() - buffer skb for later encoding / decodin=
g
> - * @skb: skb to add to path
> - * @nc_path: path to add skb to
> - * @neigh_node: next hop to forward packet to
> - * @packet_id: checksum to identify packet
> - *
> - * Return: true if the packet was buffered or false in case of an error.
> - */
> -static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_path *nc_=
path,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_neigh_node *=
neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 packet_id)
> -{
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet;
> -
> -=C2=A0=C2=A0 nc_packet =3D kzalloc(sizeof(*nc_packet), GFP_ATOMIC);
> -=C2=A0=C2=A0 if (!nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -
> -=C2=A0=C2=A0 /* Initialize nc_packet */
> -=C2=A0=C2=A0 nc_packet->timestamp =3D jiffies;
> -=C2=A0=C2=A0 nc_packet->packet_id =3D packet_id;
> -=C2=A0=C2=A0 nc_packet->skb =3D skb;
> -=C2=A0=C2=A0 nc_packet->neigh_node =3D neigh_node;
> -=C2=A0=C2=A0 nc_packet->nc_path =3D nc_path;
> -
> -=C2=A0=C2=A0 /* Add coding packet to list */
> -=C2=A0=C2=A0 spin_lock_bh(&nc_path->packet_list_lock);
> -=C2=A0=C2=A0 list_add_tail(&nc_packet->list, &nc_path->packet_list);
> -=C2=A0=C2=A0 spin_unlock_bh(&nc_path->packet_list_lock);
> -
> -=C2=A0=C2=A0 return true;
> -}
> -
> -/**
> - * batadv_nc_skb_forward() - try to code a packet or add it to the codin=
g packet
> - *=C2=A0 buffer
> - * @skb: data skb to forward
> - * @neigh_node: next hop to forward packet to
> - *
> - * Return: true if the skb was consumed (encoded packet sent) or false o=
therwise
> - */
> -bool batadv_nc_skb_forward(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct batadv_neigh_node *neigh_node)
> -{
> -=C2=A0=C2=A0 const struct net_device *netdev =3D neigh_node->if_incoming=
->mesh_iface;
> -=C2=A0=C2=A0 struct batadv_priv *bat_priv =3D netdev_priv(netdev);
> -=C2=A0=C2=A0 struct batadv_unicast_packet *packet;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path;
> -=C2=A0=C2=A0 struct ethhdr *ethhdr =3D eth_hdr(skb);
> -=C2=A0=C2=A0 __be32 packet_id;
> -=C2=A0=C2=A0 u8 *payload;
> -
> -=C2=A0=C2=A0 /* Check if network coding is enabled */
> -=C2=A0=C2=A0 if (!atomic_read(&bat_priv->network_coding))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* We only handle unicast packets */
> -=C2=A0=C2=A0 payload =3D skb_network_header(skb);
> -=C2=A0=C2=A0 packet =3D (struct batadv_unicast_packet *)payload;
> -=C2=A0=C2=A0 if (packet->packet_type !=3D BATADV_UNICAST)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Try to find a coding opportunity and send the skb if one=
 is found */
> -=C2=A0=C2=A0 if (batadv_nc_skb_dst_search(skb, neigh_node, ethhdr))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -
> -=C2=A0=C2=A0 /* Find or create a nc_path for this src-dst pair */
> -=C2=A0=C2=A0 nc_path =3D batadv_nc_get_path(bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.coding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethhdr->h_source,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 neigh_node->addr);
> -
> -=C2=A0=C2=A0 if (!nc_path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Add skb to nc_path */
> -=C2=A0=C2=A0 packet_id =3D batadv_skb_crc32(skb, payload + sizeof(*packe=
t));
> -=C2=A0=C2=A0 if (!batadv_nc_skb_add_to_path(skb, nc_path, neigh_node, pa=
cket_id))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_nc_path;
> -
> -=C2=A0=C2=A0 /* Packet is consumed */
> -=C2=A0=C2=A0 return true;
> -
> -free_nc_path:
> -=C2=A0=C2=A0 batadv_nc_path_put(nc_path);
> -out:
> -=C2=A0=C2=A0 /* Packet is not consumed */
> -=C2=A0=C2=A0 return false;
> -}
> -
> -/**
> - * batadv_nc_skb_store_for_decoding() - save a clone of the skb which ca=
n be
> - *=C2=A0 used when decoding coded packets
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: data skb to store
> - */
> -void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb)
> -{
> -=C2=A0=C2=A0 struct batadv_unicast_packet *packet;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path;
> -=C2=A0=C2=A0 struct ethhdr *ethhdr =3D eth_hdr(skb);
> -=C2=A0=C2=A0 __be32 packet_id;
> -=C2=A0=C2=A0 u8 *payload;
> -
> -=C2=A0=C2=A0 /* Check if network coding is enabled */
> -=C2=A0=C2=A0 if (!atomic_read(&bat_priv->network_coding))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Check for supported packet type */
> -=C2=A0=C2=A0 payload =3D skb_network_header(skb);
> -=C2=A0=C2=A0 packet =3D (struct batadv_unicast_packet *)payload;
> -=C2=A0=C2=A0 if (packet->packet_type !=3D BATADV_UNICAST)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Find existing nc_path or create a new */
> -=C2=A0=C2=A0 nc_path =3D batadv_nc_get_path(bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bat_priv->nc.decoding_hash,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethhdr->h_source,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethhdr->h_dest);
> -
> -=C2=A0=C2=A0 if (!nc_path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> -
> -=C2=A0=C2=A0 /* Clone skb and adjust skb->data to point at batman header=
 */
> -=C2=A0=C2=A0 skb =3D skb_clone(skb, GFP_ATOMIC);
> -=C2=A0=C2=A0 if (unlikely(!skb))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_nc_path;
> -
> -=C2=A0=C2=A0 if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 if (unlikely(!skb_pull_rcsum(skb, ETH_HLEN)))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 /* Add skb to nc_path */
> -=C2=A0=C2=A0 packet_id =3D batadv_skb_crc32(skb, payload + sizeof(*packe=
t));
> -=C2=A0=C2=A0 if (!batadv_nc_skb_add_to_path(skb, nc_path, NULL, packet_i=
d))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV_CNT_NC_BUFFER);
> -=C2=A0=C2=A0 return;
> -
> -free_skb:
> -=C2=A0=C2=A0 kfree_skb(skb);
> -free_nc_path:
> -=C2=A0=C2=A0 batadv_nc_path_put(nc_path);
> -out:
> -=C2=A0=C2=A0 return;
> -}
> -
> -/**
> - * batadv_nc_skb_store_sniffed_unicast() - check if a received unicast p=
acket
> - *=C2=A0 should be saved in the decoding buffer and, if so, store it the=
re
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: unicast skb to store
> - */
> -void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb)
> -{
> -=C2=A0=C2=A0 struct ethhdr *ethhdr =3D eth_hdr(skb);
> -
> -=C2=A0=C2=A0 if (batadv_is_my_mac(bat_priv, ethhdr->h_dest))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -
> -=C2=A0=C2=A0 /* Set data pointer to MAC header to mimic packets from our=
 tx path */
> -=C2=A0=C2=A0 skb_push(skb, ETH_HLEN);
> -
> -=C2=A0=C2=A0 batadv_nc_skb_store_for_decoding(bat_priv, skb);
> -}
> -
> -/**
> - * batadv_nc_skb_decode_packet() - decode given skb using the decode dat=
a stored
> - *=C2=A0 in nc_packet
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @skb: unicast skb to decode
> - * @nc_packet: decode data needed to decode the skb
> - *
> - * Return: pointer to decoded unicast packet if the packet was decoded o=
r NULL
> - * in case of an error.
> - */
> -static struct batadv_unicast_packet *
> -batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff=
 *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet)
> -{
> -=C2=A0=C2=A0 const int h_size =3D sizeof(struct batadv_unicast_packet);
> -=C2=A0=C2=A0 const int h_diff =3D sizeof(struct batadv_coded_packet) - h=
_size;
> -=C2=A0=C2=A0 struct batadv_unicast_packet *unicast_packet;
> -=C2=A0=C2=A0 struct batadv_coded_packet coded_packet_tmp;
> -=C2=A0=C2=A0 struct ethhdr *ethhdr, ethhdr_tmp;
> -=C2=A0=C2=A0 u8 *orig_dest, ttl, ttvn;
> -=C2=A0=C2=A0 unsigned int coding_len;
> -=C2=A0=C2=A0 int err;
> -
> -=C2=A0=C2=A0 /* Save headers temporarily */
> -=C2=A0=C2=A0 memcpy(&coded_packet_tmp, skb->data, sizeof(coded_packet_tm=
p));
> -=C2=A0=C2=A0 memcpy(&ethhdr_tmp, skb_mac_header(skb), sizeof(ethhdr_tmp)=
);
> -
> -=C2=A0=C2=A0 if (skb_cow(skb, 0) < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 if (unlikely(!skb_pull_rcsum(skb, h_diff)))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* Data points to batman header, so set mac header 14 bytes=
 before
> -=C2=A0=C2=A0=C2=A0 * and network to data
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 skb_set_mac_header(skb, -ETH_HLEN);
> -=C2=A0=C2=A0 skb_reset_network_header(skb);
> -
> -=C2=A0=C2=A0 /* Reconstruct original mac header */
> -=C2=A0=C2=A0 ethhdr =3D eth_hdr(skb);
> -=C2=A0=C2=A0 *ethhdr =3D ethhdr_tmp;
> -
> -=C2=A0=C2=A0 /* Select the correct unicast header information based on t=
he location
> -=C2=A0=C2=A0=C2=A0 * of our mac address in the coded_packet header
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 if (batadv_is_my_mac(bat_priv, coded_packet_tmp.second_dest=
)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we are the second destination=
 the packet was overheard,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so the Ethernet address mus=
t be copied to h_dest and
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pkt_type changed from PACKE=
T_OTHERHOST to PACKET_HOST
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ether_addr_copy(ethhdr->h_dest, cod=
ed_packet_tmp.second_dest);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->pkt_type =3D PACKET_HOST;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_dest =3D coded_packet_tmp.seco=
nd_orig_dest;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttl =3D coded_packet_tmp.second_ttl=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttvn =3D coded_packet_tmp.second_tt=
vn;
> -=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orig_dest =3D coded_packet_tmp.firs=
t_orig_dest;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttl =3D coded_packet_tmp.ttl;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttvn =3D coded_packet_tmp.first_ttv=
n;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 coding_len =3D ntohs(coded_packet_tmp.coded_len);
> -
> -=C2=A0=C2=A0 /* ensure dst buffer is large enough (payload only) */
> -=C2=A0=C2=A0 if (coding_len + h_size > skb->len)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* ensure src buffer is large enough (payload only) */
> -=C2=A0=C2=A0 if (coding_len + h_size > nc_packet->skb->len)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* Here the magic is reversed:
> -=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 extract the missing packet from the rec=
eived coded packet
> -=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0 batadv_nc_memxor(skb->data + h_size,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc_pa=
cket->skb->data + h_size,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codin=
g_len);
> -
> -=C2=A0=C2=A0 /* Resize decoded skb if decoded with larger packet */
> -=C2=A0=C2=A0 if (nc_packet->skb->len > coding_len + h_size) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pskb_trim_rcsum(skb, coding=
_len + h_size);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL=
;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* Create decoded unicast packet */
> -=C2=A0=C2=A0 unicast_packet =3D (struct batadv_unicast_packet *)skb->dat=
a;
> -=C2=A0=C2=A0 unicast_packet->packet_type =3D BATADV_UNICAST;
> -=C2=A0=C2=A0 unicast_packet->version =3D BATADV_COMPAT_VERSION;
> -=C2=A0=C2=A0 unicast_packet->ttl =3D ttl;
> -=C2=A0=C2=A0 ether_addr_copy(unicast_packet->dest, orig_dest);
> -=C2=A0=C2=A0 unicast_packet->ttvn =3D ttvn;
> -
> -=C2=A0=C2=A0 batadv_nc_packet_free(nc_packet, false);
> -=C2=A0=C2=A0 return unicast_packet;
> -}
> -
> -/**
> - * batadv_nc_find_decoding_packet() - search through buffered decoding d=
ata to
> - *=C2=A0 find the data needed to decode the coded packet
> - * @bat_priv: the bat priv with all the mesh interface information
> - * @ethhdr: pointer to the ethernet header inside the coded packet
> - * @coded: coded packet we try to find decode data for
> - *
> - * Return: pointer to nc packet if the needed data was found or NULL oth=
erwise.
> - */
> -static struct batadv_nc_packet *
> -batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ethhdr *ethhdr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_coded_packet *coded)
> -{
> -=C2=A0=C2=A0 struct batadv_hashtable *hash =3D bat_priv->nc.decoding_has=
h;
> -=C2=A0=C2=A0 struct batadv_nc_packet *tmp_nc_packet, *nc_packet =3D NULL=
;
> -=C2=A0=C2=A0 struct batadv_nc_path *nc_path, nc_path_key;
> -=C2=A0=C2=A0 u8 *dest, *source;
> -=C2=A0=C2=A0 __be32 packet_id;
> -=C2=A0=C2=A0 int index;
> -
> -=C2=A0=C2=A0 if (!hash)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> -
> -=C2=A0=C2=A0 /* Select the correct packet id based on the location of ou=
r mac-addr */
> -=C2=A0=C2=A0 dest =3D ethhdr->h_source;
> -=C2=A0=C2=A0 if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 source =3D coded->second_source;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id =3D coded->second_crc;
> -=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 source =3D coded->first_source;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet_id =3D coded->first_crc;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 batadv_nc_hash_key_gen(&nc_path_key, source, dest);
> -=C2=A0=C2=A0 index =3D batadv_nc_hash_choose(&nc_path_key, hash->size);
> -
> -=C2=A0=C2=A0 /* Search for matching coding path */
> -=C2=A0=C2=A0 rcu_read_lock();
> -=C2=A0=C2=A0 hlist_for_each_entry_rcu(nc_path, &hash->table[index], hash=
_entry) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Find matching nc_packet */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(&nc_path->packet_list_=
lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(tmp_nc_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nc_path->packet_list, list) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (packet_=
id =3D=3D tmp_nc_packet->packet_id) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 list_del(&tmp_nc_packet->list);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nc_packet =3D tmp_nc_packet;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_bh(&nc_path->packet_lis=
t_lock);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0 }
> -=C2=A0=C2=A0 rcu_read_unlock();
> -
> -=C2=A0=C2=A0 if (!nc_packet)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_dbg(BATADV_DBG_NC, bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "No decoding packet found for %u\n", packet_id);
> -
> -=C2=A0=C2=A0 return nc_packet;
> -}
> -
> -/**
> - * batadv_nc_recv_coded_packet() - try to decode coded packet and enqueu=
e the
> - *=C2=A0 resulting unicast packet
> - * @skb: incoming coded packet
> - * @recv_if: pointer to interface this packet was received on
> - *
> - * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
> - * otherwise.
> - */
> -static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_hard_i=
face *recv_if)
> -{
> -=C2=A0=C2=A0 struct batadv_priv *bat_priv =3D netdev_priv(recv_if->mesh_=
iface);
> -=C2=A0=C2=A0 struct batadv_unicast_packet *unicast_packet;
> -=C2=A0=C2=A0 struct batadv_coded_packet *coded_packet;
> -=C2=A0=C2=A0 struct batadv_nc_packet *nc_packet;
> -=C2=A0=C2=A0 struct ethhdr *ethhdr;
> -=C2=A0=C2=A0 int hdr_size =3D sizeof(*coded_packet);
> -
> -=C2=A0=C2=A0 /* Check if network coding is enabled */
> -=C2=A0=C2=A0 if (!atomic_read(&bat_priv->network_coding))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 /* Make sure we can access (and remove) header */
> -=C2=A0=C2=A0 if (unlikely(!pskb_may_pull(skb, hdr_size)))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 coded_packet =3D (struct batadv_coded_packet *)skb->data;
> -=C2=A0=C2=A0 ethhdr =3D eth_hdr(skb);
> -
> -=C2=A0=C2=A0 /* Verify frame is destined for us */
> -=C2=A0=C2=A0 if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !batadv_is_my_mac(bat_priv, coded_p=
acket->second_dest))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -
> -=C2=A0=C2=A0 /* Update stat counter */
> -=C2=A0=C2=A0 if (batadv_is_my_mac(bat_priv, coded_packet->second_dest))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_SNIFFED);
> -
> -=C2=A0=C2=A0 nc_packet =3D batadv_nc_find_decoding_packet(bat_priv, ethh=
dr,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 coded_packet);
> -=C2=A0=C2=A0 if (!nc_packet) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_DECODE_FAILED);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_skb;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* Make skb's linear, because decoding accesses the entire =
buffer */
> -=C2=A0=C2=A0 if (skb_linearize(skb) < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_nc_packet;
> -
> -=C2=A0=C2=A0 if (skb_linearize(nc_packet->skb) < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_nc_packet;
> -
> -=C2=A0=C2=A0 /* Decode the packet */
> -=C2=A0=C2=A0 unicast_packet =3D batadv_nc_skb_decode_packet(bat_priv, sk=
b, nc_packet);
> -=C2=A0=C2=A0 if (!unicast_packet) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV=
_CNT_NC_DECODE_FAILED);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_nc_packet;
> -=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0 /* Mark packet as decoded to do correct recoding when forwa=
rding */
> -=C2=A0=C2=A0 BATADV_SKB_CB(skb)->decoded =3D true;
> -=C2=A0=C2=A0 batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE);
> -=C2=A0=C2=A0 batadv_add_counter(bat_priv, BATADV_CNT_NC_DECODE_BYTES,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 skb->len + ETH_HLEN);
> -=C2=A0=C2=A0 return batadv_recv_unicast_packet(skb, recv_if);
> -
> -free_nc_packet:
> -=C2=A0=C2=A0 batadv_nc_packet_free(nc_packet, true);
> -free_skb:
> -=C2=A0=C2=A0 kfree_skb(skb);
> -
> -=C2=A0=C2=A0 return NET_RX_DROP;
> -}
> -
> -/**
> - * batadv_nc_mesh_free() - clean up network coding memory
> - * @bat_priv: the bat priv with all the mesh interface information
> - */
> -void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, =
1);
> -=C2=A0=C2=A0 batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1)=
;
> -=C2=A0=C2=A0 cancel_delayed_work_sync(&bat_priv->nc.work);
> -
> -=C2=A0=C2=A0 batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, N=
ULL);
> -=C2=A0=C2=A0 batadv_hash_destroy(bat_priv->nc.coding_hash);
> -=C2=A0=C2=A0 batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,=
 NULL);
> -=C2=A0=C2=A0 batadv_hash_destroy(bat_priv->nc.decoding_hash);
> -}
> diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-cod=
ing.h
> deleted file mode 100644
> index 368cc3130e4c910f1c551aae1bf4038e3c3bd867..0000000000000000000000000=
000000000000000
> --- a/net/batman-adv/network-coding.h
> +++ /dev/null
> @@ -1,106 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (C) B.A.T.M.A.N. contributors:
> - *
> - * Martin Hundeb=C3=B8ll, Jeppe Ledet-Pedersen
> - */
> -
> -#ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
> -#define _NET_BATMAN_ADV_NETWORK_CODING_H_
> -
> -#include "main.h"
> -
> -#include <linux/netdevice.h>
> -#include <linux/skbuff.h>
> -#include <linux/types.h>
> -#include <uapi/linux/batadv_packet.h>
> -
> -#ifdef CONFIG_BATMAN_ADV_NC
> -
> -void batadv_nc_status_update(struct net_device *net_dev);
> -int batadv_nc_init(void);
> -int batadv_nc_mesh_init(struct batadv_priv *bat_priv);
> -void batadv_nc_mesh_free(struct batadv_priv *bat_priv);
> -void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_orig_node *orig_neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_ogm_packet *ogm_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int is_single_hop_neigh);
> -void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool (*to_purge)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_nod=
e *));
> -void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
> -void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
> -bool batadv_nc_skb_forward(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct batadv_neigh_node *neigh_node);
> -void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb);
> -void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb);
> -
> -#else /* ifdef CONFIG_BATMAN_ADV_NC */
> -
> -static inline void batadv_nc_status_update(struct net_device *net_dev)
> -{
> -}
> -
> -static inline int batadv_nc_init(void)
> -{
> -=C2=A0=C2=A0 return 0;
> -}
> -
> -static inline int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
> -{
> -=C2=A0=C2=A0 return 0;
> -}
> -
> -static inline void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
> -{
> -}
> -
> -static inline void
> -batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t batadv_orig_node *orig_neigh_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t batadv_ogm_packet *ogm_packet,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i=
s_single_hop_neigh)
> -{
> -}
> -
> -static inline void
> -batadv_nc_purge_orig(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t batadv_orig_node *orig_node,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool =
(*to_purge)(struct batadv_priv *,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_nc_node *))
> -{
> -}
> -
> -static inline void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
> -{
> -}
> -
> -static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_nod=
e)
> -{
> -}
> -
> -static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct batadv_neigh_node *neigh_=
node)
> -{
> -=C2=A0=C2=A0 return false;
> -}
> -
> -static inline void
> -batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct sk_buff *skb)
> -{
> -}
> -
> -static inline void
> -batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb)
> -{
> -}
> -
> -#endif /* ifdef CONFIG_BATMAN_ADV_NC */
> -
> -#endif /* _NET_BATMAN_ADV_NETWORK_CODING_H_ */
> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index a464ff96b92917c3e9122b850d948a0108602518..c84420cb410d5d948c6612cf2=
7e320e7e0af017e 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
> @@ -37,7 +37,6 @@
> #include "log.h"
> #include "multicast.h"
> #include "netlink.h"
> -#include "network-coding.h"
> #include "routing.h"
> #include "translation-table.h"
>
> @@ -883,9 +882,6 @@ void batadv_orig_node_release(struct kref *ref)
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 spin_unlock_bh(&orig_node->vlan_list_lock);
>
> -=C2=A0=C2=A0 /* Free nc_nodes */
> -=C2=A0=C2=A0 batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
> -
> =C2=A0=C2=A0=C2=A0 call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
> }
>
> @@ -959,8 +955,6 @@ struct batadv_orig_node *batadv_orig_node_new(struct =
batadv_priv *bat_priv,
> =C2=A0=C2=A0=C2=A0 spin_lock_init(&orig_node->tt_lock);
> =C2=A0=C2=A0=C2=A0 spin_lock_init(&orig_node->vlan_list_lock);
>
> -=C2=A0=C2=A0 batadv_nc_init_orig(orig_node);
> -
> =C2=A0=C2=A0=C2=A0 /* extra reference for return */
> =C2=A0=C2=A0=C2=A0 kref_init(&orig_node->refcount);
>
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 35d8c578399985760c28f09de9629a57212d2f27..12c16f81cc51df0f059976c14=
38fe9fe53f66a54 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -31,7 +31,6 @@
> #include "hard-interface.h"
> #include "log.h"
> #include "mesh-interface.h"
> -#include "network-coding.h"
> #include "originator.h"
> #include "send.h"
> #include "tp_meter.h"
> @@ -956,15 +955,9 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>
> =C2=A0=C2=A0=C2=A0 /* function returns -EREMOTE for promiscuous packets *=
/
> =C2=A0=C2=A0=C2=A0 check =3D batadv_check_unicast_packet(bat_priv, skb, h=
dr_size);
> -
> -=C2=A0=C2=A0 /* Even though the packet is not for us, we might save it t=
o use for
> -=C2=A0=C2=A0=C2=A0 * decoding a later received coded packet
> -=C2=A0=C2=A0=C2=A0 */ ...

