Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Oct 2011 10:18:42 +0100
Message-ID: <6028805.d7dOrXsFof@sven-laptop.home.narfation.org>
In-Reply-To: <1319964962-5092-6-git-send-email-ordex@autistici.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2001510.qzX1lgRH6X";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Distributed ARP Table -
	add snooping functions for ARP messages
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2001510.qzX1lgRH6X
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 30 October 2011 09:56:01 Antonio Quartulli wrote:
> In case of an ARP message going in or out the soft_iface, it is intercepted
> and a special action is performed. In particular the DHT helper functions
> previously implemented are used to store all the ARP entries belonging to
> the network in order to provide a fast and unicast lookup instead of the
> classic broadcast flooding mechanism.
> Each node stores the entries it is responsible for (following the DHT rules)
> in its soft_iface ARP table. This makes it possible to reuse the kernel
> data structures and functions for ARP management.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
[...]
> diff --git a/Makefile.kbuild b/Makefile.kbuild
> index c8d6543..3076c22 100644
> --- a/Makefile.kbuild
> +++ b/Makefile.kbuild
> @@ -25,7 +25,7 @@ ifeq ($(MAKING_MODULES),1)
>  -include $(TOPDIR)/Rules.make
>  endif
> 
> -# ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
> +ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
> 
>  ifneq ($(REVISION),)
>  ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"

Please remove that change.

Thanks,
	Sven
--nextPart2001510.qzX1lgRH6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOrRZyAAoJEF2HCgfBJntGqZYP/3GoUK81LgEGPog+703DOFAo
o2oGo/F01aUL9T3wEkfU6fDSfzNb/OanDGQ1WXvSnrzH7+uZeokHtebwT0Y5IIPX
ynaypH3un3VK3F5RArkIrPXO1myBnMRMDOZ3lSe8Ul/2AEH1YkIHxtL8lF6o1FCo
XgRyUHRTR5Hos6v5Q9j7qQl4OQ7WdJ7wKe8Nah9tt/HJrsKN1hpQNPmncRkEBnQs
TUHLXfSFwqLQBzaRBIbYoVTcui+yR2hkcT3EZ7Xgmo4li0hN4Z8EOdu5kr+vlf1o
s/Pk+LNvKWCzLHliqCHKPsPJYYmqE/kU/Naf3cavW+3kL/jwLeYmWRtrSUQ8vJNG
X0zgol8y+U24JHhUdN4JKRBjzAEpCPNTyeTDdaglUgRzSNVlPD90soeeSZQuRxy3
Q7Sty81pDbyns/FbfMNY9VvCGc67jbsIN9HvOwGjtcyP1Cp+4ZPLj0xv2igIIA80
SwD30ZnORKEpLMbl9+roKYrsearfern1XPQdz/PbsJ+X5aDNlLWvULPxhFJVU6jC
TzRfpcuweH6TSu9YVYPbYlpc8FTuks7VFFkbGPvbXoAzBTORy+JCbY2zVYWuuiRm
BG5nuJHAoqK8NZlqNm7RehSqVi5ogE9G/+sm57sDiHDo8LEU6xMTxNpci1L9t5b7
RWslkErW6o1p0Pt4N7Yz
=asP/
-----END PGP SIGNATURE-----

--nextPart2001510.qzX1lgRH6X--

