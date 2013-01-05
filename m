Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <50E76594.5010903@altermundi.net>
Date: Sat, 5 Jan 2013 10:47:57 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FD8BE79-700F-402E-AC8B-ACA10D6DD61C@stephan.homeunix.net>
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301040839.00852.lindner_marek@yahoo.de> <50E6F17B.1010305@altermundi.net>
 <201301050141.04885.lindner_marek@yahoo.de> <50E76594.5010903@altermundi.net>
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

Am 05.01.2013 um 00:28 schrieb NicoEch=E1niz:

> On 01/04/2013 02:41 PM, Marek Lindner wrote:
>> On Friday, January 04, 2013 23:12:59 NicoEch=E1niz wrote:
>>>> Selection class 3 and beyond do change the gateway when a better =
one
>>>> becomes available. But as you correctly pointed out these selection
>>>> classes don't consider the announced bandwidth for the simple =
reason
>>>> that nobody cared. In most wireless scenarios (the main playground =
for
>>>> batman-adv) the path towards the gateway turned out to be more =
critical
>>>> than the gateway's pipe to the internet.
>>>>=20
>>>> Feel free to propose something if you care about having this =
option. The
>>>> necessary code shouldn't be too hard to add. Backward compatibility =
will
>>>> be more difficult to achieve.
>>>=20
>>> I believe that those of us who chose to use selection class 1 would
>>> prefer if it were "dynamic". So if a new gateway appears, then the
>>> client would evaluate with the same previous criteria if it is =
better or
>>> not (considering "the gateway's advertised throughput as well as the
>>> link quality") and switch accordingly. I see no reason why when =
someone
>>> chooses selection class 1 she would be expecting to choose the best
>>> available gw once and not ever check again.
>>>=20
>>> If a network is stable, when a new better gw appears in some area it
>>> won't be selected until nodes are restarted, and that might be a =
long time.
>>=20
>> You misread my statement. Nobody needs to be convinced of the =
usefulness of=20
>> such a feature (at least for what concerns myself). Somebody needs to =
come up=20
>> with a solid proposal which then needs to be implemented. That is =
what I meant=20
>> by saying "Feel free to propose something [..]".
>=20
>>> One other change that might be interesting would be the addition of =
a
>>> setting for how much the advertised throughput affects gw selection.
>>> I've seen Jan uses 96/96Mbit as advertised throughput on one router; =
I
>>> do the same on our "main gateway", but maybe it would be better if =
we
>>> could actually advertise the real throughput and have a setting to
>>> control how much the bandwidth difference affects the selection.
>>=20
>> Again, feel free to propose something which can be discussed.
>=20
> It could just be implemented as a new setting like: gw_bw_weight
>=20
> which would regulate how much gw bandwidth/throughput affects best gw
> calculation.
>=20
> I don't know what's the current algorithm but I guess there would be =
no
> problem with backwards compatibility here; if the value is not set, =
the
> default should produce the same result we get now.
>=20
>=20
> So to make the proposal clear:
>=20
> I'd change options for gw_mode client to something like this:
>=20
> gw_sel_class [1|2] (1 considers TQ and bw, 2 only considers TQ)
>=20
> gw_tq_threshold [3...256]
> the minimum TQ delta to switch to a better gw, defaults to 20.
>=20
> gw_bw_weight [value from 0 to 1]
> how much does advertised gw bandwidth affect the selection. 0 does not
> affect selection, 1 has most effect. Defaults to 1 but has no effect =
if
> gw_sel_class is 2.
>=20
> For backwards compatibility, if gw_sel_class > 2, it should behave as
> the proposed option 2 with gw_tq_threshold set to the actual value. =
So,
> for example gw_sel_class 20 would be "translated" to: gw_sel_class 2,
> gw_tq_threshold 20, al least until it's deprecated.


I guess, we'll be fine with this. However, it's not clear to me, in what =
way (formula) gw_bw_weight will actually influence the selection =
process.
Do you have any proposals?

Thanks
Keep smiling
yanosz=
