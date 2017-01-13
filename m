Return-Path: <javier.simo@urjc.es>
References: <CAPkwMUejbf31RfVY_nCJSVwe=_mGVO3y5PY9zzfkQk0eDc1HTA@mail.gmail.com>
 <2739485.ZOxij8zM53@bentobox>
 <CAEhDGG==nXsChyg6iekEit-TeRKHEte8VrgW_hreaXoX6YN2qg@mail.gmail.com>
 <8483867.uzBTzBJoDH@bentobox>
From: =?UTF-8?Q?Javier_Sim=c3=b3?= <javier.simo@urjc.es>
Message-ID: <5878A512.9060905@urjc.es>
Date: Fri, 13 Jan 2017 10:59:46 +0100
MIME-Version: 1.0
In-Reply-To: <8483867.uzBTzBJoDH@bentobox>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Fail to create tunnels using br-lan
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, Andrei Buciulea <andreibuciulea@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Sven

Thanks for your answer, I collaborate with Andrei, who asked the=20
question, let me try to help to explain, though I suspect that your=20
message did contain the answer somehow.

We know that batman-adv does multi-hop at L2. That is in fact the=20
problem. We are trying to test how a network utility called simplemux=20
may improve the performance in a mesh network using batman-adv. The idea=20
behind simplemux is that aggregating all packets that node X wants to=20
sent to node Y at any time, making them share the IP header and=20
accessing the channel only once for the bundle, can dramatically improve=20
the performance. Node X should take any packets in the TX  queue coming=20
from different sources and probably going to different destinations but=20
having the same next hop, and put them together in a bundle. That is=20
what simplemux does. But actually simplemux operates on a tunnel that=20
takes the packets sent through a physical interface in X and drives them=20
to a physical interface of Y.

We don't know well how the tunnel manages the traffic, but possibly the=20
problem is that it requires the packages coming up from the physical=20
interface to the IP layer (what does not happen in batman-adv), which is=20
actually what you say. In this case, may be we cannot do what we wanted=20
to do :-(

Thanks a lot

Javier

El 13/01/17 a las 08:31, Sven Eckelmann escribi=F3:
> On Donnerstag, 12. Januar 2017 20:27:34 CET Andrei Buciulea wrote:
> [...]
>> *> The tunnels can be successfully created in OpenWRT*I have created the
>> tunnel and assigning the mesh devices an IP(192.168.100.5):
>> The other one mesh device IP is: 192.168.100.4
>>
>>        tun0      Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>                   inet addr:192.168.100.5  P-t-P:192.168.100.5
>> Mask:255.255.255.0
>>                   UP POINTOPOINT NOARP MULTICAST  MTU:1500  Metric:1
> [...]
>> If anyone has any idea why it does not work I would be very grateful.
> Sorry, but I still don't get what are you doing with layer 3 tunnel stuff=
 and
> what batman-adv has to do with it (it is a layer 2 based protocol which
> requires layer 2 interfaces).
>
> Kind regards,
> 	Sven

--=20

---------------------------------------------------
Fco. Javier Sim=F3 Reigadas <javier.simo@urjc.es>
Subdirector de Ord. Docente
ETS de Ingenier=EDa de Telecomunicaci=F3n
D-204, Departamental III
Camino Del Molino, s/n - 28943 Fuenlabrada (Madrid)
Tel: 914888428, Fax: 914887500
Web personal: http://www.tsc.urjc.es/~javier.simo

