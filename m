Message-ID: <480E4DCC.7090402@gmx.net>
Date: Tue, 22 Apr 2008 22:42:52 +0200
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
	<480E421E.3030407@gmx.net>
	<FF6CA3D4-0705-458F-8FD4-80D4CDA3A165@philippeapril.com>
In-Reply-To: <FF6CA3D4-0705-458F-8FD4-80D4CDA3A165@philippeapril.com>
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

Hi Philippe -

> The WRT54GL's are available here (I'm in Canada), I'm sure it is also 
> available down in the US.
>
That's good to know.

> We like the Atheros hardware (fonera, meraki) because it's so small in 
> comparison (unless your WRT54GL's are the ones with smaller footprint 
> than the old big blue model?) and because it's less proprietary than 
> broadcom hardware/drivers...
It is small - ok. Things I like about WRT54GL: JTAG (even if you hose
the system completely including bootloader you can restore it), serial
interface, wide range DC-input (5-20 Volts), doesn't die if you reverse
polarity, low power consumption (3.6 Watts under full load). Up to 250mW
transmit power. Makes it ideal for my solar-powered home and developing
countries, outdoor nodes, disaster areas and so on. Open up the housing
and have a look at those *three* individual DC-DC converters for every
internal voltage.

Disclaimer: I am not working or getting paid by Linksys. I'm willing to
utilize everything good that comes the way...

Of course I don't like using proprietary code, this is sad. You know
Linksys/Cisco had to be forced to their own good. They must be selling
those devices like crazy. We have WRTs running on churches in a noisy
area with many competing networks,  each one linked to 15-20 other
single hop mesh nodes. Somewhere around 30 single hop neighbors there is
a limit for the driver/chipset, I suppose. The driver works rock solid.
As soon as Madwifi or ath5k (with OpenHAL) can compete with that I'll be
much more than happy.

If I could utter a wish to a fairy coming my way I would also ask to
have at least one good performing usb chipset for 802.11abgn that works
with Linux as well. I'd start assembling omnis and directionals with
usb-connector immediately ;-)

Cheers,

cu elektra



