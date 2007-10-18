Message-ID: <50100.85.41.146.90.1192717709.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200710181607.59969.lindner_marek@yahoo.de>
References: <000001c81164$7ec1c8d0$4100a8c0@meritechbrett>
	<200710181607.59969.lindner_marek@yahoo.de>
Date: Thu, 18 Oct 2007 16:28:29 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] Tunnel problems...
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi Marek,

maybe my fault... but I can't process rv733 ipk

-- Antonio

> Hi,
>
>> I can see A routing through B to GW fine. The tunnel bat0 on A and B
>> seems
>> unstable though. I'm looking at VIS packets arriving at PC. It arrives
>> for
>> about 30 sec then stops for a while. It is not clear why the tunnel
>> keeps
>> disconnecting.
>
> thank you for reporting this bug. As Axel already pointed out the
> blackhole
> detection falsely kicks your gateway connection. Therefore I added a check
> for services that don't send data back as the vis server and snmp. If you
> know more services to ignore please let us know.
>
> Could you re-test with the latest revision ?
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


