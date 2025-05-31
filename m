Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F2C5B543
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:52:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E3A1B847A0
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:52:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748685158;
 b=tM40BZl2ifRACHf+Qp/oDm13cJXis3pWBKBNUoV+1wvwc3H43m0PmTsrL1HyVVYp6sCPL
 /kluBDDq7EKmiCwbNFyOcT71ALr7R5FfcTc3qhQg0cuPLHl4cnzqTxSjaVxaf62mQElRxyv
 82xag8XT9h7bMDTThnAM3wJPirAjgxk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748685158; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yvo1gKEFvcCi1DSavYyf9wE/OfH4XiSCUbk32K7rcBQ=;
 b=s1KdL7vulfMDRiroBt1WTnOgrqod7zptaAbCsoeN5+lrGzA8RTopo9htWoeqNNn4xOgh1
 btqb0+ndnpCaeRuJZ5t42LPlXKhxeXILnAKBbJ50dJarhm/JWmmAc2VwGCWneDw86I6kLPt
 XznK3YfS0Fa25V4ZatRr37Wz/VJMLQw=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9E95982586
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:52:19 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748685149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yvo1gKEFvcCi1DSavYyf9wE/OfH4XiSCUbk32K7rcBQ=;
	b=MrMw9f1OxDSI1OaE7SCFngTeTl8Zez+IpnIKVk2QgMDlF3wsaLv9ih5jfZkrT2AkfsS/iR
	26jlRHRhi1L7OSr9f9804P3aRZQlTDUCyKc6zhb++ujZ7PE1osoZ11rP09MtzFRsG0jBuD
	Ua8PE23CmJfMgFjD2BpQDBcRXE0XSc0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nUO6SsTZ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748685149; a=rsa-sha256;
	cv=none;
	b=nRtqTODWNhGUcuu+OCAL0EfrEXpr3e1jsOe61HgKhOW3Q7gUztVHcl7nefPwCdo6G2x07V
	DdgcV1gtbj8Fx4mAX/TEjo7JPu4NkVkwL8VJmtXsmdaht34w0jQFKm44om1qF7OvBNiV95
	h5DAQckEJaWxWzO8hkhhZ+GJiBz+a2A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvo1gKEFvcCi1DSavYyf9wE/OfH4XiSCUbk32K7rcBQ=;
	b=nUO6SsTZH54XbUvXnm3Ki3CChaZZZASBQx/bUv8hbtvqU5PiZUPFTbmxUu9k/yn5srJafl
	k5CXPZdG/k8vTSCpGQa3b+CFO6elNPORIR2r0USjAJcoCUaMCLd6Xwwy3wbZ393/KKVX0N
	ld/l6hZZXkLzBgccZIoVQ1O+Q9zUvsk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject: 
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:52:12 +0200
Message-ID: <6005840.1IzOArtZ34@sven-desktop>
In-Reply-To: 
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4437374.BddDVKsqQX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: EOMAI56QRWCZ5R3MLNVVQAQOZHXPI46N
X-Message-ID-Hash: EOMAI56QRWCZ5R3MLNVVQAQOZHXPI46N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EOMAI56QRWCZ5R3MLNVVQAQOZHXPI46N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4437374.BddDVKsqQX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:52:12 +0200
Message-ID: <6005840.1IzOArtZ34@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:29 CEST Matthias Schiffer wrote:
> -int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
> +int batadv_hardif_enable_interface(struct net_device *net_dev,
>                                    struct net_device *mesh_iface)
>  {
[....]
> +       hard_iface->wifi_flags =3D batadv_wifi_flags_evaluate(net_dev);

Moving this here should break the WIFI TT flag in scenarios like this:

                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90            =20
       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BCbr-lan=E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =20
       =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98      =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
     =E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=90                    =E2=
=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =20
     =E2=94=82ap0=E2=94=82                    =E2=94=82bat0=E2=94=82   =20
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98                    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98   =20
                                 =E2=94=82     =20
                                 =E2=94=82     =20
                              =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=80=E2=94=90  =20
                              =E2=94=82mesh0=E2=94=82  =20
                              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =20


ap0 is not the lower interface of any batadv mesh interface but TT ap=20
isolation is depending on the information stored for this hardif. See:



/**
 * batadv_is_wifi_hardif() - check if the given hardif is a wifi interface
 * @hard_iface: the device to check
 *
 * Return: true if the net device is a 802.11 wireless device, false otherw=
ise.
 */
bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
{
	if (!hard_iface)
		return false;

	return hard_iface->wifi_flags !=3D 0;
}

bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
			 unsigned short vid, int ifindex, u32 mark)
{
[...]
	if (ifindex !=3D BATADV_NULL_IFINDEX)
		in_dev =3D dev_get_by_index(net, ifindex);

	if (in_dev)
		in_hardif =3D batadv_hardif_get_by_netdev(in_dev);
[...]
	if (batadv_is_wifi_hardif(in_hardif))
		tt_local->common.flags |=3D BATADV_TT_CLIENT_WIFI;
[...]


static bool
_batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
		       struct batadv_tt_global_entry *tt_global_entry)
{
	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI &&
	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
		return true;

	/* check if the two clients are marked as isolated */
	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_ISOLA &&
	    tt_global_entry->common.flags & BATADV_TT_CLIENT_ISOLA)
		return true;

	return false;
}


Kind regards,
	Sven
--nextPart4437374.BddDVKsqQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrRTAAKCRBND3cr0xT1
yzUsAQCp/BGDaLgH0bq7xgYDPfCB+JWa1ATr3Z4n9blbzryMMgD/bOqU8Sjbwa9V
21JVjVIElBn4VBShwmvDlt2H82tdMQg=
=Ej70
-----END PGP SIGNATURE-----

--nextPart4437374.BddDVKsqQX--



