Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Jul 2010 00:06:51 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007062215.45412.lindner_marek@yahoo.de>
	<201007062346.43276.clemens-john@gmx.de>
In-Reply-To: <201007062346.43276.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201007070006.51804.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

On Tuesday, July 06, 2010 23:46:36 Clemens John wrote:
> Okay I did this but I have some questions left:

No problem.  :)


> Does the DHCP server on the gateway need to distribute IP-Adresses?

The server should distribute IP addresses and a default route to itself. I'=
m=20
not sure whether you will find a dhcp server which does not distribute IPs =
but=20
default routes.


> If so I think they have to be distributet on the batman interface right?

Correct.


> Does the Batman advanced interface on the clients need to request an
> IP-Adress from the DHCP server or can I also set a static IP adress?

That depends on your needs. Any interface which is supposed to use the gate=
way=20
feature has to run a dhcp client. If the batX interface on the client does =
not=20
need it you can give it a static address. If you just want to define the IP=
=20
address of a specific host you can also work with aliases / multiple IPs pe=
r=20
interface.


> If the clients need to request an IP adress from the DHCP server, where is
> the difference between requesting an IP without Batman advanced and with
> Batman advanced? Does Batman advanced say from wich server to request the
> IP or which default route to choose?

Normal dhcp requests are broadcasted through the entire network. Every dhcp=
=20
server that receives this request will answer. If the client receives multi=
ple=20
answers it depends on the implementation to choose its "favorite" dhcp serv=
er.=20
Most clients simply use the first server that answered.
If you enable the gateway client this request will not be broadcasted but=20
directly sent to the chosen gateway. The other dhcp servers will not receiv=
e=20
this dhcp request.


> Sry for this question we just discussed this on the last community meeting
> and somebody wondered if this is the most beautiful way. Maybe it=B4s not
> but you are right there is no other way.

We had this layer2/layer3 discussion quite often and this is the compromise=
 we=20
managed to achieve. It only works when enabled and indirectly via dhcp. It =
is=20
not "beautiful" but it works.  :)


> Okay but it will likely be usable without crashing right?

No, it should not crash. I'm using it on a daily basis without problems.


> How can I configure batman advanced in /etc/config/batman-adv to enable gw
> server/client mode?

Since it was not part of an official release it also is not supported by th=
e uci=20
scripts. You would have add it yourself.

Regards,
Marek
