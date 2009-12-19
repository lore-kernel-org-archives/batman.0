Return-Path: <breno@freeunix.com.br>
MIME-Version: 1.0
In-Reply-To: <20091219004443.GA26489@pandem0nium>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
	<20091219004443.GA26489@pandem0nium>
Date: Sat, 19 Dec 2009 15:25:55 -0300
Message-ID: <2ced936d0912191025k5fbdbf45s2c1b16d241850549@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] wireless adapter and linux kernel version
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi Eric,

    I've been through your same situation, under a very stressful
circumstance: implementing my master thesis. I found out that that
most adapters really suck at implementing ad-hoc mode. However, there
are some very decent adapters that are cheap and have very stable
drivers.

* Atheros: As Simon said, it is one of the best. Most laptops come
with some sort of atheros chipset built in. I was not happy on finding
external adapters with atheros chipsets, but that was about a year
ago. Things may have changed.

* Edimax EW-7318USg (Ralink chipset): Today, it is one of the best. No
cell-splits, no hassles, no problems. Rock-solid driver, works
"plug-n-p=C4=BAay" on Ubuntu 9.04 and 9.10. In addition, it's very cheap
and supports external antennas. USB.

* Alfa Networks AWUS036H: Very, very good... but a little expensive
(at least here in Brazil). The best driver for this adapter is the one
with the Backtrack distribution (www.remote-exploit.org). Since it is
used a lot for Wardriving, etc.. monitor and ad-hoc mode is very
stable. USB.


     My experience with these three adapters was awesome. They saved me :).

     Hey guys, perhaps this kind of information should be on the wiki.
That may help a lot of people. I could elaborate into more details if
you guys are interested.


best regards,

--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=C3=ADcil =C3=A9 a =C3=BAnica maneira de torn=C3=A1-lo f=
=C3=A1cil algum dia.  ::



2009/12/18 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>:
> Hi Eric,
>
> there are a lot of wifi cards and drivers which don't support ad-hoc mode=
.
> I had bad experience with RTL based wifi cards. More info about drivers a=
nd
> supported modes can be found here:
>
> http://linuxwireless.org/en/users/Drivers
>
> Try to use Atheros based cards, most of them support Ad-Hoc mode.
>
> best regards,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Simon
>
> On Fri, Dec 18, 2009 at 04:45:50PM -0500, Conner, Eric wrote:
>> I have been trying to get my wireless network to establish an ad-hoc
>> network and I just can't seem to do it. =C2=A0It appears the linux 2.6.3=
1
>> kernel does not support the RealTek 8185L (Encore ENLWI-G2) wireless
>> card I have. =C2=A0The drivers it does install are older and seem to not
>> support Ad-Hoc networking.
>>
>>
>>
>> Can anyone recommend a wireless card and/or a linux distro that easily
>> supports ad-hoc networking? =C2=A0I have the tried latest openSuse and U=
buntu
>> distros.
>>
>>
>>
>> Is this a common problem with Linux? =C2=A0I have set up wireless ad-hoc
>> networks before in windows and never really had a problem.
>>
>>
>>
>> Or better yet - does anyone have patches to the realtek 8185L drivers to
>> use the net_device_ops struct as opposed to the deprecated net_device
>> struct?
>>
>>
>>
>> Thanks
>>
>> Eric
>>
>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@lists.open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkssIfsACgkQrzg/fFk7axaMgACeODNzgJWBIx/LJO33DRxaT1Eu
> ezkAn2D7cFaCEDQ+G3VyVMmqb7MOppFN
> =3Dm/SP
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
