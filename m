Message-ID: <484AD57D.5080101@gmx.net>
Date: Sat, 07 Jun 2008 20:37:49 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: =?ISO-8859-1?Q?Re=3A_=5BB=2EA=2ET=2EM=2EA=2EN=2E=5D_Fwd=3A_?=
	=?ISO-8859-1?Q?=5Bak-vorrat=5D_Internet_=FCber_CB-Funk?=
References: <5cc93d950806070719s5ce178d3pd4f2d607882d0fd@mail.gmail.com>	<bccbc6690806070721w3d596edr2f715fcc3f160487@mail.gmail.com>	<484ACE55.5080203@gmx.net>
	<bccbc6690806071122h4a205861q7d795633a769bd48@mail.gmail.com>
In-Reply-To: <bccbc6690806071122h4a205861q7d795633a769bd48@mail.gmail.com>
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

you'd be surprised. I have built WiFi links up to 25 km (480 KByte/sec 
TCP throughput with 802.11b). Which is not rocket science and actually 
relatively short, compared to the WiFi world record of 380 km...

Even with the default antennas, a popular Wifi router has a range of 
approx 2 km at 1 Megabit, given a clear fresnel zone.

What you are referring to is the fact, that those WIMAX modems don't 
support multipoint-to-multipoint networking.  Actually there is an idea 
to have this mode in WIMAX (don't know the IEEE draft number, though), 
but it surely is not implemented...

cu elektra


> Hi thanks for the feedback
> CB Funk is only up to 9000 baud, that is too slow.
> The question is, if every laptop has a HDSPA WIMAX stick, if those can 
> connect directly to each other, so, that they can exchange data,
> the answer is now, as both need a SIM card, but then the question is, 
> if any firmeware can be coded, that the Stick can send to each other, 
> as they have the capability to send to 3-7 km or so.
> http://en.wikipedia.org/wiki/Huawei_E220
> Can two E220 connect to each other without a sim card with a new firmware?
> I guess that is not possible, and that will limit BATMAN to wifi chips 
> of a range of a few meters. not kilometers.
> Given that, i see only one solution, to build Batman based on the 
> Wimax/HDSPA and E220, which then will cause Data retention logging as 
> there is an ISP, but you can solve this with encryption layer networks 
> (http://www.i2p2.de/ / retroshare.sf.net <http://retroshare.sf.net> 
> etc). But that is nonsense as well, as you use batman, where no cable 
> or central wimax station is given.
> So batman will stay on wifi, if there is no hardware development on 
> wimax, that these chips can mesh together over greater distance 
> without any sim-card.
> Max
>
> 2008/6/7 elektra <onelektra@gmx.net <mailto:onelektra@gmx.net>>:
>
>     Hi -
>
>     I'd say if you run a data network you can run BATMAN on it. For
>     packet radio you may want to choose a Originator interval in the
>     range of 30 seconds or more, though.
>
>     cu elektra
>
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>   

