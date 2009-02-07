MIME-Version: 1.0
In-Reply-To: <200902072238.50756.onelektra@gmx.net>
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<200902071030.10319.lindner_marek@yahoo.de>
	<2ced936d0902071238i14ac756cmccfe2481cb56e6c7@mail.gmail.com>
	<200902072238.50756.onelektra@gmx.net>
Date: Sat, 7 Feb 2009 19:44:56 -0300
Message-ID: <2ced936d0902071444q129aed4me5dab6117a2e19fb@mail.gmail.com>
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

Hello Elektra,

     Thanks for the information. At least now I have some background
to work on - I already have several rt73 USB dongles, some notebooks
with Atheros, some OpenMokos (which have atheros chipsets) and a few
Nokia N810 tablets (which have a prism chipset). Specially the Nokias
are actually messing up the network, when I put them together. They
just dont seem to figure out how to syncronize to the same BSSID.
These devices are all on the same room, in close range.

    I read this
http://wiki.villagetelco.org/index.php/Information_about_cell-id_splitting,=
_stuck_beacons,_and_failed_IBSS_merges!

     And they mentioned about some intermediate mode, called
Pseudo-IBSS or AHdemo mode, which allows a device to set a static
BSSID and it is supported by some drivers. I suppose we are talking
about the same thing here, just not giving any names (?).

     When you mentioned your EEE PC, which uses an Atheros chipset,
did you also had to set a static BSSID to the same used in the mesh
network you use?

regards,

--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::




2009/2/7 elektra <onelektra@gmx.net>:
> Hi -
>
> I'm waiting for working drivers (particularly USB)  for IBSS mode for lon=
g
> time and was putting my hope on Ralink RT73 as well.
>
> The situation is improving with the mac80211 driver development in the Li=
nux
> kernel. Recently patches went into compat-wireless that allow to fix the
> IBSSID with the
>
> iwconfig  <interface> ap <cell-id>
>
> command - with some drivers, not all.
>
> However the situation is a little more complex than just fixing the IBSSI=
D,
> because the drivers/firmware have to be convinced not to perform a IBSS-m=
erge
> every time the TSF timestamp in a received beacon is a little older.  Upo=
n a
> merge the cards may flush  their MAC table - this could happen every few
> miliseconds - like I have observed with Intel ipw4965 driver. Also TSF cl=
ock
> skews can cause race conditions.
>
> So far ath5k and ath9k seem to work - but the only driver I can really
> recommend is Madwifi with all patches from Openwrt -  vanilla Madwifi is
> *not* working. The patched Madwifi in Openwrt Kamikaze works perfectly (I=
'm
> using mesh with Batman exclusively every day and I can  suspend/resume my
> EEE-PC for weeks and I'm always online ;-)
>
> But Madwifi does not support USB...
>
> Best bet for USB is Zydas, I guess.
>
> cu elektra
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
