Return-Path: <fboehm@aon.at>
Message-ID: <4BE05AA8.1010805@aon.at>
Date: Tue, 04 May 2010 19:34:32 +0200
From: =?ISO-8859-15?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <201005030828.08856.lindner_marek@yahoo.de>	<201005041340.07717.onelektra@gmx.net>
	<4BE014CC.50904@aon.at> <201005041505.34855.onelektra@gmx.net>
In-Reply-To: <201005041505.34855.onelektra@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] sysfs compat
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Elektra,

as far as I know there is no 100% open source driver for Atheros AR9280 
that is compliant with ETSI regulations. Please correct me if I am wrong.

Interestingly there is also no 5GHz support in OpenWrt 10.03 because of 
regulatory issues.

Sorry Elektra, but it's irrelevant what you can do with all those 
wireless stuff around. You can also use a kitchen knife as a weapon. 
It's only a matter of being compliant with laws if you want to get your 
product on the market.

For example you need reverse polarity connectors (RP-SMA, ...) to make 
it harder for people to attach some self constructed antennas. This is 
simply a FCC regulation every certified product has to obey.

As I already said, this is only applicable for commercial products. But 
also OpenWrt seems to be worried about regulations.

This discussion is off topic and also not BATMAN relevant. So I would 
say we shouldn't go further into detail about regulation good, bad, yes 
or no.

Regards,
Franz


elektra schrieb:
> Hi Franz -
> 
> there are certified devices out there, running OpenWrt / open-source drivers. 
> May I ask, what particular regulator issues you have in mind, that a open-
> source driver can not comply with? Read: Are you sure you don't get the 
> regulators blessing for your product with a open-source driver?
> 
> Besides: Do you know this song by Eric Idle, regarding the FCC?
> 
> http://www.youtube.com/watch?v=F4ajZ-5kTXk
> 
> A few memes:
> 
> Any product can be tampered with.
> 
> In many certified devices you can simply switch the reg domain. Then choose 
> Japan, for example. Now you can transmit on channel 14 in the 2.4GHz range. 
> Not so legal anywhere outside of Nippon. 
> 
> The old Broadcom chipset / proprietary driver can be configured to transmit at 
> 250mW with the proprietary closed source driver. Hence you can transmit at 
> ~25dbm EIRP (with the stock antennas), far beyond the ETSI regulations of 
> 20dBm EIRP.
> 
> Any device with a external antenna connector can be used together with a high-
> gain antenna. Again you get far beyond the legal limits.
> 
> Cheers,
> Elektra
> 
