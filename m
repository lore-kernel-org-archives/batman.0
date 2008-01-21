References: <200801211527.04600.lindner_marek@yahoo.de>
In-Reply-To: <200801211527.04600.lindner_marek@yahoo.de>
Subject: RE: [B.A.T.M.A.N.] batman OpenWRT integration
Date: Mon, 21 Jan 2008 15:04:54 -0000
Message-ID: <000001c85c3e$fd11d070$f7357150$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Marek, correct me here but are you saying you included the tunnel module in
batman ipk? No need for that as there is already a separate kmod-tun for
kamikaze7.09.

Also, the official kamikaze7.09 includes batman-0.2 (I think) but there are
these nice /etc/config/batman and /etc/init.d/batman that come with it. Have you
included those in your package? I have played a bit with the init script to
include one-way-tunnel and two-way-tunnel parameters in /etc/config/batman but
if you want I can play some more and include most if not all parameters in the
init script?
Also does the package include both batman-0.3 and batman-exp-0.3?

Regards,

Pele

> -----Original Message-----
> From: b.a.t.m.a.n-bounces@open-mesh.net [mailto:b.a.t.m.a.n-bounces@open-
> mesh.net] On Behalf Of Marek Lindner
> Sent: Monday, January 21, 2008 2:27 PM
> To: b.a.t.m.a.n@open-mesh.net
> Subject: [B.A.T.M.A.N.] batman OpenWRT integration
> 
> 
> Hi,
> 
> finally I finished updating all the batman OpenWRT packages. Additionally,
> you
> can find the tunnel kernel modul, the battools and batman advanced (layer
> 2)
> kernel module in OpenWRT now.
> You need the latest trunk to get these updates. We are already working on a
> backport to 07.09 kamikaze but I'm not sure that these files are included
> in
> the official SVN repository.
> Feel free to contact me if you have any thoughts / wishes / bugs on that.
> 
> Greetings,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

