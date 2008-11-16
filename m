From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ipkg install batman over ssh: postinst fails
Date: Mon, 17 Nov 2008 00:15:45 +0800
References: <20081116154159.GC26177@aims.ac.za>
In-Reply-To: <20081116154159.GC26177@aims.ac.za>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200811170015.45791.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

> I have a mesh running freifunk =E2=92=88.6.32 nodes.
> I am using the recommended batman0.2 ipkg to test it next
> to OLSR. (Is there no ipkg package and source for 0.3 or
> the latest stable?)

please see our download section to get precompiled packages for your platfo=
rm:
https://dev.open-mesh.net/batman/wiki/Download

Since 0.3 we fixed a couple of annoying bugs which resulted in a 0.3.1 beta=
. If=20
you experience major problems you should give a try.


> The freifunk-batman package:
> Unpacking freifunk-batman...Done.
> Configuring freifunk-batman...//usr/lib/ipkg/info/freifunk-batman.postins=
t:
> 10: nvram: not found //usr/lib/ipkg/info/freifunk-batman.postinst: 10:
> nvram: not found Done.
>
> And the S66batman restart, which I did manually.

The batman WebUI from Ludger is outdated and not compatible with newer batm=
an=20
versions. You should avoid using it.=20


> In the meantime, do I have to reflash them, install batman manually
> or with expect? Can I even do that or what happens when the web interface
> is used to enter the network migration info, which is now not happening
> on my nodes?

I think the main problem is the firewall. Batman sends UDP broadcasts on po=
rt=20
4305 and uses 4306 for gateway tunneling. The vis server operates on 4307. =


Regards,
Marek



