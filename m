Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <201301050141.04885.lindner_marek@yahoo.de>
Date: Fri, 4 Jan 2013 19:25:58 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <28DE955B-83FE-458C-BA6F-53FC0C53FC7B@stephan.homeunix.net>
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301040839.00852.lindner_marek@yahoo.de> <50E6F17B.1010305@altermundi.net>
 <201301050141.04885.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,


Am 04.01.2013 um 18:41 schrieb Marek Lindner:

> On Friday, January 04, 2013 23:12:59 NicoEch=E1niz wrote:
>>> Selection class 3 and beyond do change the gateway when a better one
>>> becomes available. But as you correctly pointed out these selection
>>> classes don't consider the announced bandwidth for the simple reason
>>> that nobody cared. In most wireless scenarios (the main playground =
for
>>> batman-adv) the path towards the gateway turned out to be more =
critical
>>> than the gateway's pipe to the internet.
>>>=20
>>> Feel free to propose something if you care about having this option. =
The
>>> necessary code shouldn't be too hard to add. Backward compatibility =
will
>>> be more difficult to achieve.
>>=20
>> I believe that those of us who chose to use selection class 1 would
>> prefer if it were "dynamic". So if a new gateway appears, then the
>> client would evaluate with the same previous criteria if it is better =
or
>> not (considering "the gateway's advertised throughput as well as the
>> link quality") and switch accordingly. I see no reason why when =
someone
>> chooses selection class 1 she would be expecting to choose the best
>> available gw once and not ever check again.
>>=20
>> If a network is stable, when a new better gw appears in some area it
>> won't be selected until nodes are restarted, and that might be a long =
time.
>=20
> You misread my statement. Nobody needs to be convinced of the =
usefulness of=20
> such a feature (at least for what concerns myself). Somebody needs to =
come up=20
> with a solid proposal which then needs to be implemented. That is what =
I meant=20
> by saying "Feel free to propose something [..]".
>=20
> Note that switching immediately as soon as a better gateway comes =
around isn't=20
> the best solution. Imagine a case in which a gateway announcing the =
highest=20
> bandwidth in your network barely is visible for your gateway client. =
It will=20
> keep switching between gateways, thereby breaking all your stateful=20
> connections such as: ssh, vpns, video & music streams, etc


Thanks for being open minded. Imho there are a few "tweaks" for doing =
so.

For our networks, it's not important, that all clients choose the =
gateway with the highest data rate. Basically, we have 3 gateway-types
-> Regular Gateways, that should be used if they are reachable (above a =
certain TQ threshold)
-> Backup Gateways - Gateways, that should be used if no regular Gateway =
is available.
-> Test Gateways - Just for testing purpose - should be used if no =
Backup-Gateway is available.

Imho others may have more / or less classes. basically what is needed =
here is a positive gateway ("route priority") - imho the already =
existing gateway-class may be used for doing so.

In order to prevent "switching immediately as soon as a better gateway =
comes around", we may can go this way:
gw_mode client may have three parameters:
1st: Switching threshold based on TQ (Like today, eg 20: late switching)
2nd: Switching threshold based on Gateway Class). GC-Thresh
3rd: LQ-Threshold for GW-class-switch GC-TQ-Thresh

Meaning:
Switch gateway to same / better class, if  there is a Gateway having TQ =
xx-Times bigger (traditional late switching with xx)
Switch gateway to a better class, if a Class is GC-Thresh times better, =
and LQ is above TQ-GC-Thresh
Switch gateway to a worse class, if all existing gateway of same or =
better class have LQ < GC-TQ-Thresh

However, this is quite complex and I don't know if everybody will be =
happy with this - However, I'll be so.

For backwards compatibility, old configurations can be detected by =
counting the number of parameters and react according old defaults.

If you like thinks to be more complex - Different thresholds for =
blocking DHCPDISCOVER / DHCPREQUEST ;-)

Thanks,
Keep smiling
yanosz

