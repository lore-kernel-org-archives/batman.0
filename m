Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F51D34F.9040204@codigosur.org>
Date: Sat, 03 Mar 2012 05:16:15 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org>
	<201203031553.53565.lindner_marek@yahoo.de>
In-Reply-To: <201203031553.53565.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
 + ethernet
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 03/03/2012 04:53 AM, Marek Lindner wrote:
> On Saturday, March 03, 2012 15:39:09 Nicol=E1s Ech=E1niz wrote:
>> this happens with the nodes configured according to:
>> http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance
>>
>> or so we understand!
>=20
> If the ethernet is used for mesh purposes uniquely why do you bother runn=
ing=20
> the bridge loop avoidance at all instead of adding the ethernet interface=
 as a=20
> regular batman interface ? The only reason why you would want the bridge =
loop=20
> avoidance is when you have ethernet clients that are bridged into the mes=
h.=20
> This does not seem to be the case. As far as I understand the ethernet ca=
ble=20
> is used as reliable "wireless cable".

Maerk thanks for your fast reply. In fact, that's how we started, that's
what I meant by:

"We have also tried adding eth0 to bat0 and take it out of br-lan, which
also "works" but gives routing loops from time to time."

but my english sometimes fails me :)


we also had routing loops with that setup and that's where we started to
look at loop avoidance docs.


I haven't saved traceroutes from that moment; I've actually turned off
the wlan0 on the MR now, but I can turn it back on and add eth0 as a
batman interface to reproduce it.
Is this a known issue or should this not happen in a setup where both
interfaces are added to batman?




