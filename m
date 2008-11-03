Message-ID: <d5bba6ce0811031526y6073839eibd9b8c486b9178e6@mail.gmail.com>
Date: Mon, 3 Nov 2008 21:26:56 -0200
From: "Julio Cesar Puigpinos" <jcpuigpinos@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
In-Reply-To: <200810292133.58495.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810280856.11668.axel@open-mesh.net>
	<d5bba6ce0810290758q517ea4b3vf7a688599c2fe2f0@mail.gmail.com>
	<200810292133.58495.axel@open-mesh.net>
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

2008/10/29 Axel Neumann >:
> Hey Julio,

Hi

> actually I am a bit clueless. Today I came back to Berlin, where I could test
> on Foneros MIPS devices (I suspected the endian type to be related to the
> problem but it also works very smoothly there. I tried with rv1146 on gw and
> client and with exactly the same parameter which you used. For me it looks
> like the handshake messages send by the client do not even end up at the bmxd
> running in the gw-node.
> [...]

Well, after several (and painfull :) ) tests we could determinate 2 scenarios:
1) BMX started like this "bmxd -o 2000 -g 5000 ath2", it didn't
asigned an IP to the client node.
With "ps aux" it only showed one bmxd running.

2) BMX started like this "bmxd -o 2000 -g 5000 -d 3 ath2", it did
asigned an IP to the client node.

With "ps aux" it showed 3 bmxd running.

Starting BMX in the second way (using "-d 3") the mesh works well.

                                            Saludos, Julio

-- 
www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
www.lugro.org.ar                         GNU/Linux User Group Rosario, Argentina
Slackware rulez :P             www.slackware.org
NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
