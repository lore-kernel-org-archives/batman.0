Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2016 09:43 +0200
Message-ID: <1861048.i0QxsABPPD@bentobox>
In-Reply-To: <20160510000311.GJ5816@otheros>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1811882.4NqUN7GsV2@sven-edge> <20160510000311.GJ5816@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2316921.Vml0yyevI0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 0/4] Multicast optimizations for
	bridges
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

--nextPart2316921.Vml0yyevI0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 10 May 2016 02:03:11 Linus L=FCssing wrote:
> On Thu, May 05, 2016 at 11:15:28PM +0200, Sven Eckelmann wrote:
> > On Thursday 05 May 2016 17:07:01 Linus L=FCssing wrote:
> > > This patchset can be found in the current linus/multicast-bridge
> > > branch.
> >=20
> > Please check the attached results of the daily build test scripts.
>=20
> Thanks Sven!
>=20
> Just wanted to note that there seem to be some false positives in
> there.
>=20
> "[net/batman-adv/multicast.c:1181]: (style) The function=20
'batadv_mcast_flags_seq_print_text' is never used."
> -> used in debugfs.c

Yes, cppcheck has some problems from time to time with it. I can whitel=
ist
this function.

> Also the header suggestions seem a bit unreliable to me,

I have do disagree here. Usually the person using the script or the per=
son=20
reading the result it unreliable.

For example I forgot to remove the compat-sources changes from the resu=
lts. It=20
is expected that it doesn't get the headers right here because it build=
s=20
against 4.5 and the changes in it are not for 4.5. So it will not find =
code=20
and thus think that it requires no headers.

> the following removals are false positives, I think:
>=20
> * header removals in compat-sources/*
>   -> breaks compiling

See above

=20
> * linux/icmp6.h in multicast.c
>   -> icmp6_hdr()
> * linux/ipv6.h in multicast.c
>   -> ipv6_hdr()
>=20
> * net/addrconf.h in multicast.c
>   -> ipv6_mc_check_mld()
>   -> ipv6_addr_is_ll_all_nodes()
> * net/ip.h in multicast.c
>   -> ip_eth_mc_map()
> * net/ipv6.h in multicast.c
>   -> IPV6_ADDR_MC_SCOPE
>   -> IPV6_ADDR_SCOPE_LINKLOCAL

Problem seems to be that your sources don't build at the moment. So mos=
t=20
likely you are missing some dependencies like CONFIG_INET (and maybe ev=
en=20
more).

The whole thing cannot work when your stuff doesn't build against the h=
eaders=20
prepared in build_test. I didn't see that you've added something to Kco=
nfig=20
and thus I haven't rebuild my headers.

> Moving the following includes upwards seems unnecessary:
> * linux/if_bridge.h in multicast.c
> * linux/igmp.h in multicast.c

This seems to be a side effect of how the script works. Moving is not t=
he=20
important part here but just what else is added/removed. But this can b=
e false=20
positives because the stuff doesn't build at the moment (even against 4=
.5)

[...]
> PS: I also do not understand the sparse complaints regarding
> ip_eth_mc_map(). The according include is currently there, seems
> to compile fine.

See above

> I can ignore return type warnings of sparse for the copy & pasted com=
pat
> stuff, right?

No, it will be causing build reports every day. Actually, we wanted no =
build=20
reports when there is no problem (didn't happen since a long time becau=
se we=20
never were able to submit all patches to net-next.git/net.git)

> Can I ignore the namespace checks mentioned in the end of the log?
> If not, how are they usually resolved for such external functions?

There are usually no external functions. You've introduced them :)

But this is most likely an artifact because you're stuff doesn't compil=
e at=20
the moment.

> Is it possible for the scripts to tell why it wants an include for
> linux/kernel.h? Currently can't find any function multicast.c
> might want from it.

I can run it (you can also with the stuff explained some days ago to An=
tonio=20
[1] + checking the "test" file).

It seems to be sprintf

Kind regards,
=09Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-May/015203.h=
tml
--nextPart2316921.Vml0yyevI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMZEEAAoJEF2HCgfBJntGURoP/3X2IX0pPGSmfZiYm3zd/JMx
7OSXGxOOFeVlwN1WPKNM06tIZROGVeAW6MHTnEmXNQt5jmuRS8dMaIm5mBdWuVGd
eK18zaJ+szarvFxKKi8YjhrBBw5Xhc7YFIOhGrhc3EUtyL9UAFMCvNUDcxb/9RMc
oCEcFXp2XFbfBMCPoR8L4lYHCKCAYRFx4lRA0ImcveKF95/wHrWI+jTo8/m1dhW/
2wllsYFRdzWEgF8uVyzPUlV7/NJ7+A6ox8q//WAsrQOMKu84KNmSkVCzY5z/ZZH4
efMn281axbJii5/KxETmt2kkhgph3bpP8FkeOYh6a2ibHQChm0T2xawfEq8w9wQT
D2rHEue2lAlUhxS3JnUM76egBHoDg7382NhAh5dpTFIdLR9M2N4H/guxAX++/vYB
IEyjWmuJLaK9lFgIs2G0vz8IE+pgMuQ0FRw/JdGsLH/ioShcOQfKOSYYTHQl+wRA
vDCMBW64FTLuM2kyAqS6dqzCBfA11VCqGZmhJoTJbk3c7S86RrOnDTMssNDX1cFB
L87ilgLz5rKk3FQijeVZRwq3RR05IiEQjWD0dWvmVU8zWeiUUkDLFxFZKGvxVHje
Wxwuuu3EOzhmUePrLt+jUaTDA0QhRph0NcB35w0zk6CKvD6Y8A5o2pDVtB8S3ypU
+hi/WkkmyoWQhV9Hezr/
=2cfA
-----END PGP SIGNATURE-----

--nextPart2316921.Vml0yyevI0--

