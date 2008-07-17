Message-ID: <487F8235.3070905@reglue.org>
Date: Thu, 17 Jul 2008 12:32:37 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org> <487F77DF.8050305@reglue.org>
	<a934d3f30807171003i249be5bfp5f571364e1f4cdd3@mail.gmail.com>
In-Reply-To: <a934d3f30807171003i249be5bfp5f571364e1f4cdd3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Vinay Menon wrote:
> Hi,
> 
> Are you trying to run batman with whiterussian (i am  not sure of freifunk
> build)?

Yes, Freifunk is Whiterussian.

> if so the init script installed with the batman 0.3 package does not support
> nvram. it supports uci (as noticed @
> https://dev.openwrt.org/cgi-bin/trac.fcgi/browser/packages/net/batman/files/etc/init.d/batmand)
> 
> If your init script is similar to the one in that openwrt link... you can
> get stuff working by replacing the uci get variables with valid nvram
> variables
> like interface=$(uci get batmand.general.interface) to interface=$(nvram get
> wireless_interface)  ... i dont remember the variable name correctly.

Thank you.  I'll take a look.
