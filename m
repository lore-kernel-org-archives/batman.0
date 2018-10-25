Return-Path: <guohuizou2000@sina.com>
From: "gary" <guohuizou2000@sina.com>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <19500073.zgPyDjR2lk@bentobox>
 <100c018ff42541ddb2615fae42bc64f62ced80b4.camel@sdl.usu.edu>
 <1897809.X9xPm7IOO6@bentobox>
In-Reply-To: <1897809.X9xPm7IOO6@bentobox>
Date: Thu, 25 Oct 2018 17:06:18 +0800
Message-ID: <042f01d46c41$fe24ddd0$fa6e9970$@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, 'Jonathan Haws' <jhaws@sdl.usu.edu>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi Sven and Jon,

The patch does NOT work for me.

I review the code again and find the issue. The following code may make =
my
testbed work.


--- a/util.c
+++ b/util.c
@@ -122,14 +122,14 @@ int ipv4_arp_request(struct interface *interface,
const alfred_addr *addr,
        arpreq.arp_dev[sizeof(arpreq.arp_dev) - 1] =3D '\0';
=20
        if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
-               return -1;
-
-       while (retries-- && !(arpreq.arp_flags & ATF_COM)) {
-               ipv4_request_mac_resolve(addr);
-               usleep(200000);
-
-               if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
-                       return -1;
+       {
+               while (retries-- && !(arpreq.arp_flags & ATF_COM)) {
+                       ipv4_request_mac_resolve(addr);
+                       usleep(200000);
+
+                       if (ioctl(interface->netsock, SIOCGARP, &arpreq) =
<
0)
+                               return -1;
+               }
        }

Regards,
Gary


-----Original Message-----
From: Sven Eckelmann <sven@narfation.org>=20
Sent: 2018=C4=EA10=D4=C225=C8=D5 14:15
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: guohuizou2000@sina.com; b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue

On Mittwoch, 24. Oktober 2018 18:39:43 CEST Jonathan Haws wrote:
[...]
> I just submitted a patch that pulls the request_mac_resolve() routine=20
> from batctl, modifies it appropriately, and uses it when MAC=20
> resolution isn't from the cache.
>=20
> I've tested this with my VM setup here and it works properly (after I=20
> verified that the nodes were not sharing messages first).
>=20
> Gary - can you try the patch with your setup and make sure it solves=20
> the problem in your setup as well?


The patch can be found at https://patchwork.open-mesh.org/patch/17552/ =
(or
directly on the mailing list)

Please reply via mail with a line

Tested-by: FirstName LastName <guohuizou2000@sina.com>

when you've successfully tested it (FirstName and LastName have to be
replaced with your actual name).

Kind regards,
	Sven


