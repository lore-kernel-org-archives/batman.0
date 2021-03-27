Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Problem with batman-adv and wifi adhoc in OpenWrt 19.07
Date: Sat, 27 Mar 2021 09:12:29 +0100
Message-ID: <12440149.KDPBelFpPj@sven-l14>
In-Reply-To: <20210327003654.1205.8819@diktynna.open-mesh.org>
References: <20210327003654.1205.8819@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12634480.o9XkevPc1q"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: spiccinini@altermundi.net

 
--nextPart12634480.o9XkevPc1q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: spiccinini@altermundi.net
Subject: Re: Problem with batman-adv and wifi adhoc in OpenWrt 19.07
Date: Sat, 27 Mar 2021 09:12:29 +0100
Message-ID: <12440149.KDPBelFpPj@sven-l14>
In-Reply-To: <20210327003654.1205.8819@diktynna.open-mesh.org>
References: <20210327003654.1205.8819@diktynna.open-mesh.org>

On Saturday, 27 March 2021 01:36:54 CET spiccinini@altermundi.net wrote:
> Libremesh based on OpenWrt 19.07 + ad-hoc: not working
> Libremesh based on OpenWrt 19.07 + 802.11s: working
> Libremesh based on OpenWrt 18.06 + ad-hoc: working
> Libremesh based on OpenWrt 18.06 + 802.11s: working

Sounds like your wifi stack/driver is failing. batman-adv doesn't know or care 
about whether the wifi layer is using IBSS or a non-fwding meshpoint 
interface.

batman-adv is needing:

* working broadcast in both directions

  - you can see in `batctl n` whether some OGMs were received from a neighbor
  - you can see in `batctl o` if both directions work(ed)

* working unicast in both directions

  - just use something like `batctl ping` or some other kind of `ping` 
    directly on the lower interface (wlan*-adhoc)
  - you might also use something like `tcpdump`/`batctl td` to check if the 
    peer can receive your unicast packets on the lower device (wlan*-adhoc)

You should also configure a third device in wifi monitor mode to figure out 
whether the transmission of the unicast/broadcast packets is working or not. 
This should make it easier for you to figure out whether the sending or 
receiving part is not working in your wifi stack/driver.
 	
Kind regards,
	Sven
--nextPart12634480.o9XkevPc1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmBe6O0ACgkQXYcKB8Em
e0Z59Q/9E+yxXScw7fQnxfXqrfWkmcTsBTNmcv3LnI02M3k1KfVglji5Lnbf9Nwo
+HXhXk2t7dlRyF+whdP9N09uRdhHI5HIZfJz0be43jBycdnMa3Nt2ErPpMaNuMsq
wm9GX8kUpNhfyc5NO0BwOiF2brSYxEe2+AafBdToxbVVCnS2Jse0LAd3uo54CniG
2s7hlG6z7w0h2XEgv5GnrVuIbwY/7TO1/vm+pr29tsJ3nAgFtrGwSs6ZXtU6IJOr
1cHpT1hV2xjq8by7Fcgc9T7ByufdQW1jq9y2jjDik1Uz//V1Xvl1L9eHMn72BPcb
9ThlWocXxaWJy/U81RR8l30GR4R2yN5GAHb5ljxbJ+JabsgxkYl7izfVrDyCRcbN
JUfUQ+6UCeO6Hmlma+fW9pCtcOxdUjxmEFn7+dLvkvp+hfB/4OXgvAl+VQG+T6Rf
6hWYpzhkGAhZKwkgdJK5V/mq3G0FDIXmlOql+Z4BFrQkWpVDMcwRcEPjbATix/lK
6FOnNSlr7tQpaV+NW4VesgMiEmvPvIj08sNGptf2wZmCNnfMwpgS15REDt2Ks3zp
Acl7XT/pA4REN/+kjd+zAA/nIxbf8qeFDR943XZByXg897R4vcz4FFOAqxqeLts8
53AcoyBg9mhccNzQTCeapYdHcdjMErKcOA74o51e+L6cMFNfCZk=
=7O2Q
-----END PGP SIGNATURE-----

--nextPart12634480.o9XkevPc1q--


