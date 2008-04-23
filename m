Message-ID: <480E8EA7.2040804@gmx.net>
Date: Wed, 23 Apr 2008 03:19:35 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Who can help with BATMAN-ADV integration into
	ROBIN-FW?
References: <003a01c894a2$8f7ebe00$ae7c3a00$@com>	<20080403133445.GA29070@hrz.tu-chemnitz.de>	<001001c8959b$2596d2d0$70c47870$@com>
	<47F6072D.2050503@gmx.net>	<1768846515.20080405222610@pyro.de>	<bccbc6690804220924w3af5cffeqbdc9a122b7840537@mail.gmail.com>	<480E35DC.801@gmx.net>	<2520215E-4451-43DD-B86C-BE1AA134933B@philippeapril.com>	<480E4DBA.8000304@gmx.net>	<55049.198.214.160.28.1208897871.squirrel@webmail.reglue.org>
	<bccbc6690804221407r662b4f03r313170fcf742d52f@mail.gmail.com>
In-Reply-To: <bccbc6690804221407r662b4f03r313170fcf742d52f@mail.gmail.com>
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

Hi -

I can't recommend using a variety of different wireless hardware with 
different chipsets, drivers, firmware in a network - yet. And I don't 
know any USB stick that I would recommend. If someone reading this list 
has a working recommendation still available for purchase, please add a 
comment.

What we usually do is: Get a router supported by Freifunk/OpenWRT with 
Broadcom/Atheros SoC inside, reflash it with Freifunk Firmware and 
connect it to your notebook. Or: If you have Atheros in your notebook or 
PC  with a self compiled recent Madwifi, fine. Otherwise replace the 
build-in card with something Atheros-based (you may have to modify your 
notebooks BIOS if you use IBM/Lenovo/HP, in order that the machine 
accepts the card), or insert a additional cardbus/express card with 
Atheros chipset, given that you still have a cardbus/express interface 
in your notebook. The Madwifi driver shipped with your favorite Linux 
distro may not work properly, so get it from madwifi.org and compile it 
against the Linux kernel that you are running.

With Atheros you can fix the IBSSID in order to overcome those notorious 
issues with cell-splitting, I also managed to perform this with IPW3945. 
Also OpenWRT/Freifunk does allow this with Broadcom hardware, too.

The command on a Linux-PC  to fix the IBSSID is:

iwconfig <interface> ap <your preferred cell-id like 02:CA:FF:EE:BA:BE>

Note that this is non-standard behavior, and is unlikely to work with 
other cards. Actually upon request from Freifunk this was modified in 
the Madwifi driver.

Old Cisco Aironet 802.11b works for me (mostly) as long as the mesh is 
the only ad-hoc network around... I use it every day, it is running 
stable until I stop it. Also ancient Atmel 76c503 based USB sticks work 
- I used to build mesh routers with them in the old days ;-) Old Prism2, 
2.5, 3 and Prism54 (Hard-Mac only) work, but are susceptible to 
cell-splitting (and may lock up if cell-splitting is already going on in 
your WiFi cell).

I have a Intel IPW3945 in a new notebook that works somehow with a 
little trick under Ubuntu (fix the Cell-ID in managed mode first, switch 
to ad-hoc, set essid, set channel, enable interface) -  but from time to 
time I get hiccups that seem to be associated with firmware errors 
(reported in syslog) - then I need to reset the interface). The 
experience with IPW2200 was even worse with a notebook I used a year 
ago, but I didn't try that recently.

Broadcom would be an option, but the company doesn't provide drivers for 
Linux-PCs. There is an open-source driver but I don't know whether it 
actually works in ad-hoc mode now.

cu elektra



> thanks, elektra, would it be possible, that an usb stick with wifi 
> chip and coded in software can be distributed? e.g. by foebud?
> we need a solution, where people use their laptop and not need to 
> configure their routers.
> The Laptop or USB-Stick has the wifi chip...
> is there a wiki, where all wifi chips are listed and how the bug 
> fixing for them is going on by whoom?
>  
> Maxx
> ------------------------------------------------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>   

