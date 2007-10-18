From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Tunnel problems...
Date: Thu, 18 Oct 2007 16:07:59 +0200
References: <000001c81164$7ec1c8d0$4100a8c0@meritechbrett>
In-Reply-To: <000001c81164$7ec1c8d0$4100a8c0@meritechbrett>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710181607.59969.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> I can see A routing through B to GW fine. The tunnel bat0 on A and B seems
> unstable though. I'm looking at VIS packets arriving at PC. It arrives for
> about 30 sec then stops for a while. It is not clear why the tunnel keeps
> disconnecting.

thank you for reporting this bug. As Axel already pointed out the blackhole 
detection falsely kicks your gateway connection. Therefore I added a check 
for services that don't send data back as the vis server and snmp. If you 
know more services to ignore please let us know.

Could you re-test with the latest revision ?

Regards,
Marek
