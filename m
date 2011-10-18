Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2011 21:15:32 +0200
Message-ID: <22002081.QEpvgSbQlm@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2662543.BFmRBCrGMQ";
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


--nextPart2662543.BFmRBCrGMQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"


----------  Forwarded Message  ----------

Subject: Re: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
Date: Tuesday 18 October 2011, 21:11:51
From: Filippo Sallemi <tonyputi@gmail.com>
To: Sven Eckelmann <sven@narfation.org>

Ok but i'm using backfire 10.03 with "package" url of
feeds.default.conf and in this version the makefile is for batman-adv
2011.2.0.

in my feeds.conf.default i have:
src-svn packages
svn://svn.openwrt.org/openwrt/branches/packages_10.03.1
svn://svn.openwrt.org/openwrt/packages

and in svn://svn.openwrt.org/openwrt/branches/packages_10.03.1 there
is batman-adv 2011.2.0 package.

It is a openwrt problem? my feeds.conf.default is the original openwrt conf.

Rgds


2011/10/18 Sven Eckelmann <sven@narfation.org>:
> On Tuesday 18 October 2011 20:57:53 Filippo Sallemi wrote:
> [...]
>> > Please create a new checkout of openwrt, add the feed, add batman-adv to
>> > the config and build it with V=99 (the clean checkout not an old one).
>> > Add the .config and the log to you mail.
>> >
>> > Thanks,
>> >        Sven
>>
>> This is my make V=99 output after make distclean and however a fresh
>> checkout of openwrt.
>
> No, that wasn't what I asked for.
>
>>
>> make[3]: Entering directory
>> `/home/fsallemi/Develop/backfire/feeds/packages/net/batman-adv'
>> gzip -dc /home/fsallemi/Develop/backfire/dl/batman-adv-2011.2.0.tar.gz
>
> What is that? 2011.3.0 with patches from 2011.3.0... this will _not_ work.
>
>>
>> | /bin/tar -C
>> | /home/fsallemi/Develop/backfire/build_dir/target-mips_r2_uClibc-0.9.30.
>> | 1/batman-adv/batman-adv-2011.2.0/..
>>
>> -xf -
>>
>> Applying
>> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.
>> patch using plaintext:
>> patching file translation-table.c
>> Hunk #1 FAILED at 1054.
>> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
>> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
>> Patch failed!  Please fix
>> ./patches/batman-
adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.p
>> atch! make[3]: ***
>
> This is a patch for 2011.3.0 and not for 2011.2.0
>
>> [/home/fsallemi/Develop/backfire/build_dir/target-mips_r2_uClibc-0.9.30.1/b
>> atman-adv/batman-adv-2011.2.0/.prepared_d634b3efc2524a3909e7512491480870]
>> Error 1
>
> This says 2011.2.0
>
> [,,,]
>
> Kind regards,
>        Sven



-- 
Filippo Sallemi
-----------------------------------------
--nextPart2662543.BFmRBCrGMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOndBUAAoJEF2HCgfBJntGsP4QAJk0koeC6afLBzAXkW40uDEs
SlOHRPQ/0M4Yii0V5QdubnUcIMXZSdg6FH8UWXs60d3hlQbyVREfwQagfrhsERpK
C7DOYUjxAHFK1Knj2iyOHrqsLNmKxsn9hACJLpFQv5lwkUsjI6hF6CZteNybbGG8
WRYXdFG+smhi6rVkKBU0/qHeYekfS5yY8HFC33+jQ3jPQVXiMbZLEybnY2Ani+nB
vYYR/we42vFFU5dXal/ssS4XfxA76sxVJ3OFC6Jh60LRYTi37uAw6nnbnHn3p6cP
JhV/9WJuAtnGJGW4GYJnM32m2vgyS/daCweZIj22jezEras9Z8I9Djr1B7ut7dAb
+gvoB488Z/qfIMif9KG10vyHzDHyDe0bqQktMWOXJw0HyecJfomB72kGkjAz2ndH
K2cZGFFE6NXG/h1xf0zEsdRJ8IMH7sZOhFGv44zDPTGEYknqcIQuk7rrD74yDfhA
DdYndSFZKhIcFsm35G9GPpoKbRS/txVDGoRCaYvEJmMRLDE9UjT1MN5p35ch0uvY
swUjNz2Jcqj+9serHBT0v+RbYasdBM8SVePMgusfMQtH5ge3c6hZfo0P8EjXKvKX
ouZiJ0VmFpHbTyOCMyfCmdkoXtMcnktgo8OxZ9xVJX4lj6We1Wy/RERwVKR1NpS+
eIcQSX3ijvTMSlRNyvw8
=280H
-----END PGP SIGNATURE-----

--nextPart2662543.BFmRBCrGMQ--

