MIME-Version: 1.0
In-Reply-To: <20090204205611.GA13896@pandem0nium>
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<20090204205611.GA13896@pandem0nium>
Date: Thu, 5 Feb 2009 14:26:34 -0300
Message-ID: <2ced936d0902050926r1f07cf85j405bf808f0bf3f7f@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Stable adapters for Ad Hoc networks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello Simon,

    Thanks, I was searching a bit on google about that. It's harder to
solve than I thought.

     I still wonder if setting up a static BSSID will stop the BSSID
selection algorithm from ocurring. What do you think? Have tested this
in practice?

    Setting the BSSID manually was only supported by the Atheros
chipset, which runs on my laptop. I'm also working with portable
devices, such as OpenMoko Freerunner (which is Atheros too, but I
havent checked this) and Nokia N810 (which has a prism chipset). Nokia
N810 was really buggy... whenever I tried to put one device on the
network, it started to split itself from it.

best regards,

--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::



2009/2/4 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>:
> Hey Breno,
>
> sounds like the well known ad-hoc cell splitting problem to me. A common
> workaround is to fixate the BSSID to some pre-defined value:
>
> iwconfig athX ap 02:CA:FF:EE:BA:BE
>
> hopefully all your drivers support this. :)
>
> best regards,
>        Simon
>
> On Wed, Feb 04, 2009 at 03:03:35PM -0300, Breno Jacinto wrote:
>> Hello everyone,
>>
>>   I`m running several experiments involving ad hoc networks. I`ve
>> selected some well known-to-be-compatible adapters, such as Edimax
>> (Ralink shipset), Alfa networks (Realtek) and Atheros (madwifi).
>> Atheros is available only as built-in adapter on the equipement or as
>> a  PCI board.
>>
>>   So, I'm experiencing some instability regarding the selection of
>> the BSSID used by all the nodes. I start the network with a single
>> node, then another, then another. Now, for a couple of minutes it
>> works, bu then some nodes start losing sight of each and changing
>> their BSSIDs to a different value (and they should always use the
>> same). I'm really running out of
>> explanations of why this is happening, because these nodes are all
>> in-range of each other, and should be "pingable" directly. My main
>> suspect is the driver instability, but then I dont know of any other
>> better alternatives. I've tested the following USB adapters:
>>
>> - Edimax EW-7318USg (rt73 drivers)
>> - Alfa AWUS036H-11g
>>
>>   And the builtin adapters:
>>
>> - Atheros chipset AR5007EG
>>
>>
>> best regards,
>>
>> --
>> --
>> :: Breno Jacinto ::
>> :: breno - at - gprt.ufpe.br ::
>> :: FingerPrint ::
>>    2F15 8A61 F566 E442 8581
>>    E3C0 EFF4 E202 74B7 7484
>> :: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil al=
gum dia.  ::
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFJigDrrzg/fFk7axYRAk8QAJ9O76YpSsZ7F4YlfGOCdVMzlgxjqQCghJWF
> 8Do0FGAC4gG9ASicOnh700g=3D
> =3DpaEZ
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
