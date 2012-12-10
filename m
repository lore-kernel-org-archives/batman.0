Return-Path: <jow@openwrt.org>
Message-ID: <50C52937.1060308@openwrt.org>
Date: Mon, 10 Dec 2012 01:13:43 +0100
From: Jo-Philipp Wich <jow@openwrt.org>
MIME-Version: 1.0
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
 <CAHD-aqLUc7YAsmgOdGS2nxdU06U3KTbCAtjXHa4v_64fzHNhWg@mail.gmail.com>
 <50C471C0.2060407@web.de> <201212092231.50649.lindner_marek@yahoo.de>
 <50C4B63F.60101@web.de>
 <CAHD-aqJ9vCqHBSa53zDvWvAr1hJnqqjr_Jxj0YEtV4BCFkuu+g@mail.gmail.com>
In-Reply-To: <CAHD-aqJ9vCqHBSa53zDvWvAr1hJnqqjr_Jxj0YEtV4BCFkuu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> I'd also add 'netifd' as a dependency in the makefile

You could but I do not think it is necessary. kmod-batman-adv works
well without netifd, the onyl thing that would break is the support
scripts.

Also netifd is pretty much guranteed to be present in current release
so you can rely on it, but people who do not have it installed for
wahtever reason might still want to use the batman kernel module, so
I'd opt for not making it a hard dependency.

Cheers,
Jow

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDFKTcACgkQdputYINPTPMRrwCcDBW58q62Jm7lJKIywuLX7B15
59MAn3G4pLJUn7ACt5iTxBpOx8qjS7E4
=btbj
-----END PGP SIGNATURE-----
