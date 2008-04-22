Message-ID: <480E4DBA.8000304@gmx.net>
Date: Tue, 22 Apr 2008 22:42:34 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Who can help with BATMAN-ADV integration into
	ROBIN-FW?
References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>
	<20080403133445.GA29070@hrz.tu-chemnitz.de>
	<001001c8959b$2596d2d0$70c47870$@com>
	<47F6072D.2050503@gmx.net> <1768846515.20080405222610@pyro.de>
	<bccbc6690804220924w3af5cffeqbdc9a122b7840537@mail.gmail.com>
	<480E35DC.801@gmx.net>
	<2520215E-4451-43DD-B86C-BE1AA134933B@philippeapril.com>
In-Reply-To: <2520215E-4451-43DD-B86C-BE1AA134933B@philippeapril.com>
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

Hi Phillipe -

well, Freifunk and others around the globe are successfully using mesh
as network infrastructure for their daily communication needs. (I'm
using multihop mesh as internet uplink since 4 years).

Here is how it works: Rather than using a zoo of different hardware use
one that works, and that is the proprietary (I hate to support this!!!)
Broadcom driver for the embedded Broadcom designs used in many 802.11b/g
routers.

Get this and go ahead deploying your network. You'll love it.
Particularly if you use Freifunk firmware. This is one key to success
nowadays.

It is a pitty that Linksys USA is not selling WRT54GL's in the US
(correct me if I'm wrong). So most people there are using Atheros SoC -
Fonera, Meraki - which are all made by Accton/Taiwan. (Again, correct me
if I'm wrong). While people in Europe, Africa and Asia are predominantly
using WRT54GL.

As far as I understood Antonio Anselmi, recent RO.B.I.N. firmware works
stable in ad-hoc with Atheros SoC.

I was working on a system for the Meraka institute in SA, for their
'Massive Mesh' grid, which was build to practically develop/test/verify
mesh routing protocols and drivers. (I was running tests of OLSRD and
all B.A.T.M.A.N. versions there.)

I have patched an older Madwifi which works rock-solid in the Meraka
mesh. There is only one issue: Fragmentation does not work. To be
precise: If you enable it, the cards won't send data packets greater
than the fragmentation value  anymore :-(

AFAIK this issue is still not solved.

Running different Madwifi VAPs in ad-hoc and master mode is something I
didn't test. Last time that I have tested it (quite a while ago) it was
a hack. And I was happy if my machine didn't lock up after a while.
Since I performed those tests several months ago I can't say much about it.

I see it that way: Keep infrastructure clients separated from your mesh
infrastructure - particularly keep clients away from your mesh channel.
Otherwise you will degrade performance by using and re-using the same
channel all the time. Even if Madwifi VAPs work stable-ish this doesn't
perform well. A stupid but working access point is cheap, use the mesh
as an uplink. Well, if all that you want is a very cheap mesh with a
couple of nodes and want to accept performance issues, you may be fine
with VAPs if the driver works.

The new ath5k driver in the most recent Linux kernel works in ad-hoc,
but has range issues. As could be read recently in the news, Atheros is
actively sponsoring development of their hardware for the kernel now
(they are paying a guy to develop drivers).

cu elektra


> Hi Elektra,
>
> I haven't replied on the list about my problems with mesh networks but 
> I think I narrowed my issues to exactly this: I have hardware at home 
> that just doesn't like to see an access point with an ADHOC interface 
> AND an AP interface.
>
> The weird hardware: my macbook pro (atheros based?), and a dell 
> truemobile 1400.
>
> The same setup works flawlessly with a D-Link G-630 PCMCIA.
>
> I don't know what to do to resolve these issues, but I will certainly 
> not deploy a mesh network in these conditions where maybe 30%+ of the 
> hardware doesn't work with adhoc mesh!
>
> Tonight I'll try to switch my access points to 802.11b only and see if 
> it's more compatible for adhoc+ap...
>
> If you have any clue as to what to tweak in Madwifi to help with these 
> compatibility issues, let me know :)
>
> On 22-Apr-08, at 3:00 PM, elektra wrote:
>>
>> In general the ad-hoc mode has been widely neglected by manufacturers 
>> and developers. From the first day I started to work on mesh networks 
>> I have been battling with firmware/driver issues. But as more and 
>> more people start using mesh networks the demand for working drivers 
>> is increasing. So we can expect that - finally, after many years - 
>> the situation will improve quickly.
>


