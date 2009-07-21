Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 21 Jul 2009 22:48:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090721204801.GA14658@pandem0nium>
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dingo,

i know it is a long time ago, but can you please verify if the problem pres=
ent in
Ticket 121 [1] still affects you? Or is it already solved? The entries are =
10
months old and the issue is probably already fixed.

Thank you very much,
	Simon

[1] https://www.open-mesh.net/ticket/121

On Fri, Sep 05, 2008 at 10:01:24PM +0700, Outback Dingo wrote:
>  see pastebin
>=20
> http://www.pastebin.ca/1194874
>=20
> pertinent info
> dmesg | grep 'batgat loaded'
> batgat: [init_module:96] batgat loaded  rv1025
> uname -a
> Linux nightwing 2.6.23.16 #16 Tue Apr 22 20:00:17 ART 2008 mips unknown
> root@nightwing:~# batmand -v
> WARNING: You are using the unstable batman branch. If you are interested =
in
> *using* batman get the latest stable release !
> B.A.T.M.A.N. 0.3-beta (compatibility version 5)
> lsmod
>=20
> Module                  Size  Used by    Tainted:
> P
> sch_htb                14048
> 2
> ath_ahb               103616
> 0
> wlan_xauth               480
> 0
> wlan_wep                4000
> 0
> wlan_tkip               9856
> 0
> wlan_ccmp               5440
> 2
> wlan_acl                1920  0
> ath_rate_minstrel       8352  1
> ath_hal               136832  3 ath_ahb,ath_rate_minstrel
> wlan_scan_sta           8768  1
> wlan_scan_ap            6656  0
> wlan                  152464  10
> ath_ahb,wlan_xauth,wlan_wep,wlan_tkip,wlan_ccmp,wlan_acl,ath_rate_minstre=
l,wlan_scan_sta,wlan_scan_ap
> batgat                 10944  1
> ipt_iprange              672  0
> ipt_TOS                  832  0
> ipt_TTL                  928  0
> xt_MARK                  960  3
> ipt_ECN                 1472  0
> xt_CLASSIFY              640  0
> ipt_ttl                  704  0
> ipt_tos                  544  0
> ipt_time                1568  0
> xt_tcpmss               1088  0
> xt_statistic             832  0
> xt_mark                  672  7
> xt_mac                   736  3
> xt_length                736  0
> ipt_ecn                 1024  0
> xt_DSCP                 1056  0
> xt_dscp                  832  0
> imq                     2096  0
> ipt_IMQ                  672  2
> xt_string                896  0
> xt_layer7               9840  0
> ipt_ipp2p               6784  0
> ipt_LOG                 4640  0
> xt_CHAOS                1792  0
> xt_DELUDE               2624  1
> xt_TARPIT               2816  1
> xt_quota                 800  0
> xt_portscan             2016  0
> xt_pkttype               704  0
> xt_physdev              1488  0
> ipt_owner                800  0
> iptable_raw              832  0
> xt_NOTRACK               832  0
> xt_CONNMARK             1088  0
> ipt_recent              4992  0
> xt_helper                992  0
> xt_conntrack            1312  0
> xt_connmark              832  0
> xt_connbytes            1312  0
> tun                     6592  0

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpmKYEACgkQrzg/fFk7axa3jQCfbUDUU+9KB2/vgrPrfefpwvAO
B2AAn0h76olEPQ6u+w7MZcJ2R30KwIBe
=NUcO
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
