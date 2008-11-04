From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
Date: Tue, 4 Nov 2008 11:44:29 +0200
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810292133.58495.axel@open-mesh.net>
	<d5bba6ce0811031526y6073839eibd9b8c486b9178e6@mail.gmail.com>
In-Reply-To: <d5bba6ce0811031526y6073839eibd9b8c486b9178e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811041044.29172.axel@open-mesh.net>
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

On Dienstag 04 November 2008, Julio Cesar Puigpinos wrote:
[...]
> Well, after several (and painfull :) ) tests we could determinate 2
> scenarios: 1) BMX started like this "bmxd -o 2000 -g 5000 ath2", it didn't

THANX a lot for your painfull testing! That was the tip. I was not aware that 
forking to backgound after launching a new thread is so problematic. And 
because i forgot that my initscripts on the foneras always added -d3 and 
>/dev/zero & to the commandline the problem never appeared. Should be fixed 
with rv1148.

best regards,
axel


> asigned an IP to the client node.
> With "ps aux" it only showed one bmxd running.
>
> 2) BMX started like this "bmxd -o 2000 -g 5000 -d 3 ath2", it did
> asigned an IP to the client node.
>
> With "ps aux" it showed 3 bmxd running.
>
> Starting BMX in the second way (using "-d 3") the mesh works well.
>
>                                             Saludos, Julio


