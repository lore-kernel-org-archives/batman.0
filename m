From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] assigned IP life
Date: Fri, 21 Sep 2007 21:59:45 +0200
References: <38681.85.41.146.90.1190394295.squirrel@krisma.oltrelinux.com>
In-Reply-To: <38681.85.41.146.90.1190394295.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709212159.45398.axel@open-mesh.net>
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

Ok,

Just had a short look on the code and recognized that the ip adress assigned 
from the gateway is several times just copied from a data buffer to an 
interger and back.
Maybe its related to your HW, because foneros and Merakis are mips MSB and 
mispel based Buffalos and WRTs is LSB architecture. 
That would also explain why it worked just fine on the Buffalos and WRTs we 
are using here.
We'll check that,..

ciao,
axel

On Freitag 21 September 2007, a.anselmi@oltrelinux.com wrote:
> Hi
> mybe these lines form -d3 level at client node 5.1.7.251 can help:
>
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - disconnecting from unresponsive gateway: 5.1.7.254
> Deleting default route via bat0 0.0.0.0 (table 67)
> -- after some seconds --
> Adding default route to 5.1.7.254 (49,64,64)
> Adding default route via bat0 0.0.0.0 (table 67)
>
> ...seems that lease assigned by gateway to client (IP 1.0.254.169) have a
> less than 1 sec of life... almost in my case.
>
> Antonio
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


