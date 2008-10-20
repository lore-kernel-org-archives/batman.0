Message-ID: <48FD001A.5030808@gmx.net>
Date: Tue, 21 Oct 2008 00:03:06 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] every phone a hotspot?
	->	http://www.walkinghotspot.com/
References: <bccbc6690810201215p72de1046p67e2cd3a0b9336a1@mail.gmail.com>
	<46faed20810201234q122e31ddle8fbcb1b29daea74@mail.gmail.com>
In-Reply-To: <46faed20810201234q122e31ddle8fbcb1b29daea74@mail.gmail.com>
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
> I've got "joikuspot" installed on my phone (Symbian) ... battery is 
> drained within 2 hours...

this is the crux of current WiFi interfaces in mobile phones. WiFi 
consumes way to much power - especially if a phone forwards traffic for 
other devices. It is possible - but the mobile handset will need to have 
the size and weight of a mobile phone 8 years ago, simply to provide the 
battery capacity. Batman-Experimental has an option to disable routing 
traffic for other phones (--asocial-device : mobile device mode 
reluctant to help others). An "asocial" device will just make itself 
known to the existing mesh infrastructure and use the closest Batman 
node as a gateway. It will only reply to Originator messages originated  
by the chosen gateway. Together with a slow OGM interval you can roam 
within an existing mesh infrastructure without wearing your batteries 
out quickly.

> I've heard wmfhotspot for windows mobile is just thesame... and best 
> of all the HTC brand consumes more energy than it's charger so even 
> with a powerplug you have no chance :-)

That sounds like a miserable design.

Cheers,

elektra

