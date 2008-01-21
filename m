From: Andreas Langer <an.langer@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman OpenWRT integration
Date: Mon, 21 Jan 2008 19:20:30 +0100
References: <200801211527.04600.lindner_marek@yahoo.de>
	<000001c85c3e$fd11d070$f7357150$@com>
In-Reply-To: <000001c85c3e$fd11d070$f7357150$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801211920.30577.an.langer@gmx.de>
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

 Hi,

> Marek, correct me here but are you saying you included the tunnel module in
> batman ipk? No need for that as there is already a separate kmod-tun for
> kamikaze7.09.

marek means the batgat module which i wrote. batman does its own tunneling and 
uses kmod-tun for it. this batman tunneling can also be done in the kernel 
space which improves the overall tunnel performance. i hope ;)


> Also, the official kamikaze7.09 includes batman-0.2 (I think) but there are
> these nice /etc/config/batman and /etc/init.d/batman that come with it.
> Have you included those in your package?
> I have played a bit with the init 
> script to include one-way-tunnel and two-way-tunnel parameters in
> /etc/config/batman but if you want I can play some more and include most if
> not all parameters in the init script?

yes, the config files are also included. but as far as i understood they are 
not needed anymore in the not so distant future. OpenWRT has a new config 
interface called UCI which we are going to support. up to now we don't fully 
understand how this is going to work but as soon as we do we let you know.


regards,
andreas

