Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2011 20:09:47 +0200
Message-ID: <16914270.mta8dqh2TR@sven-desktop.home.narfation.org>
In-Reply-To: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
References: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1661495.HhaBJdxUSP";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
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


--nextPart1661495.HhaBJdxUSP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday 18 October 2011 13:59:18 Filippo Sallemi wrote:
> Hi all,
> after an ./script/feeds update when i try to build openwrt I get an
> error on batman-adv package:
> 
> Applying
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.
> patch using plaintext:
> patching file translation-table.c
> Hunk #1 FAILED at 1054.
> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
> Patch failed!  Please fix
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.p
> atch!

Please create a new checkout of openwrt, add the feed, add batman-adv to the 
config and build it with V=99 (the clean checkout not an old one). Add the 
.config and the log to you mail.

Thanks,
	Sven
--nextPart1661495.HhaBJdxUSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOncDrAAoJEF2HCgfBJntGofwP/RQCFDRY4JY0b+egVrupVJhW
AAwudSQbQ7KnlHPvAYQFhP2aG7kE8LVXc0CERFN/Hd5VOJyHyLKoCFRra0JDgQej
DmPpvmkuJ0xKKhN2+kgaj0coRRyvCKKuuNJfrVNaH0O4KQEwizZyv/69ZTeFSXxU
76w3evq4xwu5GWEVbHwhDvcPXNs+P2QDbn7tsizeD5vjX+scppUNLv8e1/Ljr2xx
pNzC4peWwmVGuw3kUnJbS/Z6TEzy9HzqqYXyb5fh5H8SmftBAQuL88iTskAhNwRv
yL991gMf9IwQ+puUzK7LMQ5SuyuXX9xsWbT8awJBTt55ThwkzR70Kntqc0xzjXFj
FlvDDjnDQ7Ej4n8hJERE02LrbzXxavqxIFCH1eJxovWCIUqc6/xrZ2Kng3TqvRzV
av7AcLsVwnMesd3wozKVCOsVbHrYDceZhNjtGxq7vAM0S6KSwdnrHcRg1ilTIY9b
9kUhhn13FhNZ0FVfgQpkaDhOQHwYz439RHffFAa6W2aennzNFG1G0uED0Uk/n0Yi
Or3+VXR98n6QkCDTKoFhfsD3cxc5SECHYQWQubCH95U9Pw0lZIPAsjeghEfSPoi2
UMQo4A3CruX4F0gLlJ6VMLi0BNiWG+DphiyexdvNAmMRdttYpQuscyNVkkP4WwJY
RfYQfVzD0KoNqpN/It35
=2N/s
-----END PGP SIGNATURE-----

--nextPart1661495.HhaBJdxUSP--

