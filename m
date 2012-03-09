Return-Path: <zoobab@gmail.com>
MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <20120309085636.GA9018@pandem0nium>
References: <4F4F6D18.3070403@ninux.org>
	<201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
Date: Fri, 9 Mar 2012 10:17:47 +0100
Message-ID: <CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
From: Benjamin Henrion <bh@udev.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Mar 9, 2012 at 9:56 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hey Gabriel,
>
> thanks for bringing the discussion to the batman ml and giving some const=
ructive
> input. I've written this bonding/alternating feature some time ago, and w=
e released
> it at WBMv3 together with this little documentation to be found in the wi=
ki. Actually,
> I considered the feature rather simple and therefore I did not write too =
much about it
> - because there is not really much to write about, or so I thought. Obvio=
usly, there
> were some things unclear, so thanks for pointing me/us to that.
>
> When implementing, it is easy to miss some things that are not that obvio=
us
> for outsiders, so please feel free to ask or suggest things. We'll rework=
 the
> bonding/interface alternating part in the next days, and would be
> happy to include your suggestions. :)
>
> Usually, we create the protocol documentation for the purpose of review a=
nd
> documentation for other batman-adv devs - and we don't expect that they a=
ll
> fall on the head at the same time. They are meant to describe the concept=
 and
> not the actual implementation with all their nasty details.
>
> On Wed, Mar 07, 2012 at 11:18:48PM +0100, Gabriel Kerneis wrote:
>> [CC: b.a.t.m.a.n@lists.open-mesh.org, see note 3 in particular]
>>
>> Antonio,
>>
>> On Wed, Mar 07, 2012 at 06:17:52PM +0100, Antonio Quartulli wrote:
>> > Technical details about what? Interface-alternating? It is there!
>> > Gabriel wrote the link.
>>
>> No. Please re-read my email carefuly. =A0The wiki contains a rough expla=
nation of
>> the general principle (ie. =93same interface =3D bad, different interfac=
e =3D good=94).
>> Not the actual algorithm used by batman-adv (quoting from the wiki: =93t=
he
>> algorithm tries to avoid forwarding packets on the interface which just =
received
>> the packet=94).
>>
>> Note that the wiki has been updated since then, by Simon with a few more
>> details [1], and by Marek with benchmark results from WBMv3.
>>
>
> Maybe "algorithm" is a big word for a little feature like that. The bondi=
ng
> and interface alternating basically work in two steps:
>
> =A01) detect that a neighbor is reachable via two different links
> =A02) use the two different links for various manipulations (bonding, int=
erface alternation)

Hoping over the same frequency should be made costly.

Do you add a cost if the packet comes from the same wireless interface?

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-3500762
"In July 2005, after several failed attempts to legalise software
patents in Europe, the patent establishment changed its strategy.
Instead of explicitly seeking to sanction the patentability of
software, they are now seeking to create a central European patent
court, which would establish and enforce patentability rules in their
favor, without any possibility of correction by competing courts or
democratically elected legislators."
