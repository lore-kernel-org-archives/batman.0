Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50E61CF9.2050305@altermundi.net>
Date: Thu, 03 Jan 2013 21:06:17 -0300
From: =?ISO-8859-1?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301032258.15573.lindner_marek@yahoo.de>
 <82C77F63-2AB3-4AEB-A86A-23B3488E6C51@stephan.homeunix.net>
 <201301032314.22606.lindner_marek@yahoo.de>
In-Reply-To: <201301032314.22606.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

On 01/03/2013 12:14 PM, Marek Lindner wrote:
> On Thursday, January 03, 2013 23:01:07 Jan L=FChr wrote:
>>> Ah! You failed to mention this part in your initial email.
>>>
>>> The behavior is easily explained: batman-adv does not switch gateway
>>> whenever a new gateway is found (even if it is a better gateway) unless
>>> the selection class is on fast or late switching.
>>
>> It is. - Sorry, forgot to mention:
>> Freifunk-b0487acb2d58:~# batctl gw_mode
>> client (selection class: 1)
>>
>> =3D> 1 -> fast connection consider the gateway's advertised  throughput =
as
>> well as the link quality towards the gateway
>=20
> You did mention you were using selection class 1. I was referring to your=
 test=20
> in which you turn on/off your best gateway. As I explained in my previous=
=20
> mail: batman-adv does not switch the gateway once it has chosen a gateway=
=20
> unless you select fast or late switching as selection class. Selection cl=
ass 1=20
> does not fall into this category which means a gateway reselection only=20
> happens if the currently selected gateway disappears.


Marek, could you please clarify this?

From the man page I don't see an option that would behave as Jan (and I) s=
eem to be expecting it to work. That is: switch to a better gateway - with =
more bandwidth and comparable link quality - when it's available.


gw_mode|gw [off|client|server] [sel_class|bandwidth]
[...]
              If the node is a gateway client the parameter will decide whi=
ch
              criterias to consider when the batman-adv module has to choose
              between different internet connections announced by the afore-
              mentioned servers.
                        default: 20 -> late switch (TQ 20)
                       examples:  1 -> fast connection
                                       consider the gateway's advertised
                                       throughput as well as the link quali=
ty
                                       towards the gateway
                                 2  -> stable connection
                                       chooses the gateway with the best li=
nk
                                       quality and stick with it (ignore the
                                       advertised throughput)
                                 3  -> fast switch connection
                                       chooses the gateway with the best li=
nk
                                       quality but switches to another gate=
way
                                       as soon as a better one is found
                                 XX -> late switch connection
                                       chooses the gateway with the best li=
nk
                                       quality but switches to another gate=
way
                                       as soon as a better one is found whi=
ch
                                       is at least XX TQ better than the cu=
r-
                                       rently selected gateway (XX has to b=
e a
                                       number between 3 and 256).


Would mode 3 accomplish this fast switching? It doesn't mention if this mod=
e will consider advertised throughput or not; only selection class 1 mentio=
ns throughput.


--
NicoEch=E1niz




