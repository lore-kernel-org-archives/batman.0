Return-Path: <hannes.harms@tu-bs.de>
References: <5757ED74.2010109@tu-bs.de> <3964079.xB3saelhBu@bentobox>
From: "Harms, Hannes" <hannes.harms@tu-bs.de>
Message-ID: <575972A3.8040505@tu-bs.de>
Date: Thu, 9 Jun 2016 15:44:03 +0200
MIME-Version: 1.0
In-Reply-To: <3964079.xB3saelhBu@bentobox>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] How to compile BATMAN V against linux backports
 cfg80211
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

thanks for the advice.
I managed somehow to integrate batman inside my backport tree
and changed the Makefiles etc. Now the mesh is up and BATMAn V seems to=20
work,
at least I can ping other nodes and measure throughput.

But unfortunately now batctl always says that the mesh is not activated=20
(no interface),
which is obviously wrong. Maybe  I made somewhere a mistake while=20
porting the code.

Can you guess what goes wrong?

Best Regards,
Hannes


Am 08.06.2016 um 13:20 schrieb Sven Eckelmann:
> On Wednesday 08 June 2016 12:03:32 Harms, Hannes wrote:
>> Hi,
>>
>> I want to test the new batman V with throughput based metric, but I
>> could not find out how to compile batman-adv against cfg80211 from linux
>> backports.
> You cannot build against the backports modules with the batman-adv Makefi=
le.
> This is only for systems which don't replace cfg80211 with an incompatible
> version. But you should have a look at the OpenWrt compile rules (especia=
lly
> NOSTDINC_FLAGS [1]). It basically uses its own compat-hack header and uses
> the rest from the backports compat layer + the new cfg80211 headers.
>
> Most important here is that you don't compile against cfg80211.h of your
> kernel when your backports stuff uses complete different struct definitio=
ns
> (this is most likely what causes the crash on your system).
>
> Kind regards,
> 	Sven
>
> [1] https://github.com/openwrt-routing/packages/blob/master/batman-adv/Ma=
kefile

--=20
Dipl.-Ing. Hannes Harms
Technische Universit=E4t Braunschweig
Institut f=FCr mobile Maschinen und Nutzfahrzeuge
Langer Kamp 19a
D-38106 Braunschweig

Durchwahl: +49 (0)531 391-7197
E-Mail:  hannes.harms@tu-braunschweig.de
http://www.tu-braunschweig.de/imn

