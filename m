Message-Id: <DDB9027B-13A4-4D03-A7FC-81253F5865A2@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200901140145.34127.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Sun, 18 Jan 2009 22:17:14 +0200
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
	<1231872376-21395-1-git-send-email-sven.eckelmann@gmx.de>
	<1F63FEA4-ED42-48C5-B45E-87BF3764F4BB@7degrees.co.za>
	<200901140145.34127.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Compile batmand under FreeBSD and OSX (Was: Compile
	vis)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: Kobus Roux <kroux@csir.co.za>, Ajay Makan <amakan@csir.co.za>


On 14 Jan 2009, at 02:45 , Sven Eckelmann wrote:

> On Tuesday 13 January 2009 22:29:25 Antoine van Gelder wrote:
>> On 13 Jan 2009, at 20:46 , Sven Eckelmann wrote:
>>> PS: Interested in porting batmand again to *bsd plattforms?
>>
>> Possibly - it would be nice to have the option to mesh with a =20
>> beastie :)
>>
>> Do you have a rough idea of what broke since it last worked ?
> Don't know when it worked the last time but it doesnt compile at the =20=

> moment.



Fun weekend :)

batmand compiles under FreeBSD now but Darwin (Mac OSX) support is =20
still broken.

 =46rom what I can make out it looks like net/if_tun.h mysteriously got =20=

renditioned at some point on the road to Leopard.

Not sure what the best strategy would be moving forward. Any advice/=20
suggestions ?  http://tuntaposx.sourceforge.net perhaps ?

Some more information at: =
http://lists.apple.com/archives/Darwin-development/2000/Oct/msg00033.html


> There are also some parts marked as "not implemented" in bsd/route.c
> You must check if all functions in bsd/*.c are in sync with linux/*.c


These are the functions to manage the policy routing rules - I've had =20=

some limited success running batmand with the --policy-routing-script =20=

option but this is going to have to wait till next weekend to finish up.

Best
antoine


--
http://7degrees.co.za
"Libr=E9 software for human education."

