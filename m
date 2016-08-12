Return-Path: <dreamtrick@gmail.com>
Message-ID: <1470988256.16102.4.camel@gmail.com>
From: Ignacio Quezada <dreamtrick@gmail.com>
Date: Fri, 12 Aug 2016 09:50:56 +0200
In-Reply-To: <20160811163153.GK4483@otheros>
References: <1470928381.10121.0.camel@gmail.com>
 <20160811154723.GJ4483@otheros> <1470931774.10121.10.camel@gmail.com>
 <20160811163153.GK4483@otheros>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] is the multicast performance throttled?
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


-- 

MVH
Ignacio Quezada

On tor, 2016-08-11 at 18:31 +0200, Linus Lüssing wrote:
> On Thu, Aug 11, 2016 at 06:09:34PM +0200, Ignacio Quezada wrote:
> > 
> > Hi Linus,
> > 
> > On tor, 2016-08-11 at 17:47 +0200, Linus Lüssing wrote:
> > > 
> > > Hi Ignacio,
> > > 
> > > Could you describe your setup a little more, just two devices?
> > > What hardware are you using, which wifi cards? Which operating
> > > system and version?
> > > 
> > > Which version of batman-adv are you using? What is your kernel
> > > version?
> > 
> > The test environment is 2 android phones with Android 5.1 running
> > kernel 3.4 where I backported batman 2016.2, same wifi chip (same
> > soc)
> > BCM4339.
> 
> Note sure how usable IBSS on Android is. Last time I heard someone
> talking about it, it was supposedly unusable. But maybe someone
> else has some more current information :-).
> 
After some tweaking, it works good enough.
> > 
> > 
> > > 
> > > What is a typical bitrate your wifi cards are agreeing on (iw
> > > station dump)? What multicast rate have you configured for your
> > > wifi cards?
> > 
> > Sadly, the support of iw for these kind of chipsets is very limited
> > and
> > iw dev wlan0 station dump returns nothing. I don't know how to get
> > you
> > that information.
> 
> And the multicast rate is still left at the 1MBit/s default?
> Unfortunately, usually multicast packets are sent at the lowest
> rate available as there are no wifi ACKs. To maximize the probability
> of
> reception. There are some tweaks in OpenWRT though.
> 
> Also, often people change the bitrate from 1MBit/s to more like
> 12MBit/s or even above. That gives more free airtime and enhances the
> batman-adv estimations (BATMAN IV).
> 
Do you mean that with 1MBit/s for multicast, batman protocol needs
80kb/s to set up the connections? 1MBit/s for my application is more
than enough. 
> > 
> > 
> > > 
> > > What software are you using for testing? What is the bitrate you
> > > have configured in there? Is the unicast test UDP as well? What
> > > bitrates are you able to achieve via TCP? Does a lower payload
> > > length make any difference?
> > > 
> > 
> > The software used is a java program with 1 socket each where one
> > sends
> > and the other receives. The unicast is UDP as well, yes. I haven't
> > tried with TCP but I can do it if it is necessary, my application
> > only
> > relies on UDP.
> 
> UDP has no flow control. That's why I was asking about the bitrate
> you have configured in the application. Sending with "as fast as
> possible" will basically jam your (and your neighbors) wifi. And
> will create trouble for batman-adv to find usable routes too
> without any airtime available.
> 
> Regards, Linus

What I don't understand is that you are explaining standard behavior of
WiFi networks, but using plain WiFi without batman works ok and the
multicast goes up to 100kb/s (I think I wrote that in my first email). 
The tests have been like this so far:
- wlan0 (no batman),  multicast: 100kb/s
- wlan0 (no batman),  unicast: 100kb/s
- bat0,  unicast: 100kb/s
- bat0,  multicast: 20kb/s


PS: Emails from the Gmail Android App get rejected by the mailinglist,
I guess it is because of the HTML format? I wasn't able to disable it,
back at the desktop.

MVH 
Ignacio Quezada
