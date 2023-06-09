Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1F7C7EE25
	for <batman@archiver.kernel.org>; Fri,  9 Jun 2023 12:10:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C5DAC816FB
	for <batman@archiver.kernel.org>; Fri,  9 Jun 2023 14:10:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686312612;
 b=T+1XOMYyw02FwbzMvg9KdHW0q/G2MXstHoXP7jyhpkmOGxQ1QzjfcJwom6jwepWwu9JDs
 SsNefyPxBFRgAe95JBQAhZPK9kIk+6YtVxzuGFhfi7MBW2WiTwfDfOdhYONMqPdFLnQk2qC
 qm3vqFwglNJE7bOSa0EncH8KiMpdKO4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686312612; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GlNSm7D+6AunSFexTxHVxCw0Xl1Yt/sPbQSFTpQ/WPo=;
 b=S08UQkNmHAP130t2k53rG33tms+bk9+JO7xHbciS8NopJeNJ3zMgntIi3wwx5v7Msazcj
 RFwJF1Rulut8LyJE3rVIRhCA61/P/WqtqatGUd5i/Oen0EtxDeSG2n+Apkk2EKh873elv7s
 k+CbzN0ybcGi+ESaz5/ttLmyu6AclPQ=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5585680A12
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 Jun 2023 14:10:06 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686312606; a=rsa-sha256;
	cv=none;
	b=gHp16wUdM7JvKXXdjIVe2aGVZ5lzJ0XNx2+Z7Cyv5EtFgsjD4Vi+ZKP2tP1t6GBKfnOt7b
	sm9WlfWl6+VAewQjiYOaikv0AgFD+oIXRQpElRxeYWHZwwPAeTDdEBFWNGAoJhiNYcUkdg
	qUMLSjQmL0yGLUb4QUvnwdbGX9C7crg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="YUW/u355";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686312606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GlNSm7D+6AunSFexTxHVxCw0Xl1Yt/sPbQSFTpQ/WPo=;
	b=DD317q6/gXqWjpnQQnOHhPnCIJhoBa+IXkTd3TjZ/wbwCMktoFJep+OwxdBlHGCkM7qsox
	eKGo3TDvq6TsI//FgPOrinZvlYhmbZiB4+POU5xDDCG6iBJpJqp+qSxXsUjUXsUR03GA68
	/OMtZ5Ff8wYsdO0WrTfEqX2VAa6auHA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1686312605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlNSm7D+6AunSFexTxHVxCw0Xl1Yt/sPbQSFTpQ/WPo=;
	b=YUW/u355/RPI8NkZ/ZlWWYs3V/MS4Z/hD7N14iOxWHSM0IODTyT2EjChdMKVrlUpQzEBCZ
	zgQrA2KCY12jogWKows29G3Do/gAQDtT71CsujBtvt8Lv+fRWRzdwVPo2cfIf8e0ovivkN
	ixPJrMEIHNGELyCIShRJkq6pW8GeWBU=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: 
 Re: Error - mac address of the ping destination could not be resolved and is
 not a bat-host name
Date: Fri, 09 Jun 2023 14:10:00 +0200
Message-ID: <8229391.T7Z3S40VBb@ripper>
In-Reply-To: <168625670360.986.1615951581894902714@diktynna.open-mesh.org>
References: <168625670360.986.1615951581894902714@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10285869.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HINNLGVAOGZB7BWAEUJFWDXYR2SSZNR2
X-Message-ID-Hash: HINNLGVAOGZB7BWAEUJFWDXYR2SSZNR2
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: mark.mundy@draeger.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HINNLGVAOGZB7BWAEUJFWDXYR2SSZNR2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart10285869.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: mark.mundy@draeger.com
Date: Fri, 09 Jun 2023 14:10:00 +0200
Message-ID: <8229391.T7Z3S40VBb@ripper>
MIME-Version: 1.0

On Thursday, 8 June 2023 22:38:23 CEST mark.mundy@draeger.com wrote:
> What is the best way to figure out why 2 nodes that are connected on a WMN can see each other through 'batctl n', but 'batman ping' fails with the message "Error - mac address of the ping destination could not be resolved and is not a bat-host name"?

Please use either the actual mac address of the remote or the IP which is 
configured on the bat0 (which is also reachable directly by your host). 
batman-adv is not the IP subsystem and will therefore not be able to resolve 
any non-direct neighbors (over bat0).

> Node at eth1 - 10.1.1.1, wlan0 mac ether 04:f0:21:59:38:c9
> root@jammy-newport:~# batctl n
> [B.A.T.M.A.N. adv 2021.3, MainIF/MAC: wlan0/04:f0:21:59:38:c9 (bat0/72:85:90:2a:95:06 BATMAN_IV)]
> IF             Neighbor              last-seen
>         wlan0     c4:4b:d1:90:02:90    0.500s
> root@jammy-newport:~# batctl ping 10.2.1.1
> Error - mac address of the ping destination could not be resolved and is not a bat-host name: 10.2.1.1
> 
> 
> Node at eth1 - 10.2.1.1, wlan0 mac ether c4:4b:d1:90:02:90
> root@focal-newport:~# batctl n
> [B.A.T.M.A.N. adv 2021.3, MainIF/MAC: wlan0/c4:4b:d1:90:02:90 (bat0/6e:87:15:7e:f3:14 BATMAN_IV)]
> IF             Neighbor              last-seen
>         wlan0     04:f0:21:59:38:c9    0.708s
> root@focal-newport:~# batctl ping 10.1.1.1
> Error - mac address of the ping destination could not be resolved and is not a bat-host name: 10.1.1.1
> 
> My intention is to be able to reach a computer on the far side of the WMN connected to eth1 10.2.1.1 from my host computer connected to the same network on eth1 10.1.1.1. It should look something like this.
> network -> eth1 10.1.1.1 -> wlan0 -> bat0 (inet 10.1.1.4) -> BATMAN -> bat0 (inet 10.2.1.4) -> wlan0 -> eth1 10.2.1.1 -> non-BATMAN computer
> 
> My intention is to have eth1 10.1.1.1 connected to the main network as an interface for bat0 able to communicate over bat0. On the other end, eth1 10.2.1.1 The interfaces for eth1 and wlan0 show as active for both computers. 

Reach how? With IP routing? It is not the task of batman-adv to perform IP 
routing (it is on the wrong layer).


On Thursday, 8 June 2023 22:38:23 CEST mark.mundy@draeger.com wrote:
> allow hotplug eth1
> auto eth1
> iface eth1 inet static
>         address 10.1.1.1
>         netmask 255.0.0.0
>         gateway 10.0.0.1
> #        dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4
> 
> allow hotplug bat0
> auto bat0
> iface bat0 inet static
>         address 10.1.1.4
>         netmask 255.0.0.0

The IP configuration is weird. You have two IP addresses (bat0+ethX) which are 
overlapping (10.0.0.0/8). This cannot work.

If it should be a transparent bridge between mesh without IP routing then 
please add bat0+eth1 in the same bridge. And then configure the IP address on 
top of the bridge.

Kind regards,
	Sven
--nextPart10285869.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmSDFpgACgkQXYcKB8Em
e0YvDhAAltHwATLUTpUYdlkPAtCxgd1H/4rLNEX9SJ37wXJD/8zjO2DQ2YozcWbE
qC+GsFohluRxVdiDQEMSiKLZWV3zCltJYMq88x6GErN7OKXMHqDRJvQ8++rDXOJO
a6DEEYRitSmckdKESxiUtLk6AkNpg95495tabOTRf29t1TCC+BwLQbV2Qkrq53va
1TKZXhMvupp+9M7d2XnqHrf4Z0IkBJe9KKEymh4Yb2hUBvA7MP5eGRcF44Y01k2g
QF8edjCaD2JSlJql7hsuFRYgr/4ixoS66+Xg814CdALQY2HA/aTX2SjIjqGU6xuN
sIP048CoxvLSHmcASnqq7ot/Ol2heKC5urj8TscytnT4hypa6vBxZmKCaUAQrPsf
mrN5zw1d17EF1PclKbUN8hc5e5taOgseHJAeseFtgepbAVQbJoxY/B/quy7KMQ7v
BtjwLUyFMkFoX5AJ2eGtdITUGSYDAxRWl4DMI4xKadu7MhM2hXDGRMhBMJva7Ntf
jx8MNUbYPbG8yscSwCSNMcO62c7l66i2zKo4C2iQb+m6OQofGuhds2gs06XKG97R
fvnzaapDK0yzfxs1hTTsyWmsGVy5RX2TvPszkStEqwjndNB1Lq8bDstfqO6sc9L5
0BYiRnRWmXLHgTSFd9J7euZdmRbmQvVYKRSKs8ODJyAlBGyv7kc=
=N9/l
-----END PGP SIGNATURE-----

--nextPart10285869.nUPlyArG6x--



