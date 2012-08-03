Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Aug 2012 23:08:48 +0200
Message-ID: <13310929.DWNbFFCIHG@sven-laptop.home.narfation.org>
In-Reply-To: <CAMVTf1iJv-Eiduk6jpgz_qTTtED=niZAmPCfTQ4t7dFeEhVOvg@mail.gmail.com>
References: <CAMVTf1hm9Q8Ppu2Lq6h4+7OpvZ9meLYhxFKHFLhudD3LCTNXmg@mail.gmail.com>
 <CAMVTf1hncmbgHS9PL0uEuRA8TL+8rp1cX_iv+iiO6NHzFTU4cA@mail.gmail.com>
 <CAMVTf1iJv-Eiduk6jpgz_qTTtED=niZAmPCfTQ4t7dFeEhVOvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1810209.3APLMR4K3I";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Problems with internet connection in a
	mesh-network, (and dhcp and wireless access)
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


--nextPart1810209.3APLMR4K3I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 03 August 2012 12:41:46 Esteban Municio wrote:
> Solved!
> 
> It was a fool thing. I needed to add
> /sbin/iptables -t nat -A POSTROUTING -o <wan interface> -j MASQUERADE
>  to the gateway node. A L3 matter!
> 
> The help came from forum.openwrt , but thanks for your patience ;-)

? I wrote that you have to do masquerading in my first mail.

Kind regards,
	Sven
--nextPart1810209.3APLMR4K3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQHD3gAAoJEF2HCgfBJntG7hwQAIoU1Q58rJMCSF3+H1jYaIxb
SoucOhEKlNfemn39MJDaf8CfgY/QXc3EMGRdhXhf5zf422TRI6eV65HDWuzkiNfd
ijpHn7im4Y+i4JfstMjw7vtLpitFR3X5+T4jhuCrYv5WTc62ITWyhESV3WPsrGBA
g6eodmr1/9h0dZQBy7GNTrmrJzoHaqV+N6JXhNTpRW46paG0EKsc9ShuN+Ncjxpl
WQW/RXzzj5lgMhHuXgV/TQSJ1aBcXxQFmuGQZky4U33gRT6NlHPpGpO6LOY6BiBl
ZThuMW68ir7sM0BZlddv5iv8MBLky2+bBns9cIkhWRMzFxGjfxGp0BtATPvv+niS
gLuuoo5k5yYtN80CC8KwD5EOAtB91z0nmLABGL9YJM+mB84NfKTgtoiv2efpGdWD
JUEAE4KEzF619cOWmnzaEpLl/PX2kQNjcNKfftNWrlR8leQHM2K4XAWPJ7bnw/5o
a/UzWCDzCFd+dA/rUPhFkwV6qUijU/9dWNoeEf+tnFN3B5c9ZUSjBeA4qof1JJQl
KQIMcf1EtbPF48alze1lFXww4yLkGOlmnb+IiSHXn3pZm9NORpLJCaHAUzSgxNoW
pSuQEiXYuagTrkeKBPDbyMOYE8SXg2j9y8FAlMFJ8CNkpWJ5msHEQBfj0vHhiDqE
F0nLQqgi6xlT8AL95vqa
=+GZa
-----END PGP SIGNATURE-----

--nextPart1810209.3APLMR4K3I--

