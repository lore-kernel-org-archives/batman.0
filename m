Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8DBC636CD
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 09:50:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A42083DAD
	for <batman-adv@archiver.kernel.org>; Tue,  7 Feb 2023 10:50:37 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B3093803C8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Feb 2023 10:50:12 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1675763412; a=rsa-sha256;
	cv=none;
	b=PPGMaz0wzqOIiWwDDROJ1U776dfshd/ZBJe56IZO1xh1m84atuopfWVrtn4N1R1u0vMWxi
	4PQzUah/+hQ4ZrKYQMHyqwwkZqkXM+7UO4qwDz1hmQt52BQrApu/OCdRwwwGINROSwYgCy
	d8yV4RelKiq++AShehsE265CDo84R5s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2TcFs7t2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1675763412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0+RV4XYFLyO7dcuOSeOHYrkVg5qZ6ECDyVby5qmjwco=;
	b=EZ3rwJKNwPblYqarKFkDb+pQZW5qbsZqRJIq3MM+07U+ST33YtSTsNMjjbBFoiwZ4ER7LX
	wEu7zF7MuwZME4LxW2hgi3rIaw+oU50m/Ujd9kUsMRFJRAUPUdtnz1v+dAx8sRSXBipZRI
	ESnGOT2ppfOJXzcTtnqzpQ9rabMSdqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1675763411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+RV4XYFLyO7dcuOSeOHYrkVg5qZ6ECDyVby5qmjwco=;
	b=2TcFs7t2E5qp1ZP8wxlCkFGcVi1Mzk5xsdhYKODHaZhGdlF79d+p6Wf3X8J09+REVnb3Pp
	NiZ0Z0WvI4v7ONX9eGxeevOTo6qQTMGVLJeubkLrDmVU/8D+RL+TZTbv8+sXyl/FzARNTh
	S7dL+4PhCI3Km3YAg4Vn+zdbQnn+Nc8=
From: Sven Eckelmann <sven@narfation.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Date: Tue, 07 Feb 2023 10:50:08 +0100
Message-ID: <4503106.V25eIC5XRa@ripper>
In-Reply-To: <Y+ITwsu5Lg5DxgRt@unreal>
References: 
 <20230127102133.700173-1-sw@simonwunderlich.de> <8520325.EvYhyI6sBW@ripper>
 <Y+ITwsu5Lg5DxgRt@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4561296.LM0AJKV5NW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4C4AJATT5AXTHBIBEIK55KPVX6FROIJW
X-Message-ID-Hash: 4C4AJATT5AXTHBIBEIK55KPVX6FROIJW
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4C4AJATT5AXTHBIBEIK55KPVX6FROIJW/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4561296.LM0AJKV5NW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/5] batman-adv: Start new development cycle
Date: Tue, 07 Feb 2023 10:50:08 +0100
Message-ID: <4503106.V25eIC5XRa@ripper>
In-Reply-To: <Y+ITwsu5Lg5DxgRt@unreal>
MIME-Version: 1.0

On Tuesday, 7 February 2023 10:02:58 CET Leon Romanovsky wrote:
> In cases where you can prove real userspace breakage, we simply stop to
> update module versions.

That would be the worst option. Then the kernel shows bogus values and no one 
is helped.


And how should I prove it to you? Is that enough?

    $ lsmod|grep '^batman_adv'
    batman_adv            266240  0
    $ sudo batctl -v
    batctl debian-2022.3-2 [batman-adv: module not loaded]
    $ sudo batctl if add enp70s0
    Error - batman-adv module has not been loaded
    $ sudo ip link show dev bat0       
    8: bat0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
        link/ether 7a:8b:21:b7:13:b8 brd ff:ff:ff:ff:ff:ff
    $ sudo ip link set master bat0 dev enp70s0
    $ sudo ip link set up dev bat0
    $ sudo batctl n                         
    Missing attributes from kernel
    $ sudo batctl o
    Missing attributes from kernel


Expected was following output:

    $ sudo batctl -v
    batctl debian-2022.3-2 [batman-adv: 2022.3]
    $ sudo batctl if add enp70s0
    $ sudo ip link show dev bat0
    $ sudo ip link set up dev bat0
    $ sudo batctl n
    [B.A.T.M.A.N. adv 2022.3, MainIF/MAC: enp70s0/2c:f0:5d:04:70:39 (bat0/7a:8b:21:b7:13:b8 BATMAN_IV)]
    IF             Neighbor              last-seen
          enp70s0     50:7b:9d:ce:26:83    0.708s
    $ sudo batctl o
    [B.A.T.M.A.N. adv 2022.3, MainIF/MAC: enp70s0/2c:f0:5d:04:70:39 (bat0/7a:8b:21:b7:13:b8 BATMAN_IV)]
       Originator        last-seen (#/255) Nexthop           [outgoingIF]
     * 50:7b:9d:ce:26:83    0.684s   (255) 50:7b:9d:ce:26:83 [   enp70s0]

Kind regards,
	Sven
--nextPart4561296.LM0AJKV5NW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmPiHtEACgkQXYcKB8Em
e0ZizhAAgr1dcBRgU3o30VgcFrIx7VcmSLU0y9KP2tpRJECfvS5pj89II02klmRn
dHtj1rU1tiJfTRWMyefDLTvgYKN5gQjBW7AYO1qpY4kYmY6dcMK1rNJkmnU/leXJ
BTKEEl1fQKUoTXzKNC/81QUm3abYXOG21XP2c06wntKOlvKkdjwAHisVjmYK1cnK
mZMeiK7/zdKW89of0As4Z+Cli9VrsAgV1FwIlIfqweWG5SUcTyP9/Bhg8y9yPsxt
jas9Vo+9atRRyKvWYzH5NKMZ449bQAvMsaAu2rvTdvQl0S+tr6AsqqDrpLMRsjif
3PJTx7qkbwUzrCdk9Kbraq9v7JtsypZWJ8BW3ydkqcBkCr+Uv4q9/dM3mJ1W1MKk
NXhsmxlbRecidCMXUiScRDRISJ/ngrKGrUv5b8xn1qxvJRMUKYX3Br+NBy3AVxwc
Xc+v9Uy4RFbC1k/k+ZKB8lXCddznopvjKPeMIU5Ig3UhIDw+NVWXZ3vQg5eGpxPt
NjWajsE59001CJlnjIBekIcn+uYiBxEDKecfD2A/aoEllM7tuy2DAWugKLUZyvCO
iT1JRa+7tcyfHdjPgyeQjWOsJhJ7nlmqOgJFz4OsF2IGyxvO9DV1dSr/OZJDaR28
raEnHU8ZRJBYSLcg2L7JZ7tBrMGpliCTbYq556HopbuR8M3eAZo=
=ku9t
-----END PGP SIGNATURE-----

--nextPart4561296.LM0AJKV5NW--


