Subject: Re: [B.A.T.M.A.N.] batman and Kernel 2.6.26-rc8&rc9
From: Mark Kelly <mark.kelly@cadre5.com>
In-Reply-To: <20080714154944.GA16555@hrz.tu-chemnitz.de>
References: <1216040292.12178.3.camel@mkellyDell>
	<20080714154944.GA16555@hrz.tu-chemnitz.de>
Content-Type: multipart/alternative; boundary="=-4LoiN1fXRPqyjiN2Qdus"
Date: Thu, 17 Jul 2008 21:48:27 -0400
Message-Id: <1216345707.2919.1.camel@mkellyDell>
Mime-Version: 1.0
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


--=-4LoiN1fXRPqyjiN2Qdus
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Simon,

I just got around to trying this again on 2.6.26 final and I'm still
getting a fail error on the gateway module, and I've tried it using
r1099 and r1100 under openwrt on an ixp4xx board.

make[3]: Entering directory
`/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'
  CC
[M]  /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.o
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c: In function 'init_module':
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:93: error: implicit declaration of function 'class_device_create'
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c: In function 'cleanup_module':
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:118: error: implicit declaration of function 'class_device_destroy'
make[4]: ***
[/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.o] Error 1
make[3]: ***
[_module_/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules]
Error 2
make[3]: Leaving directory
`/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'
make[2]: *** [/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/.built]
Error 2
make[2]: Leaving directory `/opt/openwrt/packages/net/batman'
make[1]: *** [package/batman/compile] Error 2
make[1]: Leaving directory `/opt/openwrt/k1'
make: *** [package/batman-compile] Error 2



On Mon, 2008-07-14 at 17:49 +0200, Simon Wunderlich wrote:

> Hello Mark,
> 
> thanks for the report. The issue should be fixed with revision 1099.
> 
> regards
> 	Simon
> 
> On Mon, Jul 14, 2008 at 08:58:11AM -0400, Mark Kelly wrote:
> > The batman layer3 kernel module does not appear to compile on the
> > 2.6.26-rc8 & rc9 kernels.  Is this a known bug?
> > 
> > 
> 
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--=-4LoiN1fXRPqyjiN2Qdus
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.3">
</HEAD>
<BODY>
Hey Simon,<BR>
<BR>
I just got around to trying this again on 2.6.26 final and I'm still getting a fail error on the gateway module, and I've tried it using r1099 and r1100 under openwrt on an ixp4xx board.<BR>
<BR>
make[3]: Entering directory `/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'<BR>
&nbsp; CC [M]&nbsp; /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.o<BR>
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c: In function 'init_module':<BR>
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:93: error: implicit declaration of function 'class_device_create'<BR>
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c: In function 'cleanup_module':<BR>
/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:118: error: implicit declaration of function 'class_device_destroy'<BR>
make[4]: *** [/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.o] Error 1<BR>
make[3]: *** [_module_/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules] Error 2<BR>
make[3]: Leaving directory `/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'<BR>
make[2]: *** [/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/.built] Error 2<BR>
make[2]: Leaving directory `/opt/openwrt/packages/net/batman'<BR>
make[1]: *** [package/batman/compile] Error 2<BR>
make[1]: Leaving directory `/opt/openwrt/k1'<BR>
make: *** [package/batman-compile] Error 2<BR>
<BR>
<BR>
<BR>
On Mon, 2008-07-14 at 17:49 +0200, Simon Wunderlich wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Hello Mark,

thanks for the report. The issue should be fixed with revision 1099.

regards
	Simon

On Mon, Jul 14, 2008 at 08:58:11AM -0400, Mark Kelly wrote:
&gt; The batman layer3 kernel module does not appear to compile on the
&gt; 2.6.26-rc8 &amp; rc9 kernels.  Is this a known bug?
&gt; 
&gt; 

&gt; _______________________________________________
&gt; B.A.T.M.A.N mailing list
&gt; <A HREF="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</A>
&gt; <A HREF="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</A>

_______________________________________________
B.A.T.M.A.N mailing list
<A HREF="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</A>
<A HREF="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</A>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-4LoiN1fXRPqyjiN2Qdus--
