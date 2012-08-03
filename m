Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Aug 2012 11:48:28 +0200
Message-ID: <12564988.U0eif3lDW2@bentobox>
In-Reply-To: <CAMVTf1hm9Q8Ppu2Lq6h4+7OpvZ9meLYhxFKHFLhudD3LCTNXmg@mail.gmail.com>
References: <CAMVTf1hm9Q8Ppu2Lq6h4+7OpvZ9meLYhxFKHFLhudD3LCTNXmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8352106.fb23zS2d1A";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Problems with internet connection in a
	mesh-network, (and dhcp and wireless access)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart8352106.fb23zS2d1A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 02 August 2012 19:35:34 Esteban Municio wrote:
> Hi all
> 
> I wrote recently about problems with our batman-adv mesh
> implementation in a development proyect in Peru:
> 
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-August/007820.html
> 
> Now we are having problems again.
> Our mesh-network are formed with Ubiquiti nanostation M5 nodes running
> OpenWRT(10.03.x, r32751)+ Batman-adv 2.6.32.

batman-adv was not included in 2.6.32. We had our first version in 2.6.33. So, 
this information is bogus. Please update to a recent version (for example 
2012.2.0 + the updates from the maint branch; or just batman-adv-devel).

> In one of the nodes, the wan gate is connected with Public IP to
> internet and I can access to internet from there.
> 
> But from a laptop(without batman-adv), I can make ping to all the
> nodes of the mesh, but i can't make ping to 8.8.8.8 neither the Ip
> public gateway. However, I can make ping to my Ip Public, in the
> interface wan of my gateway node.
> 
> What am I doing wrong? I have tried to write static routes, but I
> think that the problem is about the mesh-bridge.
> Is it beacuse of i need do NAT?

It is hard to understand what you are doing and what you want. All you are 
doing here is L3 stuff... so out of scope for batman-adv. batman-adv provides 
only the l2 stuff (+ a dhcp routing hack when you enable the gateway stuff).

So you need to do the same stuff you are doing when you want to configure an 
"internet gateway" for your private network. That usually includes 
masquerading, dhcp, dns, ...

> All the nodes of the mesh can see themselves, and I set the node with
> the gateway to internet like the gateway of the mesh, but it does not
> work.
> 
> Any help or comment?

Sry, my parser failed. Maybe someone else can help.

> That is my /etc/rc.local and /etc/config/network in the gateway node:
> 
> /etc/rc.local
> 
> wifi up
> ifconfig wlan0 mtu 1528
> batctl if add wlan0
> ifconfig wlan0 up
> ifconfig bat0 up
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
> ifconfig eth0 up
> ifconfig bat0 up
> ifconfig mesh-bridge inet 1.1.1.1 netmask 255.255.255.0
> ifconfig mesh-bridge up
> exit 0
> 
> /etc/config/network
> 
> config 'interface' 'loopback'
>     option 'ifname' 'lo'
>     option 'proto' 'static'
>     option 'ipaddr' '127.0.0.1'
>     option 'netmask' '255.0.0.0'
> 
> config 'interface' 'lan'
>     option 'ifname' 'eth0'
>     option 'proto' 'static'
>     option 'ipaddr' '192.168.1.2'
>     option 'netmask' '255.255.255.0'
> 
> config 'interface' 'wan'
>     option 'ifname' 'eth1'
>     option 'proto' 'static'
>     option 'ipaddr' my Ip public
>     option 'netmask' '255.255.255.192'
>     option 'gateway' my ip public gateway
>     option 'dns' '8.8.8.8'
> 
> config 'route'
> 
> And some offtopic questions...
> 
> What should i do for permit to others laptops without batman-adv can
> connect by wireless to the mesh, make another wlan interface with
> another ssid in ap mode and add it to the mesh-bridge?

Didn't you say that you are already doing something like that? At least you've 
mentioned that that you are can connect with you non-mesh laptop. But yes, 
you should have a second interface configured as AP attached to your mesh-
bridge to allow wireless clients connected to this interface to work like the 
ethernet clients. It doesn't make much sense to have a non-batman-adv-aware 
client connected on a interface that is attached as slave (hard) interface to 
batman-adv.

At least the configuration looks a little bit like you are trying to do 
something like this.

Kind regards,
	Sven
--nextPart8352106.fb23zS2d1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQG55sAAoJEF2HCgfBJntGoocQAKuRgPQRPMqBcpZ/xnwHdVHh
24DKoVvpsAZR6POwl8A84QzQ+qvKDPOuCTLLl1SJDl4lAB7j/9L9M9ZlwDaLOZCB
C52w9b8ggyP2ZjlTC/Q+D02Yh+9YclPiAR+TPP11QSCX8LPFiw0wYuc6XSSNbEtI
8ufF5up1iPEJN7uYtHKWxi4VaQ8HvUYMumnmjBVXMvWfSmsAeob9IquJb8lfnrZr
D50fz06ouIRTBYfYQlBMGjSHT/4D0iqDpSCFH+afgM+YtWFpnjWSPz+vZSOZlwin
jVnbhKI7yL5k740ATZVn+7VhUfAFSaEqDeiNMJTbZm12V+n+niTABucWy8NVwPio
G83xq064MFikjmpm7JxVgBFtfGfIhwAHgQjz5Jy0rt1Vhfttp+iO7rRceNxKgPbt
eUX/8d5taVk+9A0nB5ADFv/dSmVfD9wQrPbxcwMnmfKlOPqPyFyZnqdcFQx2teMY
wDBzZXWYFJeCck4D9lsG+IsB9AC+JMZEqjuxscMd1MedYcdH8K4US77568V173he
RcdLAL5r5/GlI49QhbPg70P3l0w73P3OOnXfqWsD5ngHBqvBQN4nf9kzv3WNYRFa
xFXH49IbLfknJtlpgjMB4baUJ+TNwqDUghGSrlWF3d9R1dFupE6ix3P96UM7BYE5
JnEIngA7Kq0qlLMeRX+g
=ApPS
-----END PGP SIGNATURE-----

--nextPart8352106.fb23zS2d1A--

