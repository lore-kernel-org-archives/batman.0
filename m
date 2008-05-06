From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final released
Date: Tue, 6 May 2008 15:27:48 +0800
References: <200805051954.19727.lindner_marek@yahoo.de>
	<200805060224.29201.lindner_marek@yahoo.de>
	<50769.209.206.168.53.1210029743.squirrel@webmail.reglue.org>
In-Reply-To: <50769.209.206.168.53.1210029743.squirrel@webmail.reglue.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805061527.48573.lindner_marek@yahoo.de>
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

On Tuesday, 6. May 2008 07:22:23 dondavis@reglue.org wrote:
> Sorry for the density, but what is the link to the batman III stable
> package (ipkg for openwrt/freifunk)?  

The pre-compiled packages will be available at:
http://downloads.open-mesh.net/batman/stable
in the coming days. Give us some time to recover from our release party.  ;-)


> Any suggestions on how to compile 
> batman for openwrt using the sdk?  I've compiled a few simple packages
> before but the batman source (e.g. modules) looked a bit more elaborate
> than what I've done before.

The current OpenWRT trunk offers batman packages. Just download the "packages" 
branch and link the batman packages into your OpenWRT package dir. After 
executing "make menuconfig" you will find the batman packages in the network 
section. 

Greetings,
Marek
