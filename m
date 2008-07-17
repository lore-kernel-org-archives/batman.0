Message-ID: <a934d3f30807171003i249be5bfp5f571364e1f4cdd3@mail.gmail.com>
Date: Thu, 17 Jul 2008 22:33:29 +0530
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
In-Reply-To: <487F77DF.8050305@reglue.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5704_4561890.1216314209555"
References: <487F60E5.5000003@reglue.org> <487F77DF.8050305@reglue.org>
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

------=_Part_5704_4561890.1216314209555
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Are you trying to run batman with whiterussian (i am  not sure of freifunk
build)?
if so the init script installed with the batman 0.3 package does not support
nvram. it supports uci (as noticed @
https://dev.openwrt.org/cgi-bin/trac.fcgi/browser/packages/net/batman/files/etc/init.d/batmand)

If your init script is similar to the one in that openwrt link... you can
get stuff working by replacing the uci get variables with valid nvram
variables
like interface=$(uci get batmand.general.interface) to interface=$(nvram get
wireless_interface)  ... i dont remember the variable name correctly.


Regards,
--
Vinay Menon

------=_Part_5704_4561890.1216314209555
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>Are you trying to run batman with whiterussian (i am&nbsp; not sure of freifunk build)? <br>if so the init script installed with the batman 0.3 package does not support nvram. it supports uci (as noticed @ <a href="https://dev.openwrt.org/cgi-bin/trac.fcgi/browser/packages/net/batman/files/etc/init.d/batmand">https://dev.openwrt.org/cgi-bin/trac.fcgi/browser/packages/net/batman/files/etc/init.d/batmand</a> )<br>
<br>If your init script is similar to the one in that openwrt link... you can get stuff working by replacing the uci get variables with valid nvram variables<br>like interface=$(uci get batmand.general.interface) to interface=$(nvram get wireless_interface)&nbsp; ... i dont remember the variable name correctly.<br>
<br><br>Regards,<br>--<br>Vinay Menon<br></div>

------=_Part_5704_4561890.1216314209555--
