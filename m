Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Sat, 7 May 2016 16:37:55 +0000
Message-ID: <bd9e8031919e41188957b3791a29d2d5@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
 <1906308.Wsn34X6QAt@sven-edge>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

On 05/07/2016 12:40 AM, Sven Eckelmann wrote:=0A=
> On Friday 06 May 2016 20:45:50 Jonathan Haws wrote:=0A=
>> I am trying to get familiar with the Alfred tools and downloaded version=
=0A=
>> 2016.1.  Unfortunately it didn't work - I couldn't get past a bind error=
:=0A=
>>=0A=
>> root@sierra1:~# ./alfred -m -i bat0=0A=
>> can't bind: Cannot assign requested address=0A=
>> Failed to open interfaces=0A=
>>=0A=
>> I had setup batman-adv with the commands:=0A=
>>=0A=
>> batctl if add eth0=0A=
>> ip link set up bat0 (eth0 was already up)=0A=
>>=0A=
>> I rolled back to 2015.0 (per a hint at=0A=
>> http://wiki.pinneberg.freifunk.net/alfred) and alfred started up just=0A=
>> fine instead of giving the error.  However it periodically gives the=0A=
>> following message:=0A=
>=0A=
> Thanks for reporting it (why didn't FF Pinneberg report it?). Can you ple=
ase=0A=
> try following workaround:=0A=
>=0A=
>      make clean=0A=
>      make CONFIG_ALFRED_CAPABILITIES=3Dn=0A=
>      # only when you've installed it before=0A=
>      make CONFIG_ALFRED_CAPABILITIES=3Dn install=0A=
>      # try it again=0A=
>      ./alfred -m -i bat0=0A=
>=0A=
> It would also be interesting to see the output of `ip addr show dev bat0`=
 and=0A=
> the used kernel version.=0A=
>=0A=
> Kind regards,=0A=
> 	Sven=0A=
>=0A=
=0A=
I am using the Yocto project to build my kernel/distro for my VMs, since =
=0A=
that is what we use on our hardware.  Here is the output from those =0A=
commands:=0A=
=0A=
root@sierra1:~# ip link show dev bat0=0A=
6: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =0A=
UNKNOWN mode DEFAULT group default=0A=
     link/ether f2:52:c3:50:2e:d7 brd ff:ff:ff:ff:ff:ff=0A=
=0A=
root@sierra1:~# uname -a=0A=
Linux sierra1 4.1.18-rt15-yocto-preempt-rt #1 SMP PREEMPT RT Wed May 4 =0A=
23:15:13 MDT 2016 x86_64 GNU/Linux=0A=
=0A=
My guess, per Matthias next email in the thread, is that IPv6 is =0A=
required, which I believe is not built into my kernel.  I'll see about =0A=
adding that and try again.=0A=
=0A=
Thanks!=0A=
Jon=0A=
